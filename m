Message-Id: <200108191559.RAA01163@piglet.grunz.lu>
Date: Sun, 19 Aug 2001 17:59:00 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: About TAU (and ICTC)
To: hozer@drgw.net
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200108191003.MAA00874@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-846930886-998236754=:840"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-846930886-998236754=:840
Content-Type: TEXT/plain; charset=us-ascii

Hi all,

I've thought a bit more about using ICTC...

On  19 Aug, this message from Michel Lanners echoed through cyberspace:
> Something else about an eventual TAU usage: Troy writes '...use cpu load
> (from scheduler) and ICTC to extend battery life...'. That could
> probably be done via something like i386's kapm_idled (kernel thread to
> burn cycles efficiently, basically). Does that sound feasible?

Attached is a first quick hack based on i386's kapm-idled. It creates a
thread that while running sets ICTC to some predefined value, thus
slowing down the CPU.

However, it seems to have the exact _opposite_ efect, in that it both
increases CPU temperature (from a displayed 4 C while idle to 12 C while
running this) and reduces battery life by about 30 min.

This is probably because the idle thread keeps the already-present
powersaving through the CPU's NAP and/or DOZE mode from kicking in.
On the other hand, the second patch adds an ICTC interface under
/proc/sys/kernel, based on the l2cr interface, so you can set arbitrary
ICTC values. You need to write ((slowdown_factor << 1) | enable);
slowdown_factor beeing between 0 and 255 processor cycles between
instruction fetches, and enable obviously being 1 to enable ICTC useage.

My preliminary test indicate that settig ICTC to 33 (0x21) has no
noticeable effect on an idle machine. While running an endless kernel
compile loop, however, it makes the CPU temperature drop from 19C to
15-17C, and increases battery life by about 20 min.

So, it would seem that ICTC has very limited use on an idle system,
whereas it could be useful under certain circumstances (low activity on
a battery-powered system; typically word processing on the morning
train). Obviously this makes setting ICTC automatically rather
difficult; it wold need to be set based on the machine load, and not on
the number of running processes as is done in my patch. Also, a separate
kernel thread seems counter-productive; it seems easier to just set and
clear ICTC in the idle loop (which does NAP/DOZE now), or even as a
userspace daemon, avoiding kernel code altogether.

It seems ICTC is best set according to user policy, so it would
definitely be a userspace thing.

> Anybody know of any adverse effects of using ICTC to slow the CPU?
> Bogompis and the kernel delay loop come to mind; don't know whether
> those would need to be adjusted... which would be quite difficult, I
> guess.

During my tests, I've not noticed any adverse effects apart from slowing
the machine down a bit.....

Please have a look at the patches, and test it for yourself ;-). All
temp/battery life data from my TiBook.

Cheers

Michel

PS To use the idle thread, drop k_ppc_idled.c into arch/ppc/kernel and
add k_ppc_idled.o in the Makefile over there.

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134458388-846930886-998236754=:840
Content-Type: TEXT/plain; name="k_ppc_idled.c"
Content-Disposition: attachment; filename="k_ppc_idled.c"

/*
 * First try at a PPC idled kernel thread
 * Should slow the CPU via ICTC when idle for too long
 */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/sched.h>


#define CONFIG_APM_CPU_IDLE

/* Instruction fetch interval expressed in processor clock cycles */
#define ICTC_CPU_SLOWED 4

#ifdef CONFIG_APM_CPU_IDLE
static int			clock_slowed;
#endif
static int			exit_kapmd;
static int			kapmd_running;

extern void _set_ICTC(int);

static int apm_do_idle(void)
{
	clock_slowed = 1;

	/* Set ICTC and make sure ICTC[E] is set */
	_set_ICTC((ICTC_CPU_SLOWED << 1) | 1);
	return 1;
}

static void apm_do_busy(void)
{
	if (clock_slowed) {
		/* Reset ICTC */
		_set_ICTC(0);
		clock_slowed = 0;
	}
}



/*
 * This is the APM thread main loop.
 *
 * Check whether we're the only running process to
 * decide if we should just power down.
 *
 */
#define system_idle()		(nr_running == 1)
#define APM_CHECK_TIMEOUT	(HZ)

static void apm_mainloop(void)
{
	int timeout = HZ;

	set_current_state(TASK_INTERRUPTIBLE);
	for (;;) {
		/* Nothing to do, just sleep for the timeout */
//		timeout = 2*timeout;
		if (timeout > APM_CHECK_TIMEOUT)
			timeout = APM_CHECK_TIMEOUT;
		schedule_timeout(timeout);
		if (exit_kapmd)
			break;

		/*
		 * Ok, check for idle (and mark us sleeping
		 * so as not to count towards the load average)..
		 */
		set_current_state(TASK_INTERRUPTIBLE);
		if (!system_idle())
			continue;
		if (apm_do_idle()) {
			while ((!exit_kapmd) && system_idle()) {
				apm_do_idle();
			}
			apm_do_busy();
//			timeout = 1;
		}
	}
}

static int ppc_idled(void *unused)
{
	kapmd_running = 1;

	daemonize();

	strcpy(current->comm, "k_ppc_idled");
	sigfillset(&current->blocked);
	current->tty = NULL;	/* get rid of controlling tty */

	printk(KERN_INFO "PPC idled kernel thread started.\n");

	if (smp_num_cpus == 1) {
		apm_mainloop();
	}
	kapmd_running = 0;

	return 0;
}

/*
 * Just start the APM thread. We do NOT want to do APM BIOS
 * calls from anything but the APM thread, if for no other reason
 * than the fact that we don't trust the APM BIOS. This way,
 * most common APM BIOS problems that lead to protection errors
 * etc will have at least some level of being contained...
 *
 * In short, if something bad happens, at least we have a choice
 * of just killing the apm thread..
 */
static int __init apm_init(void)
{

	kernel_thread(ppc_idled, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);

	return 0;
}

static void __exit apm_exit(void)
{
	exit_kapmd = 1;
	while (kapmd_running)
		schedule();
}

module_init(apm_init);
module_exit(apm_exit);

EXPORT_NO_SYMBOLS;

--134458388-846930886-998236754=:840
Content-Type: TEXT/plain; name="ictc.diff"
Content-Disposition: attachment; filename="ictc.diff"

--- /usr/src/sources/2.4/linux-2.4.benh/arch/ppc/kernel/ppc_htab.c	Fri Aug 17 22:38:30 2001
+++ arch/ppc/kernel/ppc_htab.c	Sun Aug 19 15:45:41 2001
@@ -38,6 +38,8 @@
 static long long ppc_htab_lseek(struct file * file, loff_t offset, int orig);
 int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
 		  void *buffer, size_t *lenp);
+int proc_doictcvec(ctl_table *table, int write, struct file *filp,
+		  void *buffer, size_t *lenp);

 extern PTE *Hash, *Hash_end;
 extern unsigned long Hash_size, Hash_mask;
@@ -519,6 +521,101 @@

 			p += sprintf(p,"\n");

+			len = strlen(buf);
+			if (len > left)
+				len = left;
+			if(copy_to_user(buffer, buf, len))
+				return -EFAULT;
+			left -= len;
+			buffer += len;
+			break;
+		}
+	}
+
+	if (!write && !first && left) {
+		if(put_user('\n', (char *) buffer))
+			return -EFAULT;
+		left--, buffer++;
+	}
+	if (write) {
+		p = (char *) buffer;
+		while (left) {
+			char c;
+			if(get_user(c, p++))
+				return -EFAULT;
+			if (!isspace(c))
+				break;
+			left--;
+		}
+	}
+	if (write && first)
+		return -EINVAL;
+	*lenp -= left;
+	filp->f_pos += *lenp;
+	return 0;
+}
+
+int proc_doictcvec(ctl_table *table, int write, struct file *filp,
+		  void *buffer, size_t *lenp)
+{
+	int vleft, first=1, len, left, val;
+	#define TMPBUFLEN 128
+	char buf[TMPBUFLEN], *p;
+
+	if (!(cur_cpu_spec[0]->cpu_features & CPU_FTR_ICTC))
+		return -EFAULT;
+
+	printk ("ICTC: sysctl interface used.\n");
+
+	if ( /*!table->maxlen ||*/ (filp->f_pos && !write)) {
+		*lenp = 0;
+		return 0;
+	}
+
+	vleft = table->maxlen / sizeof(int);
+	left = *lenp;
+
+	for (; left /*&& vleft--*/; first=0) {
+		if (write) {
+			while (left) {
+				char c;
+				if(get_user(c,(char *) buffer))
+					return -EFAULT;
+				if (!isspace(c))
+					break;
+				left--;
+				((char *) buffer)++;
+			}
+			if (!left)
+				break;
+			len = left;
+			if (len > TMPBUFLEN-1)
+				len = TMPBUFLEN-1;
+			if(copy_from_user(buf, buffer, len))
+				return -EFAULT;
+			buf[len] = 0;
+			p = buf;
+			if (*p < '0' || *p > '9')
+				break;
+			val = simple_strtoul(p, &p, 0);
+			len = p-buf;
+			if ((len < left) && *p && !isspace(*p))
+				break;
+			buffer += len;
+			left -= len;
+			_set_ICTC(val);
+
+		} else {
+			p = buf;
+			if (!first)
+				*p++ = '\t';
+			val = _get_ICTC();
+			p += sprintf(p, "Instruction Cache Throttling Control:\n\n");
+			p += sprintf(p, "0x%08x: ", val);
+			p += sprintf(p, " %s", val & 1 ? "enabled" :
+				     	"disabled");
+			p += sprintf(p, ", delay: %d clock cycles.\n",
+					(val >> 1) & 255 );
 			len = strlen(buf);
 			if (len > left)
 				len = left;
--- /usr/src/sources/2.4/linux-2.4.benh/kernel/sysctl.c	Fri Aug 17 21:33:27 2001
+++ kernel/sysctl.c	Sun Aug 19 15:07:42 2001
@@ -88,6 +88,8 @@
 #ifdef CONFIG_6xx
 int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
 		  void *buffer, size_t *lenp);
+int proc_doictcvec(ctl_table *table, int write, struct file *filp,
+		  void *buffer, size_t *lenp);
 #endif
 #endif

@@ -188,6 +190,8 @@
 #ifdef CONFIG_6xx
 	{KERN_PPC_L2CR, "l2cr", NULL, 0,
 	 0644, NULL, &proc_dol2crvec},
+	{KERN_PPC_ICTC, "ictc", NULL, 0,
+	 0644, NULL, &proc_doictcvec},
 #endif
 #endif
 	{KERN_CTLALTDEL, "ctrl-alt-del", &C_A_D, sizeof(int),
--- /usr/src/sources/2.4/linux-2.4.benh/include/linux/sysctl.h	Fri Aug 17 22:18:30 2001
+++ include/linux/sysctl.h	Sun Aug 19 15:07:19 2001
@@ -118,7 +118,8 @@
 	KERN_SHMPATH=48,	/* string: path to shm fs */
 	KERN_HOTPLUG=49,	/* string: path to hotplug policy agent */
 	KERN_IEEE_EMULATION_WARNINGS=50, /* int: unimplemented ieee instructions */
-	KERN_S390_USER_DEBUG_LOGGING=51  /* int: dumps of user faults */
+	KERN_S390_USER_DEBUG_LOGGING=51, /* int: dumps of user faults */
+	KERN_PPC_ICTC=52	/* int: ictc register on PPC */
 };



--134458388-846930886-998236754=:840--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

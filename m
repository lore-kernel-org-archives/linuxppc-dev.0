Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4D28C508-C56C-11D8-8C0F-000393DBC2E8@freescale.com>
Cc: Pan Jacob-r7aahq <Jacob.Pan@freescale.com>,
	linuxppc-dev Development <linuxppc-dev@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Add support for the L3CR to 2.6
Date: Wed, 23 Jun 2004 18:23:14 -0500
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul, Ben

Here is a patch from Jacob Pan that adds 'proper' support for the L3CR
on 745x parts.

- kumar

diff -Nru a/arch/ppc/kernel/l2cr.S b/arch/ppc/kernel/l2cr.S
--- a/arch/ppc/kernel/l2cr.S	Thu Jun 24 00:04:09 2004
+++ b/arch/ppc/kernel/l2cr.S	Thu Jun 24 00:04:09 2004
@@ -36,7 +36,9 @@
  		several months.  The L2CR is similar, but I'm going
  		to assume the user of this functions knows what they
  		are doing.
-
+	June 17, 2004.
+	- JPAN: Fixed 745X L3 cache enablement routine, also use HW flush
assist.
+
  	Author:	Terry Greeniaus (tgree@phys.ualberta.ca)
  	Please e-mail updates to this file to me, thanks!
  */
@@ -292,17 +294,18 @@

  	/* Flush the cache.
  	 */
-
-	/* TODO: use HW flush assist */
-
-	lis	r4,0x0008
-	mtctr	r4
-	li	r4,0
-1:
-	lwzx	r0,r0,r4
-	dcbf	0,r4
-	addi	r4,r4,32		/* Go to start of next cache line */
-	bdnz	1b
+	/* use HW flush assist. (UM 3.6.3.1.5) */
+	mfspr	r4, SPRN_L3CR
+	oris	r4,r4,0x0040	/* Set L3CR[L3IO/9] = 1. */
+	ori	r4,r4,0x0040	/* Set L3CR[L3DO/29] = 1.*/
+	mtspr	1018,r4		/* Lock the L3 by making IONLY and DONLY */
+	ori	r4,r4,0x0800	/* Set L3CR[L3HWF/20] for hardware flush */
+	mtspr	SPRN_L3CR,r4
+flush_745x_L3_poll:
+	mfspr	r4,SPRN_L3CR
+	rlwinm.	r4,r4,0,20,20
+	bne	flush_745x_L3_poll
+	sync	/* Clear the store queues per procedure (UM step 8) */

  2:
  	/* Set up the L3CR configuration bits (and switch L3 off) */
@@ -348,8 +351,8 @@
  	cmplwi	r5,0
  	beq	4f

-	/* Enable the cache */
-	oris	r3,r3,(L3CR_L3E | L3CR_L3CLKEN)@h
+	/* enable L3 clock */
+	oris	r3,r3,(L3CR_L3CLKEN)@h
  	mtspr	SPRN_L3CR,r3
  	sync

@@ -357,6 +360,15 @@
  	li	r0,256
  	mtctr	r0
  1:	bdnz	1b
+
+	/* Clear MSSSR0 which may cause parity error */
+	xor	r5,r5,r5
+	mtspr	1015, r5
+
+	/* Enable L3 cache */
+	oris	r3,r3,(L3CR_L3E)@h
+	mtspr	SPRN_L3CR,r3
+	sync

  	/* Restore MSR (restores EE and DR bits to original state) */
  4:	SYNC
diff -Nru a/arch/ppc/kernel/ppc_htab.c b/arch/ppc/kernel/ppc_htab.c
--- a/arch/ppc/kernel/ppc_htab.c	Thu Jun 24 00:04:09 2004
+++ b/arch/ppc/kernel/ppc_htab.c	Thu Jun 24 00:04:09 2004
@@ -37,6 +37,8 @@
  static long long ppc_htab_lseek(struct file * file, loff_t offset, int
orig);
  int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
  		  void __user *buffer, size_t *lenp);
+int proc_dol3crvec(ctl_table *table, int write, struct file *filp,
+		  void __user *buffer, size_t *lenp);

  extern PTE *Hash, *Hash_end;
  extern unsigned long Hash_size, Hash_mask;
@@ -469,3 +471,173 @@
  	filp->f_pos += *lenp;
  	return 0;
  }
+/* JPAN: external L3CACHE is supported by MPC745X processors. L3
timing parameters
+ * are both CPU and platform dependent, so we do not enable L3 during
boot time, but rather
+ * allow user to enable via sysctl via /proc/sys/kernel/l3cr. Prior to
booting
+ * the kernel, correct L3 SRAM AC timing can be adjusted by L3IDCR0-3,
+ * - MPC7450 UM 2.1.5.5.4
+ */
+int proc_dol3crvec(ctl_table *table, int write, struct file *filp,
+		  void __user *buffer_arg, size_t *lenp)
+{
+	int vleft, first=1, len, left, val;
+	char __user *buffer = (char __user *) buffer_arg;
+	char buf[TMPBUFLEN], *p;
+	static const char *sizestrings[2] = {
+		"1MB", "2MB"
+	};
+	static const char *clockstrings[8] = {
+		"divided by 6",
+		"reserved (1)",
+		"divided by 2",
+		"divided by 2.5",
+		"divided by 3",
+		"divided by 3.5",
+		"divided by 4",
+		"divided by 5"
+	};
+	/* 7457 only */
+	static const char *clockstrings_ext[8] = {
+		"divided by 7",
+		"divided by 8",
+		"divided by 4.5",
+		"divided by 5.5",
+		"divided by 6.5",
+		"divided by 7.5",
+		"reserved (6)",
+		"reserved (7)"
+	};
+	static const char *clocksamplepoint[4] = {
+	  "2 clocks",
+	  "3 clocks",
+	  "4 clocks",
+	  "5 clocks"
+	};
+	/* 7457 only */
+	static const char *clocksamplepoint_ext[4] = {
+	  "6 clocks",
+	  "7 clocks",
+	  "8 clocks",
+	  "9 clocks"
+	};
+	static const char* p_clocksamplepoint[8] ={
+	  "0 clocks",
+	  "1 clocks",
+	  "2 clocks",
+	  "3 clocks",
+	  "4 clocks",
+	  "5 clocks",
+	  "reserved (6)",
+	  "reserved (7)"
+	};
+
+	static const char* typestrings[4] = {
+	  "MSUG2 DDR SRAM",
+	  "pipelined sync late-write SRAM",
+	  "reserved type (2)",
+	  "PB2 SRAM",
+	};
+
+	if (!(cur_cpu_spec[0]->cpu_features & CPU_FTR_L3CR))
+		return -EFAULT;
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
+				if(get_user(c, buffer))
+					return -EFAULT;
+				if (!isspace(c))
+					break;
+				left--;
+				buffer++;
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
+			_set_L3CR(val);
+		} else {
+			p = buf;
+			if (!first)
+				*p++ = '\t';
+			val = _get_L3CR();
+			p += sprintf(p, "0x%08x: ", val);
+			p += sprintf(p, " %s", (val >> 31) & 1 ? "enabled" :
+				     	"disabled");
+			p += sprintf(p, ", %sparity", (val>>30)&1 ? "" : "no ");
+			p += sprintf(p, ", %s address parity", (val>>29)&1 ? "" : "no ");
+			p += sprintf(p, ", %s", sizestrings[(val >> 28) & 1]);
+ 			if(val & (1<<21)) //clock ext
+			  p += sprintf(p, ", %s", clockstrings_ext[(val >> 23) & 7]);
+			else
+			  p += sprintf(p, ", %s", clockstrings[(val >> 23) & 7]);
+			p += sprintf(p, ", %s", typestrings[(val >> 8) & 3]);//SRAM type
+			p += sprintf(p,"\n");
+			if(val & (1<<20)) //clock sp ext
+			  p += sprintf(p, ", %s sample point (ext)",
clocksamplepoint_ext[(val>>16)&3]);
+			else
+			  p += sprintf(p, ", %s sample point",
clocksamplepoint[(val>>16)&3]);
+
+			p += sprintf(p, ", %s p-sample point",
p_clocksamplepoint[(val>>13)&7]);
+			p += sprintf(p, "%s", (val>>6)&1 ? ", data only" : ", unified");
+
+			p += sprintf(p, ", %s", (val>>12)&1 ? "8-bit running counter
replacement":\
+				     "default replacement");
+			p += sprintf(p,"\n");
+
+			len = strlen(buf);
+			if (len > left)
+				len = left;
+			if (copy_to_user(buffer, buf, len))
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
diff -Nru a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	Thu Jun 24 00:04:09 2004
+++ b/include/linux/sysctl.h	Thu Jun 24 00:04:09 2004
@@ -133,6 +133,7 @@
  	KERN_NGROUPS_MAX=63,	/* int: NGROUPS_MAX */
  	KERN_SPARC_SCONS_PWROFF=64, /* int: serial console power-off halt */
  	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
+	KERN_PPC_L3CR=66,	/* int: control L3 cache on/off */
  };


diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	Thu Jun 24 00:04:09 2004
+++ b/kernel/sysctl.c	Thu Jun 24 00:04:09 2004
@@ -114,6 +114,9 @@
  extern unsigned long powersave_nap;
  int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
  		  void *buffer, size_t *lenp);
+int proc_dol3crvec(ctl_table *table, int write, struct file *filp,
+		  void *buffer, size_t *lenp);
+
  #endif

  #ifdef CONFIG_BSD_PROCESS_ACCT
@@ -369,6 +372,12 @@
  		.procname	= "l2cr",
  		.mode		= 0644,
  		.proc_handler	= &proc_dol2crvec,
+	},
+	{
+		.ctl_name	= KERN_PPC_L3CR,
+		.procname	= "l3cr",
+		.mode		= 0644,
+		.proc_handler	= &proc_dol3crvec,
  	},
  #endif
  	{

Signed-off-by: Jacob Pan <Jacob.Pan@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

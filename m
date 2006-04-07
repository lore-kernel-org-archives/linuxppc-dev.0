Return-Path: <vatsa@in.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C0FC67B37
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2006 16:34:55 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k376YqkU023924
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2006 02:34:52 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k376VUTA259416
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2006 00:31:30 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k376Yqgw026432
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2006 00:34:52 -0600
Date: Fri, 7 Apr 2006 12:02:56 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: anton@samba.org, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 4/4] tickless idle cpus: decrementer statistics - NOT MEANT
	FOR INCLUSION
Message-ID: <20060407063256.GD22416@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, sri_vatsa_v@yahoo.com
Reply-To: vatsa@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch (a hack) provides some statistics of decrementer exception on
each CPU. I used this purely to verify that tickless feature is working.

Anton, would this be useful statistics to be exposed (maybe in
/proc/interrupts)? If so, I could work out a more cleaner way of
providing this statistics to user.

Signed-off-by: Srivatsa Vaddagiri <vatsa@in.ibm.com>

---

 linux-2.6.17-rc1-root/arch/powerpc/kernel/time.c |    4 ++++
 linux-2.6.17-rc1-root/fs/proc/proc_misc.c        |   17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff -puN arch/powerpc/kernel/time.c~stat arch/powerpc/kernel/time.c
--- linux-2.6.17-rc1/arch/powerpc/kernel/time.c~stat	2006-04-07 11:29:20.000000000 +0530
+++ linux-2.6.17-rc1-root/arch/powerpc/kernel/time.c	2006-04-07 11:29:20.000000000 +0530
@@ -757,6 +757,8 @@ void start_hz_timer(struct pt_regs *regs
 static inline int clear_hzless_mask(void) { return 0;}
 #endif
 
+DEFINE_PER_CPU(int, dec_ticks);
+
 /*
  * For iSeries shared processors, we have to let the hypervisor
  * set the hardware decrementer.  We set a virtual decrementer
@@ -780,6 +782,8 @@ void timer_interrupt(struct pt_regs * re
 
 	irq_enter();
 
+	__get_cpu_var(dec_ticks) += 1;
+
 	clear_hzless_mask();
 
 	profile_tick(CPU_PROFILING, regs);
diff -puN fs/proc/proc_misc.c~stat fs/proc/proc_misc.c
--- linux-2.6.17-rc1/fs/proc/proc_misc.c~stat	2006-04-07 11:29:20.000000000 +0530
+++ linux-2.6.17-rc1-root/fs/proc/proc_misc.c	2006-04-07 11:29:20.000000000 +0530
@@ -243,6 +243,22 @@ static int version_read_proc(char *page,
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+DECLARE_PER_CPU(int, dec_ticks);
+
+static int decrementer_read_proc(char *page, char **start, off_t off,
+				 int count, int *eof, void *data)
+{
+	int len, cpu;
+	char *cp = page;
+
+	for_each_cpu(cpu)
+		cp += sprintf (cp, "%d ", per_cpu(dec_ticks, cpu));
+
+	len = cp - page;
+
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
 extern struct seq_operations cpuinfo_op;
 static int cpuinfo_open(struct inode *inode, struct file *file)
 {
@@ -740,6 +756,7 @@ void __init proc_misc_init(void)
 		{"uptime",	uptime_read_proc},
 		{"meminfo",	meminfo_read_proc},
 		{"version",	version_read_proc},
+		{"decrementer",	decrementer_read_proc},
 #ifdef CONFIG_PROC_HARDWARE
 		{"hardware",	hardware_read_proc},
 #endif

_

-- 
Regards,
vatsa

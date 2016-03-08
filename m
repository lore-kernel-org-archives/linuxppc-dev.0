Return-Path: <pmladek@suse.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E0D41A009D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 03:03:06 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B8B3F14012C
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 03:03:04 +1100 (AEDT)
Date: Tue, 8 Mar 2016 17:02:59 +0100
From: Petr Mladek <pmladek@suse.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@ozlabs.org, duwe@lst.de, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz,
 mpe@ellerman.id.au, jikos@kernel.org, Torsten Duwe <duwe@suse.de>
Subject: Re: [v5][PATCH] livepatch/ppc: Enable livepatching on powerpc
Message-ID: <20160308160259.GF10940@pathway.suse.cz>
References: <1457422437-3357-1-git-send-email-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457422437-3357-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue 2016-03-08 18:33:57, Balbir Singh wrote:
> Changelog v5:
> 	1. Removed the mini-stack frame created for klp_return_helper.
> 	   As a result of the mini-stack frame, function with > 8
> 	   arguments could not be patched
> 	2. Removed camel casing in the comments

I tested this patch and it fails when I call a patched printk()
from a module.

You might try it with the test patch below. It is a bit twisted
because it calls the patched printk from livepatch_cmdline_proc_show()
that it added by the same patch module. Please, look at
livepatch_cmdline_proc_show(), it does:

	static int count;

	if (!count++)
		trace_printk("%s\n", "this has been live patched");
	else
		printk("%s\n", "this has been live patched");


It means that calls only trace_printk() when called first time.
It calls the patched printk when called second time.


I have tested it the following way:


# booted kernel with the changes below
# applied the patch:
$> modprobe livepatch-sample

# trigger the pached printk()
$>cat /sys/kernel/livepatch/livepatch_sample/enabled
1

# look into both dmesg and trace buffer
$> dmesg | tail -n 1
[  727.537307] patch enabled: 1
$> cat /sys/kernel/debug/tracing/trace | tail -n 1
             cat-3588  [003] ....   727.537448: livepatch_printk: patch enabled: 1

# trigger livepatch_cmdline_proc_show() 1st time
c79:~ # cat /proc/cmdline 
this has been live patched

# the message appeared only in trace buffer
$> dmesg | tail -n 1
[  727.537307] patch enabled: 1
c79:~ # cat /sys/kernel/debug/tracing/trace | tail -n 1
             cat-3511  [000] ....    862.958383:	     livepatch_cmdline_proc_show: this has been live patched


# trigger livepatch_cmdline_proc_show() 2nd time
c79:~ # cat /proc/cmdline 

!!! KABOOM !!!

It is becaused it tried to call the patched printk()?

Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0xc0000000023f014c
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=2048 NUMA pSeries
Modules linked in: livepatch_sample af_packet dm_mod rtc_generic e1000 ext4 crc16 mbcache jbd2 sr_mod cdrom sd_mod ibmvscsi scsi_transport_srp sg scsi_mod autofs4
CPU: 1 PID: 3514 Comm: cat Tainted: G              K 4.5.0-rc7-11-default+ #110
task: c000000003e60e20 ti: c000000003d38000 task.ti: c000000003d38000
NIP: c0000000023f014c LR: c0000000023f014c CTR: c0000000001a72c0
REGS: c000000003d3b930 TRAP: 0400   Tainted: G              K  (4.5.0-rc7-11-default+)
MSR: 8000000010009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28222022  XER: 20000000
CFAR: c000000000009e9c SOFTE: 1 
GPR00: c0000000023f014c c000000003d3bbb0 c000000000fae100 0000000000000000 
GPR04: c0000000fea60038 000000000000000c 0000000068637461 0000000000000068 
GPR08: 0000000000000000 c000000003e627cc c000000003e60e20 d0000000023f0308 
GPR12: 0000000000002200 c000000007e80300 0000000010020360 0000000000010000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000010000300000 c0000000035bf540 0000000000010000 c000000003d3be00 
GPR24: c0000000035b8500 0000000000000000 fffffffffffff000 c000000003d3bc58 
GPR28: 0000010000300000 c0000000035bf500 d0000000023f0578 d0000000023f0558 
NIP [c0000000023f014c] 0xc0000000023f014c
LR [c0000000023f014c] 0xc0000000023f014c
Call Trace:
[c000000003d3bbb0] [c0000000023f014c] 0xc0000000023f014c (unreliable)
[c000000003d3bc30] [c000000000009e88] klp_return_helper+0x0/0x18
[c000000003d3bcd0] [c00000000034798c] proc_reg_read+0x8c/0xd0
[c000000003d3bd00] [c0000000002b7fbc] __vfs_read+0x4c/0x160
[c000000003d3bd90] [c0000000002b9318] vfs_read+0xa8/0x1c0
[c000000003d3bde0] [c0000000002ba61c] SyS_read+0x6c/0x110
[c000000003d3be30] [c000000000009204] system_call+0x38/0xb4
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
---[ end trace 17a32fcaa99f5af5 ]---



Here is the patch that I used:

>From 313627cab861dd53d3325efc3d4d364eee77f9db Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Tue, 8 Mar 2016 13:51:02 +0100
Subject: [PATCH] livepatch: test_printk() patch

!!!!IMPORTANT!!!

The patch is a bit ugly because cmdline_proc_show() can be called
also by some other code. So, you might get the crash earlier than
you expect.
---
 include/linux/printk.h               |  3 +++
 kernel/livepatch/core.c              |  1 +
 kernel/printk/printk.c               | 23 +++++++++++++++++++++
 samples/livepatch/livepatch-sample.c | 39 ++++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 9ccbdf2c1453..ffe0ceb56972 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -125,6 +125,9 @@ void early_printk(const char *s, ...) { }
 typedef __printf(1, 0) int (*printk_func_t)(const char *fmt, va_list args);
 
 #ifdef CONFIG_PRINTK
+int vprintk_default(const char *fmt, va_list args);
+int test_printk(const char *fmt, ...);
+
 asmlinkage __printf(5, 0)
 int vprintk_emit(int facility, int level,
 		 const char *dict, size_t dictlen,
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index e2dbf0127f0f..7d0a6029043c 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -615,6 +615,7 @@ static ssize_t enabled_show(struct kobject *kobj,
 	struct klp_patch *patch;
 
 	patch = container_of(kobj, struct klp_patch, kobj);
+	printk("patch enabled: %d\n", patch->state);
 	return snprintf(buf, PAGE_SIZE-1, "%d\n", patch->state);
 }
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c963ba534a78..9f785bfbb3fd 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1920,6 +1920,29 @@ asmlinkage __visible int printk(const char *fmt, ...)
 }
 EXPORT_SYMBOL(printk);
 
+int test_printk(const char *fmt, ...)
+{
+	printk_func_t vprintk_func;
+	va_list args;
+	int r;
+
+	va_start(args, fmt);
+
+	/*
+	 * If a caller overrides the per_cpu printk_func, then it needs
+	 * to disable preemption when calling printk(). Otherwise
+	 * the printk_func should be set to the default. No need to
+	 * disable preemption here.
+	 */
+	vprintk_func = this_cpu_read(printk_func);
+	r = vprintk_func(fmt, args);
+
+	va_end(args);
+
+	return r;
+}
+EXPORT_SYMBOL(test_printk);
+
 #else /* CONFIG_PRINTK */
 
 #define LOG_LINE_MAX		0
diff --git a/samples/livepatch/livepatch-sample.c b/samples/livepatch/livepatch-sample.c
index fb8c8614e728..d5c09bc629e8 100644
--- a/samples/livepatch/livepatch-sample.c
+++ b/samples/livepatch/livepatch-sample.c
@@ -40,16 +40,53 @@
  */
 
 #include <linux/seq_file.h>
+#include <linux/printk.h>
 static int livepatch_cmdline_proc_show(struct seq_file *m, void *v)
 {
+	static int count;
+
+	if (!count++)
+		trace_printk("%s\n", "this has been live patched");
+	else
+		printk("%s\n", "this has been live patched");
+
 	seq_printf(m, "%s\n", "this has been live patched");
 	return 0;
 }
 
+asmlinkage static int livepatch_printk(const char *fmt, ...)
+{
+	va_list args, args2;
+	int r = 0;
+
+	va_start(args, fmt);
+
+	/*
+	 * If a caller overrides the per_cpu printk_func, then it needs
+	 * to disable preemption when calling printk(). Otherwise
+	 * the printk_func should be set to the default. No need to
+	 * disable preemption here.
+	 */
+	vprintk_default(fmt, args);
+
+	va_end(args);
+
+	va_start(args2, fmt);
+	ftrace_vprintk(fmt, args2);
+	va_end(args2);
+
+
+	return r;
+}
+
 static struct klp_func funcs[] = {
 	{
 		.old_name = "cmdline_proc_show",
 		.new_func = livepatch_cmdline_proc_show,
+	},
+	{
+		.old_name = "printk",
+		.new_func = livepatch_printk,
 	}, { }
 };
 
@@ -77,6 +114,8 @@ static int livepatch_init(void)
 		WARN_ON(klp_unregister_patch(&patch));
 		return ret;
 	}
+	/* Make sure that trace_printk buffers are allocated. */
+	trace_printk("LivePatch sample loaded\n");
 	return 0;
 }
 
-- 
1.8.5.6

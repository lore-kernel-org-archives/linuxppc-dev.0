Return-Path: <anton@ozlabs.org>
Date: Mon, 8 Feb 2010 11:44:16 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Add last sysfs file and dump of ftrace buffer to
	oops printout
Message-ID: <20100208004416.GK32246@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Add printout of last accessed sysfs file, added to x86 in
ae87221d3ce49d9de1e43756da834fd0bf05a2ad (sysfs: crash debugging)

Also add the notify_die hook that allows us to print out the ftrace
buffer on oops. This is useful in conjunction with ftrace function_graph:


Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=128 NUMA pSeries
last sysfs file: /sys/class/net/tunl0/type
Dumping ftrace buffer:

...

  0)               |                .sysrq_handle_crash() {
  0)   0.476 us    |                  .hash_page();
  0)   0.488 us    |                  .xmon_fault_handler();
  0)               |                  .bad_page_fault() {
  0)               |                    .search_exception_tables() {
  0)   0.590 us    |                      .search_module_extables();
  0)   2.546 us    |                    }
  0)               |                    .printk() {
  0)               |                      .vprintk() {
  0)   0.488 us    |                        ._raw_spin_lock();
  0)   0.572 us    |                        .emit_log_char();


Showing the function graph of a sysrq-c crash.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/kernel/traps.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/traps.c	2010-02-08 11:15:51.463071942 +1100
+++ powerpc.git/arch/powerpc/kernel/traps.c	2010-02-08 11:17:29.914321833 +1100
@@ -146,6 +146,11 @@ int die(const char *str, struct pt_regs 
 #endif
 		printk("%s\n", ppc_md.name ? ppc_md.name : "");
 
+		sysfs_printk_last_file();
+		if (notify_die(DIE_OOPS, str, regs, err, 255,
+			       SIGSEGV) == NOTIFY_STOP)
+			return 1;
+
 		print_modules();
 		show_regs(regs);
 	} else {

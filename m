Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC7F30KFczDrVJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 16:59:35 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id e199so5442142pfh.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 23:59:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH v2 2/3] powerpc/powernv: machine check use kernel crash path
Date: Wed, 19 Jul 2017 16:59:11 +1000
Message-Id: <20170719065912.19183-3-npiggin@gmail.com>
In-Reply-To: <20170719065912.19183-1-npiggin@gmail.com>
References: <20170719065912.19183-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are quite a few machine check exceptions that can be caused by
kernel bugs. To make debugging easier, use the kernel crash path in
cases of synchronous machine checks that occur in kernel mode, if that
would not result in the machine going straight to panic or crash dump.

There is a downside here that die()ing the process in kernel mode can
still leave the system unstable. panic_on_oops will always force the
system to fail-stop, so systems where that behaviour is important will
still do the right thing.

As a test, when triggering an i-side 0111b error (ifetch from foreign
address) in kernel mode process context on POWER9, the kernel currently
dies quickly like this:

Severe Machine check interrupt [Not recovered]
  NIP [ffff000000000000]: 0xffff000000000000
  Initiator: CPU
  Error type: Real address [Instruction fetch (foreign)]
[  127.426651616,0] OPAL: Reboot requested due to Platform error.
    Effective[  127.426693712,3] OPAL: Reboot requested due to Platform error. address: ffff000000000000
opal: Reboot type 1 not supported
Kernel panic - not syncing: PowerNV Unrecovered Machine Check
CPU: 56 PID: 4425 Comm: syscall Tainted: G   M            4.12.0-rc1-13857-ga4700a261072-dirty #35
Call Trace:
[  128.017988928,4] IPMI: BUG: Dropping ESEL on the floor due to buggy/mising code in OPAL for this BMCRebooting in 10 seconds..
Trying to free IRQ 496 from IRQ context!


After this patch, the process is killed and the kernel continues with
this message, which gives enough information to identify the offending
branch (i.e., with CFAR):

Severe Machine check interrupt [Not recovered]
  NIP [ffff000000000000]: 0xffff000000000000
  Initiator: CPU
  Error type: Real address [Instruction fetch (foreign)]
    Effective address: ffff000000000000
Oops: Machine check, sig: 7 [#1]
SMP NR_CPUS=2048
NUMA
PowerNV
Modules linked in: iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp tun bridge stp llc kvm_hv kvm iptable_filter binfmt_misc vmx_crypto ip_tables x_tables autofs4 crc32c_vpmsum
CPU: 22 PID: 4436 Comm: syscall Tainted: G   M            4.12.0-rc1-13857-ga4700a261072-dirty #36
task: c000000932300000 task.stack: c000000932380000
NIP: ffff000000000000 LR: 00000000217706a4 CTR: ffff000000000000
REGS: c00000000fc8fd80 TRAP: 0200   Tainted: G   M             (4.12.0-rc1-13857-ga4700a261072-dirty)
MSR: 90000000001c1003 <SF,HV,ME,RI,LE>
  CR: 24000484  XER: 20000000
CFAR: c000000000004c80 DAR: 0000000021770a90 DSISR: 0a000000 SOFTE: 1
GPR00: 0000000000001ebe 00007fffce4818b0 0000000021797f00 0000000000000000
GPR04: 00007fff8007ac24 0000000044000484 0000000000004000 00007fff801405e8
GPR08: 900000000280f033 0000000024000484 0000000000000000 0000000000000030
GPR12: 9000000000001003 00007fff801bc370 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR28: 00007fff801b0000 0000000000000000 00000000217707a0 00007fffce481918
NIP [ffff000000000000] 0xffff000000000000
LR [00000000217706a4] 0x217706a4
Call Trace:
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
---[ end trace 32ae1dabb4f8dae6 ]---

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/bug.h        |  1 +
 arch/powerpc/include/asm/fadump.h     |  2 ++
 arch/powerpc/kernel/fadump.c          |  9 ++++++++-
 arch/powerpc/kernel/traps.c           | 22 ++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c | 32 ++++++++++++++++++++++++++------
 5 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 0151af6c2a50..9a918b3ca5ee 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -133,6 +133,7 @@ extern int do_page_fault(struct pt_regs *, unsigned long, unsigned long);
 extern void bad_page_fault(struct pt_regs *, unsigned long, int);
 extern void _exception(int, struct pt_regs *, int, unsigned long);
 extern void die(const char *, struct pt_regs *, long);
+extern bool die_will_crash(void);
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index ce88bbe1d809..5a23010af600 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -209,11 +209,13 @@ extern int early_init_dt_scan_fw_dump(unsigned long node,
 extern int fadump_reserve_mem(void);
 extern int setup_fadump(void);
 extern int is_fadump_active(void);
+extern int should_fadump_crash(void);
 extern void crash_fadump(struct pt_regs *, const char *);
 extern void fadump_cleanup(void);
 
 #else	/* CONFIG_FA_DUMP */
 static inline int is_fadump_active(void) { return 0; }
+static inline int should_fadump_crash(void) { return 0; }
 static inline void crash_fadump(struct pt_regs *regs, const char *str) { }
 #endif
 #endif
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index da8830e49696..8a3058f5943b 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -125,6 +125,13 @@ int is_fadump_boot_memory_area(u64 addr, ulong size)
 	return (addr + size) > RMA_START && addr <= fw_dump.boot_memory_size;
 }
 
+int should_fadump_crash(void)
+{
+	if (!fw_dump.dump_registered || !fw_dump.fadumphdr_addr)
+		return 0;
+	return 1;
+}
+
 int is_fadump_active(void)
 {
 	return fw_dump.dump_active;
@@ -518,7 +525,7 @@ void crash_fadump(struct pt_regs *regs, const char *str)
 	struct fadump_crash_info_header *fdh = NULL;
 	int old_cpu, this_cpu;
 
-	if (!fw_dump.dump_registered || !fw_dump.fadumphdr_addr)
+	if (!should_fadump_crash())
 		return;
 
 	/*
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 574e949f8db9..2849c4f50324 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -114,6 +114,28 @@ static void pmac_backlight_unblank(void)
 static inline void pmac_backlight_unblank(void) { }
 #endif
 
+/*
+ * If oops/die is expected to crash the machine, return true here.
+ *
+ * This should not be expected to be 100% accurate, there may be
+ * notifiers registered or other unexpected conditions that may bring
+ * down the kernel. Or if the current process in the kernel is holding
+ * locks or has other critical state, the kernel may become effectively
+ * unusable anyway.
+ */
+bool die_will_crash(void)
+{
+	if (should_fadump_crash())
+		return true;
+	if (kexec_should_crash(current))
+		return true;
+	if (in_interrupt() || panic_on_oops ||
+			!current->pid || is_global_init(current))
+		return true;
+
+	return false;
+}
+
 static arch_spinlock_t die_lock = __ARCH_SPIN_LOCK_UNLOCKED;
 static int die_owner = -1;
 static unsigned int die_nest_count;
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 96436d129684..140350aacca5 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -34,6 +34,7 @@
 #include <asm/opal.h>
 #include <asm/firmware.h>
 #include <asm/mce.h>
+#include <asm/bug.h>
 
 #include "powernv.h"
 
@@ -426,17 +427,36 @@ static int opal_recover_mce(struct pt_regs *regs,
 		/* Fatal machine check */
 		pr_err("Machine check interrupt is fatal\n");
 		recovered = 0;
-	} else if ((evt->severity == MCE_SEV_ERROR_SYNC) &&
-			(user_mode(regs) && !is_global_init(current))) {
+	}
+
+	if (!recovered && evt->severity == MCE_SEV_ERROR_SYNC) {
 		/*
-		 * For now, kill the task if we have received exception when
-		 * in userspace.
+		 * Try to kill processes if we get a synchronous machine check
+		 * (e.g., one caused by execution of this instruction). This
+		 * will devolve into a panic if we try to kill init or are in
+		 * an interrupt etc.
 		 *
 		 * TODO: Queue up this address for hwpoisioning later.
+		 * TODO: This is not quite right for d-side machine
+		 *       checks ->nip is not necessarily the important
+		 *       address.
 		 */
-		_exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
-		recovered = 1;
+		if ((user_mode(regs))) {
+			_exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
+			recovered = 1;
+		} else if (die_will_crash()) {
+			/*
+			 * die() would kill the kernel, so better to go via
+			 * the platform reboot code that will log the
+			 * machine check.
+			 */
+			recovered = 0;
+		} else {
+			die("Machine check", regs, SIGBUS);
+			recovered = 1;
+		}
 	}
+
 	return recovered;
 }
 
-- 
2.11.0

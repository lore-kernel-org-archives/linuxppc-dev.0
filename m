Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbnJD3XQFzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 16:43:40 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id w69so11230536pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 May 2017 23:43:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [RFC] powerpc/powernv: machine check use kernel crash path
Date: Mon, 29 May 2017 16:43:28 +1000
Message-Id: <20170529064328.22300-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the normal kernel crash path in more cases (whenever we're not
the init task), because it generally leads to much better Linux crash
information.

POWER9 has introduced more machine check conditions that can be
triggered by programming errors (as opposed to hardware errors),
which need to be debugged in Linux.

It's unclear what the best way is to do this. Do we need to base the
behaviour on the type of error? That might be impossible to do really
well because some types of errors (e.g., translation multi hits) can
be caused by software or hardware failures. Best would be to do
something that works well for both.

So what does BMC/OCC need here? Should we plumb
OPAL_REBOOT_PLATFORM_ERROR into the generic crash path somehow (to be
triggered by a special case of die()/panic()?

This patch is just an RFC only, but when I test triggering a 0111b
error from (kernel) process context after the previous patch, this
patch changes the result from taking down the system with:

w8l login: Severe Machine check interrupt [Not recovered]
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

To killing the process and continuing with:

w8l login: Severe Machine check interrupt [Not recovered]
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
---
 arch/powerpc/platforms/powernv/opal.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 59684b4af4d1..67df76ac1fba 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -30,6 +30,7 @@
 #include <asm/opal.h>
 #include <asm/firmware.h>
 #include <asm/mce.h>
+#include <asm/bug.h>
 
 #include "powernv.h"
 
@@ -407,16 +408,28 @@ static int opal_recover_mce(struct pt_regs *regs,
 		/* Fatal machine check */
 		pr_err("Machine check interrupt is fatal\n");
 		recovered = 0;
-	} else if ((evt->severity == MCE_SEV_ERROR_SYNC) &&
-			(user_mode(regs) && !is_global_init(current))) {
+	} else if ((evt->severity == MCE_SEV_ERROR_SYNC)
+					&& !is_global_init(current)) {
 		/*
-		 * For now, kill the task if we have received exception when
-		 * in userspace.
-		 *
-		 * TODO: Queue up this address for hwpoisioning later.
+		 * Try to kill processes if we get a synchronous machine check
+		 * and are not "init" (see opal_machine_check() comment about
+		 * not going via normal panic path in case we are in early
+		 * boot).
 		 */
-		_exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
-		recovered = 1;
+		if ((user_mode(regs)) {
+			/*
+			 * For now, kill the task if we have received exception
+			 * when in userspace.
+			 *
+			 * TODO: Queue up this address for hwpoisioning later.
+			 */
+			_exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
+			recovered = 1;
+		} else {
+			/* Kernel mode in process context */
+			die("Machine check", regs, SIGBUS);
+			recovered = 1;
+		}
 	}
 	return recovered;
 }
-- 
2.11.0

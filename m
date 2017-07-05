Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2S1n2QRszDr1p
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 14:04:45 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id d193so11265528pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jul 2017 21:04:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH 2/4] powerpc/powernv: machine check use kernel crash path
Date: Wed,  5 Jul 2017 14:04:20 +1000
Message-Id: <20170705040422.20933-3-npiggin@gmail.com>
In-Reply-To: <20170705040422.20933-1-npiggin@gmail.com>
References: <20170705040422.20933-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the kernel crash path in cases of recovered machine checks that
occur in kernel mode, because it gives much better Linux crash
information, and can allow the offending process to be killed without
completely taking down the system.


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
branch (e.g., CFAR):

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
---
 arch/powerpc/platforms/powernv/opal.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 4b2505d98eb8..92f00113227f 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -30,6 +30,7 @@
 #include <asm/opal.h>
 #include <asm/firmware.h>
 #include <asm/mce.h>
+#include <asm/bug.h>
 
 #include "powernv.h"
 
@@ -407,15 +408,22 @@ static int opal_recover_mce(struct pt_regs *regs,
 		/* Fatal machine check */
 		pr_err("Machine check interrupt is fatal\n");
 		recovered = 0;
-	} else if ((evt->severity == MCE_SEV_ERROR_SYNC) &&
-			(user_mode(regs) && !is_global_init(current))) {
+	} else if (evt->severity == MCE_SEV_ERROR_SYNC) {
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
+		if ((user_mode(regs)))
+			_exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
+		else
+			die("Machine check", regs, SIGBUS);
 		recovered = 1;
 	}
 	return recovered;
-- 
2.11.0

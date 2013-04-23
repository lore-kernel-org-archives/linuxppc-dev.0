Return-Path: <r61911@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 572CA2C017B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 17:18:59 +1000 (EST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] powerpc/fsl-pci:fix incorrect iounmap pci
 hose->private_data
Date: Tue, 23 Apr 2013 23:18:03 +0800
Message-ID: <1366730283-14606-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Yuanquan Chen <Yuanquan.Chen@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pci hose->private_data will be used by other function, for example,
fsl_pcie_check_link(), so do not iounmap it.

fix the kerenl crash on T4240:

Unable to handle kernel paging request for data at address
0x8000080080060f14
Faulting instruction address: 0xc000000000032554
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=24 T4240 QDS
Modules linked in:
NIP: c000000000032554 LR: c00000000003254c CTR: c00000000001e5c0
REGS: c000000179143440 TRAP: 0300   Not tainted
(3.8.8-rt2-00754-g951f064-dirt)
MSR: 0000000080029000 <CE,EE,ME>  CR: 24adbe22  XER: 00000000
SOFTE: 0
DEAR: 8000080080060f14, ESR: 0000000000000000
TASK = c00000017913d2c0[1] 'swapper/0' THREAD: c000000179140000 CPU: 2
GPR00: c00000000003254c c0000001791436c0 c000000000ae2998
0000000000000027
GPR04: 0000000000000000 00000000000005a5 0000000000000000
0000000000000002
GPR08: 3030303038303038 c000000000a2d4d0 c000000000aebeb8
c000000000af2998
GPR12: 0000000024adbe22 c00000000fffa800 c000000000001be0
0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
GPR20: 0000000000000000 0000000000000000 0000000000000000
c0000000009ddf70
GPR24: c0000000009e8d40 c000000000af2998 c000000000b1529c
c000000179143b40
GPR28: c0000001799b4000 c000000179143c00 8000080080060000
c000000000727ec8
NIP [c000000000032554] .fsl_pcie_check_link+0x104/0x150
LR [c00000000003254c] .fsl_pcie_check_link+0xfc/0x150
Call Trace:
[c0000001791436c0] [c00000000003254c] .fsl_pcie_check_link+0xfc/0x150
(unreliab)
[c000000179143a30] [c0000000000325d4]
.fsl_indirect_read_config+0x34/0xb0
[c000000179143ad0] [c0000000002c7ee8]
.pci_bus_read_config_byte+0x88/0xd0
[c000000179143b90] [c0000000009c0528] .pci_apply_final_quirks+0x9c/0x18c
[c000000179143c40] [c00000000000142c] .do_one_initcall+0x5c/0x1f0
[c000000179143cf0] [c0000000009a0bb4] .kernel_init_freeable+0x180/0x264
[c000000179143db0] [c000000000001bfc] .kernel_init+0x1c/0x420
[c000000179143e30] [c0000000000008b4] .ret_from_kernel_thread+0x64/0xb0
Instruction dump:
60000000 4bffffa0 ebc301d0 3fe2ffc4 3c62ffe0 3bff5530 38638a78 7fe4fb78
7fc5f378 486ea77d 60000000 7c0004ac <801e0f14> 0c000000 4c00012c
3c62ffe0
---[ end trace f841fbc03c9d2e1b ]---

Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Rebooting in 180 seconds..

Signed-off-by: Yuanquan Chen <Yuanquan.Chen@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
based on Kumar's next branch
v2:v1, fix the exit issue

 arch/powerpc/sysdev/fsl_pci.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index f823304..cffe7ed 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -244,12 +244,12 @@ static void setup_pci_atmu(struct pci_controller *hose)
 
 	if (paddr_hi == paddr_lo) {
 		pr_err("%s: No outbound window space\n", name);
-		goto out;
+		return;
 	}
 
 	if (paddr_lo == 0) {
 		pr_err("%s: No space for inbound window\n", name);
-		goto out;
+		return;
 	}
 
 	/* setup PCSRBAR/PEXCSRBAR */
@@ -395,9 +395,6 @@ static void setup_pci_atmu(struct pci_controller *hose)
 		pr_info("%s: DMA window size is 0x%llx\n", name,
 			(u64)hose->dma_window_size);
 	}
-
-out:
-	iounmap(pci);
 }
 
 static void __init setup_pci_cmd(struct pci_controller *hose)
-- 
1.7.9.5

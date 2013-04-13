Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C18CE2C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Apr 2013 17:14:51 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/fsl-pci: don't unmap the PCI SoC controller registers
 in setup_pci_atmu
Date: Sat, 13 Apr 2013 15:14:41 +0800
Message-ID: <1365837281-27002-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In patch 34642bbb (powerpc/fsl-pci: Keep PCI SoC controller registers in
pci_controller) we choose to keep the map of the PCI SoC controller
registers. But we missed to delete the unmap in setup_pci_atmu
function. This will cause the following call trace once we access
the PCI SoC controller registers later.

Unable to handle kernel paging request for data at address 0x8000080080040f14
Faulting instruction address: 0xc00000000002ea58
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=24 T4240 QDS
Modules linked in:
NIP: c00000000002ea58 LR: c00000000002eaf4 CTR: c00000000002eac0
REGS: c00000017e10b4a0 TRAP: 0300   Not tainted  (3.9.0-rc1-00052-gfa3529f-dirty)
MSR: 0000000080029000 <CE,EE,ME>  CR: 28adbe22  XER: 00000000
SOFTE: 0
DEAR: 8000080080040f14, ESR: 0000000000000000
TASK = c00000017e100000[1] 'swapper/0' THREAD: c00000017e108000 CPU: 2
GPR00: 0000000000000000 c00000017e10b720 c0000000009928d8 c00000017e578e00
GPR04: 0000000000000000 000000000000000c 0000000000000001 c00000017e10bb40
GPR08: 0000000000000000 8000080080040000 0000000000000000 0000000000000016
GPR12: 0000000088adbe22 c00000000fffa800 c000000000001ba0 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000008a5b70
GPR24: c0000000008af938 c0000000009a28d8 c0000000009bb5dc c00000017e10bb40
GPR28: c00000017e32a400 c00000017e10bc00 c00000017e32a400 c00000017e578e00
NIP [c00000000002ea58] .fsl_pcie_check_link+0x88/0xf0
LR [c00000000002eaf4] .fsl_indirect_read_config+0x34/0xb0
Call Trace:
[c00000017e10b720] [c00000017e10b7a0] 0xc00000017e10b7a0 (unreliable)
[c00000017e10ba30] [c00000000002eaf4] .fsl_indirect_read_config+0x34/0xb0
[c00000017e10bad0] [c00000000033aa08] .pci_bus_read_config_byte+0x88/0xd0
[c00000017e10bb90] [c00000000088d708] .pci_apply_final_quirks+0x9c/0x18c
[c00000017e10bc40] [c0000000000013dc] .do_one_initcall+0x5c/0x1f0
[c00000017e10bcf0] [c00000000086ebac] .kernel_init_freeable+0x180/0x26c
[c00000017e10bdb0] [c000000000001bbc] .kernel_init+0x1c/0x460
[c00000017e10be30] [c000000000000880] .ret_from_kernel_thread+0x64/0xe4
Instruction dump:
38210310 2b800015 4fdde842 7c600026 5463fffe e8010010 7c0803a6 4e800020
60000000 60000000 e92301d0 7c0004ac <80690f14> 0c030000 4c00012c 38210310
---[ end trace 7a8fe0cbccb7d992 ]---

Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
This is based on Kumar's next branch.

 arch/powerpc/sysdev/fsl_pci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 40ffe29..cf81d65 100644
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
1.8.1.4

Return-Path: <r66093@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id ECEF5B6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2012 17:37:00 +1100 (EST)
Received: from mail133-ch1 (localhost [127.0.0.1])	by
 mail133-ch1-R.bigfish.com (Postfix) with ESMTP id D33A930030A	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2012 06:36:54 +0000 (UTC)
Received: from CH1EHSMHS024.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.254])	by mail133-ch1.bigfish.com (Postfix) with ESMTP id
 98662C0047
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2012 06:36:52 +0000 (UTC)
From: <r66093@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: check the return value of fsl_add_bridge
Date: Mon, 9 Jan 2012 13:45:31 +0800
Message-ID: <1326087931-2515-1-git-send-email-r66093@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

For all mpc85xx DS/MDS boards, we should check the return value from
function "fsl_add_bridge", otherwise, when pcie node status is disabled,
the kernel will panic when perform the function "pci_find_hose_for_OF_device"
because the hose controller is NULL.

below is the call trace log:
NIP: c05bca80 LR: c05bca78 CTR: c000ec54
REGS: c0615eb0 TRAP: 0300   Not tainted  (3.2.0-rc3-00090-gfa8cbaa-dirty)
MSR: 00021000 <CE,ME>  CR: 84044022  XER: 20000000
DEAR: 00000110, ESR: 00000000
TASK = c05e8380[0] 'swapper' THREAD: c0614000
GPR00: c05bca70 c0615f60 c05e8380 00000000 c0550a08 ffffffff c0613140 c061314c
GPR08: 00000000 00000000 00000286 c0620000 84044022 1009d368 00000000 00000000
GPR16: c0000a00 00000014 3fffffff 03ff9000 00000015 7ff3a724 c0614000 00000000
GPR24: 00000000 00000000 00008000 c0550a08 c0534808 efbe3834 00000000 ffffffff
NIP [c05bca80] p1022_ds_setup_arch+0xa8/0x1ac
LR [c05bca78] p1022_ds_setup_arch+0xa0/0x1ac
Call Trace:
[c0615f60] [c05bca70] p1022_ds_setup_arch+0x98/0x1ac (unreliable)
[c0615fb0] [c05b88e0] setup_arch+0x1e8/0x224
[c0615fc0] [c05b4524] start_kernel+0x84/0x2d8
[c0615ff0] [c00003c4] skpinv+0x2b0/0x2ec
Instruction dump:
5400033e 7f80d000 7fa3eb78 40be0010 38800001 4bffedf1 48000008 4bffede9
7fa3eb78 4ba53119 7f64db78 7c691b78
81830114 7f85e378 8149010c
---[ end trace 31fd0ba7d8756001 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
Call Trace:
[c0615d90] [c0007b74] show_stack+0x44/0x154 (unreliable)
[c0615dd0] [c04495b8] panic+0xa4/0x1d4
[c0615e20] [c003e7b8] do_exit+0x588/0x614
[c0615e70] [c000a00c] die+0xc8/0x198
[c0615e90] [c0011a1c] bad_page_fault+0xb4/0xfc
[c0615ea0] [c000e2e0] handle_page_fault+0x7c/0x80
--- Exception: 300 at p1022_ds_setup_arch+0xa8/0x1ac
    LR = p1022_ds_setup_arch+0xa0/0x1ac
[c0615f60] [c05bca70] p1022_ds_setup_arch+0x98/0x1ac (unreliable)
[c0615fb0] [c05b88e0] setup_arch+0x1e8/0x224
[c0615fc0] [c05b4524] start_kernel+0x84/0x2d8
[c0615ff0] [c00003c4] skpinv+0x2b0/0x2ec

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
 arch/powerpc/platforms/85xx/corenet_ds.c   |    5 ++++-
 arch/powerpc/platforms/85xx/mpc8536_ds.c   |   13 +++++++++----
 arch/powerpc/platforms/85xx/mpc85xx_ds.c   |   13 +++++++++----
 arch/powerpc/platforms/85xx/mpc85xx_mds.c  |   13 +++++++++----
 arch/powerpc/platforms/85xx/p1022_ds.c     |   13 +++++++++----
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   14 ++++++++++----
 6 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index c48b661..9d72e3a 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -85,8 +85,11 @@ void __init corenet_ds_setup_arch(void)
 	for_each_node_by_type(np, "pci") {
 		if (of_device_is_compatible(np, "fsl,p4080-pcie") ||
 		    of_device_is_compatible(np, "fsl,qoriq-pcie-v2.2")) {
-			fsl_add_bridge(np, 0);
+			if (fsl_add_bridge(np, 0) < 0)
+				continue;
 			hose = pci_find_hose_for_OF_device(np);
+			if (!hose)
+				continue;
 			max = min(max, hose->dma_window_base_cur +
 					hose->dma_window_size);
 		}
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index 9ee6455..ee2ebbb 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -82,12 +82,17 @@ static void __init mpc8536_ds_setup_arch(void)
 		    of_device_is_compatible(np, "fsl,mpc8548-pcie")) {
 			struct resource rsrc;
 			of_address_to_resource(np, 0, &rsrc);
-			if ((rsrc.start & 0xfffff) == 0x8000)
-				fsl_add_bridge(np, 1);
-			else
-				fsl_add_bridge(np, 0);
+			if ((rsrc.start & 0xfffff) == 0x8000) {
+				if (fsl_add_bridge(np, 1) < 0)
+					continue;
+			} else {
+				if (fsl_add_bridge(np, 0) < 0)
+					continue;
+			}
 
 			hose = pci_find_hose_for_OF_device(np);
+			if (!hose)
+				continue;
 			max = min(max, hose->dma_window_base_cur +
 					hose->dma_window_size);
 		}
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 2113120..5eba5f0 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -175,12 +175,17 @@ static void __init mpc85xx_ds_setup_arch(void)
 		    of_device_is_compatible(np, "fsl,p2020-pcie")) {
 			struct resource rsrc;
 			of_address_to_resource(np, 0, &rsrc);
-			if ((rsrc.start & 0xfffff) == primary_phb_addr)
-				fsl_add_bridge(np, 1);
-			else
-				fsl_add_bridge(np, 0);
+			if ((rsrc.start & 0xfffff) == primary_phb_addr) {
+				if (fsl_add_bridge(np, 1) < 0)
+					continue;
+			} else {
+				if (fsl_add_bridge(np, 0) < 0)
+					continue;
+			}
 
 			hose = pci_find_hose_for_OF_device(np);
+			if (!hose)
+				continue;
 			max = min(max, hose->dma_window_base_cur +
 					hose->dma_window_size);
 		}
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 495cfd9..3a68122 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -351,12 +351,17 @@ static void __init mpc85xx_mds_setup_arch(void)
 		    of_device_is_compatible(np, "fsl,mpc8548-pcie")) {
 			struct resource rsrc;
 			of_address_to_resource(np, 0, &rsrc);
-			if ((rsrc.start & 0xfffff) == 0x8000)
-				fsl_add_bridge(np, 1);
-			else
-				fsl_add_bridge(np, 0);
+			if ((rsrc.start & 0xfffff) == 0x8000) {
+				if (fsl_add_bridge(np, 1) < 0)
+					continue;
+			} else {
+				if (fsl_add_bridge(np, 0) < 0)
+					continue;
+			}
 
 			hose = pci_find_hose_for_OF_device(np);
+			if (!hose)
+				continue;
 			max = min(max, hose->dma_window_base_cur +
 					hose->dma_window_size);
 		}
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 2bf4342..614768b 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -292,12 +292,17 @@ static void __init p1022_ds_setup_arch(void)
 
 		of_address_to_resource(np, 0, &rsrc);
 
-		if ((rsrc.start & 0xfffff) == 0x8000)
-			fsl_add_bridge(np, 1);
-		else
-			fsl_add_bridge(np, 0);
+		if ((rsrc.start & 0xfffff) == 0x8000) {
+			if (fsl_add_bridge(np, 1) < 0)
+				continue;
+		} else {
+			if (fsl_add_bridge(np, 0) < 0)
+				continue;
+		}
 
 		hose = pci_find_hose_for_OF_device(np);
+		if (!hose)
+			continue;
 		max = min(max, hose->dma_window_base_cur +
 			  hose->dma_window_size);
 	}
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 569262c..819f29b 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -83,11 +83,17 @@ mpc86xx_hpcn_setup_arch(void)
 	for_each_compatible_node(np, "pci", "fsl,mpc8641-pcie") {
 		struct resource rsrc;
 		of_address_to_resource(np, 0, &rsrc);
-		if ((rsrc.start & 0xfffff) == 0x8000)
-			fsl_add_bridge(np, 1);
-		else
-			fsl_add_bridge(np, 0);
+		if ((rsrc.start & 0xfffff) == 0x8000) {
+			if (fsl_add_bridge(np, 1) < 0)
+				continue;
+		} else {
+			if (fsl_add_bridge(np, 0) < 0)
+				continue;
+		}
+
 		hose = pci_find_hose_for_OF_device(np);
+		if (!hose)
+			continue;
 		max = min(max, hose->dma_window_base_cur +
 			  hose->dma_window_size);
 	}
-- 
1.7.5.4

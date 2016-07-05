Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBfb4GZMzDqsr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:05:43 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBfH3QGCz9s9Z
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:05:26 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 29/41] powerpc: Move 32-bit probe() machine to later in the
 boot process
Date: Tue,  5 Jul 2016 15:04:05 +1000
Message-Id: <1467695057-12431-30-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
References: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This converts all the 32-bit platforms to use the expanded device-tree
which is a pretty mechanical change. Unlike 64-bit, the 32-bit kernel
didn't rely on platform initializations to setup the MMU since it
sets it up entirely before probe_machine() so the move has comparatively
less consequences though it's a bigger patch.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2. Fix typos
v3. Fix more typos
---
 arch/powerpc/kernel/setup_32.c                    | 35 +++++++++++---------
 arch/powerpc/platforms/40x/ep405.c                |  4 +--
 arch/powerpc/platforms/40x/ppc40x_simple.c        |  2 +-
 arch/powerpc/platforms/40x/virtex.c               |  4 +--
 arch/powerpc/platforms/40x/walnut.c               |  4 +--
 arch/powerpc/platforms/44x/canyonlands.c          |  5 ++-
 arch/powerpc/platforms/44x/ebony.c                |  4 +--
 arch/powerpc/platforms/44x/iss4xx.c               |  4 +--
 arch/powerpc/platforms/44x/ppc44x_simple.c        |  3 +-
 arch/powerpc/platforms/44x/ppc476.c               |  6 ++--
 arch/powerpc/platforms/44x/sam440ep.c             |  4 +--
 arch/powerpc/platforms/44x/virtex.c               |  4 +--
 arch/powerpc/platforms/44x/warp.c                 |  4 +--
 arch/powerpc/platforms/512x/mpc5121_ads.c         |  4 +--
 arch/powerpc/platforms/512x/mpc512x_generic.c     |  2 +-
 arch/powerpc/platforms/512x/pdm360ng.c            |  4 +--
 arch/powerpc/platforms/52xx/efika.c               |  3 +-
 arch/powerpc/platforms/52xx/lite5200.c            |  2 +-
 arch/powerpc/platforms/52xx/media5200.c           |  2 +-
 arch/powerpc/platforms/52xx/mpc5200_simple.c      |  2 +-
 arch/powerpc/platforms/82xx/ep8248e.c             |  3 +-
 arch/powerpc/platforms/82xx/km82xx.c              |  3 +-
 arch/powerpc/platforms/82xx/mpc8272_ads.c         |  3 +-
 arch/powerpc/platforms/82xx/pq2fads.c             |  3 +-
 arch/powerpc/platforms/83xx/asp834x.c             |  3 +-
 arch/powerpc/platforms/83xx/km83xx.c              |  3 +-
 arch/powerpc/platforms/83xx/mpc830x_rdb.c         |  2 +-
 arch/powerpc/platforms/83xx/mpc831x_rdb.c         |  2 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c         |  4 +--
 arch/powerpc/platforms/83xx/mpc832x_rdb.c         |  4 +--
 arch/powerpc/platforms/83xx/mpc834x_itx.c         |  4 +--
 arch/powerpc/platforms/83xx/mpc834x_mds.c         |  4 +--
 arch/powerpc/platforms/83xx/mpc836x_mds.c         |  4 +--
 arch/powerpc/platforms/83xx/mpc836x_rdk.c         |  4 +--
 arch/powerpc/platforms/83xx/mpc837x_mds.c         |  4 +--
 arch/powerpc/platforms/83xx/mpc837x_rdb.c         |  2 +-
 arch/powerpc/platforms/83xx/sbc834x.c             |  4 +--
 arch/powerpc/platforms/85xx/bsc913x_qds.c         |  4 +--
 arch/powerpc/platforms/85xx/bsc913x_rdb.c         |  4 +--
 arch/powerpc/platforms/85xx/c293pcie.c            |  4 +--
 arch/powerpc/platforms/85xx/corenet_generic.c     |  5 ++-
 arch/powerpc/platforms/85xx/ge_imp3a.c            |  4 +--
 arch/powerpc/platforms/85xx/ksi8560.c             |  4 +--
 arch/powerpc/platforms/85xx/mpc8536_ds.c          |  4 +--
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |  4 +--
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |  4 +--
 arch/powerpc/platforms/85xx/mpc85xx_ds.c          | 12 ++-----
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         | 12 ++-----
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c         | 40 ++++++-----------------
 arch/powerpc/platforms/85xx/mvme2500.c            |  4 +--
 arch/powerpc/platforms/85xx/p1010rdb.c            |  6 ++--
 arch/powerpc/platforms/85xx/p1022_ds.c            |  4 +--
 arch/powerpc/platforms/85xx/p1022_rdk.c           |  4 +--
 arch/powerpc/platforms/85xx/p1023_rdb.c           |  4 +--
 arch/powerpc/platforms/85xx/ppa8548.c             |  4 +--
 arch/powerpc/platforms/85xx/qemu_e500.c           |  4 +--
 arch/powerpc/platforms/85xx/sbc8548.c             |  4 +--
 arch/powerpc/platforms/85xx/socrates.c            |  4 +--
 arch/powerpc/platforms/85xx/stx_gp3.c             |  4 +--
 arch/powerpc/platforms/85xx/tqm85xx.c             |  2 +-
 arch/powerpc/platforms/85xx/twr_p102x.c           |  4 +--
 arch/powerpc/platforms/85xx/xes_mpc85xx.c         | 12 ++-----
 arch/powerpc/platforms/86xx/gef_ppc9a.c           |  4 +--
 arch/powerpc/platforms/86xx/gef_sbc310.c          |  4 +--
 arch/powerpc/platforms/86xx/gef_sbc610.c          |  4 +--
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c        |  4 +--
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |  6 ++--
 arch/powerpc/platforms/86xx/sbc8641d.c            |  4 +--
 arch/powerpc/platforms/8xx/adder875.c             |  3 +-
 arch/powerpc/platforms/8xx/ep88xc.c               |  3 +-
 arch/powerpc/platforms/8xx/mpc86xads_setup.c      |  3 +-
 arch/powerpc/platforms/8xx/mpc885ads_setup.c      |  3 +-
 arch/powerpc/platforms/8xx/tqm8xx_setup.c         |  4 +--
 arch/powerpc/platforms/amigaone/setup.c           |  4 +--
 arch/powerpc/platforms/embedded6xx/c2k.c          |  4 +--
 arch/powerpc/platforms/embedded6xx/gamecube.c     |  5 +--
 arch/powerpc/platforms/embedded6xx/holly.c        |  4 +--
 arch/powerpc/platforms/embedded6xx/linkstation.c  |  6 +---
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |  4 +--
 arch/powerpc/platforms/embedded6xx/mvme5100.c     |  4 +--
 arch/powerpc/platforms/embedded6xx/storcenter.c   |  4 +--
 arch/powerpc/platforms/embedded6xx/wii.c          |  5 +--
 arch/powerpc/platforms/powermac/setup.c           |  8 -----
 83 files changed, 120 insertions(+), 289 deletions(-)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 3f0aca2..e7bb4e7 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -113,23 +113,7 @@ notrace void __init machine_init(u64 dt_ptr)
 
 	early_init_mmu();
 
-	probe_machine();
-
 	setup_kdump_trampoline();
-
-#ifdef CONFIG_6xx
-	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
-	    cpu_has_feature(CPU_FTR_CAN_NAP))
-		ppc_md.power_save = ppc6xx_idle;
-#endif
-
-#ifdef CONFIG_E500
-	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
-	    cpu_has_feature(CPU_FTR_CAN_NAP))
-		ppc_md.power_save = e500_idle;
-#endif
-	if (ppc_md.progress)
-		ppc_md.progress("id mach(): done", 0x200);
 }
 
 /* Checks "l2cr=xxxx" command-line option */
@@ -249,6 +233,21 @@ static void __init exc_lvl_early_init(void)
 #define exc_lvl_early_init()
 #endif
 
+static void setup_power_save(void)
+{
+#ifdef CONFIG_6xx
+	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
+	    cpu_has_feature(CPU_FTR_CAN_NAP))
+		ppc_md.power_save = ppc6xx_idle;
+#endif
+
+#ifdef CONFIG_E500
+	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
+	    cpu_has_feature(CPU_FTR_CAN_NAP))
+		ppc_md.power_save = e500_idle;
+#endif
+}
+
 /* Warning, IO base is not yet inited */
 void __init setup_arch(char **cmdline_p)
 {
@@ -260,6 +259,10 @@ void __init setup_arch(char **cmdline_p)
 	unflatten_device_tree();
 	check_for_initrd();
 
+	probe_machine();
+
+	setup_power_save();
+
 	if (ppc_md.init_early)
 		ppc_md.init_early();
 
diff --git a/arch/powerpc/platforms/40x/ep405.c b/arch/powerpc/platforms/40x/ep405.c
index ddc12a1..1c8aec6 100644
--- a/arch/powerpc/platforms/40x/ep405.c
+++ b/arch/powerpc/platforms/40x/ep405.c
@@ -105,9 +105,7 @@ static void __init ep405_setup_arch(void)
 
 static int __init ep405_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "ep405"))
+	if (!of_machine_is_compatible("ep405"))
 		return 0;
 
 	return 1;
diff --git a/arch/powerpc/platforms/40x/ppc40x_simple.c b/arch/powerpc/platforms/40x/ppc40x_simple.c
index b0c4637..2a05000 100644
--- a/arch/powerpc/platforms/40x/ppc40x_simple.c
+++ b/arch/powerpc/platforms/40x/ppc40x_simple.c
@@ -63,7 +63,7 @@ static const char * const board[] __initconst = {
 
 static int __init ppc40x_probe(void)
 {
-	if (of_flat_dt_match(of_get_flat_dt_root(), board)) {
+	if (of_device_compatible_match(of_root, board)) {
 		pci_set_flags(PCI_REASSIGN_ALL_RSRC);
 		return 1;
 	}
diff --git a/arch/powerpc/platforms/40x/virtex.c b/arch/powerpc/platforms/40x/virtex.c
index 9aa7ae2..91a08ea 100644
--- a/arch/powerpc/platforms/40x/virtex.c
+++ b/arch/powerpc/platforms/40x/virtex.c
@@ -37,9 +37,7 @@ machine_device_initcall(virtex, virtex_device_probe);
 
 static int __init virtex_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "xlnx,virtex"))
+	if (!of_machine_is_compatible("xlnx,virtex"))
 		return 0;
 
 	return 1;
diff --git a/arch/powerpc/platforms/40x/walnut.c b/arch/powerpc/platforms/40x/walnut.c
index f7ac2d0..e579781 100644
--- a/arch/powerpc/platforms/40x/walnut.c
+++ b/arch/powerpc/platforms/40x/walnut.c
@@ -46,9 +46,7 @@ machine_device_initcall(walnut, walnut_device_probe);
 
 static int __init walnut_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "ibm,walnut"))
+	if (!of_machine_is_compatible("ibm,walnut"))
 		return 0;
 
 	pci_set_flags(PCI_REASSIGN_ALL_RSRC);
diff --git a/arch/powerpc/platforms/44x/canyonlands.c b/arch/powerpc/platforms/44x/canyonlands.c
index 22ca543..157f4ce 100644
--- a/arch/powerpc/platforms/44x/canyonlands.c
+++ b/arch/powerpc/platforms/44x/canyonlands.c
@@ -53,11 +53,10 @@ machine_device_initcall(canyonlands, ppc460ex_device_probe);
 
 static int __init ppc460ex_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-	if (of_flat_dt_is_compatible(root, "amcc,canyonlands")) {
+	if (of_machine_is_compatible("amcc,canyonlands")) {
 		pci_set_flags(PCI_REASSIGN_ALL_RSRC);
 		return 1;
-		}
+	}
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/44x/ebony.c b/arch/powerpc/platforms/44x/ebony.c
index ae89322..1070225 100644
--- a/arch/powerpc/platforms/44x/ebony.c
+++ b/arch/powerpc/platforms/44x/ebony.c
@@ -49,9 +49,7 @@ machine_device_initcall(ebony, ebony_device_probe);
  */
 static int __init ebony_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "ibm,ebony"))
+	if (!of_machine_is_compatible("ibm,ebony"))
 		return 0;
 
 	pci_set_flags(PCI_REASSIGN_ALL_RSRC);
diff --git a/arch/powerpc/platforms/44x/iss4xx.c b/arch/powerpc/platforms/44x/iss4xx.c
index c7c6758..5f296dd 100644
--- a/arch/powerpc/platforms/44x/iss4xx.c
+++ b/arch/powerpc/platforms/44x/iss4xx.c
@@ -149,9 +149,7 @@ static void __init iss4xx_setup_arch(void)
  */
 static int __init iss4xx_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "ibm,iss-4xx"))
+	if (!of_machine_is_compatible("ibm,iss-4xx"))
 		return 0;
 
 	return 1;
diff --git a/arch/powerpc/platforms/44x/ppc44x_simple.c b/arch/powerpc/platforms/44x/ppc44x_simple.c
index 573c3d2..8d6e4da 100644
--- a/arch/powerpc/platforms/44x/ppc44x_simple.c
+++ b/arch/powerpc/platforms/44x/ppc44x_simple.c
@@ -67,11 +67,10 @@ static char *board[] __initdata = {
 
 static int __init ppc44x_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
 	int i = 0;
 
 	for (i = 0; i < ARRAY_SIZE(board); i++) {
-		if (of_flat_dt_is_compatible(root, board[i])) {
+		if (of_machine_is_compatible(board[i])) {
 			pci_set_flags(PCI_REASSIGN_ALL_RSRC);
 			return 1;
 		}
diff --git a/arch/powerpc/platforms/44x/ppc476.c b/arch/powerpc/platforms/44x/ppc476.c
index c11ce65..be4bf64 100644
--- a/arch/powerpc/platforms/44x/ppc476.c
+++ b/arch/powerpc/platforms/44x/ppc476.c
@@ -275,12 +275,10 @@ static void ppc47x_pci_irq_fixup(struct pci_dev *dev)
  */
 static int __init ppc47x_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (of_flat_dt_is_compatible(root, "ibm,akebono"))
+	if (of_machine_is_compatible("ibm,akebono"))
 		return 1;
 
-	if (of_flat_dt_is_compatible(root, "ibm,currituck")) {
+	if (of_machine_is_compatible("ibm,currituck")) {
 		ppc_md.pci_irq_fixup = ppc47x_pci_irq_fixup;
 		return 1;
 	}
diff --git a/arch/powerpc/platforms/44x/sam440ep.c b/arch/powerpc/platforms/44x/sam440ep.c
index 3ee4a03..688ffea 100644
--- a/arch/powerpc/platforms/44x/sam440ep.c
+++ b/arch/powerpc/platforms/44x/sam440ep.c
@@ -46,9 +46,7 @@ machine_device_initcall(sam440ep, sam440ep_device_probe);
 
 static int __init sam440ep_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "acube,sam440ep"))
+	if (!of_machine_is_compatible("acube,sam440ep"))
 		return 0;
 
 	pci_set_flags(PCI_REASSIGN_ALL_RSRC);
diff --git a/arch/powerpc/platforms/44x/virtex.c b/arch/powerpc/platforms/44x/virtex.c
index ad272c1..a7e0802 100644
--- a/arch/powerpc/platforms/44x/virtex.c
+++ b/arch/powerpc/platforms/44x/virtex.c
@@ -43,9 +43,7 @@ machine_device_initcall(virtex, virtex_device_probe);
 
 static int __init virtex_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "xlnx,virtex440"))
+	if (!of_machine_is_compatible("xlnx,virtex440"))
 		return 0;
 
 	return 1;
diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
index 501333c..5ecce54 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -44,9 +44,7 @@ machine_device_initcall(warp, warp_device_probe);
 
 static int __init warp_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "pika,warp"))
+	if (!of_machine_is_compatible("pika,warp"))
 		return 0;
 
 	/* For __dma_alloc_coherent */
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
index 3e90ece..4e03f04 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
@@ -57,9 +57,7 @@ static void __init mpc5121_ads_init_IRQ(void)
  */
 static int __init mpc5121_ads_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,mpc5121ads");
+	return of_machine_is_compatible("fsl,mpc5121ads");
 }
 
 define_machine(mpc5121_ads) {
diff --git a/arch/powerpc/platforms/512x/mpc512x_generic.c b/arch/powerpc/platforms/512x/mpc512x_generic.c
index ce71408..87eba17 100644
--- a/arch/powerpc/platforms/512x/mpc512x_generic.c
+++ b/arch/powerpc/platforms/512x/mpc512x_generic.c
@@ -38,7 +38,7 @@ static const char * const board[] __initconst = {
  */
 static int __init mpc512x_generic_probe(void)
 {
-	return of_flat_dt_match(of_get_flat_dt_root(), board);
+	return of_device_compatible_match(of_root, board);
 }
 
 define_machine(mpc512x_generic) {
diff --git a/arch/powerpc/platforms/512x/pdm360ng.c b/arch/powerpc/platforms/512x/pdm360ng.c
index 116f2325..f9cad19 100644
--- a/arch/powerpc/platforms/512x/pdm360ng.c
+++ b/arch/powerpc/platforms/512x/pdm360ng.c
@@ -113,9 +113,7 @@ void __init pdm360ng_init(void)
 
 static int __init pdm360ng_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "ifm,pdm360ng");
+	return of_machine_is_compatible("ifm,pdm360ng");
 }
 
 define_machine(pdm360ng) {
diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
index 6af651e..39b4982 100644
--- a/arch/powerpc/platforms/52xx/efika.c
+++ b/arch/powerpc/platforms/52xx/efika.c
@@ -200,8 +200,7 @@ static void __init efika_setup_arch(void)
 
 static int __init efika_probe(void)
 {
-	const char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
-						"model", NULL);
+	const char *model = of_get_property(of_root, "model", NULL);
 
 	if (model == NULL)
 		return 0;
diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 7492de3..c94c385 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -183,7 +183,7 @@ static const char * const board[] __initconst = {
  */
 static int __init lite5200_probe(void)
 {
-	return of_flat_dt_match(of_get_flat_dt_root(), board);
+	return of_device_compatible_match(of_root, board);
 }
 
 define_machine(lite5200) {
diff --git a/arch/powerpc/platforms/52xx/media5200.c b/arch/powerpc/platforms/52xx/media5200.c
index 8fb9548..a322704 100644
--- a/arch/powerpc/platforms/52xx/media5200.c
+++ b/arch/powerpc/platforms/52xx/media5200.c
@@ -242,7 +242,7 @@ static const char * const board[] __initconst = {
  */
 static int __init media5200_probe(void)
 {
-	return of_flat_dt_match(of_get_flat_dt_root(), board);
+	return of_device_compatible_match(of_root, board);
 }
 
 define_machine(media5200_platform) {
diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/platforms/52xx/mpc5200_simple.c
index 792a301..a80c627 100644
--- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
+++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
@@ -70,7 +70,7 @@ static const char *board[] __initdata = {
  */
 static int __init mpc5200_simple_probe(void)
 {
-	return of_flat_dt_match(of_get_flat_dt_root(), board);
+	return of_device_compatible_match(of_root, board);
 }
 
 define_machine(mpc5200_simple_platform) {
diff --git a/arch/powerpc/platforms/82xx/ep8248e.c b/arch/powerpc/platforms/82xx/ep8248e.c
index 6781bda..cdab847 100644
--- a/arch/powerpc/platforms/82xx/ep8248e.c
+++ b/arch/powerpc/platforms/82xx/ep8248e.c
@@ -309,8 +309,7 @@ machine_device_initcall(ep8248e, declare_of_platform_devices);
  */
 static int __init ep8248e_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-	return of_flat_dt_is_compatible(root, "fsl,ep8248e");
+	return of_machine_is_compatible("fsl,ep8248e");
 }
 
 define_machine(ep8248e)
diff --git a/arch/powerpc/platforms/82xx/km82xx.c b/arch/powerpc/platforms/82xx/km82xx.c
index 387b446..28860e4 100644
--- a/arch/powerpc/platforms/82xx/km82xx.c
+++ b/arch/powerpc/platforms/82xx/km82xx.c
@@ -198,8 +198,7 @@ machine_device_initcall(km82xx, declare_of_platform_devices);
  */
 static int __init km82xx_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-	return of_flat_dt_is_compatible(root, "keymile,km82xx");
+	return of_machine_is_compatible("keymile,km82xx");
 }
 
 define_machine(km82xx)
diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
index d24deac..d23c10a 100644
--- a/arch/powerpc/platforms/82xx/mpc8272_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
@@ -201,8 +201,7 @@ machine_device_initcall(mpc8272_ads, declare_of_platform_devices);
  */
 static int __init mpc8272_ads_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-	return of_flat_dt_is_compatible(root, "fsl,mpc8272ads");
+	return of_machine_is_compatible("fsl,mpc8272ads");
 }
 
 define_machine(mpc8272_ads)
diff --git a/arch/powerpc/platforms/82xx/pq2fads.c b/arch/powerpc/platforms/82xx/pq2fads.c
index 3a5164a..6c654dc 100644
--- a/arch/powerpc/platforms/82xx/pq2fads.c
+++ b/arch/powerpc/platforms/82xx/pq2fads.c
@@ -164,8 +164,7 @@ static void __init pq2fads_setup_arch(void)
  */
 static int __init pq2fads_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-	return of_flat_dt_is_compatible(root, "fsl,pq2fads");
+	return of_machine_is_compatible("fsl,pq2fads");
 }
 
 static const struct of_device_id of_bus_ids[] __initconst = {
diff --git a/arch/powerpc/platforms/83xx/asp834x.c b/arch/powerpc/platforms/83xx/asp834x.c
index 464ea8e..17e5433 100644
--- a/arch/powerpc/platforms/83xx/asp834x.c
+++ b/arch/powerpc/platforms/83xx/asp834x.c
@@ -43,8 +43,7 @@ machine_device_initcall(asp834x, mpc83xx_declare_of_platform_devices);
  */
 static int __init asp834x_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-	return of_flat_dt_is_compatible(root, "analogue-and-micro,asp8347e");
+	return of_machine_is_compatible("analogue-and-micro,asp8347e");
 }
 
 define_machine(asp834x) {
diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index 4bc6bbb..e7fbd63 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -171,11 +171,10 @@ static char *board[] __initdata = {
  */
 static int __init mpc83xx_km_probe(void)
 {
-	unsigned long node = of_get_flat_dt_root();
 	int i = 0;
 
 	while (board[i]) {
-		if (of_flat_dt_is_compatible(node, board[i]))
+		if (of_machine_is_compatible(board[i]))
 			break;
 		i++;
 	}
diff --git a/arch/powerpc/platforms/83xx/mpc830x_rdb.c b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
index 4f2d9fe..040d5d0 100644
--- a/arch/powerpc/platforms/83xx/mpc830x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
@@ -46,7 +46,7 @@ static const char *board[] __initdata = {
  */
 static int __init mpc830x_rdb_probe(void)
 {
-	return of_flat_dt_match(of_get_flat_dt_root(), board);
+	return of_device_compatible_match(of_root, board);
 }
 
 machine_device_initcall(mpc830x_rdb, mpc83xx_declare_of_platform_devices);
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index fa25977..40e0d83 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -46,7 +46,7 @@ static const char *board[] __initdata = {
  */
 static int __init mpc831x_rdb_probe(void)
 {
-	return of_flat_dt_match(of_get_flat_dt_root(), board);
+	return of_device_compatible_match(of_root, board);
 }
 
 machine_device_initcall(mpc831x_rdb, mpc83xx_declare_of_platform_devices);
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index a973b2a..375a58d 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -102,9 +102,7 @@ machine_device_initcall(mpc832x_mds, mpc83xx_declare_of_platform_devices);
  */
 static int __init mpc832x_sys_probe(void)
 {
-        unsigned long root = of_get_flat_dt_root();
-
-        return of_flat_dt_is_compatible(root, "MPC832xMDS");
+        return of_machine_is_compatible("MPC832xMDS");
 }
 
 define_machine(mpc832x_mds) {
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index ea2b87d..2ef03e7 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -220,9 +220,7 @@ machine_device_initcall(mpc832x_rdb, mpc83xx_declare_of_platform_devices);
  */
 static int __init mpc832x_rdb_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "MPC832xRDB");
+	return of_machine_is_compatible("MPC832xRDB");
 }
 
 define_machine(mpc832x_rdb) {
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 80aea8c..88657a4 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -70,9 +70,7 @@ static void __init mpc834x_itx_setup_arch(void)
  */
 static int __init mpc834x_itx_probe(void)
 {
-        unsigned long root = of_get_flat_dt_root();
-
-        return of_flat_dt_is_compatible(root, "MPC834xMITX");
+        return of_machine_is_compatible("MPC834xMITX");
 }
 
 define_machine(mpc834x_itx) {
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index 553e793..eeaee61 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -91,9 +91,7 @@ machine_device_initcall(mpc834x_mds, mpc83xx_declare_of_platform_devices);
  */
 static int __init mpc834x_mds_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "MPC834xMDS");
+	return of_machine_is_compatible("MPC834xMDS");
 }
 
 define_machine(mpc834x_mds) {
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index dd70b85..ada6e5e 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -209,9 +209,7 @@ machine_arch_initcall(mpc836x_mds, mpc836x_usb_cfg);
  */
 static int __init mpc836x_mds_probe(void)
 {
-        unsigned long root = of_get_flat_dt_root();
-
-        return of_flat_dt_is_compatible(root, "MPC836xMDS");
+        return of_machine_is_compatible("MPC836xMDS");
 }
 
 define_machine(mpc836x_mds) {
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
index 4cd7153..cf67ac9 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -42,9 +42,7 @@ static void __init mpc836x_rdk_setup_arch(void)
  */
 static int __init mpc836x_rdk_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,mpc8360rdk");
+	return of_machine_is_compatible("fsl,mpc8360rdk");
 }
 
 define_machine(mpc836x_rdk) {
diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index e53a60b..199f6ee 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -93,9 +93,7 @@ machine_device_initcall(mpc837x_mds, mpc83xx_declare_of_platform_devices);
  */
 static int __init mpc837x_mds_probe(void)
 {
-        unsigned long root = of_get_flat_dt_root();
-
-        return of_flat_dt_is_compatible(root, "fsl,mpc837xmds");
+        return of_machine_is_compatible("fsl,mpc837xmds");
 }
 
 define_machine(mpc837x_mds) {
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index 9813c81..667731d 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -73,7 +73,7 @@ static const char * const board[] __initconst = {
  */
 static int __init mpc837x_rdb_probe(void)
 {
-	return of_flat_dt_match(of_get_flat_dt_root(), board);
+	return of_device_compatible_match(of_root, board);
 }
 
 define_machine(mpc837x_rdb) {
diff --git a/arch/powerpc/platforms/83xx/sbc834x.c b/arch/powerpc/platforms/83xx/sbc834x.c
index 26cb3e9..b867e88 100644
--- a/arch/powerpc/platforms/83xx/sbc834x.c
+++ b/arch/powerpc/platforms/83xx/sbc834x.c
@@ -60,9 +60,7 @@ machine_device_initcall(sbc834x, mpc83xx_declare_of_platform_devices);
  */
 static int __init sbc834x_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "SBC834xE");
+	return of_machine_is_compatible("SBC834xE");
 }
 
 define_machine(sbc834x) {
diff --git a/arch/powerpc/platforms/85xx/bsc913x_qds.c b/arch/powerpc/platforms/85xx/bsc913x_qds.c
index dcfafd6..07dd6ae 100644
--- a/arch/powerpc/platforms/85xx/bsc913x_qds.c
+++ b/arch/powerpc/platforms/85xx/bsc913x_qds.c
@@ -60,9 +60,7 @@ machine_arch_initcall(bsc9132_qds, mpc85xx_common_publish_devices);
 
 static int __init bsc9132_qds_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,bsc9132qds");
+	return of_machine_is_compatible("fsl,bsc9132qds");
 }
 
 define_machine(bsc9132_qds) {
diff --git a/arch/powerpc/platforms/85xx/bsc913x_rdb.c b/arch/powerpc/platforms/85xx/bsc913x_rdb.c
index 9d57bed..e48f671 100644
--- a/arch/powerpc/platforms/85xx/bsc913x_rdb.c
+++ b/arch/powerpc/platforms/85xx/bsc913x_rdb.c
@@ -50,9 +50,7 @@ machine_device_initcall(bsc9131_rdb, mpc85xx_common_publish_devices);
 
 static int __init bsc9131_rdb_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,bsc9131rdb");
+	return of_machine_is_compatible("fsl,bsc9131rdb");
 }
 
 define_machine(bsc9131_rdb) {
diff --git a/arch/powerpc/platforms/85xx/c293pcie.c b/arch/powerpc/platforms/85xx/c293pcie.c
index 61bc851..3b9e3f0 100644
--- a/arch/powerpc/platforms/85xx/c293pcie.c
+++ b/arch/powerpc/platforms/85xx/c293pcie.c
@@ -54,9 +54,7 @@ machine_arch_initcall(c293_pcie, mpc85xx_common_publish_devices);
  */
 static int __init c293_pcie_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (of_flat_dt_is_compatible(root, "fsl,C293PCIE"))
+	if (of_machine_is_compatible("fsl,C293PCIE"))
 		return 1;
 	return 0;
 }
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index a2b0bc8..3a6a84f 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -170,20 +170,19 @@ static const char * const boards[] __initconst = {
  */
 static int __init corenet_generic_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
 	char hv_compat[24];
 	int i;
 #ifdef CONFIG_SMP
 	extern struct smp_ops_t smp_85xx_ops;
 #endif
 
-	if (of_flat_dt_match(root, boards))
+	if (of_device_compatible_match(of_root, boards))
 		return 1;
 
 	/* Check if we're running under the Freescale hypervisor */
 	for (i = 0; boards[i]; i++) {
 		snprintf(hv_compat, sizeof(hv_compat), "%s-hv", boards[i]);
-		if (of_flat_dt_is_compatible(root, hv_compat)) {
+		if (of_machine_is_compatible(hv_compat)) {
 			ppc_md.init_IRQ = ehv_pic_init;
 
 			ppc_md.get_irq = ehv_pic_get_irq;
diff --git a/arch/powerpc/platforms/85xx/ge_imp3a.c b/arch/powerpc/platforms/85xx/ge_imp3a.c
index 55eefef..14af36a 100644
--- a/arch/powerpc/platforms/85xx/ge_imp3a.c
+++ b/arch/powerpc/platforms/85xx/ge_imp3a.c
@@ -197,9 +197,7 @@ static void ge_imp3a_show_cpuinfo(struct seq_file *m)
  */
 static int __init ge_imp3a_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "ge,IMP3A");
+	return of_machine_is_compatible("ge,IMP3A");
 }
 
 machine_arch_initcall(ge_imp3a, mpc85xx_common_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
index 3dc1bda..e841675 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -176,9 +176,7 @@ machine_device_initcall(ksi8560, mpc85xx_common_publish_devices);
  */
 static int __init ksi8560_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "emerson,KSI8560");
+	return of_machine_is_compatible("emerson,KSI8560");
 }
 
 define_machine(ksi8560) {
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index a378ba3..6ba687f 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -64,9 +64,7 @@ machine_arch_initcall(mpc8536_ds, swiotlb_setup_bus_notifier);
  */
 static int __init mpc8536_ds_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,mpc8536ds");
+	return of_machine_is_compatible("fsl,mpc8536ds");
 }
 
 define_machine(mpc8536_ds) {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index de72a5f..0fba649 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -160,9 +160,7 @@ machine_arch_initcall(mpc85xx_ads, mpc85xx_common_publish_devices);
  */
 static int __init mpc85xx_ads_probe(void)
 {
-        unsigned long root = of_get_flat_dt_root();
-
-        return of_flat_dt_is_compatible(root, "MPC85xxADS");
+        return of_machine_is_compatible("MPC85xxADS");
 }
 
 define_machine(mpc85xx_ads) {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index d7e87ff..827155a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -367,9 +367,7 @@ static void mpc85xx_cds_show_cpuinfo(struct seq_file *m)
  */
 static int __init mpc85xx_cds_probe(void)
 {
-        unsigned long root = of_get_flat_dt_root();
-
-        return of_flat_dt_is_compatible(root, "MPC85xxCDS");
+        return of_machine_is_compatible("MPC85xxCDS");
 }
 
 machine_arch_initcall(mpc85xx_cds, mpc85xx_common_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 64a7e8c..6bc07d8 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -167,9 +167,7 @@ static void __init mpc85xx_ds_setup_arch(void)
  */
 static int __init mpc8544_ds_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return !!of_flat_dt_is_compatible(root, "MPC8544DS");
+	return !!of_machine_is_compatible("MPC8544DS");
 }
 
 machine_arch_initcall(mpc8544_ds, mpc85xx_common_publish_devices);
@@ -185,9 +183,7 @@ machine_arch_initcall(p2020_ds, swiotlb_setup_bus_notifier);
  */
 static int __init mpc8572_ds_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return !!of_flat_dt_is_compatible(root, "fsl,MPC8572DS");
+	return !!of_machine_is_compatible("fsl,MPC8572DS");
 }
 
 /*
@@ -195,9 +191,7 @@ static int __init mpc8572_ds_probe(void)
  */
 static int __init p2020_ds_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return !!of_flat_dt_is_compatible(root, "fsl,P2020DS");
+	return !!of_machine_is_compatible("fsl,P2020DS");
 }
 
 define_machine(mpc8544_ds) {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index f61cbe2..c26db01 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -376,9 +376,7 @@ static void __init mpc85xx_mds_pic_init(void)
 
 static int __init mpc85xx_mds_probe(void)
 {
-        unsigned long root = of_get_flat_dt_root();
-
-        return of_flat_dt_is_compatible(root, "MPC85xxMDS");
+        return of_machine_is_compatible("MPC85xxMDS");
 }
 
 define_machine(mpc8568_mds) {
@@ -398,9 +396,7 @@ define_machine(mpc8568_mds) {
 
 static int __init mpc8569_mds_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,MPC8569EMDS");
+	return of_machine_is_compatible("fsl,MPC8569EMDS");
 }
 
 define_machine(mpc8569_mds) {
@@ -420,9 +416,7 @@ define_machine(mpc8569_mds) {
 
 static int __init p1021_mds_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,P1021MDS");
+	return of_machine_is_compatible("fsl,P1021MDS");
 
 }
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 761e504..c1499cb 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -147,80 +147,60 @@ machine_arch_initcall(p1024_rdb, mpc85xx_common_publish_devices);
  */
 static int __init p2020_rdb_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (of_flat_dt_is_compatible(root, "fsl,P2020RDB"))
+	if (of_machine_is_compatible("fsl,P2020RDB"))
 		return 1;
 	return 0;
 }
 
 static int __init p1020_rdb_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (of_flat_dt_is_compatible(root, "fsl,P1020RDB"))
+	if (of_machine_is_compatible("fsl,P1020RDB"))
 		return 1;
 	return 0;
 }
 
 static int __init p1020_rdb_pc_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,P1020RDB-PC");
+	return of_machine_is_compatible("fsl,P1020RDB-PC");
 }
 
 static int __init p1020_rdb_pd_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,P1020RDB-PD");
+	return of_machine_is_compatible("fsl,P1020RDB-PD");
 }
 
 static int __init p1021_rdb_pc_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (of_flat_dt_is_compatible(root, "fsl,P1021RDB-PC"))
+	if (of_machine_is_compatible("fsl,P1021RDB-PC"))
 		return 1;
 	return 0;
 }
 
 static int __init p2020_rdb_pc_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (of_flat_dt_is_compatible(root, "fsl,P2020RDB-PC"))
+	if (of_machine_is_compatible("fsl,P2020RDB-PC"))
 		return 1;
 	return 0;
 }
 
 static int __init p1025_rdb_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,P1025RDB");
+	return of_machine_is_compatible("fsl,P1025RDB");
 }
 
 static int __init p1020_mbg_pc_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,P1020MBG-PC");
+	return of_machine_is_compatible("fsl,P1020MBG-PC");
 }
 
 static int __init p1020_utm_pc_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,P1020UTM-PC");
+	return of_machine_is_compatible("fsl,P1020UTM-PC");
 }
 
 static int __init p1024_rdb_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,P1024RDB");
+	return of_machine_is_compatible("fsl,P1024RDB");
 }
 
 define_machine(p2020_rdb) {
diff --git a/arch/powerpc/platforms/85xx/mvme2500.c b/arch/powerpc/platforms/85xx/mvme2500.c
index 1233050..acc3d0d 100644
--- a/arch/powerpc/platforms/85xx/mvme2500.c
+++ b/arch/powerpc/platforms/85xx/mvme2500.c
@@ -53,9 +53,7 @@ machine_arch_initcall(mvme2500, mpc85xx_common_publish_devices);
  */
 static int __init mvme2500_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "artesyn,MVME2500");
+	return of_machine_is_compatible("artesyn,MVME2500");
 }
 
 define_machine(mvme2500) {
diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
index ad1a3d4..661d7b5 100644
--- a/arch/powerpc/platforms/85xx/p1010rdb.c
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -62,11 +62,9 @@ machine_arch_initcall(p1010_rdb, swiotlb_setup_bus_notifier);
  */
 static int __init p1010_rdb_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (of_flat_dt_is_compatible(root, "fsl,P1010RDB"))
+	if (of_machine_is_compatible("fsl,P1010RDB"))
 		return 1;
-	if (of_flat_dt_is_compatible(root, "fsl,P1010RDB-PB"))
+	if (of_machine_is_compatible("fsl,P1010RDB-PB"))
 		return 1;
 	return 0;
 }
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 371df82..63568d6 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -555,9 +555,7 @@ machine_arch_initcall(p1022_ds, swiotlb_setup_bus_notifier);
  */
 static int __init p1022_ds_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,p1022ds");
+	return of_machine_is_compatible("fsl,p1022ds");
 }
 
 define_machine(p1022_ds) {
diff --git a/arch/powerpc/platforms/85xx/p1022_rdk.c b/arch/powerpc/platforms/85xx/p1022_rdk.c
index 5087bec..2f29436 100644
--- a/arch/powerpc/platforms/85xx/p1022_rdk.c
+++ b/arch/powerpc/platforms/85xx/p1022_rdk.c
@@ -135,9 +135,7 @@ machine_arch_initcall(p1022_rdk, swiotlb_setup_bus_notifier);
  */
 static int __init p1022_rdk_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,p1022rdk");
+	return of_machine_is_compatible("fsl,p1022rdk");
 }
 
 define_machine(p1022_rdk) {
diff --git a/arch/powerpc/platforms/85xx/p1023_rdb.c b/arch/powerpc/platforms/85xx/p1023_rdb.c
index d5b7509..40d8de5 100644
--- a/arch/powerpc/platforms/85xx/p1023_rdb.c
+++ b/arch/powerpc/platforms/85xx/p1023_rdb.c
@@ -100,9 +100,7 @@ static void __init mpc85xx_rdb_pic_init(void)
 
 static int __init p1023_rdb_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,P1023RDB");
+	return of_machine_is_compatible("fsl,P1023RDB");
 
 }
 
diff --git a/arch/powerpc/platforms/85xx/ppa8548.c b/arch/powerpc/platforms/85xx/ppa8548.c
index 12019f1..2410167 100644
--- a/arch/powerpc/platforms/85xx/ppa8548.c
+++ b/arch/powerpc/platforms/85xx/ppa8548.c
@@ -81,9 +81,7 @@ machine_device_initcall(ppa8548, declare_of_platform_devices);
  */
 static int __init ppa8548_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "ppa8548");
+	return of_machine_is_compatible("ppa8548");
 }
 
 define_machine(ppa8548) {
diff --git a/arch/powerpc/platforms/85xx/qemu_e500.c b/arch/powerpc/platforms/85xx/qemu_e500.c
index 8ad2fe6..50d7458 100644
--- a/arch/powerpc/platforms/85xx/qemu_e500.c
+++ b/arch/powerpc/platforms/85xx/qemu_e500.c
@@ -62,9 +62,7 @@ static void __init qemu_e500_setup_arch(void)
  */
 static int __init qemu_e500_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return !!of_flat_dt_is_compatible(root, "fsl,qemu-e500");
+	return !!of_machine_is_compatible("fsl,qemu-e500");
 }
 
 machine_arch_initcall(qemu_e500, mpc85xx_common_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index b072146..c967180 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -120,9 +120,7 @@ machine_arch_initcall(sbc8548, mpc85xx_common_publish_devices);
  */
 static int __init sbc8548_probe(void)
 {
-        unsigned long root = of_get_flat_dt_root();
-
-        return of_flat_dt_is_compatible(root, "SBC8548");
+        return of_machine_is_compatible("SBC8548");
 }
 
 define_machine(sbc8548) {
diff --git a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
index ae368e0..cd255ac 100644
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -79,9 +79,7 @@ machine_arch_initcall(socrates, mpc85xx_common_publish_devices);
  */
 static int __init socrates_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (of_flat_dt_is_compatible(root, "abb,socrates"))
+	if (of_machine_is_compatible("abb,socrates"))
 		return 1;
 
 	return 0;
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
index 6f4939b..91b824c 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -93,9 +93,7 @@ machine_arch_initcall(stx_gp3, mpc85xx_common_publish_devices);
  */
 static int __init stx_gp3_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "stx,gp3-8560");
+	return of_machine_is_compatible("stx,gp3-8560");
 }
 
 define_machine(stx_gp3) {
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index ec0b727..b7c5445 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -122,7 +122,7 @@ static const char * const board[] __initconst = {
  */
 static int __init tqm85xx_probe(void)
 {
-	return of_flat_dt_match(of_get_flat_dt_root(), board);
+	return of_device_compatible_match(of_root, board);
 }
 
 define_machine(tqm85xx) {
diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
index 71bc255..1bc02a8 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -128,9 +128,7 @@ machine_arch_initcall(twr_p1025, mpc85xx_common_publish_devices);
 
 static int __init twr_p1025_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,TWR-P1025");
+	return of_machine_is_compatible("fsl,TWR-P1025");
 }
 
 define_machine(twr_p1025) {
diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index 1a9c108..cf0c70f 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -144,23 +144,17 @@ machine_arch_initcall(xes_mpc8540, mpc85xx_common_publish_devices);
  */
 static int __init xes_mpc8572_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "xes,MPC8572");
+	return of_machine_is_compatible("xes,MPC8572");
 }
 
 static int __init xes_mpc8548_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "xes,MPC8548");
+	return of_machine_is_compatible("xes,MPC8548");
 }
 
 static int __init xes_mpc8540_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "xes,MPC8540");
+	return of_machine_is_compatible("xes,MPC8540");
 }
 
 define_machine(xes_mpc8572) {
diff --git a/arch/powerpc/platforms/86xx/gef_ppc9a.c b/arch/powerpc/platforms/86xx/gef_ppc9a.c
index 8e63b75..ef684af 100644
--- a/arch/powerpc/platforms/86xx/gef_ppc9a.c
+++ b/arch/powerpc/platforms/86xx/gef_ppc9a.c
@@ -189,9 +189,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
  */
 static int __init gef_ppc9a_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (of_flat_dt_is_compatible(root, "gef,ppc9a"))
+	if (of_machine_is_compatible("gef,ppc9a"))
 		return 1;
 
 	return 0;
diff --git a/arch/powerpc/platforms/86xx/gef_sbc310.c b/arch/powerpc/platforms/86xx/gef_sbc310.c
index 0e0be94..67dd0c2 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc310.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc310.c
@@ -176,9 +176,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
  */
 static int __init gef_sbc310_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (of_flat_dt_is_compatible(root, "gef,sbc310"))
+	if (of_machine_is_compatible("gef,sbc310"))
 		return 1;
 
 	return 0;
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index e8292b4..8050269 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -166,9 +166,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
  */
 static int __init gef_sbc610_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (of_flat_dt_is_compatible(root, "gef,sbc610"))
+	if (of_machine_is_compatible("gef,sbc610"))
 		return 1;
 
 	return 0;
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 957473e..fef0582 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -319,9 +319,7 @@ static void __init mpc86xx_hpcd_setup_arch(void)
  */
 static int __init mpc86xx_hpcd_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (of_flat_dt_is_compatible(root, "fsl,MPC8610HPCD"))
+	if (of_machine_is_compatible("fsl,MPC8610HPCD"))
 		return 1;	/* Looks good */
 
 	return 0;
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index e508481..5ae42a0 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -96,13 +96,11 @@ mpc86xx_hpcn_show_cpuinfo(struct seq_file *m)
  */
 static int __init mpc86xx_hpcn_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (of_flat_dt_is_compatible(root, "fsl,mpc8641hpcn"))
+	if (of_machine_is_compatible("fsl,mpc8641hpcn"))
 		return 1;	/* Looks good */
 
 	/* Be nice and don't give silent boot death.  Delete this in 2.6.27 */
-	if (of_flat_dt_is_compatible(root, "mpc86xx")) {
+	if (of_machine_is_compatible("mpc86xx")) {
 		pr_warning("WARNING: your dts/dtb is old. You must update before the next kernel release\n");
 		return 1;
 	}
diff --git a/arch/powerpc/platforms/86xx/sbc8641d.c b/arch/powerpc/platforms/86xx/sbc8641d.c
index 2a9cf27..52af573 100644
--- a/arch/powerpc/platforms/86xx/sbc8641d.c
+++ b/arch/powerpc/platforms/86xx/sbc8641d.c
@@ -67,9 +67,7 @@ sbc8641_show_cpuinfo(struct seq_file *m)
  */
 static int __init sbc8641_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (of_flat_dt_is_compatible(root, "wind,sbc8641"))
+	if (of_machine_is_compatible("wind,sbc8641"))
 		return 1;	/* Looks good */
 
 	return 0;
diff --git a/arch/powerpc/platforms/8xx/adder875.c b/arch/powerpc/platforms/8xx/adder875.c
index 61cae4c..333dece 100644
--- a/arch/powerpc/platforms/8xx/adder875.c
+++ b/arch/powerpc/platforms/8xx/adder875.c
@@ -88,8 +88,7 @@ static void __init adder875_setup(void)
 
 static int __init adder875_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-	return of_flat_dt_is_compatible(root, "analogue-and-micro,adder875");
+	return of_machine_is_compatible("analogue-and-micro,adder875");
 }
 
 static const struct of_device_id of_bus_ids[] __initconst = {
diff --git a/arch/powerpc/platforms/8xx/ep88xc.c b/arch/powerpc/platforms/8xx/ep88xc.c
index 2bedeb7..cd0d90f 100644
--- a/arch/powerpc/platforms/8xx/ep88xc.c
+++ b/arch/powerpc/platforms/8xx/ep88xc.c
@@ -143,8 +143,7 @@ static void __init ep88xc_setup_arch(void)
 
 static int __init ep88xc_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-	return of_flat_dt_is_compatible(root, "fsl,ep88xc");
+	return of_machine_is_compatible("fsl,ep88xc");
 }
 
 static const struct of_device_id of_bus_ids[] __initconst = {
diff --git a/arch/powerpc/platforms/8xx/mpc86xads_setup.c b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
index 78180c5..8d02f5f 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -118,8 +118,7 @@ static void __init mpc86xads_setup_arch(void)
 
 static int __init mpc86xads_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-	return of_flat_dt_is_compatible(root, "fsl,mpc866ads");
+	return of_machine_is_compatible("fsl,mpc866ads");
 }
 
 static const struct of_device_id of_bus_ids[] __initconst = {
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index 4d62bf9..e821a42 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -193,8 +193,7 @@ static void __init mpc885ads_setup_arch(void)
 
 static int __init mpc885ads_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-	return of_flat_dt_is_compatible(root, "fsl,mpc885ads");
+	return of_machine_is_compatible("fsl,mpc885ads");
 }
 
 static const struct of_device_id of_bus_ids[] __initconst = {
diff --git a/arch/powerpc/platforms/8xx/tqm8xx_setup.c b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
index bee47a2..4cea8b1 100644
--- a/arch/powerpc/platforms/8xx/tqm8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
@@ -119,9 +119,7 @@ static void __init tqm8xx_setup_arch(void)
 
 static int __init tqm8xx_probe(void)
 {
-	unsigned long node = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(node, "tqc,tqm8xx");
+	return of_machine_is_compatible("tqc,tqm8xx");
 }
 
 static const struct of_device_id of_bus_ids[] __initconst = {
diff --git a/arch/powerpc/platforms/amigaone/setup.c b/arch/powerpc/platforms/amigaone/setup.c
index 2fe1204..a030d3b 100644
--- a/arch/powerpc/platforms/amigaone/setup.c
+++ b/arch/powerpc/platforms/amigaone/setup.c
@@ -143,9 +143,7 @@ void amigaone_restart(char *cmd)
 
 static int __init amigaone_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (of_flat_dt_is_compatible(root, "eyetech,amigaone")) {
+	if (of_machine_is_compatible("eyetech,amigaone")) {
 		/*
 		 * Coherent memory access cause complete system lockup! Thus
 		 * disable this CPU feature, even if the CPU needs it.
diff --git a/arch/powerpc/platforms/embedded6xx/c2k.c b/arch/powerpc/platforms/embedded6xx/c2k.c
index ebd3963..45197b5 100644
--- a/arch/powerpc/platforms/embedded6xx/c2k.c
+++ b/arch/powerpc/platforms/embedded6xx/c2k.c
@@ -123,9 +123,7 @@ void c2k_show_cpuinfo(struct seq_file *m)
  */
 static int __init c2k_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "GEFanuc,C2K"))
+	if (!of_machine_is_compatible("GEFanuc,C2K"))
 		return 0;
 
 	printk(KERN_INFO "Detected a GEFanuc C2K board\n");
diff --git a/arch/powerpc/platforms/embedded6xx/gamecube.c b/arch/powerpc/platforms/embedded6xx/gamecube.c
index fe0ed6e..defcef8 100644
--- a/arch/powerpc/platforms/embedded6xx/gamecube.c
+++ b/arch/powerpc/platforms/embedded6xx/gamecube.c
@@ -61,10 +61,7 @@ static void __init gamecube_init_early(void)
 
 static int __init gamecube_probe(void)
 {
-	unsigned long dt_root;
-
-	dt_root = of_get_flat_dt_root();
-	if (!of_flat_dt_is_compatible(dt_root, "nintendo,gamecube"))
+	if (!of_machine_is_compatible("nintendo,gamecube"))
 		return 0;
 
 	pm_power_off = gamecube_power_off;
diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index 8c305c7..a7a0ef9 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -250,9 +250,7 @@ void holly_halt(void)
  */
 static int __init holly_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "ibm,holly"))
+	if (!of_machine_is_compatible("ibm,holly"))
 		return 0;
 	return 1;
 }
diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index 540eeb5..1032655 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -141,11 +141,7 @@ static void linkstation_show_cpuinfo(struct seq_file *m)
 
 static int __init linkstation_probe(void)
 {
-	unsigned long root;
-
-	root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "linkstation"))
+	if (!of_machine_is_compatible("linkstation"))
 		return 0;
 
 	pm_power_off = linkstation_power_off;
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index df4ad95..eb5bfcf 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -161,9 +161,7 @@ void mpc7448_hpc2_restart(char *cmd)
  */
 static int __init mpc7448_hpc2_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "mpc74xx"))
+	if (!of_machine_is_compatible("mpc74xx"))
 		return 0;
 	return 1;
 }
diff --git a/arch/powerpc/platforms/embedded6xx/mvme5100.c b/arch/powerpc/platforms/embedded6xx/mvme5100.c
index 8f65aa3..b5ae04e 100644
--- a/arch/powerpc/platforms/embedded6xx/mvme5100.c
+++ b/arch/powerpc/platforms/embedded6xx/mvme5100.c
@@ -194,9 +194,7 @@ static void mvme5100_restart(char *cmd)
  */
 static int __init mvme5100_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "MVME5100");
+	return of_machine_is_compatible("MVME5100");
 }
 
 static int __init probe_of_platform_devices(void)
diff --git a/arch/powerpc/platforms/embedded6xx/storcenter.c b/arch/powerpc/platforms/embedded6xx/storcenter.c
index d572833..20a2f91 100644
--- a/arch/powerpc/platforms/embedded6xx/storcenter.c
+++ b/arch/powerpc/platforms/embedded6xx/storcenter.c
@@ -109,9 +109,7 @@ static void storcenter_restart(char *cmd)
 
 static int __init storcenter_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "iomega,storcenter");
+	return of_machine_is_compatible("iomega,storcenter");
 }
 
 define_machine(storcenter){
diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 352592d..cc65d68 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -205,10 +205,7 @@ static void __init wii_pic_probe(void)
 
 static int __init wii_probe(void)
 {
-	unsigned long dt_root;
-
-	dt_root = of_get_flat_dt_root();
-	if (!of_flat_dt_is_compatible(dt_root, "nintendo,wii"))
+	if (!of_machine_is_compatible("nintendo,wii"))
 		return 0;
 
 	pm_power_off = wii_power_off;
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 128ce76..509b18f 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -588,17 +588,9 @@ console_initcall(check_pmac_serial_console);
  */
 static int __init pmac_probe(void)
 {
-#ifdef CONFIG_PPC32
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "Power Macintosh") &&
-	    !of_flat_dt_is_compatible(root, "MacRISC"))
-		return 0;
-#else
 	if (!of_machine_is_compatible("Power Macintosh") &&
 	    !of_machine_is_compatible("MacRISC"))
 		return 0;
-#endif
 
 #ifdef CONFIG_PPC32
 	/* isa_io_base gets set in pmac_pci_init */
-- 
2.7.4

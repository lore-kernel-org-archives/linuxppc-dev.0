Return-Path: <haokexin@gmail.com>
Received: from mail-yb0-x244.google.com (mail-yb0-x244.google.com
 [IPv6:2607:f8b0:4002:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s94zq2GklzDqh7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 21:09:59 +1000 (AEST)
Received: by mail-yb0-x244.google.com with SMTP id e125so9865ybc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 04:09:59 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH] powerpc: populate the default bus with machine_arch_initcall
Date: Thu, 11 Aug 2016 19:09:41 +0800
Message-Id: <1470913781-9204-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the commit 44a7185c2ae6 ("of/platform: Add common method to
populate default bus"), a default function is introduced to populate
the default bus and this function is invoked at the arch_initcall_sync
level. This will override the arch specific population of default bus
which run at a lower level than arch_initcall_sync. Since not all
powerpc specific buses are added to the of_default_bus_match_table[],
this causes some powerpc specific bus are not probed. Fix this by
using a more preceding initcall.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
Of course we can adjust the powerpc arch codes to use the
of_platform_default_populate_init(), but it has high risk to break
other boards given the complicated powerpc specific buses. So I would
like just to fix the broken boards in the current release, and cook 
a patch to change to of_platform_default_populate_init() for linux-next.

Only boot test on a mpc8315erdb board.

 arch/powerpc/platforms/40x/ep405.c               | 2 +-
 arch/powerpc/platforms/40x/ppc40x_simple.c       | 2 +-
 arch/powerpc/platforms/40x/virtex.c              | 2 +-
 arch/powerpc/platforms/40x/walnut.c              | 2 +-
 arch/powerpc/platforms/44x/canyonlands.c         | 2 +-
 arch/powerpc/platforms/44x/ebony.c               | 2 +-
 arch/powerpc/platforms/44x/iss4xx.c              | 2 +-
 arch/powerpc/platforms/44x/ppc44x_simple.c       | 2 +-
 arch/powerpc/platforms/44x/ppc476.c              | 2 +-
 arch/powerpc/platforms/44x/sam440ep.c            | 2 +-
 arch/powerpc/platforms/44x/virtex.c              | 2 +-
 arch/powerpc/platforms/44x/warp.c                | 2 +-
 arch/powerpc/platforms/82xx/ep8248e.c            | 2 +-
 arch/powerpc/platforms/82xx/km82xx.c             | 2 +-
 arch/powerpc/platforms/82xx/mpc8272_ads.c        | 2 +-
 arch/powerpc/platforms/82xx/pq2fads.c            | 2 +-
 arch/powerpc/platforms/83xx/mpc831x_rdb.c        | 2 +-
 arch/powerpc/platforms/83xx/mpc834x_itx.c        | 2 +-
 arch/powerpc/platforms/85xx/ppa8548.c            | 2 +-
 arch/powerpc/platforms/8xx/adder875.c            | 2 +-
 arch/powerpc/platforms/8xx/ep88xc.c              | 2 +-
 arch/powerpc/platforms/8xx/mpc86xads_setup.c     | 2 +-
 arch/powerpc/platforms/8xx/mpc885ads_setup.c     | 2 +-
 arch/powerpc/platforms/8xx/tqm8xx_setup.c        | 2 +-
 arch/powerpc/platforms/cell/setup.c              | 2 +-
 arch/powerpc/platforms/embedded6xx/gamecube.c    | 2 +-
 arch/powerpc/platforms/embedded6xx/linkstation.c | 2 +-
 arch/powerpc/platforms/embedded6xx/mvme5100.c    | 2 +-
 arch/powerpc/platforms/embedded6xx/storcenter.c  | 2 +-
 arch/powerpc/platforms/embedded6xx/wii.c         | 2 +-
 arch/powerpc/platforms/pasemi/setup.c            | 2 +-
 31 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/platforms/40x/ep405.c b/arch/powerpc/platforms/40x/ep405.c
index 1c8aec6e9bb7..1328cb38e5d7 100644
--- a/arch/powerpc/platforms/40x/ep405.c
+++ b/arch/powerpc/platforms/40x/ep405.c
@@ -62,7 +62,7 @@ static int __init ep405_device_probe(void)
 
 	return 0;
 }
-machine_device_initcall(ep405, ep405_device_probe);
+machine_arch_initcall(ep405, ep405_device_probe);
 
 static void __init ep405_init_bcsr(void)
 {
diff --git a/arch/powerpc/platforms/40x/ppc40x_simple.c b/arch/powerpc/platforms/40x/ppc40x_simple.c
index 2a050007bbae..50dce54e6b3b 100644
--- a/arch/powerpc/platforms/40x/ppc40x_simple.c
+++ b/arch/powerpc/platforms/40x/ppc40x_simple.c
@@ -39,7 +39,7 @@ static int __init ppc40x_device_probe(void)
 
 	return 0;
 }
-machine_device_initcall(ppc40x_simple, ppc40x_device_probe);
+machine_arch_initcall(ppc40x_simple, ppc40x_device_probe);
 
 /* This is the list of boards that can be supported by this simple
  * platform code.  This does _not_ mean the boards are compatible,
diff --git a/arch/powerpc/platforms/40x/virtex.c b/arch/powerpc/platforms/40x/virtex.c
index 91a08ea758a8..d262696b3cbc 100644
--- a/arch/powerpc/platforms/40x/virtex.c
+++ b/arch/powerpc/platforms/40x/virtex.c
@@ -33,7 +33,7 @@ static int __init virtex_device_probe(void)
 
 	return 0;
 }
-machine_device_initcall(virtex, virtex_device_probe);
+machine_arch_initcall(virtex, virtex_device_probe);
 
 static int __init virtex_probe(void)
 {
diff --git a/arch/powerpc/platforms/40x/walnut.c b/arch/powerpc/platforms/40x/walnut.c
index e5797815e2f1..9a9c0bccba47 100644
--- a/arch/powerpc/platforms/40x/walnut.c
+++ b/arch/powerpc/platforms/40x/walnut.c
@@ -42,7 +42,7 @@ static int __init walnut_device_probe(void)
 
 	return 0;
 }
-machine_device_initcall(walnut, walnut_device_probe);
+machine_arch_initcall(walnut, walnut_device_probe);
 
 static int __init walnut_probe(void)
 {
diff --git a/arch/powerpc/platforms/44x/canyonlands.c b/arch/powerpc/platforms/44x/canyonlands.c
index 157f4ce46386..681fa66ff194 100644
--- a/arch/powerpc/platforms/44x/canyonlands.c
+++ b/arch/powerpc/platforms/44x/canyonlands.c
@@ -47,7 +47,7 @@ static int __init ppc460ex_device_probe(void)
 
 	return 0;
 }
-machine_device_initcall(canyonlands, ppc460ex_device_probe);
+machine_arch_initcall(canyonlands, ppc460ex_device_probe);
 
 /* Using this code only for the Canyonlands board.  */
 
diff --git a/arch/powerpc/platforms/44x/ebony.c b/arch/powerpc/platforms/44x/ebony.c
index 1070225f5f9b..fa3838fd67bc 100644
--- a/arch/powerpc/platforms/44x/ebony.c
+++ b/arch/powerpc/platforms/44x/ebony.c
@@ -42,7 +42,7 @@ static int __init ebony_device_probe(void)
 
 	return 0;
 }
-machine_device_initcall(ebony, ebony_device_probe);
+machine_arch_initcall(ebony, ebony_device_probe);
 
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/44x/iss4xx.c b/arch/powerpc/platforms/44x/iss4xx.c
index 5f296dd6b1c0..39cea8e5a6ab 100644
--- a/arch/powerpc/platforms/44x/iss4xx.c
+++ b/arch/powerpc/platforms/44x/iss4xx.c
@@ -47,7 +47,7 @@ static int __init iss4xx_device_probe(void)
 
 	return 0;
 }
-machine_device_initcall(iss4xx, iss4xx_device_probe);
+machine_arch_initcall(iss4xx, iss4xx_device_probe);
 
 /* We can have either UICs or MPICs */
 static void __init iss4xx_init_irq(void)
diff --git a/arch/powerpc/platforms/44x/ppc44x_simple.c b/arch/powerpc/platforms/44x/ppc44x_simple.c
index 8d6e4da9dfbe..5ea921ae080b 100644
--- a/arch/powerpc/platforms/44x/ppc44x_simple.c
+++ b/arch/powerpc/platforms/44x/ppc44x_simple.c
@@ -38,7 +38,7 @@ static int __init ppc44x_device_probe(void)
 
 	return 0;
 }
-machine_device_initcall(ppc44x_simple, ppc44x_device_probe);
+machine_arch_initcall(ppc44x_simple, ppc44x_device_probe);
 
 /* This is the list of boards that can be supported by this simple
  * platform code.  This does _not_ mean the boards are compatible,
diff --git a/arch/powerpc/platforms/44x/ppc476.c b/arch/powerpc/platforms/44x/ppc476.c
index e55933f9cd55..d19ba31aa442 100644
--- a/arch/powerpc/platforms/44x/ppc476.c
+++ b/arch/powerpc/platforms/44x/ppc476.c
@@ -118,7 +118,7 @@ static int __init ppc47x_device_probe(void)
 
 	return 0;
 }
-machine_device_initcall(ppc47x, ppc47x_device_probe);
+machine_arch_initcall(ppc47x, ppc47x_device_probe);
 
 static void __init ppc47x_init_irq(void)
 {
diff --git a/arch/powerpc/platforms/44x/sam440ep.c b/arch/powerpc/platforms/44x/sam440ep.c
index 688ffeab0699..13014efb1abb 100644
--- a/arch/powerpc/platforms/44x/sam440ep.c
+++ b/arch/powerpc/platforms/44x/sam440ep.c
@@ -42,7 +42,7 @@ static int __init sam440ep_device_probe(void)
 
 	return 0;
 }
-machine_device_initcall(sam440ep, sam440ep_device_probe);
+machine_arch_initcall(sam440ep, sam440ep_device_probe);
 
 static int __init sam440ep_probe(void)
 {
diff --git a/arch/powerpc/platforms/44x/virtex.c b/arch/powerpc/platforms/44x/virtex.c
index a7e08026097a..cbd8d73ae5ba 100644
--- a/arch/powerpc/platforms/44x/virtex.c
+++ b/arch/powerpc/platforms/44x/virtex.c
@@ -39,7 +39,7 @@ static int __init virtex_device_probe(void)
 
 	return 0;
 }
-machine_device_initcall(virtex, virtex_device_probe);
+machine_arch_initcall(virtex, virtex_device_probe);
 
 static int __init virtex_probe(void)
 {
diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
index 5ecce543103e..3ea5a5d92a00 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -40,7 +40,7 @@ static int __init warp_device_probe(void)
 	of_platform_bus_probe(NULL, warp_of_bus, NULL);
 	return 0;
 }
-machine_device_initcall(warp, warp_device_probe);
+machine_arch_initcall(warp, warp_device_probe);
 
 static int __init warp_probe(void)
 {
diff --git a/arch/powerpc/platforms/82xx/ep8248e.c b/arch/powerpc/platforms/82xx/ep8248e.c
index cdab847749e6..1394022574c9 100644
--- a/arch/powerpc/platforms/82xx/ep8248e.c
+++ b/arch/powerpc/platforms/82xx/ep8248e.c
@@ -302,7 +302,7 @@ static int __init declare_of_platform_devices(void)
 
 	return 0;
 }
-machine_device_initcall(ep8248e, declare_of_platform_devices);
+machine_arch_initcall(ep8248e, declare_of_platform_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/82xx/km82xx.c b/arch/powerpc/platforms/82xx/km82xx.c
index 28860e40b5db..87925209bf52 100644
--- a/arch/powerpc/platforms/82xx/km82xx.c
+++ b/arch/powerpc/platforms/82xx/km82xx.c
@@ -191,7 +191,7 @@ static int __init declare_of_platform_devices(void)
 
 	return 0;
 }
-machine_device_initcall(km82xx, declare_of_platform_devices);
+machine_arch_initcall(km82xx, declare_of_platform_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
index d23c10a96bde..518b57dab431 100644
--- a/arch/powerpc/platforms/82xx/mpc8272_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
@@ -194,7 +194,7 @@ static int __init declare_of_platform_devices(void)
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 	return 0;
 }
-machine_device_initcall(mpc8272_ads, declare_of_platform_devices);
+machine_arch_initcall(mpc8272_ads, declare_of_platform_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/82xx/pq2fads.c b/arch/powerpc/platforms/82xx/pq2fads.c
index 6c654dc74a4b..b22d8bdd6848 100644
--- a/arch/powerpc/platforms/82xx/pq2fads.c
+++ b/arch/powerpc/platforms/82xx/pq2fads.c
@@ -180,7 +180,7 @@ static int __init declare_of_platform_devices(void)
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 	return 0;
 }
-machine_device_initcall(pq2fads, declare_of_platform_devices);
+machine_arch_initcall(pq2fads, declare_of_platform_devices);
 
 define_machine(pq2fads)
 {
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index 40e0d8307b59..a95bdc1b225e 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -49,7 +49,7 @@ static int __init mpc831x_rdb_probe(void)
 	return of_device_compatible_match(of_root, board);
 }
 
-machine_device_initcall(mpc831x_rdb, mpc83xx_declare_of_platform_devices);
+machine_arch_initcall(mpc831x_rdb, mpc83xx_declare_of_platform_devices);
 
 define_machine(mpc831x_rdb) {
 	.name			= "MPC831x RDB",
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 8fd0c1e8b182..f8738d9cd52c 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -48,7 +48,7 @@ static int __init mpc834x_itx_declare_of_platform_devices(void)
 	mpc83xx_declare_of_platform_devices();
 	return of_platform_bus_probe(NULL, mpc834x_itx_ids, NULL);
 }
-machine_device_initcall(mpc834x_itx, mpc834x_itx_declare_of_platform_devices);
+machine_arch_initcall(mpc834x_itx, mpc834x_itx_declare_of_platform_devices);
 
 /* ************************************************************************
  *
diff --git a/arch/powerpc/platforms/85xx/ppa8548.c b/arch/powerpc/platforms/85xx/ppa8548.c
index 2410167b290a..0e876090661d 100644
--- a/arch/powerpc/platforms/85xx/ppa8548.c
+++ b/arch/powerpc/platforms/85xx/ppa8548.c
@@ -74,7 +74,7 @@ static int __init declare_of_platform_devices(void)
 
 	return 0;
 }
-machine_device_initcall(ppa8548, declare_of_platform_devices);
+machine_arch_initcall(ppa8548, declare_of_platform_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/8xx/adder875.c b/arch/powerpc/platforms/8xx/adder875.c
index 333dece79394..7b11310f7347 100644
--- a/arch/powerpc/platforms/8xx/adder875.c
+++ b/arch/powerpc/platforms/8xx/adder875.c
@@ -101,7 +101,7 @@ static int __init declare_of_platform_devices(void)
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 	return 0;
 }
-machine_device_initcall(adder875, declare_of_platform_devices);
+machine_arch_initcall(adder875, declare_of_platform_devices);
 
 define_machine(adder875) {
 	.name = "Adder MPC875",
diff --git a/arch/powerpc/platforms/8xx/ep88xc.c b/arch/powerpc/platforms/8xx/ep88xc.c
index cd0d90f1fb1c..ebd64df848bf 100644
--- a/arch/powerpc/platforms/8xx/ep88xc.c
+++ b/arch/powerpc/platforms/8xx/ep88xc.c
@@ -160,7 +160,7 @@ static int __init declare_of_platform_devices(void)
 
 	return 0;
 }
-machine_device_initcall(ep88xc, declare_of_platform_devices);
+machine_arch_initcall(ep88xc, declare_of_platform_devices);
 
 define_machine(ep88xc) {
 	.name = "Embedded Planet EP88xC",
diff --git a/arch/powerpc/platforms/8xx/mpc86xads_setup.c b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
index 8d02f5ff4481..5f6a9051a8f7 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -134,7 +134,7 @@ static int __init declare_of_platform_devices(void)
 
 	return 0;
 }
-machine_device_initcall(mpc86x_ads, declare_of_platform_devices);
+machine_arch_initcall(mpc86x_ads, declare_of_platform_devices);
 
 define_machine(mpc86x_ads) {
 	.name			= "MPC86x ADS",
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index e821a42d5816..911b9c3a98f5 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -210,7 +210,7 @@ static int __init declare_of_platform_devices(void)
 
 	return 0;
 }
-machine_device_initcall(mpc885_ads, declare_of_platform_devices);
+machine_arch_initcall(mpc885_ads, declare_of_platform_devices);
 
 define_machine(mpc885_ads) {
 	.name			= "Freescale MPC885 ADS",
diff --git a/arch/powerpc/platforms/8xx/tqm8xx_setup.c b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
index 4cea8b1afa44..e0c7a45d0eac 100644
--- a/arch/powerpc/platforms/8xx/tqm8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
@@ -136,7 +136,7 @@ static int __init declare_of_platform_devices(void)
 
 	return 0;
 }
-machine_device_initcall(tqm8xx, declare_of_platform_devices);
+machine_arch_initcall(tqm8xx, declare_of_platform_devices);
 
 define_machine(tqm8xx) {
 	.name			= "TQM8xx",
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index d3543e68efe8..d4809e7a3f2c 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -185,7 +185,7 @@ static int __init cell_publish_devices(void)
 
 	return 0;
 }
-machine_subsys_initcall(cell, cell_publish_devices);
+machine_arch_initcall(cell, cell_publish_devices);
 
 static void __init mpic_init_IRQ(void)
 {
diff --git a/arch/powerpc/platforms/embedded6xx/gamecube.c b/arch/powerpc/platforms/embedded6xx/gamecube.c
index 36789cec957c..a6f937552324 100644
--- a/arch/powerpc/platforms/embedded6xx/gamecube.c
+++ b/arch/powerpc/platforms/embedded6xx/gamecube.c
@@ -97,5 +97,5 @@ static int __init gamecube_device_probe(void)
 	of_platform_bus_probe(NULL, gamecube_of_bus, NULL);
 	return 0;
 }
-device_initcall(gamecube_device_probe);
+arch_initcall(gamecube_device_probe);
 
diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index f29cf29b11f8..01b4566ed2e6 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -32,7 +32,7 @@ static int __init declare_of_platform_devices(void)
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 	return 0;
 }
-machine_device_initcall(linkstation, declare_of_platform_devices);
+machine_arch_initcall(linkstation, declare_of_platform_devices);
 
 static int __init linkstation_add_bridge(struct device_node *dev)
 {
diff --git a/arch/powerpc/platforms/embedded6xx/mvme5100.c b/arch/powerpc/platforms/embedded6xx/mvme5100.c
index ed7321d6772e..8b048b708262 100644
--- a/arch/powerpc/platforms/embedded6xx/mvme5100.c
+++ b/arch/powerpc/platforms/embedded6xx/mvme5100.c
@@ -204,7 +204,7 @@ static int __init probe_of_platform_devices(void)
 	return 0;
 }
 
-machine_device_initcall(mvme5100, probe_of_platform_devices);
+machine_arch_initcall(mvme5100, probe_of_platform_devices);
 
 define_machine(mvme5100) {
 	.name			= "MVME5100",
diff --git a/arch/powerpc/platforms/embedded6xx/storcenter.c b/arch/powerpc/platforms/embedded6xx/storcenter.c
index 471a50bcd074..521d8882896c 100644
--- a/arch/powerpc/platforms/embedded6xx/storcenter.c
+++ b/arch/powerpc/platforms/embedded6xx/storcenter.c
@@ -34,7 +34,7 @@ static int __init storcenter_device_probe(void)
 	of_platform_bus_probe(NULL, storcenter_of_bus, NULL);
 	return 0;
 }
-machine_device_initcall(storcenter, storcenter_device_probe);
+machine_arch_initcall(storcenter, storcenter_device_probe);
 
 
 static int __init storcenter_add_bridge(struct device_node *dev)
diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 3fd683e40bc9..7c6eef1b8744 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -242,5 +242,5 @@ static int __init wii_device_probe(void)
 	of_platform_bus_probe(NULL, wii_of_bus, NULL);
 	return 0;
 }
-device_initcall(wii_device_probe);
+arch_initcall(wii_device_probe);
 
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index e86c1bd08f1f..a69a5c108e67 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -407,7 +407,7 @@ static int __init pasemi_publish_devices(void)
 
 	return 0;
 }
-machine_device_initcall(pasemi, pasemi_publish_devices);
+machine_arch_initcall(pasemi, pasemi_publish_devices);
 
 
 /*
-- 
2.8.1

Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fKn95GZzzF0jn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 23:15:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	frowand.list@gmail.com
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Use of_machine_compatible_match()
Date: Mon, 30 Jul 2018 23:15:16 +1000
Message-Id: <20180730131516.18406-2-mpe@ellerman.id.au>
In-Reply-To: <20180730131516.18406-1-mpe@ellerman.id.au>
References: <20180730131516.18406-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use of_machine_compatible_match() in platform code rather than open
coding.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/40x/ppc40x_simple.c    | 2 +-
 arch/powerpc/platforms/512x/mpc512x_generic.c | 2 +-
 arch/powerpc/platforms/52xx/lite5200.c        | 2 +-
 arch/powerpc/platforms/52xx/media5200.c       | 2 +-
 arch/powerpc/platforms/52xx/mpc5200_simple.c  | 2 +-
 arch/powerpc/platforms/83xx/mpc830x_rdb.c     | 2 +-
 arch/powerpc/platforms/83xx/mpc831x_rdb.c     | 2 +-
 arch/powerpc/platforms/83xx/mpc837x_rdb.c     | 2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c | 2 +-
 arch/powerpc/platforms/85xx/tqm85xx.c         | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)


Tested the corenet_generic.c change on a p5020ds, the rest are untested owing to
lack of hardware.

diff --git a/arch/powerpc/platforms/40x/ppc40x_simple.c b/arch/powerpc/platforms/40x/ppc40x_simple.c
index 2a050007bbae..f401a8add141 100644
--- a/arch/powerpc/platforms/40x/ppc40x_simple.c
+++ b/arch/powerpc/platforms/40x/ppc40x_simple.c
@@ -63,7 +63,7 @@ static const char * const board[] __initconst = {
 
 static int __init ppc40x_probe(void)
 {
-	if (of_device_compatible_match(of_root, board)) {
+	if (of_machine_compatible_match(board)) {
 		pci_set_flags(PCI_REASSIGN_ALL_RSRC);
 		return 1;
 	}
diff --git a/arch/powerpc/platforms/512x/mpc512x_generic.c b/arch/powerpc/platforms/512x/mpc512x_generic.c
index bf884d3075e4..952ea53d4829 100644
--- a/arch/powerpc/platforms/512x/mpc512x_generic.c
+++ b/arch/powerpc/platforms/512x/mpc512x_generic.c
@@ -38,7 +38,7 @@ static const char * const board[] __initconst = {
  */
 static int __init mpc512x_generic_probe(void)
 {
-	if (!of_device_compatible_match(of_root, board))
+	if (!of_machine_compatible_match(board))
 		return 0;
 
 	mpc512x_init_early();
diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index c94c385cc919..5f11e906e02c 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -183,7 +183,7 @@ static const char * const board[] __initconst = {
  */
 static int __init lite5200_probe(void)
 {
-	return of_device_compatible_match(of_root, board);
+	return of_machine_compatible_match(board);
 }
 
 define_machine(lite5200) {
diff --git a/arch/powerpc/platforms/52xx/media5200.c b/arch/powerpc/platforms/52xx/media5200.c
index 1fcab233d2f2..8641bb55c8e8 100644
--- a/arch/powerpc/platforms/52xx/media5200.c
+++ b/arch/powerpc/platforms/52xx/media5200.c
@@ -242,7 +242,7 @@ static const char * const board[] __initconst = {
  */
 static int __init media5200_probe(void)
 {
-	return of_device_compatible_match(of_root, board);
+	return of_machine_compatible_match(board);
 }
 
 define_machine(media5200_platform) {
diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/platforms/52xx/mpc5200_simple.c
index a80c6278d515..7b8b3be0f159 100644
--- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
+++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
@@ -70,7 +70,7 @@ static const char *board[] __initdata = {
  */
 static int __init mpc5200_simple_probe(void)
 {
-	return of_device_compatible_match(of_root, board);
+	return of_machine_compatible_match(board);
 }
 
 define_machine(mpc5200_simple_platform) {
diff --git a/arch/powerpc/platforms/83xx/mpc830x_rdb.c b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
index 272c41c387b9..7c0cd27e71e7 100644
--- a/arch/powerpc/platforms/83xx/mpc830x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
@@ -43,7 +43,7 @@ static const char *board[] __initdata = {
  */
 static int __init mpc830x_rdb_probe(void)
 {
-	return of_device_compatible_match(of_root, board);
+	return of_machine_compatible_match(board);
 }
 
 machine_device_initcall(mpc830x_rdb, mpc83xx_declare_of_platform_devices);
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index fd80fd570e67..3718db1c74e4 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -43,7 +43,7 @@ static const char *board[] __initdata = {
  */
 static int __init mpc831x_rdb_probe(void)
 {
-	return of_device_compatible_match(of_root, board);
+	return of_machine_compatible_match(board);
 }
 
 machine_device_initcall(mpc831x_rdb, mpc83xx_declare_of_platform_devices);
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index 0c55fa6af2d5..08c8434d895c 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -70,7 +70,7 @@ static const char * const board[] __initconst = {
  */
 static int __init mpc837x_rdb_probe(void)
 {
-	return of_device_compatible_match(of_root, board);
+	return of_machine_compatible_match(board);
 }
 
 define_machine(mpc837x_rdb) {
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index ac191a7a1337..8a2a32b75c66 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -174,7 +174,7 @@ static int __init corenet_generic_probe(void)
 	extern struct smp_ops_t smp_85xx_ops;
 #endif
 
-	if (of_device_compatible_match(of_root, boards))
+	if (of_machine_compatible_match(boards))
 		return 1;
 
 	/* Check if we're running under the Freescale hypervisor */
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index 9fc20a37835e..2172e93a7c67 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -122,7 +122,7 @@ static const char * const board[] __initconst = {
  */
 static int __init tqm85xx_probe(void)
 {
-	return of_device_compatible_match(of_root, board);
+	return of_machine_compatible_match(board);
 }
 
 define_machine(tqm85xx) {
-- 
2.14.1

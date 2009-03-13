Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <fc1755dacb01bff52fcf77ee18c4d7a075b01c37.1236923542.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/2] powerpc/msi: Mark the MSI bitmap selftest code as __init
Date: Fri, 13 Mar 2009 16:52:45 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/sysdev/msi_bitmap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
index f84217b..5a32cbe 100644
--- a/arch/powerpc/sysdev/msi_bitmap.c
+++ b/arch/powerpc/sysdev/msi_bitmap.c
@@ -141,7 +141,7 @@ void msi_bitmap_free(struct msi_bitmap *bmp)
 #define check(x)	\
 	if (!(x)) printk("msi_bitmap: test failed at line %d\n", __LINE__);
 
-void test_basics(void)
+void __init test_basics(void)
 {
 	struct msi_bitmap bmp;
 	int i, size = 512;
@@ -186,7 +186,7 @@ void test_basics(void)
 	kfree(bmp.bitmap);
 }
 
-void test_of_node(void)
+void __init test_of_node(void)
 {
 	u32 prop_data[] = { 10, 10, 25, 3, 40, 1, 100, 100, 200, 20 };
 	const char *expected_str = "0-9,20-24,28-39,41-99,220-255";
@@ -234,7 +234,7 @@ void test_of_node(void)
 	kfree(bmp.bitmap);
 }
 
-int msi_bitmap_selftest(void)
+int __init msi_bitmap_selftest(void)
 {
 	printk(KERN_DEBUG "Running MSI bitmap self-tests ...\n");
 
-- 
1.6.1.2

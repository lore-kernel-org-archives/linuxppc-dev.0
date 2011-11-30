Return-Path: <geoff@infradead.org>
Message-Id: <86c8862af65d2549c575896c031acd52fbf41968.1322615824.git.geoff@infradead.org>
In-Reply-To: <cover.1322615824.git.geoff@infradead.org>
References: <cover.1322615824.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 4/8] powerpc/ps3: Fix hcall lv1_get_version_info
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 30 Nov 2011 01:38:50 +0000
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The lv1_get_version_info hcall takes 2, not 1 output
arguments.  Adjust the lv1 hcall table and all calls.

Usage:

  int lv1_get_version_info(u64 *version_number, u64 *vendor_id)

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/include/asm/lv1call.h |    2 +-
 arch/powerpc/kernel/irq.c          |    4 ++--
 arch/powerpc/platforms/ps3/setup.c |    4 +++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/lv1call.h b/arch/powerpc/include/asm/lv1call.h
index 3ddf66c..8481221 100644
--- a/arch/powerpc/include/asm/lv1call.h
+++ b/arch/powerpc/include/asm/lv1call.h
@@ -276,7 +276,7 @@ LV1_CALL(construct_io_irq_outlet,                       1, 1, 120 )
 LV1_CALL(destruct_io_irq_outlet,                        1, 0, 121 )
 LV1_CALL(map_htab,                                      1, 1, 122 )
 LV1_CALL(unmap_htab,                                    1, 0, 123 )
-LV1_CALL(get_version_info,                              0, 1, 127 )
+LV1_CALL(get_version_info,                              0, 2, 127 )
 LV1_CALL(insert_htab_entry,                             6, 3, 158 )
 LV1_CALL(read_virtual_uart,                             3, 1, 162 )
 LV1_CALL(write_virtual_uart,                            3, 1, 163 )
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 5c3c469..e292078 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -180,8 +180,8 @@ notrace void arch_local_irq_restore(unsigned long en)
 	 * Any HV call will have this side effect.
 	 */
 	if (firmware_has_feature(FW_FEATURE_PS3_LV1)) {
-		u64 tmp;
-		lv1_get_version_info(&tmp);
+		u64 tmp, tmp2;
+		lv1_get_version_info(&tmp, &tmp2);
 	}
 
 	__hard_irq_enable();
diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index e8ec1b2..2d664c5 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -193,10 +193,12 @@ static int ps3_set_dabr(unsigned long dabr)
 
 static void __init ps3_setup_arch(void)
 {
+	u64 tmp;
 
 	DBG(" -> %s:%d\n", __func__, __LINE__);
 
-	lv1_get_version_info(&ps3_firmware_version.raw);
+	lv1_get_version_info(&ps3_firmware_version.raw, &tmp);
+
 	printk(KERN_INFO "PS3 firmware version %u.%u.%u\n",
 	       ps3_firmware_version.major, ps3_firmware_version.minor,
 	       ps3_firmware_version.rev);
-- 
1.7.0.4

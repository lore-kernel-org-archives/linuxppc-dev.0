Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <f6718cda8e9abbc89eafdaeba0e0e64be3daf25e.1216269949.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: Use WARN_ON(1) instead of __WARN()
Date: Thu, 17 Jul 2008 14:46:00 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

__WARN() is not defined for all configs, use WARN_ON(1) instead.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/lib/feature-fixups.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 4e43702..8c5a03b 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -99,7 +99,7 @@ void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 
 	for (; fcur < fend; fcur++) {
 		if (patch_feature_section(value, fcur)) {
-			__WARN();
+			WARN_ON(1);
 			printk("Unable to patch feature section at %p - %p" \
 				" with %p - %p\n",
 				calc_addr(fcur, fcur->start_off),
-- 
1.5.5

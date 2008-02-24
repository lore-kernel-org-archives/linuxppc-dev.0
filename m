Return-Path: <root@arrakis.enst.fr>
From: Samuel Tardieu <sam@rfc1149.net>
Date: Sun, 24 Feb 2008 09:06:01 +0100
Subject: [PATCH] ps3: Fix "unlikely" incorrect usage
To: linux-kernel@vger.kernel.org
Message-Id: <20080224081037.D492320AFF@arrakis.enst.fr>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix unlikely(plug) == NO_IRQ into unlikely(plug == NO_IRQ).

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 arch/powerpc/platforms/ps3/interrupt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index 3a6db04..a14e5cd 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -709,7 +709,7 @@ static unsigned int ps3_get_irq(void)
 	asm volatile("cntlzd %0,%1" : "=r" (plug) : "r" (x));
 	plug &= 0x3f;
 
-	if (unlikely(plug) == NO_IRQ) {
+	if (unlikely(plug == NO_IRQ)) {
 		pr_debug("%s:%d: no plug found: thread_id %lu\n", __func__,
 			__LINE__, pd->thread_id);
 		dump_bmp(&per_cpu(ps3_private, 0));
-- 
1.5.4.2.197.g22c43

Return-Path: <akinobu.mita@gmail.com>
Received: from mail-iw0-f188.google.com (mail-iw0-f188.google.com
	[209.85.223.188]) by ozlabs.org (Postfix) with ESMTP id 4F69FB7D59
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 21:59:11 +1100 (EST)
Received: by iwn26 with SMTP id 26so1706545iwn.9
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 02:59:09 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: use __ratelimit
Date: Sun, 28 Feb 2010 19:58:16 +0900
Message-Id: <1267354697-6456-4-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1267354697-6456-1-git-send-email-akinobu.mita@gmail.com>
References: <1267354697-6456-1-git-send-email-akinobu.mita@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, Akinobu Mita <akinobu.mita@gmail.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace open-coded rate limiting logic with __ratelimit().

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/platforms/iseries/pci.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 175aac8..5873a47 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -31,6 +31,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/of.h>
+#include <linux/ratelimit.h>
 
 #include <asm/types.h>
 #include <asm/io.h>
@@ -583,14 +584,9 @@ static inline struct device_node *xlate_iomm_address(
 
 	orig_addr = (unsigned long __force)addr;
 	if ((orig_addr < BASE_IO_MEMORY) || (orig_addr >= max_io_memory)) {
-		static unsigned long last_jiffies;
-		static int num_printed;
+		static DEFINE_RATELIMIT_STATE(ratelimit, 60 * HZ, 10);
 
-		if (time_after(jiffies, last_jiffies + 60 * HZ)) {
-			last_jiffies = jiffies;
-			num_printed = 0;
-		}
-		if (num_printed++ < 10)
+		if (__ratelimit(&ratelimit))
 			printk(KERN_ERR
 				"iSeries_%s: invalid access at IO address %p\n",
 				func, addr);
-- 
1.6.0.6

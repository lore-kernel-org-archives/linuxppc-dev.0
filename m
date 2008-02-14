Return-Path: <caglar@pardus.org.tr>
Received: from uludag.org.tr (ns2.uludag.org.tr [193.140.100.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7B47DDFC6
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 02:59:40 +1100 (EST)
From: =?utf-8?q?S=2E=C3=87a=C4=9Flar=20Onur?= <caglar@pardus.org.tr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] arch/powerpc/platforms/iseries/pci.c: Use time_* macros
Date: Thu, 14 Feb 2008 17:36:42 +0200
Message-Id: <1203003412-11594-5-git-send-email-caglar@pardus.org.tr>
In-Reply-To: y
References: y
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org,
	=?utf-8?q?S=2E=C3=87a=C4=9Flar=20Onur?= <caglar@pardus.org.tr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The functions time_before, time_before_eq, time_after, and time_after_eq are more robust for comparing jiffies against other values.

So following patch implements usage of the time_after() macro, defined at linux/jiffies.h, which deals with wrapping correctly

Cc: linuxppc-dev@ozlabs.org
Signed-off-by: S.Çağlar Onur <caglar@pardus.org.tr>
---
 arch/powerpc/platforms/iseries/pci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index cc562e4..02a634f 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -23,6 +23,7 @@
 
 #undef DEBUG
 
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/string.h>
@@ -586,7 +587,7 @@ static inline struct device_node *xlate_iomm_address(
 		static unsigned long last_jiffies;
 		static int num_printed;
 
-		if ((jiffies - last_jiffies) > 60 * HZ) {
+		if (time_after(jiffies, last_jiffies + 60 * HZ)) {
 			last_jiffies = jiffies;
 			num_printed = 0;
 		}
-- 
1.5.3.7

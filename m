Return-Path: <albert_herranz@yahoo.es>
Received: from smtp126.mail.ukl.yahoo.com (smtp126.mail.ukl.yahoo.com
	[77.238.184.57]) by ozlabs.org (Postfix) with SMTP id 5D0D2B6EF5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Dec 2009 05:33:56 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org, grant.likely@secretlab.ca
Subject: [PATCH] powerpc: gamecube/wii: fix off-by-one error in
	ugecon/usbgecko_udbg
Date: Thu, 17 Dec 2009 19:33:41 +0100
Message-Id: <1261074821-4120-1-git-send-email-albert_herranz@yahoo.es>
Cc: juha_motorsportcom@luukku.com, Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The retry logic in ug_putc() is broken.

If the TX fifo is not ready and the counter runs out it will have a
value of -1 and no transfer should be attempted. Also, a counter
with a value of 0 means that the TX fifo got ready in the last try
and the transfer should be attempted.

Reported-by: "Juha Leppanen" <juha_motorsportcom@luukku.com>
Signed-off-by: "Juha Leppanen" <juha_motorsportcom@luukku.com>
Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/boot/ugecon.c                         |    2 +-
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/ugecon.c b/arch/powerpc/boot/ugecon.c
index 50609ea..8f2a6b3 100644
--- a/arch/powerpc/boot/ugecon.c
+++ b/arch/powerpc/boot/ugecon.c
@@ -86,7 +86,7 @@ static void ug_putc(char ch)
 
 	while (!ug_is_txfifo_ready() && count--)
 		barrier();
-	if (count)
+	if (count >= 0)
 		ug_raw_putc(ch);
 }
 
diff --git a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
index edc956c..20a8ed9 100644
--- a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
+++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
@@ -120,7 +120,7 @@ static void ug_putc(char ch)
 
 	while (!ug_is_txfifo_ready() && count--)
 		barrier();
-	if (count)
+	if (count >= 0)
 		ug_raw_putc(ch);
 }
 
-- 
1.6.3.3

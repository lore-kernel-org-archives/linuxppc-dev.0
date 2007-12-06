Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B078ADE1D6
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:54 +1100 (EST)
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 8B1B2368002
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:54 +1100 (EST)
Date: Fri, 7 Dec 2007 01:48:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 04/19] [POWERPC] iSeries: cleanup PCI retry code a little
Message-Id: <20071207014814.ef15b4aa.sfr@canb.auug.org.au>
In-Reply-To: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/pci.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index e4e6ae0..8ef3226 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -45,8 +45,8 @@
 #include "pci.h"
 #include "call_pci.h"
 
-static int Pci_Retry_Max = 3;	/* Only retry 3 times  */
-static int Pci_Error_Flag = 1;	/* Set Retry Error on. */
+#define PCI_RETRY_MAX	3
+static int limit_pci_retries = 1;	/* Set Retry Error on. */
 
 /*
  * Table defines
@@ -338,8 +338,8 @@ static int CheckReturnCode(char *TextHdr, struct device_node *DevNode,
 		 * Bump the retry and check for retry count exceeded.
 		 * If, Exceeded, panic the system.
 		 */
-		if (((*retry) > Pci_Retry_Max) &&
-				(Pci_Error_Flag > 0)) {
+		if (((*retry) > PCI_RETRY_MAX) &&
+				(limit_pci_retries > 0)) {
 			mf_display_src(0xB6000103);
 			panic_timeout = 0;
 			panic("PCI: Hardware I/O Error, SRC B6000103, "
-- 
1.5.3.7


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 954C867A42
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 May 2006 04:32:33 +1000 (EST)
Date: Thu, 25 May 2006 14:32:32 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 5/5] Updates for WRS SBC82xx boards
Message-ID: <20060525183231.GG679@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: p_gortmaker@yahoo.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


patch5: fcc_enet-mac-addr.diff1
	- restore proper collection of mac addr data in obsolete FCC
	  driver by replacing mix of #ifdef and if() with case

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>



--- linux-2.6.16_rc5/arch/ppc/8260_io/fcc_enet.c.orig	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.16_rc5/arch/ppc/8260_io/fcc_enet.c	2006-02-27 18:01:45.000000000 -0500
@@ -1962,32 +1962,30 @@
 	 * non-static part of the address.
 	 */
 	eap = (unsigned char *)&(ep->fen_paddrh);
-	for (i=5; i>=0; i--) {
 
 /*
  * The EP8260 only uses FCC3, so we can safely give it the real
  * MAC address.
  */
+	for (i=5; i>=0; i--) switch(i) {
+		case 5:
 #ifdef CONFIG_SBC82xx
-		if (i == 5) {
 			/* bd->bi_enetaddr holds the SCC0 address; the FCC
 			   devices count up from there */
 			dev->dev_addr[i] = bd->bi_enetaddr[i] & ~3;
 			dev->dev_addr[i] += 1 + fip->fc_fccnum;
 			*eap++ = dev->dev_addr[i];
-		}
-#else
-#ifndef CONFIG_RPX8260
-		if (i == 3) {
+			break;
+#endif
+		case 3:
+#if !defined(CONFIG_RPX8260) && !defined(CONFIG_SBC82xx)
 			dev->dev_addr[i] = bd->bi_enetaddr[i];
 			dev->dev_addr[i] |= (1 << (7 - fip->fc_fccnum));
 			*eap++ = dev->dev_addr[i];
-		} else
+			break;
 #endif
-		{
+		default:
 			*eap++ = dev->dev_addr[i] = bd->bi_enetaddr[i];
-		}
-#endif
 	}
 
 	ep->fen_taddrh = 0;

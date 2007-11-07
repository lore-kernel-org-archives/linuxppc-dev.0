Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 536FBDDDF2
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 15:11:24 +1100 (EST)
Date: Tue, 6 Nov 2007 22:20:39 -0600
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [PATCH 1/2] pasemi_mac: Don't set replace-source-address
	descriptor bits
Message-ID: <20071107042039.GD22637@lixom.net>
References: <20071107042001.GC22637@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071107042001.GC22637@lixom.net>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Don't use the "replace source address with local MAC address" bits, since
it causes problems on some variations of the hardware due to an erratum.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: k.org/drivers/net/pasemi_mac.c
===================================================================
--- k.org.orig/drivers/net/pasemi_mac.c
+++ k.org/drivers/net/pasemi_mac.c
@@ -1126,7 +1126,7 @@ static int pasemi_mac_start_tx(struct sk
 	unsigned long flags;
 	int i, nfrags;
 
-	dflags = XCT_MACTX_O | XCT_MACTX_ST | XCT_MACTX_SS | XCT_MACTX_CRC_PAD;
+	dflags = XCT_MACTX_O | XCT_MACTX_ST | XCT_MACTX_CRC_PAD;
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		const unsigned char *nh = skb_network_header(skb);

Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5B427DDE17
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 16:09:30 +1000 (EST)
Date: Wed, 18 Apr 2007 01:27:50 -0500
To: jgarzik@pobox.com
Subject: [PATCH] [5/5] [v2] pasemi_mac: use local-mac-address
Message-ID: <20070418062750.GF11308@lixom.net>
References: <20070416061654.GB19783@lixom.net>
	<20070418062451.GA11308@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070418062451.GA11308@lixom.net>
From: olof@lixom.net (Olof Johansson)
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use local-mac-address in the device tree instead. Fall back to mac-address
for older firmware.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: powerpc/drivers/net/pasemi_mac.c
===================================================================
--- powerpc.orig/drivers/net/pasemi_mac.c
+++ powerpc/drivers/net/pasemi_mac.c
@@ -74,7 +74,12 @@ static int pasemi_get_mac_addr(struct pa
 		return -ENOENT;
 	}
 
-	maddr = get_property(dn, "mac-address", NULL);
+	maddr = get_property(dn, "local-mac-address", NULL);
+
+	/* Fall back to mac-address for older firmware */
+	if (maddr == NULL)
+		maddr = get_property(dn, "mac-address", NULL);
+
 	if (maddr == NULL) {
 		dev_warn(&pdev->dev,
 			 "no mac address in device tree, not configuring\n");

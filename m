Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E9C312BDEB
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Nov 2004 18:52:01 +1100 (EST)
Received: from pirandello (asap.atchik.net [195.167.234.210])
	by paperstreet.colino.net (Postfix) with ESMTP id 1523F73F6
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Nov 2004 08:51:10 +0100 (CET)
Date: Wed, 24 Nov 2004 08:50:54 +0100
From: Colin Leroy <colin@colino.net>
To: linuxppc-dev@ozlabs.org
Message-ID: <20041124085054.14a89f5f@pirandello>
In-Reply-To: <1101280145.4511.4.camel@gaston>
References: <1101280145.4511.4.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart_Wed__24_Nov_2004_08_50_54_+0100_mc2zGk2_OloEg=N0"
Subject: Re: TEST: Sleep patch #5
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Multipart_Wed__24_Nov_2004_08_50_54_+0100_mc2zGk2_OloEg=N0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 24 Nov 2004 at 18h11, Benjamin Herrenschmidt wrote:

Hi Ben, 

> Ok, here's the 5th version of the sleep patch for ATI based albooks &
> iBook G4. Other machine users, please test too as it may cause
> regressions (or improvements) as well.

Care to apply the attached patch to your tree ? It would avoid me 
a failing hunk when applying your patches, and also that's what 
AppleGmacEthernet does.

Thanks,
-- 
Colin

--Multipart_Wed__24_Nov_2004_08_50_54_+0100_mc2zGk2_OloEg=N0
Content-Type: text/plain; name=sungem_wol_opts.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=sungem_wol_opts.patch

--- drivers/net/sungem_phy.c.orig	2004-11-24 08:43:44.499855352 +0100
+++ drivers/net/sungem_phy.c	2004-11-24 08:42:58.990773784 +0100
@@ -147,13 +147,15 @@
 static int bcm5221_suspend(struct mii_phy* phy, int wol_options)
 {
 	u16 data;
-	data = phy_read(phy, MII_BCM5221_TEST);
-	phy_write(phy, MII_BCM5221_TEST,
-		data | MII_BCM5221_TEST_ENABLE_SHADOWS);
-
-	data = phy_read(phy, MII_BCM5221_SHDOW_AUX_MODE4);
-	phy_write(phy, MII_BCM5221_SHDOW_AUX_MODE4,
-		  data | MII_BCM5221_SHDOW_AUX_MODE4_IDDQMODE);
+	if (!wol_options) {
+		data = phy_read(phy, MII_BCM5221_TEST);
+		phy_write(phy, MII_BCM5221_TEST,
+			data | MII_BCM5221_TEST_ENABLE_SHADOWS);
+
+		data = phy_read(phy, MII_BCM5221_SHDOW_AUX_MODE4);
+		phy_write(phy, MII_BCM5221_SHDOW_AUX_MODE4,
+			  data | MII_BCM5221_SHDOW_AUX_MODE4_IDDQMODE);
+	}
 
 	return 0;
 }

--Multipart_Wed__24_Nov_2004_08_50_54_+0100_mc2zGk2_OloEg=N0--

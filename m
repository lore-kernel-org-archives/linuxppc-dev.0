Return-Path: <wfarnsworth@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 2EA0267A7D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 05:47:42 +1100 (EST)
Received: from rhino.az.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA14642
	for <linuxppc-embedded@ozlabs.org>; Tue, 15 Mar 2005 10:47:39 -0800
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <1110907039.24673.12.camel@rhino.az.mvista.com>
References: <1110907039.24673.12.camel@rhino.az.mvista.com>
Content-Type: multipart/mixed; boundary="=-UdetSYNOKESpAmKMqvKC"
Message-Id: <1110912458.24527.27.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 15 Mar 2005 11:47:38 -0700
Subject: Re: [PATCH 2/3] PPC440EP: ibm_emac phy mode bug fix
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



--=-UdetSYNOKESpAmKMqvKC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes a bug in drivers/net/ibm_emac/ibm_emac_core.c where if
the MDI0 bit is set in the ZMII_FER register, then the phy mode is not
detected properly, and SMII is selected by default.  This only occurs on
platforms where the phy_mode field of struct ocp_func_emac_data is not
used.

Regards,
Wade Farnsworth

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>


--=-UdetSYNOKESpAmKMqvKC
Content-Disposition: attachment; filename=ibm440ep-ibm_emac-bugfix.patch
Content-Type: text/plain; name=ibm440ep-ibm_emac-bugfix.patch
Content-Transfer-Encoding: 7bit

--- linux-2.6.11-bk7/drivers/net/ibm_emac/ibm_emac_core.c	2005-03-11 16:25:19.000000000 -0700
+++ linux-2.6.11-bk7-440ep/drivers/net/ibm_emac/ibm_emac_core.c	2005-03-11 16:26:19.000000000 -0700
@@ -315,7 +315,7 @@ static int emac_init_zmii(struct ocp_dev
 		zmii->base->fer &= ~ZMII_FER_MASK(input);
 		zmii->base->fer |= zmii_enable[input][mode];
 	} else {
-		switch ((zmii->base->fer & ZMII_FER_MASK(input)) << (4 * input)) {
+		switch (((zmii->base->fer & ZMII_FER_MASK(input)) << (4 * input)) & ~ZMII_MDI0) {
 		case ZMII_MII0:
 			mode = MII;
 			break;

--=-UdetSYNOKESpAmKMqvKC--

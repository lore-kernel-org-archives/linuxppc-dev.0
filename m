Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D3A302C009A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 10:26:02 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 5 Jun 2013 20:25:59 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 4B0A7C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 20:25:56 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r560Punf317154
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 20:25:56 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r560PuqZ025885
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 21:25:56 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/eeh: Don't check RTAS token to get PE addr
Date: Thu,  6 Jun 2013 08:25:50 +0800
Message-Id: <1370478350-16223-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RTAS token "ibm,get-config-addr-info" or ibm,get-config-addr-info2"
are used to retrieve the PE address according to PCI address, which
made up of domain/bus/slot/function. If we don't have those 2 tokens,
the domain/bus/slot/function would be used as the address for EEH
RTAS operations. Some older f/w might not have those 2 tokens and
that blocks the EEH functionality to be initialized. It was introduced
by commit e2af155c ("powerpc/eeh: pseries platform EEH initialization").

The patch skips the check on those 2 tokens so we can bring up EEH
functionality successfully. And domain/bus/slot/function will be
used as address for EEH RTAS operations.

Cc: <stable@vger.kernel.org> # v3.4+
Reported-by: Robert Knight <knight@princeton.edu>
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Tested-by: Robert Knight <knight@princeton.edu>
---
 arch/powerpc/platforms/pseries/eeh_pseries.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 19506f9..b456b15 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -83,7 +83,11 @@ static int pseries_eeh_init(void)
 	ibm_configure_pe		= rtas_token("ibm,configure-pe");
 	ibm_configure_bridge		= rtas_token("ibm,configure-bridge");
 
-	/* necessary sanity check */
+	/*
+	 * Necessary sanity check. We needn't check "get-config-addr-info"
+	 * and its variant since the old firmware probably support address
+	 * of domain/bus/slot/function for EEH RTAS operations.
+	 */
 	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE) {
 		pr_warning("%s: RTAS service <ibm,set-eeh-option> invalid\n",
 			__func__);
@@ -102,12 +106,6 @@ static int pseries_eeh_init(void)
 		pr_warning("%s: RTAS service <ibm,slot-error-detail> invalid\n",
 			__func__);
 		return -EINVAL;
-	} else if (ibm_get_config_addr_info2 == RTAS_UNKNOWN_SERVICE &&
-		   ibm_get_config_addr_info == RTAS_UNKNOWN_SERVICE) {
-		pr_warning("%s: RTAS service <ibm,get-config-addr-info2> and "
-			"<ibm,get-config-addr-info> invalid\n",
-			__func__);
-		return -EINVAL;
 	} else if (ibm_configure_pe == RTAS_UNKNOWN_SERVICE &&
 		   ibm_configure_bridge == RTAS_UNKNOWN_SERVICE) {
 		pr_warning("%s: RTAS service <ibm,configure-pe> and "
-- 
1.7.5.4

Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e2.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4B2B02C0257
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2012 16:15:16 +1000 (EST)
Received: from /spool/local
 by e2.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 5 Sep 2012 02:15:13 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id CC7CF6E803F
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2012 02:15:10 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q856FA5S111888
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2012 02:15:10 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q856FAO2019753
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2012 03:15:10 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/21] ppc/eeh: more logs for EEH initialization
Date: Wed,  5 Sep 2012 14:14:38 +0800
Message-Id: <1346825696-13960-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1346825696-13960-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1346825696-13960-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch adds more logs to EEH initialization functions for
debugging purpose. Also, the machine type ("pSeries") is checked
in the platform initialization to assure it's the correct platform
to invoke it.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_dev.c     |    2 ++
 arch/powerpc/platforms/pseries/eeh_pseries.c |   13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_dev.c b/arch/powerpc/platforms/pseries/eeh_dev.c
index 8e3443b..a0cee3a 100644
--- a/arch/powerpc/platforms/pseries/eeh_dev.c
+++ b/arch/powerpc/platforms/pseries/eeh_dev.c
@@ -100,6 +100,8 @@ static int __init eeh_dev_phb_init(void)
 	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
 		eeh_dev_phb_init_dynamic(phb);
 
+	pr_info("EEH: devices created\n");
+
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 5e2805a..46616c8 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -561,7 +561,18 @@ static struct eeh_ops pseries_eeh_ops = {
  */
 static int __init eeh_pseries_init(void)
 {
-	return eeh_ops_register(&pseries_eeh_ops);
+	int ret = -EINVAL;
+
+	if (!machine_is(pseries))
+		return ret;
+
+	ret = eeh_ops_register(&pseries_eeh_ops);
+	if (!ret)
+		pr_info("EEH: pSeries platform initialized\n");
+	else
+		pr_info("EEH: pSeries platform initialization failure\n");
+
+	return ret;
 }
 
 early_initcall(eeh_pseries_init);
-- 
1.7.5.4

Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B40BE100931
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 02:17:56 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 10:17:53 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id C738DC4098A
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 16:03:21 +0000 (WET)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG2xgR208774
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:59 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG1wTa026869
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:01:59 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/21] ppc/eeh: more logs for EEH initialization
Date: Thu, 28 Jun 2012 00:01:33 +0800
Message-Id: <1340812911-6793-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 2 files changed, 14 insertions(+), 1 deletion(-)

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
index bcf0bb8..bb2bd90 100644
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
1.7.9.5

Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 47DF22C009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 19:59:07 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 25 Dec 2013 03:59:03 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 7BF976E803F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 03:58:58 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBP8x1tU5571066
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 08:59:01 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBP8x1rJ009654
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 03:59:01 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] powerpc/eeh: Add restore_bars operation
Date: Wed, 25 Dec 2013 16:58:53 +0800
Message-Id: <1387961936-20451-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After reset on the specific PE or PHB, we never configure AER
correctly on PowerNV platform. We needn't care it on pSeries
platform. The patch introduces additional EEH operation eeh_ops::
restore_bars() so that we have chance to configure AER correctly
for PowerNV platform.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |    1 +
 arch/powerpc/kernel/eeh_pe.c                 |    3 +++
 arch/powerpc/platforms/pseries/eeh_pseries.c |    4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index d3e5e9b..4b709bf 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -157,6 +157,7 @@ struct eeh_ops {
 	int (*read_config)(struct device_node *dn, int where, int size, u32 *val);
 	int (*write_config)(struct device_node *dn, int where, int size, u32 val);
 	int (*next_error)(struct eeh_pe **pe);
+	void (*restore_bars)(struct device_node *dn);
 };
 
 extern struct eeh_ops *eeh_ops;
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index f945053..19eb95a 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -737,6 +737,9 @@ static void *eeh_restore_one_device_bars(void *data, void *flag)
 	else
 		eeh_restore_device_bars(edev, dn);
 
+	if (eeh_ops->restore_bars)
+		eeh_ops->restore_bars(dn);
+
 	return NULL;
 }
 
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index ccb633e..623adaf 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -689,7 +689,9 @@ static struct eeh_ops pseries_eeh_ops = {
 	.get_log		= pseries_eeh_get_log,
 	.configure_bridge       = pseries_eeh_configure_bridge,
 	.read_config		= pseries_eeh_read_config,
-	.write_config		= pseries_eeh_write_config
+	.write_config		= pseries_eeh_write_config,
+	.next_error		= NULL,
+	.restore_bars		= NULL
 };
 
 /**
-- 
1.7.10.4

Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6C4E82C00A4
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Jan 2014 20:47:25 +1100 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 3 Jan 2014 02:47:20 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2F63919D8041
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Jan 2014 02:47:10 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s039lBGh9961802
 for <linuxppc-dev@ozlabs.org>; Fri, 3 Jan 2014 10:47:11 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s039lH3f012983
 for <linuxppc-dev@ozlabs.org>; Fri, 3 Jan 2014 02:47:18 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 1/2] powerpc/eeh: Add restore_config operation
Date: Fri,  3 Jan 2014 17:47:12 +0800
Message-Id: <1388742433-7328-1-git-send-email-shangw@linux.vnet.ibm.com>
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
restore_config() so that we have chance to configure AER correctly
for PowerNV platform.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |    1 +
 arch/powerpc/kernel/eeh_pe.c                 |    3 +++
 arch/powerpc/platforms/powernv/eeh-powernv.c |    3 ++-
 arch/powerpc/platforms/pseries/eeh_pseries.c |    4 +++-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index d3e5e9b..7f8adc8 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -157,6 +157,7 @@ struct eeh_ops {
 	int (*read_config)(struct device_node *dn, int where, int size, u32 *val);
 	int (*write_config)(struct device_node *dn, int where, int size, u32 val);
 	int (*next_error)(struct eeh_pe **pe);
+	int (*restore_config)(struct device_node *dn);
 };
 
 extern struct eeh_ops *eeh_ops;
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index f945053..b60e11a 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -737,6 +737,9 @@ static void *eeh_restore_one_device_bars(void *data, void *flag)
 	else
 		eeh_restore_device_bars(edev, dn);
 
+	if (eeh_ops->restore_config)
+		eeh_ops->restore_config(dn);
+
 	return NULL;
 }
 
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 73b9814..ab91e6a 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -359,7 +359,8 @@ static struct eeh_ops powernv_eeh_ops = {
 	.configure_bridge       = powernv_eeh_configure_bridge,
 	.read_config            = pnv_pci_cfg_read,
 	.write_config           = pnv_pci_cfg_write,
-	.next_error		= powernv_eeh_next_error
+	.next_error		= powernv_eeh_next_error,
+	.restore_config		= NULL
 };
 
 /**
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index ccb633e..9ef3cc8 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -689,7 +689,9 @@ static struct eeh_ops pseries_eeh_ops = {
 	.get_log		= pseries_eeh_get_log,
 	.configure_bridge       = pseries_eeh_configure_bridge,
 	.read_config		= pseries_eeh_read_config,
-	.write_config		= pseries_eeh_write_config
+	.write_config		= pseries_eeh_write_config,
+	.next_error		= NULL,
+	.restore_config		= NULL
 };
 
 /**
-- 
1.7.10.4

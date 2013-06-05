Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D51522C02CD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 17:34:46 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 5 Jun 2013 01:34:44 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5B0C019D8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 01:34:33 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r557Ybph138000
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 01:34:37 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r557Yeov002088
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 01:34:40 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/27] powerpc/eeh: EEH post initialization operation
Date: Wed,  5 Jun 2013 15:34:08 +0800
Message-Id: <1370417668-16832-8-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch adds new EEH operation post_init. It's used to notify
the platform that EEH core has completed the EEH probe. By that,
PowerNV platform starts to use the services supplied by EEH
functionality.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h       |    1 +
 arch/powerpc/platforms/pseries/eeh.c |   11 +++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 72611fa..a577d78 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -131,6 +131,7 @@ static inline struct pci_dev *eeh_dev_to_pci_dev(struct eeh_dev *edev)
 struct eeh_ops {
 	char *name;
 	int (*init)(void);
+	int (*post_init)(void);
 	void* (*of_probe)(struct device_node *dn, void *flag);
 	int (*dev_probe)(struct pci_dev *dev, void *flag);
 	int (*set_option)(struct eeh_pe *pe, int option);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index dbc9d83..ef3b02a 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -720,6 +720,17 @@ int __init eeh_init(void)
 		return -EINVAL;
 	}
 
+	/*
+	 * Call platform post-initialization. Actually, It's good chance
+	 * to inform platform that EEH is ready to supply service if the
+	 * I/O cache stuff has been built up.
+	 */
+	if (eeh_ops->post_init) {
+		ret = eeh_ops->post_init();
+		if (ret)
+			return ret;
+	}
+
 	if (eeh_subsystem_enabled)
 		pr_info("EEH: PCI Enhanced I/O Error Handling Enabled\n");
 	else
-- 
1.7.5.4

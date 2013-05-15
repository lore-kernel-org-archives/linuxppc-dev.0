Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 869BA2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 13:35:13 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 14 May 2013 21:35:11 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 378C61FF001C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 21:30:01 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4F3Z7se136724
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 21:35:07 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4F3Z7G9003499
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 21:35:07 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/22] powerpc/eeh: EEH post initialization operation
Date: Wed, 15 May 2013 11:34:43 +0800
Message-Id: <1368588898-16224-8-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
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
index 1ff2aa9..09ea298 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -131,6 +131,7 @@ static inline struct pci_dev *eeh_dev_to_pci_dev(struct eeh_dev *edev)
 struct eeh_ops {
 	char *name;
 	int (*init)(void);
+	int (*post_init)(void);
 	void* (*of_probe)(struct device_node *dn, void *flag);
 	void* (*dev_probe)(struct pci_dev *dev, void *flag);
 	int (*set_option)(struct eeh_pe *pe, int option);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index abe26f8..39d2ea6 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -721,6 +721,17 @@ int __init eeh_init(void)
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

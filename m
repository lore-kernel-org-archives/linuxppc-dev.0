Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9AC60DE062
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 05:05:55 +1000 (EST)
Subject: [PATCH] make powerpc pci compile again
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 18 Jul 2007 19:26:48 +0200
Message-Id: <1184779608.8125.2.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Looks like we got a new declaration in the generic header... This fixes
compile but I don't know whether it's correct.
---
 arch/powerpc/kernel/pci-common.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6-git.orig/arch/powerpc/kernel/pci-common.c	2007-07-17 19:11:57.519997066 +0200
+++ linux-2.6-git/arch/powerpc/kernel/pci-common.c	2007-07-17 19:12:14.820997066 +0200
@@ -156,10 +156,12 @@ static DEVICE_ATTR(devspec, S_IRUGO, pci
 #endif /* CONFIG_PPC_OF */
 
 /* Add sysfs properties */
-void pcibios_add_platform_entries(struct pci_dev *pdev)
+int pcibios_add_platform_entries(struct pci_dev *pdev)
 {
 #ifdef CONFIG_PPC_OF
-	device_create_file(&pdev->dev, &dev_attr_devspec);
+	return device_create_file(&pdev->dev, &dev_attr_devspec);
+#else
+	return 0;
 #endif /* CONFIG_PPC_OF */
 }
 

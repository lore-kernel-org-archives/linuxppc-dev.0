Return-Path: <ryusuke@osrg.net>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E7F8F67A3B
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Nov 2006 16:15:07 +1100 (EST)
Date: Wed, 29 Nov 2006 14:07:51 +0900 (JST)
Message-Id: <20061129.140751.48374104.ryusuke@osrg.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2.6.19-rc6] powerpc: fix of_device __must_check warning
From: Ryusuke Konishi <ryusuke@osrg.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This fixes the following compile warning:

arch/powerpc/kernel/of_device.c: In function 'of_device_register':
arch/powerpc/kernel/of_device.c:199: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result

Signed-off-by: Ryusuke Konishi <ryusuke@osrg.net>
---
Hi,

This patch becomes useless when Benjamin's "powerpc: of_platform 
improvements" work will be done.  But, transiently, it helps to 
reduce gcc warning arising on the latest Linus's tree.

Regards,

Ryusuke

diff --git a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
index 397c83e..8831f00 100644
--- a/arch/powerpc/kernel/of_device.c
+++ b/arch/powerpc/kernel/of_device.c
@@ -196,9 +196,11 @@ int of_device_register(struct of_device
 	if (rc)
 		return rc;
 
-	device_create_file(&ofdev->dev, &dev_attr_devspec);
+	rc = device_create_file(&ofdev->dev, &dev_attr_devspec);
+	if (rc)
+		device_unregister(&ofdev->dev);
 
-	return 0;
+	return rc;
 }
 
 void of_device_unregister(struct of_device *ofdev)

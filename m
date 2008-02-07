Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id DA009DDE04
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 16:08:34 +1100 (EST)
Message-ID: <47AA9251.5020007@pikatech.com>
Date: Thu, 07 Feb 2008 00:08:33 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] emac/zmii link warnings
References: <478C336D.2080307@pikatech.com><20080115152748.d0a05e1b.sfr@canb.auug.org.au>
	<478C487D.9050407@pikatech.com>
In-Reply-To: <478C487D.9050407@pikatech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, here is my best shot at removing the warnings. It seems to me that 
functions called from a dev_init section should not be dev_exit.

Cheers,
   Sean

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
index e6c69f7..21fe06f 100644
--- a/drivers/net/ibm_newemac/core.c
+++ b/drivers/net/ibm_newemac/core.c
@@ -2230,7 +2230,7 @@ static int __devinit emac_of_bus_notify(struct notifier_block *nb,
 	return 0;
 }
 
-static struct notifier_block emac_of_bus_notifier = {
+static struct notifier_block __devinitdata emac_of_bus_notifier = {
 	.notifier_call = emac_of_bus_notify
 };
 
diff --git a/drivers/net/ibm_newemac/mal.c b/drivers/net/ibm_newemac/mal.c
index 6869f08..0ba0a68 100644
--- a/drivers/net/ibm_newemac/mal.c
+++ b/drivers/net/ibm_newemac/mal.c
@@ -61,8 +61,9 @@ int __devinit mal_register_commac(struct mal_instance	*mal,
 	return 0;
 }
 
-void __devexit mal_unregister_commac(struct mal_instance	*mal,
-				     struct mal_commac		*commac)
+/* This cannot be a __devexit since it is called from __devinit functions. */
+void mal_unregister_commac(struct mal_instance	*mal,
+			   struct mal_commac *commac)
 {
 	unsigned long flags;
 
diff --git a/drivers/net/ibm_newemac/zmii.c b/drivers/net/ibm_newemac/zmii.c
index 2ea472a..5e6231b 100644
--- a/drivers/net/ibm_newemac/zmii.c
+++ b/drivers/net/ibm_newemac/zmii.c
@@ -189,7 +189,8 @@ void zmii_set_speed(struct of_device *ofdev, int input, int speed)
 	mutex_unlock(&dev->lock);
 }
 
-void __devexit zmii_detach(struct of_device *ofdev, int input)
+/* This cannot be a __devexit since it is called from __devinit functions. */
+void zmii_detach(struct of_device *ofdev, int input)
 {
 	struct zmii_instance *dev = dev_get_drvdata(&ofdev->dev);
 

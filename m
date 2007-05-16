Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3EE6BDDF1A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 May 2007 05:04:21 +1000 (EST)
Date: Wed, 16 May 2007 11:57:37 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: netdev@vger.kernel.org
Subject: [PATCH 1/3] ibm_emac: fix section mismatch warnings
Message-ID: <20070516185737.GA14704@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jeff@garzik.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fix "Section mismatch" warnings

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

---
 drivers/net/ibm_emac/ibm_emac_mal.c   |    3 +--
 drivers/net/ibm_emac/ibm_emac_mal.h   |    3 +--
 drivers/net/ibm_emac/ibm_emac_rgmii.c |    2 +-
 drivers/net/ibm_emac/ibm_emac_rgmii.h |    2 +-
 drivers/net/ibm_emac/ibm_emac_tah.c   |    2 +-
 drivers/net/ibm_emac/ibm_emac_tah.h   |    2 +-
 drivers/net/ibm_emac/ibm_emac_zmii.c  |    2 +-
 drivers/net/ibm_emac/ibm_emac_zmii.h  |    2 +-
 8 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ibm_emac/ibm_emac_mal.c b/drivers/net/ibm_emac/ibm_emac_mal.c
index 6c0f071..cabd984 100644
--- a/drivers/net/ibm_emac/ibm_emac_mal.c
+++ b/drivers/net/ibm_emac/ibm_emac_mal.c
@@ -59,8 +59,7 @@ int __init mal_register_commac(struct ibm_ocp_mal *mal,
 	return 0;
 }
 
-void __exit mal_unregister_commac(struct ibm_ocp_mal *mal,
-				  struct mal_commac *commac)
+void mal_unregister_commac(struct ibm_ocp_mal *mal, struct mal_commac *commac)
 {
 	unsigned long flags;
 	local_irq_save(flags);
diff --git a/drivers/net/ibm_emac/ibm_emac_mal.h b/drivers/net/ibm_emac/ibm_emac_mal.h
index 407d2ac..64bc338 100644
--- a/drivers/net/ibm_emac/ibm_emac_mal.h
+++ b/drivers/net/ibm_emac/ibm_emac_mal.h
@@ -223,8 +223,7 @@ void mal_exit(void) __exit;
 
 int mal_register_commac(struct ibm_ocp_mal *mal,
 			struct mal_commac *commac) __init;
-void mal_unregister_commac(struct ibm_ocp_mal *mal,
-			   struct mal_commac *commac) __exit;
+void mal_unregister_commac(struct ibm_ocp_mal *mal, struct mal_commac *commac);
 int mal_set_rcbs(struct ibm_ocp_mal *mal, int channel, unsigned long size);
 
 /* Returns BD ring offset for a particular channel
diff --git a/drivers/net/ibm_emac/ibm_emac_rgmii.c b/drivers/net/ibm_emac/ibm_emac_rgmii.c
index 53d281c..9dbb5e5 100644
--- a/drivers/net/ibm_emac/ibm_emac_rgmii.c
+++ b/drivers/net/ibm_emac/ibm_emac_rgmii.c
@@ -162,7 +162,7 @@ void rgmii_set_speed(struct ocp_device *ocpdev, int input, int speed)
 	out_be32(&dev->base->ssr, ssr);
 }
 
-void __exit __rgmii_fini(struct ocp_device *ocpdev, int input)
+void __rgmii_fini(struct ocp_device *ocpdev, int input)
 {
 	struct ibm_ocp_rgmii *dev = ocp_get_drvdata(ocpdev);
 	BUG_ON(!dev || dev->users == 0);
diff --git a/drivers/net/ibm_emac/ibm_emac_rgmii.h b/drivers/net/ibm_emac/ibm_emac_rgmii.h
index 117ea48..971e458 100644
--- a/drivers/net/ibm_emac/ibm_emac_rgmii.h
+++ b/drivers/net/ibm_emac/ibm_emac_rgmii.h
@@ -37,7 +37,7 @@ struct ibm_ocp_rgmii {
 #ifdef CONFIG_IBM_EMAC_RGMII
 int rgmii_attach(void *emac) __init;
 
-void __rgmii_fini(struct ocp_device *ocpdev, int input) __exit;
+void __rgmii_fini(struct ocp_device *ocpdev, int input);
 static inline void rgmii_fini(struct ocp_device *ocpdev, int input)
 {
 	if (ocpdev)
diff --git a/drivers/net/ibm_emac/ibm_emac_tah.c b/drivers/net/ibm_emac/ibm_emac_tah.c
index e287b45..3c2d5ba 100644
--- a/drivers/net/ibm_emac/ibm_emac_tah.c
+++ b/drivers/net/ibm_emac/ibm_emac_tah.c
@@ -63,7 +63,7 @@ int __init tah_attach(void *emac)
 	return 0;
 }
 
-void __exit __tah_fini(struct ocp_device *ocpdev)
+void __tah_fini(struct ocp_device *ocpdev)
 {
 	struct tah_regs *p = ocp_get_drvdata(ocpdev);
 	BUG_ON(!p);
diff --git a/drivers/net/ibm_emac/ibm_emac_tah.h b/drivers/net/ibm_emac/ibm_emac_tah.h
index 3815394..ccf6491 100644
--- a/drivers/net/ibm_emac/ibm_emac_tah.h
+++ b/drivers/net/ibm_emac/ibm_emac_tah.h
@@ -55,7 +55,7 @@ struct tah_regs {
 #ifdef CONFIG_IBM_EMAC_TAH
 int tah_attach(void *emac) __init;
 
-void __tah_fini(struct ocp_device *ocpdev) __exit;
+void __tah_fini(struct ocp_device *ocpdev);
 static inline void tah_fini(struct ocp_device *ocpdev)
 {
 	if (ocpdev)
diff --git a/drivers/net/ibm_emac/ibm_emac_zmii.c b/drivers/net/ibm_emac/ibm_emac_zmii.c
index 37dc8f3..2c0fdb0 100644
--- a/drivers/net/ibm_emac/ibm_emac_zmii.c
+++ b/drivers/net/ibm_emac/ibm_emac_zmii.c
@@ -215,7 +215,7 @@ void __zmii_set_speed(struct ocp_device *ocpdev, int input, int speed)
 	out_be32(&dev->base->ssr, ssr);
 }
 
-void __exit __zmii_fini(struct ocp_device *ocpdev, int input)
+void __zmii_fini(struct ocp_device *ocpdev, int input)
 {
 	struct ibm_ocp_zmii *dev = ocp_get_drvdata(ocpdev);
 	BUG_ON(!dev || dev->users == 0);
diff --git a/drivers/net/ibm_emac/ibm_emac_zmii.h b/drivers/net/ibm_emac/ibm_emac_zmii.h
index 972e3a4..fad6d8b 100644
--- a/drivers/net/ibm_emac/ibm_emac_zmii.h
+++ b/drivers/net/ibm_emac/ibm_emac_zmii.h
@@ -40,7 +40,7 @@ struct ibm_ocp_zmii {
 #ifdef CONFIG_IBM_EMAC_ZMII
 int zmii_attach(void *emac) __init;
 
-void __zmii_fini(struct ocp_device *ocpdev, int input) __exit;
+void __zmii_fini(struct ocp_device *ocpdev, int input);
 static inline void zmii_fini(struct ocp_device *ocpdev, int input)
 {
 	if (ocpdev)

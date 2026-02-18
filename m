Return-Path: <linuxppc-dev+bounces-16933-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4437E9A047
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Feb 2026 13:52:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fGHxr1Bgcz3brl;
	Thu, 19 Feb 2026 00:52:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771422736;
	cv=none; b=BClKMPBuEF7K7oBIqgC817G3NZxhu3nQtO2nnUdo2RjAPyxFF2fWSBrRaj9eVNhEAONMIljsJNsATkRLwn8FWqgOaML7OFSUPjW7ikcz0tWJwehmOpdiAF5nGRy4D1jIC4ZP+7uWtFs2HTPD+CNLLjPhtQwvloJ/KYWU5bNSlfCDsdHDHiRCjRPItz8WKFJZuXBTuwQuwn/epkVy35IIpa0DbfLP/nlVIWSq+urbqz4WkxZEUnbztwHTBjoiLwgrTsJGJt1Tg68J3pi3uH4q5jyTj6/5lP9SxWbGAFLYosULoVQ5uJQC3Xhn8unrOja4zrTUZPj0mKoYwx8WX2Gvtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771422736; c=relaxed/relaxed;
	bh=5AzTzakBXerpsFjmK9f4GscJ93oBNHKLNJxS8JXaUyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFa7Mk2LO0QLvymDhBdk/OsrnJop0mYQX4N9nKRQV3Qvr/t0mEwfQ7lpoJfBNz+sDqN/kkibUoN0rQdpa/Kl1q6Ve3+nBN/joGz/af6pzgTGMzuGYiOwCbltbpRwen28tX8jMUq7Bv7XhqulKTc2/Wnd3WEo19FUyQi74uJqfODDm4+r3VinM2UgPY9HBJ6F+iQxKMBFIQ+wMwe2B6gp0EuJEx3F/l+u5yenWLOwi4F21Wi0xY6uNgA75cI2fkpUPHWOmqfkFbfDyH8BlbdUrsanNI2hcQWUBIr0Bfqoqs6llBGZsH+DT1ygQ4ozkNXld2tRONCGlzybZmtmFGKClQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RAfebbQ5; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RAfebbQ5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fGHxm0l5fz3bnL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2026 00:52:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 914B56185F;
	Wed, 18 Feb 2026 13:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436D8C2BC86;
	Wed, 18 Feb 2026 13:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771422729;
	bh=KGxbgKznSWXiSbtw2Mu7H6wWeyOpFU6lUGSUuf6OwBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RAfebbQ5ZZNQ4Vkivk5kyjKdaRezd24cEthU11fmD7QgmdjD6oIZG5z2uRvdVVxa5
	 2ijsTJczGj8EXDSaxVKNIDc/oTBw1kgzaNeIKm+Xpdta6U4vtsEoSN+vonl49kY+Bs
	 57xZY5WkDb6Xu7EbkQqyLoaInIyQRKdsKElNK5svy7Fe+yYIJzrvK6wQqbvDGagapj
	 0+Gn7T5Jy4E+q+ARQCiXKumPJ8CIdMx5F2SzxXnDH/Da/il/TXX1KvnCc2X+a9L+le
	 nxMNdstjxOoiGFkjjCWDfynFIMGztfZ+mhqBud7CRt3uVcfDh4+Lrmaw7dyxrba3DV
	 4Tupp0uDWolew==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vshyJ-0000000Bu02-0M2C;
	Wed, 18 Feb 2026 13:52:07 +0000
From: Marc Zyngier <maz@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/6] fsl_mc: Add minimal infrastructure to use platform MSI
Date: Wed, 18 Feb 2026 13:51:59 +0000
Message-ID: <20260218135203.2267907-3-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260218135203.2267907-1-maz@kernel.org>
References: <20260218135203.2267907-1-maz@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: ioana.ciornei@nxp.com, tglx@kernel.org, chleroy@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Add the tiny bit of infrastructure to be able to use platform MSI
instead of the current hack. This means providing a write_msi_msg
callback, as well as irq domain and devid retrieval helpers.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/bus/fsl-mc/fsl-mc-msi.c     | 50 ++++++++++++++++++++++++-----
 drivers/bus/fsl-mc/fsl-mc-private.h |  1 +
 include/linux/fsl/mc.h              |  2 ++
 3 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index 82cd69f7884c6..c9f50969e88ce 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -110,13 +110,8 @@ static void __fsl_mc_msi_write_msg(struct fsl_mc_device *mc_bus_dev,
 	}
 }
 
-/*
- * NOTE: This function is invoked with interrupts disabled
- */
-static void fsl_mc_msi_write_msg(struct irq_data *irq_data,
-				 struct msi_msg *msg)
+static void fsl_mc_write_msi_msg(struct msi_desc *msi_desc, struct msi_msg *msg)
 {
-	struct msi_desc *msi_desc = irq_data_get_msi_desc(irq_data);
 	struct fsl_mc_device *mc_bus_dev = to_fsl_mc_device(msi_desc->dev);
 	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_bus_dev);
 	struct fsl_mc_device_irq *mc_dev_irq =
@@ -130,6 +125,17 @@ static void fsl_mc_msi_write_msg(struct irq_data *irq_data,
 	__fsl_mc_msi_write_msg(mc_bus_dev, mc_dev_irq, msi_desc);
 }
 
+/*
+ * NOTE: This function is invoked with interrupts disabled
+ */
+static void fsl_mc_msi_write_msg(struct irq_data *irq_data,
+				 struct msi_msg *msg)
+{
+	struct msi_desc *msi_desc = irq_data_get_msi_desc(irq_data);
+
+	fsl_mc_write_msi_msg(msi_desc, msg);
+}
+
 static void fsl_mc_msi_update_chip_ops(struct msi_domain_info *info)
 {
 	struct irq_chip *chip = info->chip;
@@ -209,6 +215,20 @@ struct irq_domain *fsl_mc_find_msi_domain(struct device *dev)
 	return msi_domain;
 }
 
+struct irq_domain *fsl_mc_get_msi_parent(struct device *dev)
+{
+	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+	struct device *root_dprc_dev;
+	struct device *bus_dev;
+
+	fsl_mc_get_root_dprc(dev, &root_dprc_dev);
+	bus_dev = root_dprc_dev->parent;
+
+	return (bus_dev->of_node ?
+		of_msi_get_domain(bus_dev, bus_dev->of_node, DOMAIN_BUS_NEXUS) :
+		iort_get_device_domain(bus_dev, mc_dev->icid, DOMAIN_BUS_NEXUS));
+}
+
 int fsl_mc_msi_domain_alloc_irqs(struct device *dev,  unsigned int irq_count)
 {
 	int error = msi_setup_device_data(dev);
@@ -220,8 +240,10 @@ int fsl_mc_msi_domain_alloc_irqs(struct device *dev,  unsigned int irq_count)
 	 * NOTE: Calling this function will trigger the invocation of the
 	 * its_fsl_mc_msi_prepare() callback
 	 */
-	error = msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0, irq_count - 1);
-
+	if (!irq_domain_is_msi_parent(dev_get_msi_domain(dev)))
+		error = msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0, irq_count - 1);
+	else
+		error = platform_device_msi_init_and_alloc_irqs(dev, irq_count, fsl_mc_write_msi_msg);
 	if (error)
 		dev_err(dev, "Failed to allocate IRQs\n");
 	return error;
@@ -231,3 +253,15 @@ void fsl_mc_msi_domain_free_irqs(struct device *dev)
 {
 	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
 }
+
+u32 fsl_mc_get_msi_id(struct device *dev)
+{
+	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+	struct device *root_dprc_dev;
+
+	fsl_mc_get_root_dprc(dev, &root_dprc_dev);
+
+	return (root_dprc_dev->parent->of_node ?
+		of_msi_xlate(dev, NULL, mc_dev->icid) :
+		iort_msi_map_id(dev, mc_dev->icid));
+}
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index beed4c53533d8..44868f874fd66 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -642,6 +642,7 @@ int fsl_mc_msi_domain_alloc_irqs(struct device *dev,
 void fsl_mc_msi_domain_free_irqs(struct device *dev);
 
 struct irq_domain *fsl_mc_find_msi_domain(struct device *dev);
+struct irq_domain *fsl_mc_get_msi_parent(struct device *dev);
 
 int __must_check fsl_create_mc_io(struct device *dev,
 				  phys_addr_t mc_portal_phys_addr,
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 897d6211c1635..bcc38c0fc230a 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -361,9 +361,11 @@ int mc_send_command(struct fsl_mc_io *mc_io, struct fsl_mc_command *cmd);
 
 #ifdef CONFIG_FSL_MC_BUS
 #define dev_is_fsl_mc(_dev) ((_dev)->bus == &fsl_mc_bus_type)
+u32 fsl_mc_get_msi_id(struct device *dev);
 #else
 /* If fsl-mc bus is not present device cannot belong to fsl-mc bus */
 #define dev_is_fsl_mc(_dev) (0)
+#define fsl_mc_get_msi_id(_dev)	(0)
 #endif
 
 /* Macro to check if a device is a container device */
-- 
2.47.3



Return-Path: <linuxppc-dev+bounces-19814-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CFCF8D763
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:04:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxQpP5hMCz2yYK;
	Fri, 17 Apr 2026 04:02:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776362557;
	cv=none; b=LfLnzUv+5txwbcDXbttmnxuQAZqZEJIRuE8P4JAO726ACsyC9i5fhZkpwLwdInCoXB+/jdDxQWLRVbldIRmmvbC7YLQ3Fn9P0xAqkDDoUa3OkSOIoy6MDTLXkgrOKprRdEl/r7Qp658wTv29aLftn+BdMnbQ0Hp22bApNsbIyydJzElgfHGj04+8G/jyMCwdx46kxaXV0eNdJAe6Ist17m4ueXIjUR3t+CDSma1qJlWE8V6paw9v8fPRi4gVbPWQevaOSx2w4u9Adekh+mAQBMcASvDDFEyRj6NQWWq08GY8CaDPyC/fpHycWkH+/REya1GEHFMhaKOL0D7FShBb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776362557; c=relaxed/relaxed;
	bh=6rsPzhX1lE/RIeYrJBcHxhEhX+iKxhR1+uPggLB2nA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OeJh4RZHFDpZbbB5vjJJ/52yJx2k2fu+p/VlKLcl3mUw/Rs3vCRZ6jdTXkNz5pVVCANE13GG5N8JOzBW8udQlpsxGKg2WHGDt52N6UUBUegFevarzoNI5iC51eqsZFVKlqBZfu//3YZkJm9TLm3h7/PgPriwVjDi7gm2QBluYl5iIHSiYS6wpCFIo+YbiywfSQXdKvFD4CXIvIrCC/YKJ+X0tXOdf8qm2sTGnugkTP7XWy20tqmAoE2vZ04ExEDHleq0HfbnLSwtMR1uPIWtHqKmUgwAbac9GQovagHVigTQeWsJ+gf2V/EpS8UlQGxwe9kH3b+p8OV4sgYgS4LqNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ixR+9/lw; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ixR+9/lw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxQpP033hz304h
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 04:02:36 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 359E241A8C;
	Thu, 16 Apr 2026 18:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62BDC2BCAF;
	Thu, 16 Apr 2026 18:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362555;
	bh=w2L/1BbQlnupAA1chm17jtpCQ2vcnErH2JeEEFYOqZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ixR+9/lwLLH3bbp0iMVDTJIwkI2rqXIBOII0NxyC/hn6c2U/YDeUTFHAAOW5tf/O+
	 oIkVXRXXawG2PT5i8LPuCC3/V7EuRi7fcg2ZnTqFZ0L6t/s3+ZGy/cTVBbQd9TUlnV
	 4WoVcJlaNNyYzk1oFn5vV/Z7LpfZaksnCxir/6wIhyCzO7iLZlTcU3w2XWkpBKrQrZ
	 Ot+Xb2kuJ38nCw8PoK7FOX0kdVMb/yXUmDJkbkQ+VtLhTaDn8GBQoty0U6DcDwT5b7
	 d89PuG4rSTPdDtaTEeqn62fHInG08cog2fialg9Q21cjtsogFSFmyqCK8i08ssyMYp
	 uvjWBdbXofx0w==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 23/23] PCI/sysfs: Remove pci_create_legacy_files() and pci_sysfs_init()
Date: Thu, 16 Apr 2026 18:01:07 +0000
Message-ID: <20260416180107.777065-24-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416180107.777065-1-kwilczynski@kernel.org>
References: <20260416180107.777065-1-kwilczynski@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, pci_create_legacy_files() and pci_remove_legacy_files() are
no-op stubs.  With legacy attributes now handled by static groups
registered via pcibus_groups[], no call site needs them.

Remove both functions, their declarations, and the call sites in
pci_register_host_bridge(), pci_alloc_child_bus(), and pci_remove_bus().

Remove the pci_sysfs_init() late_initcall and sysfs_initialized.  The
late_initcall originally existed to create all the dynamic PCI sysfs
files, but with both resource and legacy attributes now handled by
static groups, it is no longer needed.

Remove the legacy_io and legacy_mem fields from struct pci_bus which
were used to track the dynamically allocated legacy attributes.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 21 ---------------------
 drivers/pci/pci.h       |  8 --------
 drivers/pci/probe.c     |  6 ------
 drivers/pci/remove.c    |  2 --
 include/linux/pci.h     |  2 --
 5 files changed, 39 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c81d3964cfa4..b167e32d55ac 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -37,10 +37,6 @@
 #define ARCH_PCI_DEV_GROUPS
 #endif
 
-#ifdef HAVE_PCI_LEGACY
-static int sysfs_initialized;	/* = 0 */
-#endif
-
 /* show configuration fields */
 #define pci_config_attr(field, format_string)				\
 static ssize_t								\
@@ -1135,8 +1131,6 @@ static const struct attribute_group pci_legacy_mem_sparse_group = {
 	.is_bin_visible = pci_legacy_mem_sparse_is_visible,
 };
 
-void pci_create_legacy_files(struct pci_bus *b) { }
-void pci_remove_legacy_files(struct pci_bus *b) { }
 #endif /* HAVE_PCI_LEGACY */
 
 const struct attribute_group *pcibus_groups[] = {
@@ -1811,21 +1805,6 @@ static const struct attribute_group pci_dev_resource_resize_attr_group = {
 	.is_visible = resource_resize_attr_is_visible,
 };
 
-#ifdef HAVE_PCI_LEGACY
-static int __init pci_sysfs_init(void)
-{
-	struct pci_bus *pbus = NULL;
-
-	sysfs_initialized = 1;
-
-	while ((pbus = pci_find_next_bus(pbus)))
-		pci_create_legacy_files(pbus);
-
-	return 0;
-}
-late_initcall(pci_sysfs_init);
-#endif
-
 static struct attribute *pci_dev_dev_attrs[] = {
 	&dev_attr_boot_vga.attr,
 	&dev_attr_serial_number.attr,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f52caf7e4d13..63f249d4833a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -356,14 +356,6 @@ static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
 int pci_hp_add_bridge(struct pci_dev *dev);
 bool pci_hp_spurious_link_change(struct pci_dev *pdev);
 
-#if defined(CONFIG_SYSFS) && defined(HAVE_PCI_LEGACY)
-void pci_create_legacy_files(struct pci_bus *bus);
-void pci_remove_legacy_files(struct pci_bus *bus);
-#else
-static inline void pci_create_legacy_files(struct pci_bus *bus) { }
-static inline void pci_remove_legacy_files(struct pci_bus *bus) { }
-#endif
-
 /* Lock for read/write access to pci device and bus lists */
 extern struct rw_semaphore pci_bus_sem;
 extern struct mutex pci_slot_mutex;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd79..94c52bf3a65c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1068,9 +1068,6 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 			dev_err(&bus->dev, "failed to add bus: %d\n", err);
 	}
 
-	/* Create legacy_io and legacy_mem files for this bus */
-	pci_create_legacy_files(bus);
-
 	if (parent)
 		dev_info(parent, "PCI host bridge to bus %s\n", name);
 	else
@@ -1276,9 +1273,6 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 			dev_err(&child->dev, "failed to add bus: %d\n", ret);
 	}
 
-	/* Create legacy_io and legacy_mem files for this bus */
-	pci_create_legacy_files(child);
-
 	return child;
 }
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 6e796dbc5b29..d8bffa21498a 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -65,8 +65,6 @@ void pci_remove_bus(struct pci_bus *bus)
 	list_del(&bus->node);
 	pci_bus_release_busn_res(bus);
 	up_write(&pci_bus_sem);
-	pci_remove_legacy_files(bus);
-
 	if (bus->ops->remove_bus)
 		bus->ops->remove_bus(bus);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6b630bac8c08..1859c0bf4e35 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -724,8 +724,6 @@ struct pci_bus {
 	pci_bus_flags_t bus_flags;	/* Inherited by child buses */
 	struct device		*bridge;
 	struct device		dev;
-	struct bin_attribute	*legacy_io;	/* Legacy I/O for this bus */
-	struct bin_attribute	*legacy_mem;	/* Legacy mem */
 	unsigned int		is_added:1;
 	unsigned int		unsafe_warn:1;	/* warned about RW1C config write */
 	unsigned int		flit_mode:1;	/* Link in Flit mode */
-- 
2.53.0



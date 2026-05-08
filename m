Return-Path: <linuxppc-dev+bounces-20603-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FC3CD3436
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 04:38:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBbtj1RBTz30VF;
	Fri, 08 May 2026 14:37:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778215021;
	cv=none; b=EfKB6SQa+uatTren1v9efIH21is29pD9zOenjBkKQVh+8KWBWPWNYRuHGv8BQVivCiIXyPZVK6GzuzY/6oVtRzGLiOMpBKrrPvokrFHUI8dNBfsIOgKzGxgqU8BaqY55VCd0CWwuySyV8CuJ2S+KzfQZmctchVONQhHpMTyGoSEDJYknf7LIiTaZlMXiPL7XlL9aaYCpYKiCqIJJRB+/GdBpAbxZOCJcrLUeMKoktJiG30eLWfMFH1+lKHCSNCLLGUMJs11ytGXJfQXFiYgbfVsAn8bq1v0pVo9LgPJyBzgdG9ZRLIcHs/SMGuQ5JzReHBywnjkQTdnvgdGvazom3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778215021; c=relaxed/relaxed;
	bh=lVjINIdtzGmaMzkg+iWCsTyqaDhe3Pz5n8X7dDjC+mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzlyCDEDEkVRl2/Vg2VcQ8X25AvK1yjFTi8mRDfPuS6Rhn6XjuF3xJ863mzLmCdwZb0I4t7H4trjR1Bs6rOonKehsWFwbMVZDjn05a6VPGbOZDQH7eMZx/xzOSnWT7FjVRVXHqYPjhV5jRy481Fnhq2xIi6qwzs3ke5rgDQ2TSHwpyZ2gEpAKjoqdiPk2MGpBThcbMS4qOL6v/5w7yVM+n1kS9x5sAsB+5FLdlr8O/RiJFl0LEYhw4S0rp4/EKBoguCh3LiMEVWRC0JtMhwQBiLGNPdHMndOitRLyhTmJJ4O5DV+WxhSEbCaUfe4+zSVhXt7oOeZdaneWFCAqyPyQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CFH6FW2E; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CFH6FW2E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBbth28zdz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 14:37:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 462A960252;
	Fri,  8 May 2026 04:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA792C2BCF4;
	Fri,  8 May 2026 04:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778215018;
	bh=N1LG0b801U/7kxVuvjnQVLRXwe7JDPv2XLRqgNSAEvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CFH6FW2EFKu5omjI2TsUpZzd1k98KUCGQyT5GFGBCDWRVdZGHbDkTug4c6Bf7fGXf
	 vMFZgPG4ZP3FtFWF++A4goPkVeIVk2jpPJy3PFsG2+f05LhqjKZo6b7F9K16whSLfr
	 n730+zUxLmt3M93gq7weK7IMNdjImnxqSfyOjWFBK+OhsEtZDZ3OcqGFyc8SM74ZT4
	 W6ljRXsaJkuYF5IAW0X2DFhE6sQ0KzlBpea4kaNsAJY8NsUjneU40/StjmNzZFVtWE
	 0LLg6Tk7H9irG+I1kNdJNMkhfv7IMvrjtPgZ4e5IuuwMny1dyRByhSdmMj2eOvnPd3
	 gSn/i9BddKycA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
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
Subject: [PATCH v7 19/24] PCI: Add macros for legacy I/O and memory address space sizes
Date: Fri,  8 May 2026 04:35:38 +0000
Message-ID: <20260508043543.217179-20-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508043543.217179-1-kwilczynski@kernel.org>
References: <20260508043543.217179-1-kwilczynski@kernel.org>
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

Add defines for the standard PCI legacy address space sizes,
replacing the raw literals used by the legacy sysfs attributes.

Then, replace open-coded values with the newly added macros.

No functional changes intended.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 4 ++--
 include/linux/pci.h     | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index a6451bbf69a8..7ba12b2abe48 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1019,7 +1019,7 @@ void pci_create_legacy_files(struct pci_bus *b)
 
 	sysfs_bin_attr_init(b->legacy_io);
 	b->legacy_io->attr.name = "legacy_io";
-	b->legacy_io->size = 0xffff;
+	b->legacy_io->size = PCI_LEGACY_IO_SIZE;
 	b->legacy_io->attr.mode = 0600;
 	b->legacy_io->read = pci_read_legacy_io;
 	b->legacy_io->write = pci_write_legacy_io;
@@ -1036,7 +1036,7 @@ void pci_create_legacy_files(struct pci_bus *b)
 	b->legacy_mem = b->legacy_io + 1;
 	sysfs_bin_attr_init(b->legacy_mem);
 	b->legacy_mem->attr.name = "legacy_mem";
-	b->legacy_mem->size = 1024*1024;
+	b->legacy_mem->size = PCI_LEGACY_MEM_SIZE;
 	b->legacy_mem->attr.mode = 0600;
 	b->legacy_mem->mmap = pci_mmap_legacy_mem;
 	/* See pci_create_attr() for motivation */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c56f2cf0d2ab..e37677a8dd3c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -27,6 +27,7 @@
 #include <linux/mod_devicetable.h>
 
 #include <linux/types.h>
+#include <linux/sizes.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/list.h>
@@ -1169,6 +1170,10 @@ enum {
 /* These external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
+/* PCI legacy I/O port and memory address space sizes. */
+#define PCI_LEGACY_IO_SIZE	(SZ_64K - 1)
+#define PCI_LEGACY_MEM_SIZE	SZ_1M
+
 extern unsigned int pci_flags;
 
 static inline void pci_set_flags(int flags) { pci_flags = flags; }
-- 
2.54.0



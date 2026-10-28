Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B151560A2606
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 03:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=g6BGph+W
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDsjg173vz2yrC;
	Wed, 28 Oct 2026 14:07:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793156855;
	cv=none; b=Jg+XmHLqb5tovtWpXksMv+QuzKIG1q3Bhl324RKWObR7uvw+o2nObV2HsFnFM+jICBKaDJX554R0ZIhIaJLADIG4r/wLQ9mf2gZ/wtHb1Kgen0FNjIHb/UwdYZuwmftMZoxe9I/BkYOVQZtO+dIRofENR3mGdv8G5Q5N78vn/FMhZR2ESiKx+RU9qLiOLKkMDM/JQuo7jWMwEvU07o1CPn8qAYoW9AcDicBfZdVZoDTCYvUPRg5Sdi65Go8vhPq7Kr+uCpAG4ZZMT1OZjWlJiC8q+TsHFy3KCUW6siUXnvYkoDk/QivgXtO538KR3axNpt3stHUwpd0ylWTmMmpnqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793156855; c=relaxed/relaxed;
	bh=hFLHtyAEUbucyklnv273Nmookz4wD3SmGr8qXgopcSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrJLbFTsiL5t0hIr9mqH2rTACEE5hWfD7Vws6C641MtgYRpI7Y+esd/Ew4CDj+5x43xyXrh/lH2/Sx80T8KJeE6negODMS6jYqNOihui8G2lFHb3mxCtTHjyNc7jaK2UlRwR/Uur4qi2cWoWB2y9AqfpNv3ip96PNTyLJMOdd+u8XxP1l3W7fLHqi2VVmzLsVvpWkSm4iIMlrka4JCiBcD/yhfdrwS2tdsnQ87MZXIm3z+EDQnVd5fFx03upiItuLIcsEEebs015C68SBy/aWSLhSw/OO1Dmf1W+0d6oBjq3P2fABhIbxXUHR9FFip9U0w0Tttq/TwbkBseyIl0CUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=g6BGph+W; dkim-atps=neutral; spf=pass (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=g6BGph+W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDsjZ1vBFz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 14:07:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hF
	LHtyAEUbucyklnv273Nmookz4wD3SmGr8qXgopcSE=; b=g6BGph+Whp9fOSqPrP
	uV/PKq/RbpyX101MLm4jpxdDC3R5aRquWyjZvCUmy7eM3i7B8v/w+RYzHxn3c5OU
	kAuBV45nPuzwJlYwq4TZFSEQhxg5S25F/dUjffZpbM3wpC3j+BNePDaw4d0nJt4V
	HRihUeKzIwntnvAvOqFGnCGe4=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnD07QZuFqZiY4DA--.60713S3;
	Wed, 28 Oct 2026 11:06:59 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 01/16] PCI: dwc: Add pcie_cap field and caching helper
Date: Wed, 28 Oct 2026 11:06:37 +0800
Message-ID: <20261028030652.2917756-2-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028030652.2917756-1-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnD07QZuFqZiY4DA--.60713S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4xCr4UZFW3KFW7Zw17GFg_yoWrZr4rp3
	9xJFWSyFs8Jr4SvFsxA3W09F13Aas3AFW7Ga93Gw1fZry3ur1UKFW0yFWjyF17Gr4Igr12
	gr43ta48GFs8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zErgAOUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BPghGrhZtPOwgAA3p
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DWC PCIe core and its platform drivers repeatedly call
dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
PCI Express Capability structure. Besides being verbose, that performs a
DBI read every time, including in paths that run repeatedly such as link
up polling, suspend/resume and interrupt handlers.

Add a pcie_cap field to struct dw_pcie and a helper
dw_pcie_get_pcie_cap() that performs the lookup on first use and caches
the result for the subsequent calls.

The lookup is deliberately done lazily, at the first place that needs the
offset, instead of at a fixed point during controller initialization.
This guarantees that the DBI read happens exactly when the open coded
dw_pcie_find_capability() call it replaces used to happen, so the series
does not introduce DBI accesses at points where the controller might not
be accessible. This matters for endpoint controllers such as qcom-ep and
tegra194, where DBI is only accessible after PERST# is deasserted, and it
also means platform drivers do not have to call the helper from a
specific callback at the right time.

Reading DBI while the controller is inaccessible (clocks or power gated)
is platform specific: some integrations hang, some return zero and some
return garbage. dw_pcie_find_capability() already rejects offsets below
the standard header, unaligned offsets and entries whose capability ID
does not match, but a transient bogus read could still look valid. To
prevent such a value from being cached for the rest of the lifetime of
the controller, the offset is only cached after the capability ID has
been read back at that offset. If it is not confirmed, the offset is
still returned to the caller for this access but not cached, so the next
call performs the lookup again, just like when the capability is not
found.

The cached value is accessed with READ_ONCE()/WRITE_ONCE(), because the
first lookup may be triggered from different contexts, for example the
qcom-ep global IRQ and PERST# IRQ handlers. A concurrent lookup stores
the same value, so this race is benign.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 6d788aa000117..dede6b3966585 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -594,6 +594,8 @@ struct dw_pcie {
 	 * use_parent_dt_ranges to true to avoid this warning.
 	 */
 	bool			use_parent_dt_ranges;
+
+	u8			pcie_cap;	/* Offset of PCI_CAP_ID_EXP */
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -832,6 +834,42 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
 	dw_pcie_writel_dbi(pci, reg, val);
 }
 
+/**
+ * dw_pcie_get_pcie_cap() - Return the PCIe Capability offset
+ * @pci: DWC instance
+ *
+ * The offset of the PCI Express Capability structure is read from the
+ * DBI configuration space on the first call and cached in
+ * @pci->pcie_cap for the subsequent ones.
+ *
+ * The lookup is done lazily at the first place that actually needs the
+ * offset, so the DBI read happens exactly when it used to happen before
+ * caching was introduced, i.e. never before the controller's clocks,
+ * resets and power are enabled.
+ *
+ * A DBI read issued while the controller is not accessible returns
+ * platform specific data, and a transient bogus value must not stick in
+ * the cache.  The offset is therefore only cached once the capability
+ * ID has been read back at that offset.  Both the not-found and the
+ * not-confirmed cases leave the cache empty, so the lookup is simply
+ * repeated on the next call.
+ *
+ * Return: the offset of the PCIe Capability, or 0 if it could not be
+ * found or has not been confirmed yet.
+ */
+static inline u8 dw_pcie_get_pcie_cap(struct dw_pcie *pci)
+{
+	u8 cap = READ_ONCE(pci->pcie_cap);
+
+	if (!cap) {
+		cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+		if (cap && dw_pcie_readb_dbi(pci, cap) == PCI_CAP_ID_EXP)
+			WRITE_ONCE(pci->pcie_cap, cap);
+	}
+
+	return cap;
+}
+
 static inline int dw_pcie_start_link(struct dw_pcie *pci)
 {
 	if (pci->ops && pci->ops->start_link)
-- 
2.43.0



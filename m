Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D6F606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TObnbVaF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMg56Pbmz2y7p;
	Tue, 17 Nov 2026 22:18:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794914321;
	cv=none; b=W+nv+LPtoGdpGcf8/xHlNW60/spVrtSxxNwrhvBB+VzZm9gPxaJ66oUN1rTiF/Dx+0iXxe2Hwk+fYD07R1anIr/7TvIWgECe0LpFZyQAYBBrpqPcAuYUDAA+Mf1I62CheDHukGb3iVrbFDnI9xIpXTqOnMae/0FB76aQ45waTMFBwVMzzMXEVvIvLD+rFuRZ+cqhzHWWJOhw2NRP9E585/xCo+rHiaQg1Ak2C/nVi1En2eeOw+uY+ZJYpjtxQhhpJ0hPLO050kNZXVyAkE4+vny/2hHik+AeJjKGuCr53QOaXBFhhXTqKNi/YjcqtuFfWIV3o04JIY1AcivTRZ4zlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794914321; c=relaxed/relaxed;
	bh=MXEFABk4Xv2GbPN1b8uTXS1gNaUbI7j11V7WDEniAMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jp9TDEJKeT9KrgCLsnAohUIYBe/rDPnk0BvbfsBuh5PQ5ylnmC7EEKd7NzCYyqvDBrR46hB3AooJMwnGIKXFvNTQCZodAa0Arvm2LpHu98U/PRMiZ/XYQ3LAcjGq6dsX8Fcw1dwTRoQD1qB7Vs+AvlvqR7Up5XukByqFhplTWOg1rFzIvwKjKpBi7kwvkV80Kguu5Pl9L85YEYLZy3kAM6iCeB+ETzwR7PQ2JuaHXiH/H563j5EyN/v0Ms+HiOb3woBPE6fqMtwQV7Mf4EWkGuNe0WUpU/DtGukKt3/zu/1qdmbIPHJrI7zIJNkWM/gSkl/1IqGoqy0uyvZahhis/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TObnbVaF; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TObnbVaF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMg50QYFz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:18:40 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5E101688;
	Tue, 17 Nov 2026 03:18:06 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 265A73F763;
	Tue, 17 Nov 2026 03:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914289; bh=yZVJhKbCQ+zekgJDP6u8e334wVc5yCWM6Mm1+2PqYS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TObnbVaF6xpP+HLg6TEoqPA+Dl8IoTW5CpnMywtjGb5xKgtWWe1CrMgEKBtJG8yd9
	 /hkB4k4x/0IHRL4kMCB2ylfOkb4BHBs6q94+rDzUMCEWiF/ftRq9V9YsA9OEeiBqzK
	 zbXfzD8kcFZqpHVyZ8TzJwgZ+zepiLO16by4KoLY=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Radu Rendec <radu@rendec.net>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 08/19] ACPI: extlog: Align extlog_print_pcie() and ghes_handle_aer()
Date: Tue, 17 Nov 2026 12:10:18 +0100
Message-ID: <20261117111444.4185512-9-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117111444.4185512-1-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In order to unify extlog_print_pcie() with ghes_handle_aer() and
prepare to remove one of the functions, align the behaviour of the
2 functions. Thus:
- Submit the decoded snapshot through aer_recover_queue() instead of
  just printing the error.
- Override the mapped AER severity with AER_FATAL when CPER_SEC_RESET
  is set so the AER worker selects the frozen-channel recovery path
  when it finds an unmasked uncorrectable error.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/acpi_extlog.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 125f7931b98bc..e09ea571c32f5 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -8,9 +8,11 @@
 
 #include <linux/module.h>
 #include <linux/acpi.h>
+#include <linux/aer.h>
 #include <linux/cper.h>
 #include <linux/ratelimit.h>
 #include <linux/edac.h>
+#include <linux/pci.h>
 #include <linux/ras.h>
 #include <cxl/event.h>
 #include <acpi/ghes.h>
@@ -138,7 +140,6 @@ static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
 	struct aer_capability_regs aer_regs = {};
-	struct pci_dev *pdev;
 	unsigned int devfn;
 	unsigned int bus;
 	int aer_severity;
@@ -156,6 +157,9 @@ static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
 		return;
 
 	aer_severity = cper_severity_to_aer(gdata->error_severity);
+	/* A component reset by firmware needs reinitialization. */
+	if (gdata->flags & CPER_SEC_RESET)
+		aer_severity = AER_FATAL;
 
 	aer_cap_regs_unpack(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
 
@@ -163,12 +167,7 @@ static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
 	bus = pcie_err->device_id.bus;
 	devfn = PCI_DEVFN(pcie_err->device_id.device,
 			  pcie_err->device_id.function);
-	pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
-	if (!pdev)
-		return;
-
-	pci_print_aer(pdev, aer_severity, &aer_regs);
-	pci_dev_put(pdev);
+	aer_recover_queue(domain, bus, devfn, aer_severity, &aer_regs);
 #endif
 }
 
-- 
2.43.0



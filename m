Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A660606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sQQSCwa5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMlB6x7sz2yR1;
	Tue, 17 Nov 2026 22:22:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794914534;
	cv=none; b=X+PYgvU9uaVA9eFWPe1r5sG0eB0UrCMNB3RYcVJG+BSbHjkp/EeGsoTYHypSUQLQcrijVBuKzUmZ50MhyVnsTqnWGEfvJPHaztb9UA6q1EzOb/lpWw213kjF/IP4O2kYlWC2lPeUHZx7S3CXxLSn8XbusXfPUGobFg8pvNCqk8pHfRQIZ74Lh08yKOoYW1Ifxgi0mN1XMdUSeYiGgEZ52+ry6P8MqzdcXttvGvImvdYDfjH+hS6qKBcpgKW/4CfUe6SFlF5yWnAf1u3vIm5VYjodL/yx3ViBW+lLwMRXX8g+yNXSJRuLqBe3bJRouNdMVxnQnX19GQALaLyqrSs8gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794914534; c=relaxed/relaxed;
	bh=x7FKUaCvfIYG+OL9lzY+LhaajL+qrQZmia0tnFbeArk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EaYcr2rbrIaSWQdrKlbpcuxhievX8Z5PIB5PeUPTRsSd10gDmjtqzUfNgWywaGI5hCYdAF0AgiElaxQHbtG8DgzPfdjJCQwRuH+Hd4OUSLxCbp1Dvn3x71tK1GBirwDbSWX3obsnV0oivQQ43DRaMkFs+k+WqxOV5JmVZ8PcEbeHKRX15In3ziFMxWnGvC/ndSARX/nP5JKTHM9ZygpUYqrfZbfqNa4tdkySUyaK7eTCftbAh++6/RZ+TjcY6Qxn+TUI/icAGdv4pIRUAlAa8UmEwQNjT2IZ7DSKHmNP7tNn/g0hU0/enstSLrB/VS3bosUhD+icpzL8vH430MdIyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sQQSCwa5; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sQQSCwa5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMlB39Mvz2yQn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:22:14 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EA331CDD;
	Tue, 17 Nov 2026 03:21:40 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D26F23F763;
	Tue, 17 Nov 2026 03:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914503; bh=fqjc/m+GsrUpdUZSOPvYguj57JvvOU+w3OhEK+hZgDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQQSCwa5WOTLaq+RJBycgz64wJdPreJtjbw51rDWGDD6fmeiEwSwMPadHDo42x6CD
	 w0B6L9CpCqAVfP8J1GCJWQmaQr2RvZNsJtfGCigaf9sVen6xN1juZACoqSkOiiD1LX
	 jn94lVUpKMqQdf/y9VmIULmx4T8eGFAvw0+NGqfQ=
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
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Radu Rendec <radu@rendec.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 19/19] PCI/ERR: Avoid NULL bridge pointer
Date: Tue, 17 Nov 2026 12:10:29 +0100
Message-ID: <20261117111444.4185512-20-pierre.gondois@arm.com>
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

Return PCI_ERS_RESULT_DISCONNECT when no upstream bridge is available,
avoiding a NULL pointer dereference in pci_walk_bridge().

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/pci/pcie/err.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 1a7fc71c79d8a..402dc74c7fe49 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -233,6 +233,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	else
 		bridge = pci_upstream_bridge(dev);
 
+	if (!bridge) {
+		pci_warn(dev, "no upstream bridge\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
 	pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL);
 
 	pci_dbg(bridge, "broadcast error_detected message\n");
-- 
2.43.0



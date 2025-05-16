Return-Path: <linuxppc-dev+bounces-8612-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50F0C54754
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 May 2025 16:56:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZzYBK5q0Jz2xHX;
	Sat, 17 May 2025 02:56:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747414569;
	cv=none; b=VAxx2dzf7alRNx+MI/0p1foIsQqThSZn9mqbM5VMEN6rybhGv3geL7a0DghDVtqxk4H/L6SBfienqsokqUhFwAGQGHRwJWlHnd/tkfgdyWFJKH+CveJeTSw42w68LKVokevHKuryuLZcg6SbH7UeP0VncDN+k0DHo+qGHIZbDthe55wr7GD9NbshMQ8xeEEG07svXmhJEybdN0HmITBty0LyHlHeVP5TKhVKKzUrkR3f0vbY/9K7ZiDcADVRMvm7l9HVEcXKvmUcsd7JDg9cZB5FblTkOPC4/nEUPu07Y7SAAR/CU7Ja0xt1Hp3sKwaWu2WWqTj/L7T+AmVePgSoAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747414569; c=relaxed/relaxed;
	bh=grA5e9IizUHs6xNUrHdJHCEjg25RlCLjAgPs5bVE1s8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W92ihVQq8Rjrv88v5Ywr+oZrxGCe8FntShlVqdiQzx/c5eHp28LRNmYTXMx2DrjgrsTJb0eLWPPDSsQMglRxR+O3/NtRv7HRHiS1LGf0WMFqzl/MSwVOmB2tTBTwp/zmReAPURkxLTC+JiVLonkKaBy/NMPB6q8Ce+3GgSol2NC/i/SiR1xaXWfLK4+XCYhLCGPA0FVRS3JmXNMVMVbydEYEb1xL4ac0rWEcT9X4v339swxmHghmMS9RwFRp4yTcLhNY1oQt7TbqN21Li9FPmne0dE9I7Hs86qKNZjATUOBxCAr3ozkRgg74sMDouh9HmvfEkyrD3oIPnUirV3eWbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=W4GHeuHb; dkim-atps=neutral; spf=pass (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=W4GHeuHb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZzYBJ2gfZz306d
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 May 2025 02:56:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gr
	A5e9IizUHs6xNUrHdJHCEjg25RlCLjAgPs5bVE1s8=; b=W4GHeuHb8bTBki/Nz8
	Za443f8O0mNQTaO3Firhsddwn9orQGcVp5KhIHrcXZWCw758smz80EjA3ZTx6Kws
	lFyU3z+r4x+jRgjH+kC7ZPzNx+Ncg+ynjO+WQFDtdckb73ad/1JJDHrneudoFgtq
	2itaqh69516l8ALGVDw9oWDKk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wB3lOX6bSdoVElgBw--.64634S4;
	Sat, 17 May 2025 00:55:24 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	tglx@linutronix.de,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	mahesh@linux.ibm.com
Cc: oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH 2/4] PCI/AER: Introduce aer_panic kernel command-line option
Date: Sat, 17 May 2025 00:55:16 +0800
Message-Id: <20250516165518.125495-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250516165518.125495-1-18255117159@163.com>
References: <20250516165518.125495-1-18255117159@163.com>
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
X-CM-TRANSID:_____wB3lOX6bSdoVElgBw--.64634S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr18XFyrtr4fZF1DAFWDurg_yoW5Jr17pF
	W5Aa48Ar4rGF1rXa1kZ3W8ua4rXwnIq34fCayfG393uF13Aa4fJwn3tFy7ZF1xJrWkur1a
	yF4Yyr17ur45JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn3ktUUUUU=
X-Originating-IP: [124.79.128.52]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwFPo2gnaWRvgQAAsa

From: Hans Zhang <hans.zhang@cixtech.com>

Add a new "aer_panic" kernel parameter to force panic on unrecoverable
PCIe errors. This prepares for handling fatal AER errors in systems where
bus hangs require immediate reboot.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/pci.c      | 2 ++
 drivers/pci/pci.h      | 2 ++
 drivers/pci/pcie/aer.c | 6 ++++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e77d5b53c0ce..663454135224 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6821,6 +6821,8 @@ static int __init pci_setup(char *str)
 				pcie_ats_disabled = true;
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
+			} else if (!strcmp(str, "aer_panic")) {
+				pci_aer_panic();
 			} else if (!strcmp(str, "earlydump")) {
 				pci_early_dump = true;
 			} else if (!strncmp(str, "realloc=", 8)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99cd4b62..8ddfc1677eeb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -958,6 +958,7 @@ static inline void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge
 
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
+void pci_aer_panic(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
@@ -968,6 +969,7 @@ void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
+static inline void pci_aer_panic(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ade98c5a19b9..fa51fb8a5fe7 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -112,6 +112,7 @@ struct aer_stats {
 					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
 
 static bool pcie_aer_disable;
+static bool pcie_aer_panic;
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
 
 void pci_no_aer(void)
@@ -119,6 +120,11 @@ void pci_no_aer(void)
 	pcie_aer_disable = true;
 }
 
+void pci_aer_panic(void)
+{
+	pcie_aer_panic = true;
+}
+
 bool pci_aer_available(void)
 {
 	return !pcie_aer_disable && pci_msi_enabled();
-- 
2.25.1



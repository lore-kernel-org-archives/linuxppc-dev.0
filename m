Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055F0606A89C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 03:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=g4pe8Niu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ5Gz4RDXz2yKn;
	Thu, 12 Nov 2026 14:19:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794453595;
	cv=none; b=Oe0D4rMdjlxeAIXfroTXeEmtev16sAOJwHBDmcuVfBIWiy9LtXf749WPUNsYivBxK9Ov1gcGoBrlsnHrHP+/oUHfOXAyydhNF9JiZ6xhYDnV53cyDao2FD2n/+I4p63BliljHUKiiFbNoEfLmMc1HKL5o+XWq0z70+LmxugbciAlGcvtG5je0U8fmsuBsXREIHdeH4d3IRSprt/xh2rI9fcQMgyQoPaRKIwe/fyzi3QmIaMFlI1e9U8RU8tKYkdioI4iFu42cSVCgQMKs0NCa+CYvcnXCk2CJ5szAqTMYbbYMO3Nu27yXHOXugdDOitny3IJhMi3cw1lnUv/qS2rIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794453595; c=relaxed/relaxed;
	bh=hmpzgPslhxYA71ELCoCW5J7VR4kuagJg7YlC5PEGMN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1N1/BnQX7k4GNfMfTFoyYSroryLqfkhvECPlq0dZccTkzMialp0Dkp/ExjSD6oxOGdOK3QbQiOTxPyDvtb4TbDVraQRDN3+p87digDSe79V3bwo5OCQsQrYwPHJ5k+PqldLmtYb3nwvFZVBv6lN0MCSWfbv/tdw839zMmT9sMR7vg1oq7rx9d35QVOrDDZpS/hkdyzbxf9UtTxdX8PZ58EypR7NTohPY3H9HKVYSVgoeH2wJjOkS7lLF06ejVkVlvgJJXwNG7t5Ssvq2xsk1DxAwCPIuo9xWWXSweJb7ej5/ITzXrrvN0Ykn1rrLIVuIQuENtTYgDdhCDdEDgsjTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=g4pe8Niu; dkim-atps=neutral; spf=pass (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=g4pe8Niu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ5Gv6tr5z2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 14:19:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hm
	pzgPslhxYA71ELCoCW5J7VR4kuagJg7YlC5PEGMN8=; b=g4pe8NiukN4etvMb8W
	f6lwOQWICimXSmmjmtzLlWyES1PIJI0uYfYidxX2DYgDG+AgwHBzPXX20SvPQOap
	BqKpvxM0qi1KdQJ6RxlthF8BQrD7urLglXcqyMyfkwHCOemlO6pxQGH314FKVFQL
	WZuv3/GCObCdXDxpnUoNZYMt8=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXD8o6MPVqh72fHQ--.23678S3;
	Thu, 12 Nov 2026 11:19:25 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: mahesh@linux.ibm.com,
	bhelgaas@google.com
Cc: oohall@gmail.com,
	mani@kernel.org,
	lukas@wunner.de,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 1/2] PCI: Introduce pci_clear/set_config_dword()
Date: Thu, 12 Nov 2026 11:19:20 +0800
Message-ID: <20261112031921.1255661-2-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112031921.1255661-1-18255117159@163.com>
References: <20261112031921.1255661-1-18255117159@163.com>
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
X-CM-TRANSID:_____wDXD8o6MPVqh72fHQ--.23678S3
X-Coremail-Antispam: 1Uf129KBjvJXoWrKw4rWrWxKrWxAFykCry7Awb_yoW8Jr15pF
	Z8CFyfGFWxGFnI9a4DXay8Cw4UWrWkWFW0grW3K3s0qa12ya4vvF909r17Jw13GrWvvr45
	A393KFZY9F4qya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR0tC7UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x0z1mr1MD0jJAAA3G
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add helper functions to clear or set bits in PCI config space.
These helpers reduce code duplication and improve readability for config
space modifications by encapsulating common read-modify-write patterns.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 include/linux/pci.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index aa3765a20a96..be277d745d5d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1420,6 +1420,18 @@ static inline int pcie_capability_clear_dword(struct pci_dev *dev, int pos,
 	return pcie_capability_clear_and_set_dword(dev, pos, clear, 0);
 }
 
+static inline void pci_clear_config_dword(const struct pci_dev *dev, int pos,
+					  u32 clear)
+{
+	pci_clear_and_set_config_dword(dev, pos, clear, 0);
+}
+
+static inline void pci_set_config_dword(const struct pci_dev *dev, int pos,
+					u32 set)
+{
+	pci_clear_and_set_config_dword(dev, pos, 0, set);
+}
+
 /* User-space driven config access */
 int pci_user_read_config_byte(struct pci_dev *dev, int where, u8 *val);
 int pci_user_read_config_word(struct pci_dev *dev, int where, u16 *val);
-- 
2.43.0



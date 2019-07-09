Return-Path: <SRS0=CkO+=VG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B9BC73C56
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jul 2019 19:54:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BD12166E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jul 2019 19:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="XT5g18WG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BD12166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45jtML0ZYbzDqYX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 05:54:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=stackframe.org
 (client-ip=2001:470:70c5:1111::170; helo=smtp.duncanthrax.net;
 envelope-from=svens@stackframe.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=stackframe.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=duncanthrax.net header.i=@duncanthrax.net
 header.b="XT5g18WG"; dkim-atps=neutral
Received: from smtp.duncanthrax.net (smtp.duncanthrax.net
 [IPv6:2001:470:70c5:1111::170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45jt6T0Y9XzDq7k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2019 05:43:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=41hNx7RJF3M/NVaosyif8t4ddhlZec6gxVrDuKDyR9E=; b=XT5g18WG+mgq6D6aCx7eQym8WO
 MrvNVM0RXOdUwadRYtn1dAhgs2OMKcM4i1VdWxbaXXYR8SltDuoYpiPgeRh8bBk2gcdmaDmGzft3j
 7axUnMMhwuA1CDtLAlj3jv25HOE2v/ZgF3TXY+ACZVmlaytlqqOvsDlu1ZhpMmCLXMEc=;
Received: from [134.3.44.134] (helo=t470p.stackframe.org)
 by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.86_2) (envelope-from <svens@stackframe.org>)
 id 1hkw1Y-0007pP-PC; Tue, 09 Jul 2019 21:43:36 +0200
From: Sven Schnelle <svens@stackframe.org>
To: kexec@lists.infradead.org
Subject: [PATCH v2 2/7] kexec_elf: change order of elf_*_to_cpu() functions
Date: Tue,  9 Jul 2019 21:43:23 +0200
Message-Id: <20190709194328.16991-3-svens@stackframe.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709194328.16991-1-svens@stackframe.org>
References: <20190709194328.16991-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Sven Schnelle <svens@stackframe.org>, deller@gmx.de,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Change the order to have a 64/32/16 order, no functional change.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 kernel/kexec_elf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
index 6e9f52171ede..76e7df64d715 100644
--- a/kernel/kexec_elf.c
+++ b/kernel/kexec_elf.c
@@ -31,22 +31,22 @@ static uint64_t elf64_to_cpu(const struct elfhdr *ehdr, uint64_t value)
 	return value;
 }
 
-static uint16_t elf16_to_cpu(const struct elfhdr *ehdr, uint16_t value)
+static uint32_t elf32_to_cpu(const struct elfhdr *ehdr, uint32_t value)
 {
 	if (ehdr->e_ident[EI_DATA] == ELFDATA2LSB)
-		value = le16_to_cpu(value);
+		value = le32_to_cpu(value);
 	else if (ehdr->e_ident[EI_DATA] == ELFDATA2MSB)
-		value = be16_to_cpu(value);
+		value = be32_to_cpu(value);
 
 	return value;
 }
 
-static uint32_t elf32_to_cpu(const struct elfhdr *ehdr, uint32_t value)
+static uint16_t elf16_to_cpu(const struct elfhdr *ehdr, uint16_t value)
 {
 	if (ehdr->e_ident[EI_DATA] == ELFDATA2LSB)
-		value = le32_to_cpu(value);
+		value = le16_to_cpu(value);
 	else if (ehdr->e_ident[EI_DATA] == ELFDATA2MSB)
-		value = be32_to_cpu(value);
+		value = be16_to_cpu(value);
 
 	return value;
 }
-- 
2.20.1


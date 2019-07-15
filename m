Return-Path: <SRS0=O2mS=VM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF41EC7618F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 08:36:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7BA20838
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 08:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="W48OtkzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7BA20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nH1b2RLwzDqVb
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 18:36:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=stackframe.org
 (client-ip=2001:470:70c5:1111::170; helo=smtp.duncanthrax.net;
 envelope-from=svens@stackframe.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=stackframe.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=duncanthrax.net header.i=@duncanthrax.net
 header.b="W48OtkzS"; dkim-atps=neutral
Received: from smtp.duncanthrax.net (smtp.duncanthrax.net
 [IPv6:2001:470:70c5:1111::170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nGqY6ltQzDqVZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2019 18:27:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=AjsZZVUemd5fzc9mR3GdHnYFPZ+tVaHoG5D8W+sMB5w=; b=W48OtkzSbCa2xuVp5NC3NM5RNw
 fWNatH1Y9QTmMCoKvFeI2f+nvDgx/jkwP0KRQqN0SdEc7Po6vRGic70GrsQPl3BroKQGGkGnyjl0J
 SxRkT16yAMr0le9/cu77XScJGBvrFvdWksk4uB/MS+T2grmVJkzAsHNnkaGOv5FxYTMw=;
Received: from frobwit.duncanthrax.net ([89.31.1.178] helo=t470p.intern)
 by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.86_2) (envelope-from <svens@stackframe.org>)
 id 1hmwKa-0005LV-0Y; Mon, 15 Jul 2019 10:27:32 +0200
From: Sven Schnelle <svens@stackframe.org>
To: kexec@lists.infradead.org
Subject: [PATCH v4 5/7] kexec_elf: remove Elf_Rel macro
Date: Mon, 15 Jul 2019 10:27:00 +0200
Message-Id: <20190715082702.27308-6-svens@stackframe.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715082702.27308-1-svens@stackframe.org>
References: <20190715082702.27308-1-svens@stackframe.org>
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

It wasn't used anywhere, so lets drop it.

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 kernel/kexec_elf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
index 70d31b8feeae..e346659af324 100644
--- a/kernel/kexec_elf.c
+++ b/kernel/kexec_elf.c
@@ -10,10 +10,6 @@
 
 #define elf_addr_to_cpu	elf64_to_cpu
 
-#ifndef Elf_Rel
-#define Elf_Rel		Elf64_Rel
-#endif /* Elf_Rel */
-
 static inline bool elf_is_elf_file(const struct elfhdr *ehdr)
 {
 	return memcmp(ehdr->e_ident, ELFMAG, SELFMAG) == 0;
-- 
2.20.1


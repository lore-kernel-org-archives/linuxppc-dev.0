Return-Path: <SRS0=Va0a=WT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED2CC3A5A2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Aug 2019 20:41:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3D82133F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Aug 2019 20:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="AJfhPLDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3D82133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46FYG41DXbzDsTN
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Aug 2019 06:41:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=stackframe.org
 (client-ip=2001:470:70c5:1111::170; helo=smtp.duncanthrax.net;
 envelope-from=svens@stackframe.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=stackframe.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=duncanthrax.net header.i=@duncanthrax.net
 header.b="AJfhPLDd"; dkim-atps=neutral
Received: from smtp.duncanthrax.net (smtp.duncanthrax.net
 [IPv6:2001:470:70c5:1111::170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46FY920xQqzDrqg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2019 06:36:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=rFyKtEp5BI1cjjxOI9RlUdT30At9mbHzmfXbqPz5lKA=; b=AJfhPLDdGMeKSUJIJVEHNSIj6P
 fmd8IzB/KY9KYPux9SJJ/2CQcIh4TKd3+SRq8zF8aY696cRSmm6gVU7PNNU1N8kHR034dlNanBpav
 jodCYkvZTZmeoQW9Xac6k73mtgXJmj8XVDlEfyAYDswTaoxxSSdnLYYAO0/K9zzeBSF8=;
Received: from [134.3.44.134] (helo=x280.stackframe.org)
 by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.86_2) (envelope-from <svens@stackframe.org>)
 id 1i1FZ3-00071n-9F; Fri, 23 Aug 2019 21:49:37 +0200
From: Sven Schnelle <svens@stackframe.org>
To: kexec@lists.infradead.org
Subject: [PATCH v5 6/7] kexec_elf: remove unused variable in kexec_elf_load()
Date: Fri, 23 Aug 2019 21:49:18 +0200
Message-Id: <20190823194919.30916-7-svens@stackframe.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190823194919.30916-1-svens@stackframe.org>
References: <20190823194919.30916-1-svens@stackframe.org>
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
Cc: Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>,
 linuxppc-dev@lists.ozlabs.org, Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

base was never assigned, so we can remove it.

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 kernel/kexec_elf.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
index 6c806ce96ac1..85f2bd177d6e 100644
--- a/kernel/kexec_elf.c
+++ b/kernel/kexec_elf.c
@@ -363,7 +363,7 @@ int kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
 			 struct kexec_buf *kbuf,
 			 unsigned long *lowest_load_addr)
 {
-	unsigned long base = 0, lowest_addr = UINT_MAX;
+	unsigned long lowest_addr = UINT_MAX;
 	int ret;
 	size_t i;
 
@@ -385,7 +385,7 @@ int kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
 		kbuf->bufsz = size;
 		kbuf->memsz = phdr->p_memsz;
 		kbuf->buf_align = phdr->p_align;
-		kbuf->buf_min = phdr->p_paddr + base;
+		kbuf->buf_min = phdr->p_paddr;
 		kbuf->mem = KEXEC_BUF_MEM_UNKNOWN;
 		ret = kexec_add_buffer(kbuf);
 		if (ret)
@@ -396,9 +396,6 @@ int kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
 			lowest_addr = load_addr;
 	}
 
-	/* Update entry point to reflect new load address. */
-	ehdr->e_entry += base;
-
 	*lowest_load_addr = lowest_addr;
 	ret = 0;
  out:
-- 
2.23.0.rc1


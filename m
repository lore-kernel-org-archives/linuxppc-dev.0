Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC93C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 01:05:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559AB20850
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 01:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vdph9WmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559AB20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4383Z21qRBzDqRc
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 12:05:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vdph9WmZ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vdph9WmZ"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4383LG68KCzDqgF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 11:55:02 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id s198so6540920pgs.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 16:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c4gBFcajzgpVz3mIuYigk+ePJNILjxunDs0Xqtmk9l8=;
 b=Vdph9WmZg2bvuGyNsk8w+z0KJCLgC0KxeBFMN939kAjuoLqIXSFh8sAHnQLimLiVw4
 gbWDp/HuSwKbBjpgqb6OjpcRxzTKBaX0Bj4Rg+sjrluP41QzhjAPjJX1Ysf7o2gCV4rT
 wXhAIsQptKJockt1QvViw63UAYC+IrtF6Se7cT2M8tfgBV3S0rFcuc6VCdld6GYJ0Qh3
 MWdsTdclJGl/r/SjVIC69y3jao5ZwkkeueT1tneqsig+S8FybDUhg33Bj54yKaDIPuBP
 YDmga5sSySXvXAVF9323ZDlzpu4Ql9IVzrpSezHGHJ7jAxaNl6u15a6zxDZNsVFc4M9W
 1vLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=c4gBFcajzgpVz3mIuYigk+ePJNILjxunDs0Xqtmk9l8=;
 b=Syg8cQb2QptLc3XZEIUTkyxh0CMSJsbtxrbpioWxVpX7PPOhmIWSzTSBwzV8nT6g7m
 j/67xSspsqx0i9/2grIUCrcyftKRIAJcdrsJ+zCwIECsJvy7mE+1jK3ee946dAP4e7X4
 XP0nTApYvaYYatSLzlgSjIPczk/pBnhE8W38mWzq/WeKcXCSZeTbIp0WrQiAkhJvU0yY
 d6HRGNaYWU+FM8T+OWck4zZ96Crf0j2BuE4OZhmXDGp/cH+hGn1hix2w3yM88kX6ZjaU
 0sTjFByOTdlVyyMcEEmCF1c9SzXQw598Q/Jrh98qgJWCNC806yLX376V+nsgJBswQGfV
 QiZQ==
X-Gm-Message-State: AA+aEWZc1PUMs8ze5uu0+73zMQqYhBufJK7ZUXhsfVvlm8fiCiLnCHhH
 B+CcZJDBFbxFP6VL9wXmSMFuEtHE
X-Google-Smtp-Source: AFSGD/VmMb5IwfBQ7a5NDJmarjE7UKb1zAEfQtxVc2pCADCv2HeY0ek9oPurt564ebewvNaRBNCkAQ==
X-Received: by 2002:a65:530c:: with SMTP id m12mr14621947pgq.224.1543884900769; 
 Mon, 03 Dec 2018 16:55:00 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id y1sm20413436pfe.9.2018.12.03.16.54.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 16:55:00 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 04 Dec 2018 11:24:54 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/3] powerpc: Discard .branch_lt section
Date: Tue,  4 Dec 2018 11:24:29 +1030
Message-Id: <20181204005429.32681-4-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204005429.32681-1-joel@jms.id.au>
References: <20181204005429.32681-1-joel@jms.id.au>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Alan Modra <amodra@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When building a 32 bit powerpc kernel with Binutils 2.31.1 this warning
is emitted:

 powerpc-linux-gnu-ld: warning: orphan section `.branch_lt' from
 `arch/powerpc/kernel/head_44x.o' being placed in section `.branch_lt'

As of binutils commit 2d7ad24e8726 ("Support PLT16 relocs against local
symbols")[1], 32 bit targets can produce .branch_lt sections in their
output.

These sections should be empty for the kernel build so discard them for
both PPC64 and PPC32.

[1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commitdiff;h=2d7ad24e8726ba4c45c9e67be08223a146a837ce
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: Discard instead of keep. Alan said "[discarding] can be a recipe for
finding linker bugs", so lets go with that.
---
 arch/powerpc/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 2c93a420f456..af0f81df8bb9 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -316,7 +316,6 @@ SECTIONS
 		DATA_DATA
 		*(.data.rel*)
 		*(.toc1)
-		*(.branch_lt)
 	}
 
 	.opd : AT(ADDR(.opd) - LOAD_OFFSET) {
@@ -388,6 +387,7 @@ SECTIONS
 		*(.hash .gnu.hash)
 		*(.interp)
 		*(.dynstr)
+		*(.branch_lt)
 #ifndef CONFIG_PPC32
 		*(.dynsym)
 #endif
-- 
2.19.1


Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20523C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 22:34:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903642082F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 22:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBsfjxfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903642082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DHty4kRdzDqlp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 09:34:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pBsfjxfS";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="pBsfjxfS"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DHmk3XpBzDqjh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 09:29:10 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id n2so5641939pgm.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 14:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q2Q4lQ2oRkM57Itjn/ZzYPUa3OWfgHNNiZhMrK/8MlQ=;
 b=pBsfjxfSKTKZHDBLV2einrEjrqKdmBYno2vub8VSldjNZijVyp0PBGxJBImi4Jvod+
 rgBrMYcIe/njKRbayZuesawNLAxmGBrgTMCfC4fy1Gdos8g8Ax3qwHk+hUEsLLzFBV1r
 16J2oULAjcpibxYzL+LiV9l1zpKj5WOG52AtBANiNYzGIQPJX7jcocqTMG0mFYahSF++
 RHTQ3XJYSmkOAcRdYXbXFvsA1TDjLXy1XcZXs2kKqwJgpd+0rZ997f6w+qGAplGk0UiN
 gOnx/aoj8BBGu9UVvIPIASxl6gebDWULMV/kqgakO7TNHZiI/HjUIuL/xGHXJtwpBI0i
 F2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Q2Q4lQ2oRkM57Itjn/ZzYPUa3OWfgHNNiZhMrK/8MlQ=;
 b=hHMFVGY/xUe0RoXo34MVMDX9ousl9TtIGRgQ2eaihyYPpIvnW+PGuDgdhsQDagP8K/
 Wq0zgxM89cizxmauDB1DuchThsTpCHCn+JpZwAhefF7obggeKzoqSMoVvr1Nb2XDbTVu
 MPZFnh4YC3BUpF+MY/jz9Z8/pjUmhkpeBBsBDG+B0GCvgNnuV/JC2gxZolizUE7mYDV8
 itM/sDfhvssMsa/ryp2Se/F/MQdzAhv707LsN/tRGfwGnhSKXEiM9rUGIhhPu19VpMBG
 hsTHCqwkkoD91vXhVr612F8VTBFHqNk0V0b4K49kRPWCVgzJP5Te4xOM2JKztyILS5Xw
 rw9w==
X-Gm-Message-State: AA+aEWaTBta2uwmBPBQapMCK7gnC+C2mNzUWRiHFNiR/f+3uvEpcuEvs
 kK4kD70f/4wviUBWT0b47q9DhS8Q
X-Google-Smtp-Source: AFSGD/XPPo44VB4qjFGKA+7cztL9S4NAK+OmlEoxgOutZIMus0qiYjZ4a4C0HNvMqwbXadAWTGC2rQ==
X-Received: by 2002:a63:9a52:: with SMTP id e18mr12418925pgo.14.1544480948212; 
 Mon, 10 Dec 2018 14:29:08 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id v70sm18583265pfa.152.2018.12.10.14.29.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 14:29:07 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 11 Dec 2018 08:59:01 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 1/3] powerpc: Discard more sections in linker script
Date: Tue, 11 Dec 2018 08:58:52 +1030
Message-Id: <20181210222854.21156-2-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181210222854.21156-1-joel@jms.id.au>
References: <20181210222854.21156-1-joel@jms.id.au>
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

Building the ppc64 kernel with a modern binutils results in this
warning:

 powerpc64le-linux-gnu-ld: warning: orphan section `.gnu.hash' from
 `linker stubs' being placed in section `.gnu.hash'

Alan Modra <amodra@gmail.com> explains:

 > .gnu.hash, like .hash, is used by glibc ld.so for dynamic symbol
 > lookup.  I imagine you don't need either section in a kernel, so
 > discarding both sounds reasonable.  Likely you could discard .interp
 > and .dynstr too, and .dynsym when !CONFIG_PPC32.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
See https://lore.kernel.org/lkml/CACPK8Xft3n5KkpTjN3=7_VUCXHFcK7mxvZm2Rrqu7tppcBoyOg@mail.gmail.com/T/#m58532c86cf0c7b4fb01cc1fe724e48d4c7d8e4a7

v3: Add dynstr hunk to this patch (it was incorrectly left in patch 2)
---
 arch/powerpc/kernel/vmlinux.lds.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 434581bcd5b4..779b8b3075a1 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -273,14 +273,11 @@ SECTIONS
 #endif
 		*(.dynsym)
 	}
-	.dynstr : AT(ADDR(.dynstr) - LOAD_OFFSET) { *(.dynstr) }
 	.dynamic : AT(ADDR(.dynamic) - LOAD_OFFSET)
 	{
 		__dynamic_start = .;
 		*(.dynamic)
 	}
-	.hash : AT(ADDR(.hash) - LOAD_OFFSET) { *(.hash) }
-	.interp : AT(ADDR(.interp) - LOAD_OFFSET) { *(.interp) }
 	.rela.dyn : AT(ADDR(.rela.dyn) - LOAD_OFFSET)
 	{
 		__rela_dyn_start = .;
@@ -388,5 +385,8 @@ SECTIONS
 		*(.gnu.version*)
 		*(.gnu.attributes)
 		*(.eh_frame)
+		*(.hash .gnu.hash)
+		*(.interp)
+		*(.dynstr)
 	}
 }
-- 
2.19.1


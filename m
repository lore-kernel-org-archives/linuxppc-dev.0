Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DD5C5CFFE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 22:37:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D0C2081F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 22:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOHNGJZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D0C2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DHxz5cTFzDqpy
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 09:37:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iOHNGJZv";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iOHNGJZv"; 
 dkim-atps=neutral
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DHms2cBJzDqhD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 09:29:17 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id 101so5915830pld.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 14:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/TTW+WFL3zOZhLS8thtCKatOPz96ExrwSjaCelzNYKI=;
 b=iOHNGJZvDSVpQwh93tJYH1s/5tAl/VYyNR+5YgFI5bN5JyEAy8DsN9spbHjaYwjoZ+
 QPYzMXNO3fiU5fZBSd1Toid3Q2o6dlr0LIvNPYU0aM80bwf5HtHinlfP4NSQC+oRhktn
 Hj+bA8hElKytN97fYPuIHu+QtvtfTVDKssweSWrEiSvB1V2+PYrrp9SRxDW3fKNURNFj
 CqdYyPcGo+MAlzuQPu0sOCJKP9J1Et9osId6i5DAo+DaZZaxD4tbCaX0NdlKfu8freOY
 +P5/+k1eS1MyNHbSZ61ZRGj3G8e4jfJL+zGD28pFLdAO/bh57VDneOdRAz9LaWW0ljhl
 aS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/TTW+WFL3zOZhLS8thtCKatOPz96ExrwSjaCelzNYKI=;
 b=TPGGTK8yPT88LNA97wQ74R4le5HrLuFU9U6lQ8pGiU8UTL7NyHW4UZImsBvYTppMd8
 Yp/TOJyajniUVJBqq14CQUgnVX8glmMy1hrSVJvcQSegwSyXORGa04P7JpFqF/4YtKt+
 qPh8AwPjOIHcCsFv3vu2H7M+s6rvSJwPzhpJ6VZmn1ohRoHlnuByWpmVb5xSHPOnYbj0
 bvly2/dPwlEN0q3wtjk3I65RE8wOPkouH6ob+Dc2H5/jlU22e+M+w37r8vShC47svPlj
 VW27cf8h/OEN1GwIoyzQZZ1NTF1ecn2e1ETArbCf3ukYaC9M2fXFQjaT/EvyyYdE1DPa
 xc8g==
X-Gm-Message-State: AA+aEWap+H0bNLjnISTPvN5waA2FFPM0f/Zt1yPWGi7zHsOh/G2CDr+1
 wIHsL5TwjhyfboT/XnUQmvqKg0c/
X-Google-Smtp-Source: AFSGD/Uv8ZQXMTEb/k07MdoezgfPKAvDJYLZ1nOY97IXNUVhDWbnAs/5TwE/uo2lq6nixgUplunZDg==
X-Received: by 2002:a17:902:9887:: with SMTP id
 s7mr13448545plp.199.1544480954751; 
 Mon, 10 Dec 2018 14:29:14 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id 134sm14065993pgb.78.2018.12.10.14.29.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 14:29:14 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 11 Dec 2018 08:59:08 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/3] powerpc: Discard dynsym section for !PPC32
Date: Tue, 11 Dec 2018 08:58:53 +1030
Message-Id: <20181210222854.21156-3-joel@jms.id.au>
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

Alan Modra <amodra@gmail.com> explains:

 > Likely you could discard .interp > and .dynstr too, and .dynsym when
 > !CONFIG_PPC32.

Discarding of interp and dynstr happened in a previous patch. The dynsym
cleanup was a bit less straightforward, so it gets it's own patch.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
See https://lore.kernel.org/lkml/CACPK8Xft3n5KkpTjN3=7_VUCXHFcK7mxvZm2Rrqu7tppcBoyOg@mail.gmail.com/T/#m58532c86cf0c7b4fb01cc1fe724e48d4c7d8e4a7

v3: Move dynstr hunk to patch 1 (it was incorrectly left in this patch)
---
 arch/powerpc/kernel/vmlinux.lds.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 779b8b3075a1..2c93a420f456 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -266,13 +266,13 @@ SECTIONS
 	}
 #ifdef CONFIG_RELOCATABLE
 	. = ALIGN(8);
+#ifdef CONFIG_PPC32
 	.dynsym : AT(ADDR(.dynsym) - LOAD_OFFSET)
 	{
-#ifdef CONFIG_PPC32
 		__dynamic_symtab = .;
-#endif
 		*(.dynsym)
 	}
+#endif
 	.dynamic : AT(ADDR(.dynamic) - LOAD_OFFSET)
 	{
 		__dynamic_start = .;
@@ -388,5 +388,8 @@ SECTIONS
 		*(.hash .gnu.hash)
 		*(.interp)
 		*(.dynstr)
+#ifndef CONFIG_PPC32
+		*(.dynsym)
+#endif
 	}
 }
-- 
2.19.1


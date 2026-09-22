Return-Path: <linuxppc-dev+bounces-27948-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3941EC98302
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 22:35:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqFLD16sGz2xwd;
	Wed, 23 Sep 2026 08:35:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::645"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790116548;
	cv=none; b=b+xz34FeR9Wqdhu170kp1s8lrxyTLKyjlc9YtHOYNjUYJTUv2AYiedRXCFUGp52x21O4kS7L5PS2MdBVuk/XU/4SiFBJqI3LR3xnYJLbaTvNTjqoCXcQwVUgXYBFa+3jNtUj+gs+Fa/IqFbHLGGi1827HlJm7uuo7v/p+fI/TtzdEATVSTdt+UCjms19vmMbMPTmsVm47l+tdP8IaEyJwg3XL6S0bqCba+ATZWvsTKxIFtXw+k+fPMgpt286bk4XX40WT/4YlB6xaDBnuQn0WJGZjY8GCVNJboqRW6j94Hl6HC0RGjPEYwZ1krQUtuzcU0A7PTb7GiACFJctF0MYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790116548; c=relaxed/relaxed;
	bh=8GRxp3EYFeG4RHE5TRXwDLoJws/VabvUKmMB/dI5TDY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GQph62PFr6mJFKFIVHxqSn0N9L/UIXbPes7v4ab0iGo4RgGAsNyvsKQhoXBskYc4LwfWlAIPM7nK/QdKflSQ02iED4x0WfhyeaYPn8/7ZbpsAGFQsfMEawNLA9p+85w/FLgHqTT1Ht0qT3DKEOqlZWOPlsZAabrap4uWuvg5WSF9kF1DhpEs8JQJgx6a1Abrq/tjiepObqm7DRY41PSMW5CYHAef2438+QQ2Vk5GZcojde6uvKKMhu4sTZb+K+ODp80R5a1s+8FdO0vM0RIsNgDlGu//bP/ANZD0ZLVxeKsAN+/4tdshkeqcG5g5Wb/uxqDeg4nI+8oNG/DrnuMVuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=l4+3hBUH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::645; helo=mail-pl1-x645.google.com; envelope-from=3vqkzagukdooyadnasaasxq.oayxuzgjbbo-pqhxuefe.alxmne.ads@flex--morbo.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=l4+3hBUH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--morbo.bounces.google.com (client-ip=2607:f8b0:4864:20::645; helo=mail-pl1-x645.google.com; envelope-from=3vqkzagukdooyadnasaasxq.oayxuzgjbbo-pqhxuefe.alxmne.ads@flex--morbo.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x645.google.com (mail-pl1-x645.google.com [IPv6:2607:f8b0:4864:20::645])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqFLB1XRbz2xnS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 08:35:45 +1000 (AEST)
Received: by mail-pl1-x645.google.com with SMTP id d9443c01a7336-2df5a65671eso3353765ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 15:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790116542; x=1790721342; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8GRxp3EYFeG4RHE5TRXwDLoJws/VabvUKmMB/dI5TDY=;
        b=l4+3hBUHiyzB3dLtDGv8QqhZSsc47x6K5QXkSeAcZjV7j/l1AsxU5n9jTckcNAlpQT
         qlcj1vMaoC4pzyP20+MpdNN1Oa9QcO2Q9aYluPyjACiexVPFb3mON8fHoEjDkbgpHr6X
         cM+wYA9zseVuZfVXwhw2dJ/L+cr4hg2jnU31uoJWEmYN2MCxIPeEyDyeYa7HarmPYvHE
         1jAW+pgf0WiP18ocKvqjKq5ek2aBQby7dKyh7/hhkz7MujQgR7pAEpf2eIeOP07bV2yG
         ugLS4RpkrK2W31Rur3FFLtiz+zrnfDLada4xjACtW7UpcNLnYjvBrwf8VzApvgVqt/8q
         EIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790116542; x=1790721342;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8GRxp3EYFeG4RHE5TRXwDLoJws/VabvUKmMB/dI5TDY=;
        b=jtY2QV89Es5ov+4Nhb8D9L0I18DMTYR+edMpgqt8PRpHVc7/ZnYQoSdcjjpFKqRrpT
         gqQEGusxdwMcSpmm3GBYTsQRZUdo5TV3gm0m2/pmlDZ/9ip5BW8sPWRKQYAFQlNE6RCL
         miB9oL7j2gDMVC0D7dRdpbmsuicEeR0uboUKi6W8uTO04MYhzJe0aIpm9HXt+/mqvNC6
         VXUIoRIDk1LESQYmPJyX+TJ3s4mb8+g2mJG8iW7F7jBXa+R5S4TU7VhKNRKWHxIjT6Rc
         tHzxCjJr54HAsnMexwjSkIIb5E7oCl+E686vqAdsspKzn6tQRjpTob/bT5pzAjbpZHlo
         xwyQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9BfSxohchc+cSxss0V0xvDZLTrtOoq0Cp30GNS1omlzJEDfVh3kUgp1UQZbh7SRzEvdmTZvgCM8An9Ew=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mcnKWKpUC5fhnkqS7DFL6BDzPZkajhqFQ5Y88K+m5+dhplHzLV
	ohPKYE/jlBsSw4ljeEiznRsQ/RXkmcSmsOUTaEeLMtDnID0T24TtKfe7sUuU2zBJsbawJRCvEIG
	c
X-Received: from ploc2.prod.google.com ([2002:a17:902:8482:b0:2dd:53b8:ff02])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ec3:b0:2df:69d4:86bf
 with SMTP id d9443c01a7336-2df69d4884cmr5081645ad.11.1790116541866; Tue, 22
 Sep 2026 15:35:41 -0700 (PDT)
Date: Tue, 22 Sep 2026 22:35:38 +0000
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
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922223538.2287676-1-morbo@google.com>
Subject: [PATCH] bus: fsl-mc: Annotate fsl_mc_io.portal_virt_addr with __counted_by_ptr
From: Bill Wendling <morbo@google.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
	Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

The GCC and Clang compilers provide the __counted_by_ptr attribute,
which is used by KASAN and compiler bounds-checking to detect
out-of-bounds accesses to pointer fields.

In "struct fsl_mc_io", the "portal_virt_addr" pointer points to the MC
command portal virtual address. The size of this allocated portal in
bytes is tracked by the "portal_size" field within the same structure.

Annotate the "portal_virt_addr" pointer field with
"__counted_by_ptr(portal_size)" to enable compiler bounds-checking and
harden against potential out-of-bounds accesses.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/fsl/mc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index c25f0f7e6dd4..0b2c0eb9b605 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -336,7 +336,7 @@ struct fsl_mc_io {
 	u16 flags;
 	u32 portal_size;
 	phys_addr_t portal_phys_addr;
-	void __iomem *portal_virt_addr;
+	void __iomem *portal_virt_addr __counted_by_ptr(portal_size);
 	struct fsl_mc_device *dpmcp_dev;
 	union {
 		/*
-- 
2.55.0.1082.g2b9226bbc0-goog



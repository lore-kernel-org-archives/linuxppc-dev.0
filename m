Return-Path: <linuxppc-dev+bounces-27539-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CDCC982C1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 05:22:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlkdv1Dh0z2xyk;
	Thu, 17 Sep 2026 15:22:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789567672;
	cv=none; b=X2iIysnwfD+U9Ft4JzcVB2YSvgmyVMFSWZ8rs4Hep4hj5fKutrawuW2B4a8RV4hcXTxz9YVw65WoKRsgogrGTDd90YdyYO+JOzLG5OT/pA/PGN8pzEo+XYwGZfj6ytKXRI+CCu+suwqcOjDre0UdMYj7GwdnCkXNqXDFA6meGzKFslrLIvJkGdJqhDYU8GLLZH0lCAryNxBuZrNseTMvzqdFHRidCwdTN6/qoNB9I6Ug1E1rI9zMQdecRxLP288e7mR9Qx423UJR/MqaqHgmT6eYHc4NMpexraNGtlPrGDUo1aV2TjJTUIhz5jXEMSN/2uAdyJofwFmXuH5Xi+2NZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789567672; c=relaxed/relaxed;
	bh=E5Rra/PVcmzax9enHjnZo2f+/CC6GR4PQjiSRwVy+Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOQpQCiCXIF7f5/4UOei78t/vyoX+6yQkLNn8iaa4StMx/vYSn64URh5fQ2GS5CNEDLcdrGhBeluSNUryvx58AYA5NLj03xoaxW7XPlN0PvR0536wCXlndtK1OECcnZwOLKck9CQnTD+EJltbBM0lFl11DLqU6C/EVpkHTQ/z2uwoASwOnFybdegEa0JYCUqnj9uQll8Gv8TOymiyuLlCWGZIXq//fem/4ucsT6y+JsHw1vm7y585kzjCJ67OfB4a8WAN/fDq2MaQiaHokPr7lzqphvHp6PsguPIiLt79sCbAvJmfJ4pSM6KtYeJ2+ojwfXPch0c/c+1/w7w66B4Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lPXJFCcr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=kaylovefoss@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lPXJFCcr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=kaylovefoss@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlLLv453Hz2yGT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 00:07:51 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2dd77300825so9452795ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 07:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789567669; x=1790172469; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E5Rra/PVcmzax9enHjnZo2f+/CC6GR4PQjiSRwVy+Jw=;
        b=lPXJFCcr7X6PU6TC9b5JzyH5FY6ba0OThYtv04Lf5PB0ljH/7t/U6CoH96FpJ+w+Rr
         HUUZH9fMSz10bi3pP844m22oterRWRhbjs/9gjaCvO4m8A5LSwDrbnX1EkVPC2pM0Vep
         V2dJZVPp+VsvljuO/TdvjbI5RRkbF5kH5w0Y+HscB5Jm5pFu8K8dB8I1Y31Qu9UHoRZ5
         L7rFX7PJCiLGM6GGTXmlOO/TcBgX5Bqy6kFhBeqMGRNoE/oAuTck6ee8exj53aPrWNMH
         zQQnTWJG3bCC5bg0kAjKHBaRprvThNWTIt6Xv+SGsh0wTNkbIi1XmpbToI66sAjSh/kQ
         ulqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789567669; x=1790172469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E5Rra/PVcmzax9enHjnZo2f+/CC6GR4PQjiSRwVy+Jw=;
        b=TTK13yoNsRt7NWcFjL768el+qHyQw7+9AnRMtvrsncvF9vByDKVNh6gs+hXm6LWvqe
         GqyZJypIINr0UI+DpsKFwx5TbY3o2pWjwRjsYHCUegImeeCYa1C9pZoOvTlnL5MPUwHe
         OvDxAbF/gUEab77XlHlGOEJuyF9mQEDKfO9u2rNsb6DiL+wSHFIf4S3m85jXNR/ns47X
         UlXxeqvhG/zBNT+hGFzvPVKDNuRU1SdcCZ05BV1sCm4zcsVM+kcpw9DPhlVcWgYQvdKL
         hOZdn3W/TuUXffuLXrOXvDi5SZVd9X/UnMEjSHkOxsso9R057Z+9Vov1jSx7SrrrRSdn
         r9+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwPZg058gcVicSE3VlC9fQgWpW4c6Vk7aB3kwZUKFlVtDF87A5rjDegs1RwQcFNNm8uskqmgFUIWUao8RM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lDsEZIAsW4aFsV9xWUnsTwcDB9uG9mNWTIOW73vpd33KMwgEOF
	7oywHRAFGRZ3YOSJW96DE64ebDEPy67X2os3DVINgOi0yL1dqXDpC5MF
X-Gm-Gg: AYBFou3OqkbL4lSyKKmXR072V7qml51zPV/1T2aeKGaqa+nsrR0+wkxXDQh3+p/9mN3
	vLyG9U2X56s65iw0pgnGiXICWU6Ik7NFlRXpjVnCRm0NQPYUsvwo3etDAw/ffIaye766CnhuNuM
	yxH73HC/Ms5E4ZsX2FBv1S/rsXf8/Qzh6bNEl0v/HhUR50zRLWhkdNa9ThY5+nEjTJf/RzDuVhP
	pdfbNcbotrEVKAqDkrL3fo6E1k1NQPKidUxmPD9A3/Btz44pFy0MzXBcSdHDtRHYpe/cAT7l7UQ
	no+dFjuiq9kU61yzRyvI1e12OweJ+tOVLV19m+7fjdEo7+d1xJ95nv3WbjjPlbUqbx7VBzGttPM
	f30qQwLaBA3xDz4cXyCBvO5xLJQ3EvrB+5SSCZcJmHN+KW0z92sJBniRDzey7wLkS4JMPUfbK5r
	uPdwtxEw99l75hadZ7wHKjXK1NeiiGlqWuFzzVaRrzAFPdUCoospsCGzlN/V5YvJd5nQp2ii+8t
	pjr
X-Received: by 2002:a17:902:d4cb:b0:2dd:88b4:6920 with SMTP id d9443c01a7336-2dd8e784c69mr58010935ad.22.1789567668803;
        Wed, 16 Sep 2026 07:07:48 -0700 (PDT)
Received: from nixos ([171.239.145.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89edd1d5sm12622275ad.48.2026.09.16.07.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 07:07:48 -0700 (PDT)
From: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] KVM: PPC: Fix callback check in kvmppc_gsm_refresh_info
Date: Wed, 16 Sep 2026 21:07:42 +0700
Message-ID: <20260916140742.636708-1-kaylovefoss@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260907145626.7675e892-56-amachhiw@linux.ibm.com>
References: <20260907145626.7675e892-56-amachhiw@linux.ibm.com>
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

The kvmppc_gsm_refresh_info() function incorrectly checks for the
presence of the fill_info callback instead of refresh_info.

This can lead to:
- NULL pointer dereference if refresh_info is NULL but fill_info is present
- EINVAL return if refresh_info is present but fill_info is NULL

Fix this by checking the correct callback.

Fixes: 6ccbbc33f06ad ("KVM: PPC: Add helper library for Guest State Buffers")
Signed-off-by: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
---
v2:
- Resend; v1 was mangled by the mail client. No code changes.

 arch/powerpc/kvm/guest-state-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/guest-state-buffer.c b/arch/powerpc/kvm/guest-state-buffer.c
index 42843eca6727..aeb586ba4523 100644
--- a/arch/powerpc/kvm/guest-state-buffer.c
+++ b/arch/powerpc/kvm/guest-state-buffer.c
@@ -598,7 +598,7 @@ EXPORT_SYMBOL_GPL(kvmppc_gsm_fill_info);
 int kvmppc_gsm_refresh_info(struct kvmppc_gs_msg *gsm,
 	struct kvmppc_gs_buff *gsb)
 {
-	if (!gsm->ops->fill_info)
+	if (!gsm->ops->refresh_info)
 	return -EINVAL;
 
 	return gsm->ops->refresh_info(gsm, gsb);
-- 
2.54.0


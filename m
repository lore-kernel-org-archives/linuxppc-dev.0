Return-Path: <SRS0=//ir=JJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9B8C433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 01:51:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E270E61027
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 01:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E270E61027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FJWtf4Y6Wz3cZq
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 11:51:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=SYWY0d3o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030;
 helo=mail-pj1-x1030.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=SYWY0d3o; dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FJWqn42xQz30Hp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Apr 2021 11:49:09 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id
 nm3-20020a17090b19c3b029014e1bbf6c60so2011213pjb.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Apr 2021 18:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aPW9xuVZJZuCiDrYNQXotx3oRG9X3McxReJTO2kC5og=;
 b=SYWY0d3oAkHA3HQIL62Nqb0zxyIXpk49D+FvlZFrRHC8iiKzs7iIbjSkYcWrt1UCwc
 g4FJ3SDPh+7EpWhSOmC1mM74DIPF329C11OpaoPO94H5XH/nJhpM6g5octHAdEcO61qt
 aIT3bRA3lGXrFJIpN/YdDtcrmMqKuXB1wxPOeebU9m4ZkmckrpYITI5Pg/qDK37Lf+qQ
 cg5JU0MwFiT6+fN9b7hdJRdrjMz/8H1vvD0dFfgeb5thcGI+1x0v8u1AsXxVjs2jk3fO
 gi18DfyAAncd7ZcpG6sdiTfTvPJBRf0fpZ9SJnTJ2494KmsTEi1uivVitDlwHETY8Qbz
 Hlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aPW9xuVZJZuCiDrYNQXotx3oRG9X3McxReJTO2kC5og=;
 b=KX1xcHGOceHdzp8GiJPKLVs9/PaAkVQSrSh3gpBLHM8FqVwn/l9HxUiqESjSPP5mTu
 kmK35Sj55fKgTL2AGEYLQnBBGsvB0S6hgi51U3Fik4x0sNjNOl8t6lfDz7RVzq6Tdg16
 wP/RGcm4SpauUooWp1Y4m42JouTLvmbgpr1X4BQjN7VG3t0uAxbzsJ7J863CgMZrQhZ/
 TX63FjGWqgDY2dAfy7gClkHciidR5ECEodC5WksYoqBFoIK4aCCkiRYGEOxSgyvR/+Zl
 DmNSnpqTOO5o01+hUzy7rlNwFxNn/pxAqAl/W3WfywbBkKjT/JzZNx5KVyw0FhA1MFYj
 UCZw==
X-Gm-Message-State: AOAM533zpXwePTIDLmJZcouPr23TlqMRZj/O+DOYieQvOj2Ii+DhaJ0u
 6wQcviT8YdEwgSvOeabJMDH+x7ZzHt8=
X-Google-Smtp-Source: ABdhPJy8SNqNyFIyV1FVhMCiP8rj7Natlar2xhV5RA3NVM+u7+4+x0Ghsb4SrJTOVJ0aBVfaYEgdtg==
X-Received: by 2002:a17:90a:b10a:: with SMTP id
 z10mr1835470pjq.161.1618192147216; 
 Sun, 11 Apr 2021 18:49:07 -0700 (PDT)
Received: from bobo.ibm.com (193-116-90-211.tpgi.com.au. [193.116.90.211])
 by smtp.gmail.com with ESMTPSA id m9sm9502345pgt.65.2021.04.11.18.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Apr 2021 18:49:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v1 05/12] KVM: PPC: Book3S HV: Prevent radix guests setting
 LPCR[TC]
Date: Mon, 12 Apr 2021 11:48:38 +1000
Message-Id: <20210412014845.1517916-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210412014845.1517916-1-npiggin@gmail.com>
References: <20210412014845.1517916-1-npiggin@gmail.com>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Prevent radix guests setting LPCR[TC]. This bit only applies to hash
partitions.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 3de8a1f89a7d..70c6e9c27eb7 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1645,6 +1645,10 @@ static int kvm_arch_vcpu_ioctl_set_sregs_hv(struct kvm_vcpu *vcpu,
  */
 unsigned long kvmppc_filter_lpcr_hv(struct kvm *kvm, unsigned long lpcr)
 {
+	/* LPCR_TC only applies to HPT guests */
+	if (kvm_is_radix(kvm))
+		lpcr &= ~LPCR_TC;
+
 	/* On POWER8 and above, userspace can modify AIL */
 	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
 		lpcr &= ~LPCR_AIL;
-- 
2.23.0


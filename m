Return-Path: <SRS0=m4lh=I6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648E5C433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 15:06:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0DD61365
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 15:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0DD61365
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FB62l2ttDz3dDV
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Apr 2021 02:06:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=VBkna4kk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c;
 helo=mail-pl1-x62c.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=VBkna4kk; dkim-atps=neutral
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FB5zt5VRYz3bc7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Apr 2021 02:03:54 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id l1so1143056plg.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Apr 2021 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r+tYArWWu4RNguNhduAefXr3uYY9Yl8n8bH2Jfs1pRM=;
 b=VBkna4kkyqlOTVRMgKF4wmiF3WwKUdpT/xha9N6ca0URPtut5wAKSfIBUID14tPokJ
 W1yMN11rSq0H0644AfNzzDeV0jviSkwHz4AubJMOwl9V8u4sTiKea1/tuUPQUkhPi/yT
 DBDoiANI8a7Wx1jNJI03p/pZf8URD+w7Qut0jTGmV4HNgP4WggdUpnuQ+ZMvtXB1oqZB
 OpDSd67O8s+JjtDam3W6rFHjzYE1LCw7j2FLXwcsx5RaTuzyX2P1AwF2rwQehTiVxpxk
 OnPl57Ur7h/TesIH4TJEhHVz/UUNi2SeBUOEQqLYHoe66RuZewTAnxx7Md0KQhNldEmV
 QYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r+tYArWWu4RNguNhduAefXr3uYY9Yl8n8bH2Jfs1pRM=;
 b=F3ROgEEDRT5xwGbvkUQv+AozmOqbLThOjITK7jptRn6xqimLb5oW81dpbUCeHhxnSV
 x0RXTAVyZzRe0OjUEIL3fRzvAsCzWulqEhGw9J1czypFOpXdK3FdNZul+ZuyBbtYTtlu
 DgaIo8GzMoVM2gPtvC0kVKs3dh9rKmkRro8Zn/UqK9dUAYp2RbzlOf+FX8Myipl0Lizi
 I2w+B+90mmlbvAb+bU4XPXxV4QIFMCdnz0WCII/c5XMwENRYu34sB4VJTobN47XvRzqc
 TejDnbfbw6TQltqjT9cbp1Yg/hVbX2zLfoJkFiXEWQJrXTi4wJqQtn+ebJkPkjVq47xY
 FDuw==
X-Gm-Message-State: AOAM530KINmK1I0dRoUwgvDdPOI1F6g70wCpduIr3CiXQIG36gpano5D
 CGC0ptHH1UsYbIxOZ1NaQSI=
X-Google-Smtp-Source: ABdhPJwV1HvN2FZK5S5m1TUvt71OYmZ8lXk95guSMCslbNZbtY3l7TpNajNyRzeGx+m8gZbEYr9thQ==
X-Received: by 2002:a17:902:bd8f:b029:e6:ec5a:3a6 with SMTP id
 q15-20020a170902bd8fb02900e6ec5a03a6mr8575548pls.31.1617289432661; 
 Thu, 01 Apr 2021 08:03:52 -0700 (PDT)
Received: from bobo.ibm.com ([1.128.218.207])
 by smtp.gmail.com with ESMTPSA id l3sm5599632pju.44.2021.04.01.08.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 08:03:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v5 05/48] KVM: PPC: Book3S HV: Remove redundant mtspr PSPB
Date: Fri,  2 Apr 2021 01:02:42 +1000
Message-Id: <20210401150325.442125-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210401150325.442125-1-npiggin@gmail.com>
References: <20210401150325.442125-1-npiggin@gmail.com>
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
Cc: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>, Fabiano Rosas <farosas@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This SPR is set to 0 twice when exiting the guest.

Acked-by: Paul Mackerras <paulus@ozlabs.org>
Suggested-by: Fabiano Rosas <farosas@linux.ibm.com>
Reviewed-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index a6b5d79d9306..8bc2a5ee9ece 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3787,7 +3787,6 @@ static int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 	mtspr(SPRN_DSCR, host_dscr);
 	mtspr(SPRN_TIDR, host_tidr);
 	mtspr(SPRN_IAMR, host_iamr);
-	mtspr(SPRN_PSPB, 0);
 
 	if (host_amr != vcpu->arch.amr)
 		mtspr(SPRN_AMR, host_amr);
-- 
2.23.0


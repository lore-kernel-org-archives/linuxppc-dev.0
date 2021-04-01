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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D498C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 15:05:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EBF561366
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 15:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBF561366
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FB62C4CYDz3d2l
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Apr 2021 02:05:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=nSmDau+w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d;
 helo=mail-pj1-x102d.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=nSmDau+w; dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FB5zp6rL5z3bpj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Apr 2021 02:03:50 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id
 a22-20020a17090aa516b02900c1215e9b33so3218481pjq.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Apr 2021 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2ljQ2o/1KJXmV5budvf2xHhIW20DBRLuADvMqiJ21X0=;
 b=nSmDau+w/+aVDhTXw35u1WBNcdKzf7qo9PmSZIT/XQ4+Yj1NafR3w7D3COAcOUcbsJ
 M3a8kec/zBYQSfxBoxR/Z8MaZ7qa16uQLbXUGTQy1tZ76DtCibMwpeLiFe7PNUTcXfVp
 MuzKMg/oCYbLeK8SIO2LuGS/eAIuWF+3niQDgwnTcoT2ypKBhER6uiXCIm3fyBy7nodN
 51h1VT2XC23AACqUDIyvA1XOmcPJGWJJJD0umcoSkUJy3twtBLTBYIbaJ8A7W3aP6EYn
 JXmcjaVyeYBWgrUjcXftxi0/A5M2wt4/D6Y7ahHh5btWwVbmNJvbCR8eiDsE4TXGIp7b
 Djzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2ljQ2o/1KJXmV5budvf2xHhIW20DBRLuADvMqiJ21X0=;
 b=Q5ucUj0zqb6tKKmlJQCPs4dRA9TCy1L0fA7fhioskJMglKW75imyhTrDgbfIOOWP/d
 oSCJrBWxMFMOPPhg/gDykrBD4l+hwRzQjnR63/CBavUSc/K82Prbhul0csZld8oCm0+g
 0k3Cd4lREUtMRrXF83b57IV5wZwDUyIPwgEj7KAkTxu7Mt7twd7vOdwI0SdL2DCL+Jx/
 9BQgNC+afUOG4UPtjSWzoSQ2gZUp6E0E8Gs4yQRoYQiBQSj4G2F25n3yAe+ddqNzOgDX
 k+4XNeLAhanRrasE3QU3Nq0mYoWpyX6cfjwLNEa5NHpcrXMa3RSqyiHjwqbUT4JJp1GQ
 gjEQ==
X-Gm-Message-State: AOAM531lgAGcenzK+aII6sDduXKHHX2OvSFgWlmIxpMBTgym2eh4pC8D
 BNGrnHId21J82CjI22BC6eQ=
X-Google-Smtp-Source: ABdhPJxqgIwpjVBmqEUJt/5rZZ2PMe1ApS0YwaeZMy7M/s+ccTi4enhWYVUkmtmbKM+OTKLDzSGPQg==
X-Received: by 2002:a17:902:c48d:b029:e6:f7d:a76d with SMTP id
 n13-20020a170902c48db02900e60f7da76dmr8340029plx.66.1617289429147; 
 Thu, 01 Apr 2021 08:03:49 -0700 (PDT)
Received: from bobo.ibm.com ([1.128.218.207])
 by smtp.gmail.com with ESMTPSA id l3sm5599632pju.44.2021.04.01.08.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 08:03:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v5 04/48] KVM: PPC: Book3S HV: Prevent radix guests setting
 LPCR[TC]
Date: Fri,  2 Apr 2021 01:02:41 +1000
Message-Id: <20210401150325.442125-5-npiggin@gmail.com>
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
index daded8949a39..a6b5d79d9306 100644
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


Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6DAC07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 03:49:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED43320837
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 03:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWGZw4Uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED43320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439z3q1cnVzDqKv
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 14:49:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hWGZw4Uy";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hWGZw4Uy"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439yxV5knnzDrVM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 14:43:42 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id y4so1077033pgc.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 19:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WR6xWqNImrfbGP3JXoxK2OHxDdNcXtai1sAf1pCiEFc=;
 b=hWGZw4Uyuh5FMpqroPmzAH+0hVI4hdqqDjYh2bcx60p9p8cRMgag7q8G75Kc5J3Fym
 7oFW82QsyywiBLVgfrm66QcyW08TZu0C5bYNtkSjM9rlFvgRi78Acis7sifFSzVf9MGv
 zXHhMBr6t5/OBAD3UHmeuhP9gjtdD6GySNBveNNdlicbwZ49A4rrAzcRfqiw2DhI+/6r
 Bq9g1VBK5MFYFAmA3+f7pLz4PxfVvSJN7Up0/umNmOfn9yRxDyO+qzpvfLPU2NGOdmby
 CCL3U2DTLoCd3AKUc3E8L3YQsnf8iHwQoii53r2DSLx2bNphTMtxeeL9KuTKsCzJTdBi
 xkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WR6xWqNImrfbGP3JXoxK2OHxDdNcXtai1sAf1pCiEFc=;
 b=KS7Te1OKxIkf+x/eU3jmogbxURfgsm2mfVp/d9nwgZkUI0y6DJjHFzCfgwkjKhUzs9
 ZBoOa1MWqRqpg+idfVYitWW44SsoQbyqRvbFm98u2auZTlF8P9ggJ1yhhX6F6r/5KeYM
 V+H9dwX8INODAQ52zXX7aTnAWNuwBDUINruo5C6a8wP+f6DI2Bb8e1Fjrm64uUW1Q8mb
 I+wH+sagqqeOO9qK+br478gICX5UW7qxZ1Ja+1yKhhD7mluZPluIpi2H9Ba8eYuofuue
 vKUv4n6JQ2FYNUGnDXP3SSdIXpn5bZiYAjkbagimEjK4fl/MpgBxtP6uIsRFa0XmL1J9
 Ch3g==
X-Gm-Message-State: AA+aEWZCpiBO303z0pRmGN/LJDBIBb4i96hTQmi8JxuS4KLuNKqIfGM3
 QFR9oLL9j9ZZp3jnnbDxlds=
X-Google-Smtp-Source: AFSGD/Xx+jN99b/DLvSvYlSyOuR8j3s4O8hgfsq6p53Dr+g5Cy7JPfi3jHvzpPuZ2o+Mo4Wl7eYzDw==
X-Received: by 2002:aa7:8549:: with SMTP id y9mr530331pfn.83.1544154220879;
 Thu, 06 Dec 2018 19:43:40 -0800 (PST)
Received: from localhost.localdomain ([1.129.152.198])
 by smtp.gmail.com with ESMTPSA id e23sm2262646pfh.68.2018.12.06.19.43.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 19:43:40 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S PR: Set hflag to indicate that POWER9
 supports 1T segments
Date: Fri,  7 Dec 2018 14:43:18 +1100
Message-Id: <20181207034326.3564-2-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181207034326.3564-1-sjitindarsingh@gmail.com>
References: <20181207034326.3564-1-sjitindarsingh@gmail.com>
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 sjitindarsingh@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When booting a kvm-pr guest on a POWER9 machine the following message is
observed:
"qemu-system-ppc64: KVM does not support 1TiB segments which guest expects"

This is because the guest is expecting to be able to use 1T segments
however we don't indicate support for it. This is because we don't set
the BOOK3S_HFLAG_MULTI_PGSIZE flag in the hflags in kvmppc_set_pvr_pr()
on POWER9.

POWER9 does indeed have support for 1T segments, so add a case for
POWER9 to the switch statement to ensure it is set.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kvm/book3s_pr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 4efd65d9e828..82840160c606 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -587,6 +587,7 @@ void kvmppc_set_pvr_pr(struct kvm_vcpu *vcpu, u32 pvr)
 	case PVR_POWER8:
 	case PVR_POWER8E:
 	case PVR_POWER8NVL:
+	case PVR_POWER9:
 		vcpu->arch.hflags |= BOOK3S_HFLAG_MULTI_PGSIZE |
 			BOOK3S_HFLAG_NEW_TLBIE;
 		break;
-- 
2.13.6


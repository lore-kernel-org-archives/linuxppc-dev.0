Return-Path: <linuxppc-dev+bounces-24754-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DF8C531D0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 00:48:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5q962zkrz2yr9;
	Fri, 24 Jul 2026 10:48:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::646"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784854090;
	cv=none; b=CwbxdPszrlIshKow1QOFT1RKUgJfQmVswlrFRXr37lf3QuARf8Rp7DNca913SYQfdU0TMA0kpQ/V2RMNaqXVhYG/XLnWLgn1GEuLYsl/x7eXXlcZ8fgk5A6ulWJ/qRaWV887itrvlUUQxhkIY+y0gAXdW/Hw7f56qN68w4RLkhUSn5Zx9AxbSQCNpbmn2XzkAxOzH5HKYZU37cvUukkIjdcCO0oNzKmOS6c+9XwWDfv4F7KmvIW/HZFPW0vZ7GXfmrdF2fCguyrC3E9kP95xbdI7CvYxBpbyzAgT5yWRXgm6yzE46RFo7trhb+eQZcQy63V9iuIi7iJyiJ5vR9otQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784854090; c=relaxed/relaxed;
	bh=I3gB3WtQDQEpdFBx4UsnySvL5yUqMDwDBCfPJjwK10k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cg/+yNajUenAhw57NVP4vzwLtv580P5YqVJBI9VUEm/blqO+qp7a94zphquc5H9Tw76YsKXfxygTSRx1evO6071q5oysdr5ciKf7Dx9wPcxH3yXvth0mjJiWWaDJG9IKXZfGFbIQWe75xfCMXDT1KA9qwqVCncXC/SkFNpRcq8mpBozly36Aj7Z9c3WqmzYhSazGjaTOLlJ83LGLXnvWwk3ZeXpZKVv90m8pMPBuFDlY0AG7dg1B0SYGj/e9EDLqlfI1r7dLX8Tl8FYge8RVcG8uBdSEmJmvyIN9SeWUltLjD+piIJp8t5NiMN86t34TOFCg7PSxrtFgROLyLM05KA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fKN0lbCn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3r7ziagykdjgk62fb48gg8d6.4gedafmphh4-56ndaklk.grd23k.gj8@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fKN0lbCn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::646; helo=mail-pl1-x646.google.com; envelope-from=3r7ziagykdjgk62fb48gg8d6.4gedafmphh4-56ndaklk.grd23k.gj8@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com [IPv6:2607:f8b0:4864:20::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5q955WG9z2yqq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 10:48:09 +1000 (AEST)
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2cacd6d37edso19563705ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 17:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784854088; x=1785458888; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I3gB3WtQDQEpdFBx4UsnySvL5yUqMDwDBCfPJjwK10k=;
        b=fKN0lbCnuXQiJyruKVfR6tq4vOUFEaUCJPFOf8sYdsqaejdvbcoJfbOAS7Hh0NqDK5
         kG6itAOPXfckc3HBBmKuGNFAURMTze0gD5xhRLcYcFH2YOhRpb5fWDC31OK+vyh+/SVD
         A7rpfKy5Ed+WEsVvAOo1dqtcaptvSqBWaRFIyH9SsNaVfh1C++xrWRhlbjp9IGPQ1+Ij
         saP1Fn60iyhBWR/OBZ6Rb8OZqjFoS6XgFWxWMybFVi8x/9DqIONywltys/ORqB0B82KZ
         IoLC8yshhWzGrf7g8wkCnl08D0eU2WwgsyCcMA2n1vRA41eDwMYL5AFzDpjEEWOtobTw
         Ee2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784854088; x=1785458888;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I3gB3WtQDQEpdFBx4UsnySvL5yUqMDwDBCfPJjwK10k=;
        b=S11MeTfesSrumPp9y7+7Y7X6ei+UfFqWPM5tDK2Zs2jJ7uBkG7xiAy4GffoxVQtduT
         mtUtvJtCfCE6cwxdPOGVniiEJ/yDC3Pc4s0pbBwpIkeJMkHaFsFz39LWnle2T9JgQmeY
         YE3nJR30HOWbpGmWBvQ2Ce1b5hOElUFWR4NXHwUgDNynk0mIw3MbOt47c4JksI6MtS3p
         usGYs+2fxlE1JBCAH9Ds134GSpxnnUDGDoidqdRw1snodDSvk3YxHVNroQ0zv1ZnYqIA
         oXCIcc0o4FHW0XEzEgSzEjcq5cs/mkqu5vcP2JJseP4qOVpGlQIDk/80XoSmHVeuwzey
         DybQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqkq2kRMwgmC/S0KMtna8OlJXtoNMEIjiWKRtuE/TE09kncEGe36pPzBgCWARYkC3PxGcrbiIvKkK0MslI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzw7eoIQQjKCjl8e1B+F7UpsNHq72+rANDqe8yRH03iHAg/yjIP
	0xLlLyzLU5WfnjtUXql0J/psRl+ndMPkNpdUslJ2P0DJ30Ye8F+j9IWIuT0eIsF6S9Os4epyipf
	YljO4PQ==
X-Received: from pltf3.prod.google.com ([2002:a17:902:74c3:b0:2ca:b3d3:7c07])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0e:b0:2ca:c84b:c4a4
 with SMTP id d9443c01a7336-2cfa748cdebmr62759825ad.28.1784854087460; Thu, 23
 Jul 2026 17:48:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 17:47:56 -0700
In-Reply-To: <20260724004757.131420-1-seanjc@google.com>
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
References: <20260724004757.131420-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724004757.131420-6-seanjc@google.com>
Subject: [PATCH 5/6] KVM: PPC: Use CLASS(kvm_vcpu_map_local_readonly) for
 patching dcbz
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Convert the kvm_vcpu_map() usage in PPC dcbz patching to the new
CLASS(kvm_vcpu_map_local) implementation, to eliminate the very last of the
the open-coded on-stack "struct kvm_host_map" declarations.  This will
allow adding hardening kvm_vcpu_map() against memory leaks (due to
clobbering the existing mapping).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/kvm/book3s_pr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 2ba2dd26a7ea..da7a038e2700 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -639,27 +639,24 @@ static void kvmppc_set_pvr_pr(struct kvm_vcpu *vcpu, u32 pvr)
  */
 static void kvmppc_patch_dcbz(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte)
 {
-	struct kvm_host_map map;
 	u64 hpage_offset;
 	u32 *page;
 	int i, r;
 
-	r = kvm_vcpu_map(vcpu, pte->raddr >> PAGE_SHIFT, &map);
-	if (r)
+	CLASS(kvm_vcpu_map_local, m)(vcpu, pte->raddr >> PAGE_SHIFT);
+	if (m.ret)
 		return;
 
 	hpage_offset = pte->raddr & ~PAGE_MASK;
 	hpage_offset &= ~0xFFFULL;
 	hpage_offset /= 4;
 
-	page = map.hva;
+	page = m.map.hva;
 
 	/* patch dcbz into reserved instruction, so we trap */
 	for (i=hpage_offset; i < hpage_offset + (HW_PAGE_SIZE / 4); i++)
 		if ((be32_to_cpu(page[i]) & 0xff0007ff) == INS_DCBZ)
 			page[i] &= cpu_to_be32(0xfffffff7);
-
-	kvm_vcpu_unmap(vcpu, &map);
 }
 
 static bool kvmppc_visible_gpa(struct kvm_vcpu *vcpu, gpa_t gpa)
-- 
2.55.0.229.g6434b31f56-goog



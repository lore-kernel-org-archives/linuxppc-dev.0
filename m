Return-Path: <linuxppc-dev+bounces-18816-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1881F106F2F3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 08:09:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhGd51lSQz2yTH;
	Thu, 26 Mar 2026 19:08:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1349"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774512537;
	cv=none; b=avf5/aZQvJEnU9fmDmBHmbxDqDs1wyzeiCAZA/m8aHLerbI7yl7cb1Ix2vKvvAB4SggURVRUpnYaTxKQl4ZUvpjec+F1xfzk9YoBefYc2QLTFYkFWLl3b/ayKkiKTRzaG788puyFM+ZrMzZr5QIWRcRd9e+RK+E3qt9EDhfqditKjW+2QFdTAE0/9PaDPxZsyOdJCWyfY+ZxEzOjk+IUNkngwfxqwAb2U1UoN4GUxuz0MUfoqaVGiW6ceoCJtQTi8VCl0droT+E0F+sGxpvB7WXNe2AqDv/eCZZbn3qptW3LCdGRJMn56Ci8gYQkX0ClG5x2DylpcwNWAE+zvz5NwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774512537; c=relaxed/relaxed;
	bh=5NgLz5FVqf/NV7m9qbKXaNWE4w/1GDJf1IUGYhV4ad8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HkACrlMj+WG7EAJ8Cx4SViDsWcd9L+8tBGMn3P+A0vcVzVb1PcnfZzqxgJgot+ljald9ZC72ANgAzWYIFHVJIj9SYy5ZmGCdvhYyxyOoFRHXPEXxC4B8pgfU1K2dqM9w2nN2+w2LCilQuE5LUqZgV8vMimiIF5XImxFvvIH+EU2bsZK50Ag2kSNlr5vjcepxVTvA0DyACthe6TKvn8hwvj8ExBh2bMIiTiiAM9y4Mr4ttHQQf30FBJWscaK63VxtIPekYQ6xGKMWQUJzpglTgjFpRVaaHS19tJG2eSe/yfAwNsp/cd9MERkozzWGWYQz0UYRBtrtzGQ+eD6V3IDTJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XGInjzmr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1349; helo=mail-dy1-x1349.google.com; envelope-from=3luneaqykdnefhe1ay3bb381.zb985ahkccz-01i85fgf.bm8xyf.be3@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XGInjzmr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--surenb.bounces.google.com (client-ip=2607:f8b0:4864:20::1349; helo=mail-dy1-x1349.google.com; envelope-from=3luneaqykdnefhe1ay3bb381.zb985ahkccz-01i85fgf.bm8xyf.be3@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1349.google.com (mail-dy1-x1349.google.com [IPv6:2607:f8b0:4864:20::1349])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhGd43nq2z2yrb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 19:08:56 +1100 (AEDT)
Received: by mail-dy1-x1349.google.com with SMTP id 5a478bee46e88-2c0ffce2570so4641821eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 01:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774512535; x=1775117335; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NgLz5FVqf/NV7m9qbKXaNWE4w/1GDJf1IUGYhV4ad8=;
        b=XGInjzmr+1ocxORz/oWXviV3hrfjPzRxaPtLMuq9FxeW0oMaL/1edrVDh6ShDW/R8w
         pg1vaOqrQuzkpHLSbRJ+WBYsAgD1RjYkqgXErB9Rql9v0cDxvg/0oCHcruVxHohtAqdC
         FO2Yos1voY87zHaDXnv9smIju8SIIBwx1WJMuFqEjqEr0Ff5j3qayopzV7lvJgWa919o
         orP7hSpB5gSb+omMhRnIGLacSqcDYBLOeg8OygdKEsyZXzClsUqFPj40xmHz7peTUDkM
         YPOIz/0VtvWrUGHTQ5edbCH3nteI28EPIy9fBWfoRQkqnH7ooDWwuOKgd1oTVbD+Tudi
         fKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774512535; x=1775117335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NgLz5FVqf/NV7m9qbKXaNWE4w/1GDJf1IUGYhV4ad8=;
        b=imZtrQu5JAA9gWU/NiZ0w0/gxT6LynhGcOsrUVZ+RetpXlAuHwdyrgNJm9o3b978Zn
         unvVLIzDJGprMikPxRg2yEpM5KWvK/JRNrt1HCb8WsjMSgdOD8znBiCZjR/c1A9J5uaL
         yaxxm42Bp8sKDyKKWmgji3dEWiwBJi/Z68nWNtKRyq7tR8mH9QJY2o87C237kY7kW1Tl
         XvGRuh5+clNqYSxUnl5G4xxieAbIysim0zjm6XEf3HSDyM/f6pRMBdZ/nQRsyNISQ59r
         /qcxE1gtXBftU7Xo70qtlzZwnwXBlDBxLunjAtDtDTRb0sBqPyL/ZGPueapViERC2EJp
         b6bA==
X-Forwarded-Encrypted: i=1; AJvYcCX0iBS2Nmr+3P2PKcQgv1WME+XYN6xKAxBdj9Wplq9zuSjZ/uySpQZZdKC5wp6QhJ9xtWxut3EMuCo4yyI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwWjWVS5q0A3VdUdqFX2ZL6C3+dR6kPEfb7NTrg4odrPPlAWnpN
	2n3UC1yBLbamtdGikYrwyWNey/YVb5hV6OHik+cuaAEbDHXrZMSjCK6tTXKAJtrtxdyPUUa5e1i
	Ac+1mBw==
X-Received: from dyt4.prod.google.com ([2002:a05:693c:8084:b0:2c1:63c5:aa2e])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7304:b0:2c0:c96a:a4db
 with SMTP id 5a478bee46e88-2c15d2ba52bmr4025361eec.4.1774512534535; Thu, 26
 Mar 2026 01:08:54 -0700 (PDT)
Date: Thu, 26 Mar 2026 01:08:36 -0700
In-Reply-To: <20260326080836.695207-1-surenb@google.com>
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
References: <20260326080836.695207-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326080836.695207-7-surenb@google.com>
Subject: [PATCH v5 6/6] KVM: PPC: use vma_start_write_killable() in kvmppc_memslot_page_merge()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Replace vma_start_write() with vma_start_write_killable(), improving
reaction time to the kill signal.
Replace vma_start_write() in kvmppc_memslot_page_merge().

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 5fbb95d90e99..0a28b48a46b8 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -410,7 +410,10 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
 			ret = H_STATE;
 			break;
 		}
-		vma_start_write(vma);
+		if (vma_start_write_killable(vma)) {
+			ret = H_STATE;
+			break;
+		}
 		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
 		vm_flags = vma->vm_flags;
 		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
-- 
2.53.0.1018.g2bb0e51243-goog



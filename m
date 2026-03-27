Return-Path: <linuxppc-dev+bounces-18944-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC9910F286F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 20:55:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjCZs3Tpgz2yvS;
	Sat, 28 Mar 2026 07:55:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::124a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774644917;
	cv=none; b=onBUbqfLVPd8qFDUfuH2GFywnU3E7ow3P1AiEoUQzUxzLlzf3yrIE+j4WTtqy7h6Ax2/UihnyzkL6KZHW5CG2HNPAJMpckS68/7qF0KWoZewNhsOK1PYNKmzoz0sk6Hur/rW4Vl4V5pjAxe2Kwdl+pzvzW+TMge7rUaX9t5wAo/Dfr7oo7fNWlB7uWdzCRS8Fnxmsm86za9q+aKM2UCLRMvLSkUTl7UKG3qolwjDqlzha1lW9oNqBnS3c/8rSIJVN18qsnAaPexMQUj6IUPwpde5Plp114p3hwtanbgZ+wBloKbW4PMelQZuxPwKT7lr4/WBDXASDvccsWhtolYJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774644917; c=relaxed/relaxed;
	bh=5NgLz5FVqf/NV7m9qbKXaNWE4w/1GDJf1IUGYhV4ad8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g+OTfY3N5fclspa0GaElMo7RidbQ5+4DY1kSiSV31kwVlBYnvJW0ZJTgAsEjW+Nz/kRKxX5rWCkdYQZi22gJxlTVcgTRKbbOHQeWvK2Az4l0kI6v8ph2sDo1qKTpZmcBUNor4n5ufSfSggMV8QxoqfP33JuHSeG8u1jHnrg18Uk11m97D0/o31irvKdxi3rkDFjs0WLRxRTO3AySwCDpKldsA9iaZLrWLa1IwN+I8hKq6Hu1auFRPxgM0nF2w0NXlqLJkNoDFTaydTtl5BDNgOZPhtJ0WP64NhgM/KtUgZjUdVNb6fVAq1xDkJjDAU5ECvOhJxvVRhGVFGsaFn+TXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=b8IjFGTM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::124a; helo=mail-dl1-x124a.google.com; envelope-from=3su7gaqykdaetvsfochpphmf.dpnmjovyqqd-efwmjtut.p0mbct.psh@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=b8IjFGTM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--surenb.bounces.google.com (client-ip=2607:f8b0:4864:20::124a; helo=mail-dl1-x124a.google.com; envelope-from=3su7gaqykdaetvsfochpphmf.dpnmjovyqqd-efwmjtut.p0mbct.psh@flex--surenb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x124a.google.com (mail-dl1-x124a.google.com [IPv6:2607:f8b0:4864:20::124a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjCZr5FDwz2ysZ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 07:55:16 +1100 (AEDT)
Received: by mail-dl1-x124a.google.com with SMTP id a92af1059eb24-12711ec96fbso1768960c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774644915; x=1775249715; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NgLz5FVqf/NV7m9qbKXaNWE4w/1GDJf1IUGYhV4ad8=;
        b=b8IjFGTMk9bp9dC18Fckv84jEoPlE6ufD10wUfdzXmS2HR7GfgmZU1ELa3X6Fpwlgl
         5uerSexUWXOEGqXtTusILMzeAaZnDQZ6bpvvOggwkjAl7/9QVE5XjAElceP4RHBRoyq6
         jacmtwzQTOLAVVxAHD8pPoess39QXNvoYz7sqLvWEvvfhLlZxWy4QFMb4RfhEFY9U7ul
         nqu1Dp7QHVd8dV/WYrC6eELfNVXvWI2ja4A8dbzknWrfX0hcFySCD2zft2oSyrSPDUC7
         5UJRr5PbKetgiMivE++WxATMpXpfO966XmhtvObD/rhlD/erCZiCGxTGJzCaf4W1m7vx
         a+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774644915; x=1775249715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NgLz5FVqf/NV7m9qbKXaNWE4w/1GDJf1IUGYhV4ad8=;
        b=c9DSm4Y58WNVoazJ8Q/CtXPRoj9Y+5ir9rOOicAVTOIkOVfVQzwyBxXt4qU0VQ2jAm
         RTlRTcVvyPDJbkDukWu3mHpXEweKbEG9zhcZYPpkrKKCO/JJgMoqm00JRMxlh0QiB6Eu
         1Nnsiyz36pd93wGxu9VC1KJdh5ZUnCMBq/voRYZ3eO9Pg/cndYelKr3DOxuLPFEWmd9R
         HoduZ58WYG1xidTEJWjbSkQK78XEQwpQhmkuJ3yzt/vTEOkpjgnYJJg0WgM7fXAmN+Wv
         TI6HG73fwI4Gdexo+XgelwcJWfUsOSB+9GcstmZjr/NQnzi38E+bNuAqwqyK5fpnM9Lt
         f5jg==
X-Forwarded-Encrypted: i=1; AJvYcCWTgqMsMlpuaRzDWXzGbovh6lQU0Z80V1pJAUtMirzB2msf9PMgx0P/S0U0Olys7fF+t7Y59FgYWrltA+E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxOeC3P+mUwJV7JheaIphfxWXztJ9tmhPLwUu2DOSVhsUMINCYe
	2adrkmbpO/+qq3OP8qq4w+ll/issb5z/2kGGLVJ90DmrbaL7+TZxXrbQyjT/tyXF2FOPu0UhB5m
	GuvtMLQ==
X-Received: from dybml5.prod.google.com ([2002:a05:7301:1505:b0:2c1:5ad0:b659])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea30:b0:128:d7a7:5261
 with SMTP id a92af1059eb24-12ab28eba7bmr2796910c88.30.1774644914544; Fri, 27
 Mar 2026 13:55:14 -0700 (PDT)
Date: Fri, 27 Mar 2026 13:54:57 -0700
In-Reply-To: <20260327205457.604224-1-surenb@google.com>
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
References: <20260327205457.604224-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327205457.604224-7-surenb@google.com>
Subject: [PATCH v6 6/6] KVM: PPC: use vma_start_write_killable() in kvmppc_memslot_page_merge()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, ljs@kernel.org, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
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



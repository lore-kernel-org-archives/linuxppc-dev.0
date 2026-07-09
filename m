Return-Path: <linuxppc-dev+bounces-23920-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574C8C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 08:51:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwpbh07L3z3c9w;
	Thu, 09 Jul 2026 18:51:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783587087;
	cv=none; b=QcPbjZmcyF6G1ChckfOgjEBgetG+uHvHKy9zek6Doy5Jtf1nmF1dExnZ+pi25QUmK3P+0KZTQxKcDB+WzsdgPlNrp4iJx4RCrhXNdR0hVG3nUU3ChoNR7XPjZoDJmT1HlC0YJqvGaVx5mRk+Wrx2q7CxhyrQK8Fw+F3TnKdXPXQJqahcSG75U6Lex60zDacLAqO0HiIYe4mNs/EA8kQ13y9yC2mX+0rW/M2O1ktYcVUEz8gPREGMZl7CRaxruxvf+j40SfI8MkxqV+PHZOb3OqA5uRo+aLEpaoNCH43UlZTxZ6XeKfuiIQc4jYAapDxbnvqxrhqsLuvokQaSmfaR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783587087; c=relaxed/relaxed;
	bh=CNp1e35ro3cQgZeEMYQvoxd6PA+bCrB79PJw0+bppNk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=P66JE5qMacUdu9qEi8e59YQzk1XO5tnSNeOTE/qOv5Cb8FwHXyDcfZoR+LiEqsyhPDp+QQ+w0VukSL7IUDM+/7RVTTxYOGDvSeE7las0seeA+aqNVhY0Qsginx4Ez9tGDMd1Yn/xnOkJbrAZ4oxCgu+q4+DxsIlPSqWQRy5L13TMs+UOjPuF9alqodpfuQhhfUQEzC6j2sn1W9wtdyFTvGSKprU++cKZWPXiJ+Pu0Yi8lSu/2WGJtFC/OVpYmn/7RhGlk3YX3vThRhhkSm5i5VsejiKZ2deKcVKFE7EcON8a/87LGr4IDW/qZ1P0VpNTT47oG+AX0wcWCR6TapUZtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XT8Nvw+j; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XT8Nvw+j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwpbg0f44z3c6n
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 18:51:26 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-c89636920a3so802829a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 01:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783587085; x=1784191885; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CNp1e35ro3cQgZeEMYQvoxd6PA+bCrB79PJw0+bppNk=;
        b=XT8Nvw+jdAj3moolMKXrI3QTLYoLOeFyU7QOh4sts/8f6qReTfqfTJhZ7zQyAOXd5J
         hoAB98D5McGt5UyJi0nWbtNQc+gyd/Ak3yhXJ3MAgln5pP/PMQ0wxHpwDh69fC0M5GOd
         hOg7EDY5cJjiAv53d08BD7pwBeMHkiM3CPV3ztJS1M2Q6yTpm2pjmdslmtYX1hj/gqJ/
         +eK7eLLolXEVww0HQDqSGyr9UTiS+UAOMhUFva4sRTueK5iHhgIyfh+hLrME0D3IOstd
         y45wbbGgm9+8YgNKinj3kFfwwof6jXrByLOcrYm4lFYeg4uKxRLePTYCOJpB3ZJJUN5N
         haZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783587085; x=1784191885;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CNp1e35ro3cQgZeEMYQvoxd6PA+bCrB79PJw0+bppNk=;
        b=jy8uCz3I7Z3t/WG7NYdruXFELImGzN31HiCM6HpfhBwNjIUf4yDlim12c1nlk9Us3u
         6o+Qt83TiZYcWn+o6w5rNn6jb4nS9ijeoEfwIzXp7Etln6WjwmxbPbH/4Klr8E85bsZd
         qEKjUYSXWlCH5lEUOUtV8pFvh5XgnE+V7f0lNEUe9ChOGa8yOSq31eBUBe0/XRFvnz+W
         GF5T9vFs5w5Ym8i1MhdbFBZ6hCFizqSQRFN1SxH4vxw5W76Cr5WCBphvR/euBvG+UIx3
         CExBzBAQqGx2V2XMBr+7dAMPBCyMOO60h+dI64FpAuGzv0C8hEdrbmfY60v07a/cMVlw
         ppCQ==
X-Forwarded-Encrypted: i=1; AHgh+RpWuixdYqNq8FG0mdtLcx37BWB8cCOG9s7oSj83RawaWO9zkbJb0+No9viGUbv/cbYTPWO+W8zpLD3N+n0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyUNlWYC46gGa9e2xLAdK4TVY6lGKkNR7rjGRL2Q0WOruKMKn1u
	GTvgLg++M6pcv0wNfWmPApLhAru5P9gKPpFQHgl2zMX/xfkTegP5pWmRUdZ/zbt9
X-Gm-Gg: AfdE7cmoNe07T6aZUdGMOaOHT61BFC9Td5F1/PSu3TyYcWteLn2heEYy/on+UMAkJ/o
	fynZGRfsqOMwYSLlOIlrBe0uowiHJgOKnGnc/LXmh6hMmVFi5dBpNTI8fDXK1a65Gh4kpAFuvtS
	9Y0LAvTmse/wqbiOlpaJ3EDwRyiKU8hJKbm/9USxmCI3TWEWGR7tSl+8e6MMya9qQ0VhI8Wf9Ig
	WhrKXqgixqt67u5VTwWwcO8L3yBYysb9jvKx3XIITTR1l67/ReHZf2o7l4GfEs1wa/FL28mtoWA
	VeZ5mSEoDzyJK0ssLlgRjahNeYcZ4wTkMlbhgX+oWDiPR7iyofrPqEWZ1ps6kwjfuAb87cTUVK8
	3nZv92Xq1/wCaI00cI6cVVo7KOJNIA3vOxA6AugR0hh51vIpFynv9VgQlT6YSIMftEm2Kie/9zA
	LKJsKYNiCJ+JY=
X-Received: by 2002:a05:6a20:3d0b:b0:3bf:7ab7:98a4 with SMTP id adf61e73a8af0-3c0bc95bad7mr8044555637.27.1783587084985;
        Thu, 09 Jul 2026 01:51:24 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311a6115e61sm5516616eec.22.2026.07.09.01.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 01:51:24 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael
 Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] KVM: Use vma_lookup() in kvm_host_page_size()
In-Reply-To: <71775f561c4b7fb23b7af0725c6ce232a4b27b20.camel@infradead.org>
Date: Thu, 09 Jul 2026 14:16:36 +0530
Message-ID: <7bn4wnwz.ritesh.list@gmail.com>
References: <71775f561c4b7fb23b7af0725c6ce232a4b27b20.camel@infradead.org>
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

David Woodhouse <dwmw2@infradead.org> writes:

> From: David Woodhouse <dwmw@amazon.co.uk>
>
> kvm_host_page_size() uses find_vma() to determine the host page size
> backing a guest page. find_vma() returns the next VMA when the address
> falls in an unmapped hole, which means an unmapped address inherits the
> page size of a completely unrelated VMA at a higher address. This is
> never a meaningful result.
>
> Replace find_vma() with vma_lookup() so that a hole address returns
> NULL, causing the function to return PAGE_SIZE (the safe default)
> rather than an unrelated VMA's page size.
>

That's exactly right.

> This is currently only cosmetic, as the only caller is in PPC book3s
> support (kvmppc_xive_native_set_queue_config()) and subsequently returns
> failure if !gfn_to_page() anyway.
>

Yup. The change make sense to me. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  virt/kvm/kvm_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 89489996fbc1..d33761123459 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2693,7 +2693,7 @@ unsigned long kvm_host_page_size(struct kvm_vcpu *vcpu, gfn_t gfn)
>  		return PAGE_SIZE;
>  
>  	mmap_read_lock(current->mm);
> -	vma = find_vma(current->mm, addr);
> +	vma = vma_lookup(current->mm, addr);
>  	if (!vma)
>  		goto out;
>  
> -- 
> 2.43.0


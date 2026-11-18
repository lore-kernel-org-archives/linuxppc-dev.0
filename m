Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A404D606A320
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a3jM4MpZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVByr2sMcz2xdX;
	Thu, 19 Nov 2026 06:50:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795031412;
	cv=none; b=cP9hFVP3vJBEdd5ARsvNXCBvNsucBVI1f6FXuK2orFONKiBjMUQX6T/XGxHMuzHcLT9eKTTSwpxk9qDcLjnx+BpNi3GxflcqjWtTElKEQZqrIfbIOrjUHIkDcFwAxSkQwyK73wpl9heY8hWvblfEaeI1h8ayh0JJY+c2sDI+3qPxjAeNvygPWEJ8WxlrsNNWSlneCc/l5RvpXIOPzaGCDYahow8puxvULZIOv5cbrbCIrhwZDShjNdoBv7gA2JrexSaoyFpcFQSIvg3Y8i5e+1YD3Z3VHz6H3bBAKYJ50XCi/ngpb7Ju6DF2fVyDJoJYMNgrOq72s8EtONGl7Smp7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795031412; c=relaxed/relaxed;
	bh=E4a1CfB+dLHAk/zicRP0eJek0KQqRlij9qTOmYyyyD0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLNnEBtn0cX/L4Wtw/OzPWlX482icudqq/IZAUvI7/ZKbviGQbBn2pN3O+UXXQjfOSyVAou60Yse+oTSJyUm8gGjNXq6gHW6BR/uHtCCu4bnBLqdY0SjqLsuGefalo7yyQm853fT6lOXP2qTk3lQ8+Sf5ujBRkWYV5x1f4JPkucHAt/+2HZ1HcIR4tPHLoLb5tJgxhN81viDQPJxIgs68bVmPdBu/fGXnY7AXkoLe2tN9beB7P5qZ1ApbQh4LMFY3lEtkYKRAPzlubAT4M5J0AUI7SybQ92dWOHp1TB/OWM2IqAVjMQMAAKnAUb99BDnU/IOZqmh7o8mYTXnx/PNLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a3jM4MpZ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a3jM4MpZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVByq06RZz2xSl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 06:50:10 +1100 (AEDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-c51239b0e3bso69801266b.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 11:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031407; x=1795636207; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E4a1CfB+dLHAk/zicRP0eJek0KQqRlij9qTOmYyyyD0=;
        b=a3jM4MpZD08Uuy/qLBe9GXe2oJXjM76UiXR2BNauUgyopRVt1SixigizoL0yB03CAx
         UvkGLifUDs6JRcg39iW+KGrV92AeZ0GohWNTBmfniuPketm4fo9cOt30Eq5qjKy0WFzz
         SY+zG/vjj/TOOBxZ3GXwThOXuFr6rMNQMFD8L/LojGPHiZ+iyI5rBeaXDHpTmXzAVnPF
         T/8LhXUCP8pvHuxtzZjVidPFJ+hYv6VaJNAzYG+1jYTdWKspxJh5dx5M1JenmydR1SPf
         0ovRq/Sbefd2g3748aRo6fVzL8TidvKPFfYQAH8sW+nqfrCzOvNsdvp2t18jcydyU5Yw
         Go6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031407; x=1795636207;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E4a1CfB+dLHAk/zicRP0eJek0KQqRlij9qTOmYyyyD0=;
        b=qApmyMoZJeeOxWzqC67Owl67okWfW6bcRDM2/X5BE4T2GM9LRL5Qzo8jUoVgcKGAZa
         zOSYn4Chd4cjWNi/Tk61KBxGWMEwkpJe+qPzTH14sGxG75OVtlyG1C3oCOOirP9xfLQw
         JDKHtiDL7La7C1avSrqS1PKRZFJSaGpzpCXL+Gzs26Ojj0xVgZU4yxhaQmfXro+NiQGd
         ZeqZedQ1efdp7/HLDDzF4cqUvr6ez6JpvhTmzuSqg4li4zd6824rTJOQPIfl7H55sgG7
         +jzfSnvg9ajiTFFLtaSZCVGPPMb8KU/LIkyH7cqxHqqkROuQY0iYf1bCfsMxXtJV0zJ0
         /kXw==
X-Forwarded-Encrypted: i=1; AL+hErHMkaSB+CSr1z5nq4s4tLbQgbBd6uCoKZ/JXFKZDZR7CkTm1aXZ9AfWaA1tYnaRIqjIs2VX0mF92KHW13E=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/g4x5KYQiz5VUNy1C8GWYxqithho4bFumAbWQSUzW7ck5mxiUz
	PNTKRGjhSm0MsWrah0JPludedqTnK/8O3ds1yLDAqFlBKpW0cDYGOfRE
X-Gm-Gg: AYBFou0zolVMULH7XFpJ1YZOedsjZA8Qlcq7qO/72EHGvHLQvRvt3yDxeeHwXA7xC1i
	OgoH+xqmtBXJAIVqb10MfR7cAYDX7ywX6Wq9zSMNBdVzdnReAVtKbq/fK8ahyyDxd6G8bWC2qyE
	nsMos98laX5uQIMa1GiTzRERORznaaQpofmmWV6c9R6tDtQd003lyksitev7X+wzTtAz2+nUYIO
	v6DzEZlaSttPwLYTJQvcKiIJgEkc/ipB2y/1cVoONzaRj9uH29hbrxY49C94o+hE4iiyzYHGHJo
	dEy55PdMPmFrF/CA1pGGWzA4C/HJdoy0Ea8xewSk0Q27BtQCYXNQqN8QDkW1LymPQJNlFMuG3Jn
	UN3zSgodPNpk6tYcluOC3N4WGorQYu/v4OK8fL82rJcC9+9sIA2dVfoBfX2DnbP02/F9QHryA8J
	RiBmnDrZM16iXzvUzPX7E9UFDQ0HUx9p5YixYVguTZkfEvHUiy2u4zaMlGMjjB6nNNfHN9R3eBI
	+X1x4ITZMs0Xa8vcoPdArJWyN9E2IdjmuRFauMAeO8g5d+d30Ea5Z45xVujrmII+hCFAg==
X-Received: by 2002:a17:907:9348:b0:c51:aa6:605a with SMTP id a640c23a62f3a-c510e1a6382mr365802366b.27.1795031407273;
        Wed, 18 Nov 2026 11:50:07 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c512341a3bdsm33510666b.32.2026.11.18.11.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:50:06 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 18 Nov 2026 20:50:04 +0100
To: Hao Ge <hao.ge@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: Re: [PATCH v5 06/11] mm/vmalloc: undo what vmap_page_range() mapped
 on failure
Message-ID: <av4BbLb6SxEcRe-8@milan>
References: <20261116071325.263682-1-hao.ge@linux.dev>
 <20261116071325.263682-7-hao.ge@linux.dev>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116071325.263682-7-hao.ge@linux.dev>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 03:13:20PM +0800, Hao Ge wrote:
> ioremap and arch setup code map their ranges with vmap_page_range().
> When the walk fails half way, or the KMSAN metadata fails after the
> walk, the ptes installed so far stay behind. The caller frees the
> vm_area on the error path, so the next mapping that lands on the same
> range trips the BUG() in vmap_pte_range().
> 
> vmap_range_noflush() now takes a mapped_end argument that the walk
> levels advance as they install, and vmap_pte_range() BUG()s before
> it installs over a pte that is already set. The ptes below mapped_end
> are therefore all ours, while a pte above it can only have been put
> there by somebody else, for example when the caller's range overlaps
> an existing mapping. On a walk failure the undo is limited to
> [addr, mapped_end), going further would clear ptes that are not
> ours. If the walk completed and only the KMSAN metadata failed, the
> whole range was installed by this call and all of it is undone.
> 
> All callers are sleepable, the teardown passes can_resched = true.
> 
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/vmalloc.c | 52 +++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d99d7710e1ba..5c1eacc2a0ac 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -117,7 +117,8 @@ static __always_inline unsigned long vmap_set_ptes(pte_t *ptep,
>  
>  static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  			phys_addr_t phys_addr, pgprot_t prot,
> -			unsigned int max_page_shift, pgtbl_mod_mask *mask)
> +			unsigned int max_page_shift, pgtbl_mod_mask *mask,
> +			unsigned long *mapped_end)
>  {
>  	pte_t *pte;
>  	u64 pfn;
> @@ -143,6 +144,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  
>  		size = vmap_set_ptes(pte, addr, end, pfn, prot, max_page_shift);
>  		nr_pages = PFN_DOWN(size);
> +		*mapped_end = addr + size;
>  	} while (pte += nr_pages, pfn += nr_pages, addr += size, addr != end);
>  
vmap_pte_range() either s=install everything or nothing. At least if i
do not miss anything.

--
Uladzislau Rezki

--
Uladzislau Rezki


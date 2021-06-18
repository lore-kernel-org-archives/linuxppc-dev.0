Return-Path: <SRS0=hJnm=LM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8293AC48BE8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 07:29:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B84F06112D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 07:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84F06112D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5rCD6jBJz3c58
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 17:29:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=HkAHlwQM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::52a;
 helo=mail-pg1-x52a.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=HkAHlwQM; dkim-atps=neutral
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5rBk27SBz2yjY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 17:28:44 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id t9so7073372pgn.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 00:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=O1VU0tYHxv24YrwsAsWYZ111zTRilkGpruVhUJhPf/o=;
 b=HkAHlwQMhlmKCvSQkIxz72o9rrZzCWQmX9UE/Dw7lC5p02YZPcFVqMxMdKOOzowDxk
 PXMhsjReVNCJRueQyIHLospkpIgnb1oKP+3xtJElgz3qFcw0TD8ME+GlyzQ+4bTQv63v
 hRAHhdGuTAv3PHOzI7KSDzGb0/LKvbVwXb+dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=O1VU0tYHxv24YrwsAsWYZ111zTRilkGpruVhUJhPf/o=;
 b=S9SjHYZrTBGopvd/8JtjhecPpygdgesbW4XSUGzRSzVmE3pwWsjT1abvPpStdZB38Q
 Ij0bVUhbfU6SqrF6rSOW2MkyidBF2JbDtIRATOiNU/YhYgn/BH/5MyNvblISd4gf7++x
 DftrKCw9x80jzSw5aEiTKgtKXO3kZbsAot/Mgk7puKna9fz7/1hNjdJGbb6+tZ98Dmux
 srpA3LKhZSwcqUAsHUdkvJFKwjNChaSTaLLLi8qwpIM3N8WdZeAUE4MPGU74Qov4MC9f
 VsuCMa0zaoPKSJfHd9nIOG5Dj/QwS8blikuMxn3tE4QVveptZ2lWzqRxYN34F35ukWEu
 CgwQ==
X-Gm-Message-State: AOAM532BmgbO3uxNxGmM/z7o3DKFOvalnp8BVcEkuyqci+7UtxPZapRR
 TJ7/tnUG46Vz0nJsgIhWKJWWuQ==
X-Google-Smtp-Source: ABdhPJypNzSzH7E1HLrQVw6+WgQZiip8Nlm0CV8eIL+F2C/IlelMaWlVvviGPoR1/U0d2aeCv7AluQ==
X-Received: by 2002:a63:5005:: with SMTP id e5mr8814792pgb.340.1624001320961; 
 Fri, 18 Jun 2021 00:28:40 -0700 (PDT)
Received: from localhost ([144.130.159.65])
 by smtp.gmail.com with ESMTPSA id t143sm8914718pgb.93.2021.06.18.00.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 00:28:40 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/4] powerpc/64s: Add DEBUG_PAGEALLOC for radix
In-Reply-To: <20210517061658.194708-2-jniethe5@gmail.com>
References: <20210517061658.194708-1-jniethe5@gmail.com>
 <20210517061658.194708-2-jniethe5@gmail.com>
Date: Fri, 18 Jun 2021 17:28:37 +1000
Message-ID: <87im2bskbe.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Jordan Niethe <jniethe5@gmail.com>, npiggin@gmail.com,
 aneesh.kumar@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jordan Niethe <jniethe5@gmail.com> writes:

> There is support for DEBUG_PAGEALLOC on hash but not on radix.
> Add support on radix.

Somewhat off-topic but I wonder at what point we can drop the weird !PPC
condition in mm/Kconfig.debug:

config DEBUG_PAGEALLOC
        bool "Debug page memory allocations"
        depends on DEBUG_KERNEL
        depends on !HIBERNATION || ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC

I can't figure out from git history why it exists or if it still serves
any function. Given that HIBERNATION isn't much use on Book3S systems it
probably never matters, it just bugs me a bit.

Again, nothing that has to block this series, just maybe something to
follow up at some vague and undefined point in the future!

> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index a666d561b44d..b89482aed82a 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -812,6 +822,15 @@ static inline bool check_pte_access(unsigned long access, unsigned long ptev)
>   * Generic functions with hash/radix callbacks
>   */
>  
> +#ifdef CONFIG_DEBUG_PAGEALLOC
> +static inline void __kernel_map_pages(struct page *page, int numpages, int enable)
> +{
> +	if (radix_enabled())
> +		radix__kernel_map_pages(page, numpages, enable);
> +	hash__kernel_map_pages(page, numpages, enable);


Does this require an else? On radix we will call both radix__ and
hash__kernel_map_pages.

I notice we call both hash__ and radix__ in map_kernel_page under radix,
so maybe this makes sense?

I don't fully understand the mechanism by which memory removal works: it
looks like on radix you mark the page as 'absent', which I think is
enough? Then you fall through to the hash code here:

	for (i = 0; i < numpages; i++, page++) {
		vaddr = (unsigned long)page_address(page);
		lmi = __pa(vaddr) >> PAGE_SHIFT;
		if (lmi >= linear_map_hash_count)
			continue;

I think linear_map_hash_count will be zero unless it gets inited to a
non-zero value in htab_initialize(). I am fairly sure htab_initialize()
doesn't get called for a radix MMU. In that case you'll just `continue;`
out of every iteration of the loop, which would explain why nothing
weird would happen on radix.

Have I missed something here?

The rest of the patch looks good to me.

Kind regards,
Daniel

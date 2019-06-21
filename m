Return-Path: <SRS0=Jsh9=UU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78382C43613
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2019 14:09:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD573215EA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2019 14:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aWygfjPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD573215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45VgXf29ppzDqdp
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Jun 2019 00:09:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ziepe.ca
 (client-ip=2607:f8b0:4864:20::841; helo=mail-qt1-x841.google.com;
 envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="aWygfjPx"; 
 dkim-atps=neutral
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45VgSp4kvgzDqVV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jun 2019 00:05:45 +1000 (AEST)
Received: by mail-qt1-x841.google.com with SMTP id m29so7044600qtu.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2019 07:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=DkOzjPryuxAAZ6jj5aW+vqBCJ/xdXKjWwEy6q7BhjEk=;
 b=aWygfjPxOlEI1tnMPH+ZEg4lwdm35MlZ9FC2Sv9mNYz1TXYg7zMy65oynguhqHPLHD
 5poTOWoehn2uMjooUllCl96WCJBItvfeaEybY0ihx7Fxw7kb42coN1wbRqEsylbfnfz5
 poQ9cLzRruP/gaTS5r2ivimvPxFxF10jIh6a1t8bY1c5/8nfCSLTPHFwmVvqBcrvoeSR
 IrRjd3ExmNKIoqdYb4sME5daBw+7RTgROqdSMT/mhe4d+vGey9AkE/rEcyeRljT6dNfy
 FwbLskfpDrkSyt1xncxh/ARyaZyhUUMnPNBaOl1L9cqI8FBxyq6cZOpH+4o3AamW6xDj
 GPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DkOzjPryuxAAZ6jj5aW+vqBCJ/xdXKjWwEy6q7BhjEk=;
 b=gmA5vcOCWikCN019NjRRMScFH6y57Ublgl2sHwhJTwVBVD3vK812MDyV4QkQvMSSir
 BV2auZIBJ3Mjcym6+luTDj0DWH3VNzFqvlIdbXQ/BTw2Kd045WOHffP+ZXYOsf1qoKCl
 Hu6+TkC6b9i1OoidIeqAMbqXyDDTOG6y59lDe/Ouz0uZ+cw1g/5YfKEsoxaqT7JDHVB9
 IgOZxvcPm9OePjuTWEaHS7NslqQF0CKGCdu6Es15NZ12TjACw6PkQhmYMWV74w37UI65
 uO86dKucBD13LIWuS9yCJ+YkgIn4QEf5n6Y6bIj0M1jgcUVmNecrb3GoOZ4S37Zf8XN+
 Ak8A==
X-Gm-Message-State: APjAAAUvriIaJaqagECgClyUq5LjySFXJSoHxRNdtKv1T04+GxJ554Wa
 IV518z7wQijPYr8u0U3Y+wmGoA==
X-Google-Smtp-Source: APXvYqzN1Bctip/8rcU9u7A4vdGN+f0/Jibs65Z8bT+DlW7GOUgigVYUV0gNRYHBistcmEEvwVki5g==
X-Received: by 2002:a0c:d610:: with SMTP id c16mr45427150qvj.22.1561125943463; 
 Fri, 21 Jun 2019 07:05:43 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.55.100])
 by smtp.gmail.com with ESMTPSA id i17sm1269594qkl.71.2019.06.21.07.05.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 21 Jun 2019 07:05:42 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1heKAg-0000Jr-7W; Fri, 21 Jun 2019 11:05:42 -0300
Date: Fri, 21 Jun 2019 11:05:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>, Kamal Dasu <kdasu.kdev@gmail.com>,
 Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 04/16] MIPS: use the generic get_user_pages_fast code
Message-ID: <20190621140542.GO19891@ziepe.ca>
References: <20190611144102.8848-1-hch@lst.de>
 <20190611144102.8848-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611144102.8848-5-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: x86@kernel.org, Rich Felker <dalias@libc.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
 James Hogan <jhogan@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Khalid Aziz <khalid.aziz@oracle.com>, Nicholas Piggin <npiggin@gmail.com>,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>,
 Andrey Konovalov <andreyknvl@google.com>, sparclinux@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 11, 2019 at 04:40:50PM +0200, Christoph Hellwig wrote:
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index 4ccb465ef3f2..7d27194e3b45 100644
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -20,6 +20,7 @@
>  #include <asm/cmpxchg.h>
>  #include <asm/io.h>
>  #include <asm/pgtable-bits.h>
> +#include <asm/cpu-features.h>
>  
>  struct mm_struct;
>  struct vm_area_struct;
> @@ -626,6 +627,8 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
>  
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> +#define gup_fast_permitted(start, end)	(!cpu_has_dc_aliases)
> +

Today this check is only being done on the get_user_pages_fast() -
after this patch it is also done for __get_user_pages_fast().

Which means __get_user_pages_fast is now non-functional on a range of
MIPS CPUs, but that seems OK as far as I can tell, so:

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

However, looks to me like this patch is also a bug fix for this:

commit 5b167c123b3c3582f62cf1896465019bc40fe526
Author: Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Fri Jun 14 17:10:03 2013 +0000

    MIPS: Fix get_user_page_fast() for mips with cache alias
    
    get_user_pages_fast() is missing cache flushes for MIPS platforms with
    cache aliases.  Filesystem failures observed with DirectIO operations due
    to missing flush_anon_page() that use page coloring logic to work with
    cache aliases. This fix falls through to take slow_irqon path that calls
    get_user_pages() that has required logic for platforms where
    cpu_has_dc_aliases is true.

> -	pgdp = pgd_offset(mm, addr);
> -	do {
> -		pgd_t pgd = *pgdp;
> -
> -		next = pgd_addr_end(addr, end);
> -		if (pgd_none(pgd))
> -			goto slow;
> -		if (!gup_pud_range(pgd, addr, next, gup_flags & FOLL_WRITE,
> -				   pages, &nr))

This is different too, the core code has a p4d layer, but I see that
whole thing gets NOP'd by the compiler as mips uses pgtable-nop4d.h -
right?

Jason

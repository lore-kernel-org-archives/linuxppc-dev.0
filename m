Return-Path: <linuxppc-dev+bounces-25788-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A190AC5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 05:45:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLDpy13YQz2y1Y;
	Thu, 13 Aug 2026 15:45:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786599930;
	cv=none; b=cT/+0O8U+/oFhM9S8DHVuFpHVpWMI4C/WcoPsOwTyYhKxteu8Mq1lKkbiR1nsh70K3qdIhMDq2w2PMCI7cjRc+/kBEp7xPTAol9QlHAvYLir8KfWjhFseD0YqQu3A0VYdn7tbMGsZq7IweiRytJA7Mj8+yNPFklgytORizQd6rq6z8imklI3WzYGOlI8XoYzizzJyBppv/8RB5bqq18WapiDFByvsxKlmNddTwIqeOzifdYrPz4m+xdmPXpOCexq9Y2LX4oXHC42KHWZMQgETzQhN/fnykrc8UB+dZc1Db1u5KwdyLvQUZEF6xX8gZY/Pm+weCVEJBBKJjv9Jv9SvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786599930; c=relaxed/relaxed;
	bh=PZARLK//mxzBm5+oVQwAyaOB1/sFHwMbhqQJ5pXDXaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVlzNBSgHeWf9XbH2/f5an45lrddA76LFY/9wZpH+8yjl5nfmL5dyrErDU94TykEFGQpx8QfeFUW3KlmNG9eKU6+krrCqcskxVX6jZ3EGlxj7Giy2AYvd2UyJwmLQaJBX18VlnGbe8RWAG/7ns5HiDP7CP9a9XwnSZYzCsJqXoQnIwsUhRwtqEEIzmW9hc1VNCDc+5Zj4sL1rNFfCzC22Utk75JhjvDwT31Z26z+maIl6njhE3y+8i9xQeOmnE2JCNfAHlAI1d5q9kbRVB/DtQ/rn6DO6kqxL6sNnd7IStSTgcB/Xt/EzvHEHaUvvwjcOdqlz89h4uZaXQKgvq0LpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=anxqrjk0; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=anxqrjk0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLDpt53PJz2y0B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 15:45:24 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 708381516;
	Wed, 12 Aug 2026 22:44:47 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A22393F673;
	Wed, 12 Aug 2026 22:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786599891; bh=CoIN6guADWC+zDyPfhFO/S+t2cXcLfG3khdmtOUCkug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=anxqrjk0iLjQHV3BgBtB7FofiyVfbzxU/TOQyrqfHVrE3KY34mv1wfvSAdfZk8k+b
	 NqfdwWG4Em+MP9I5C6wmSIbC3ZhVt828UvY5voXcU42QX/ayulcSospBc/5SlZ/BEt
	 dTzsVhGl1W0qDqm43doqgOf533QinHxqjz/j8G+o=
Date: Thu, 13 Aug 2026 11:14:48 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 4/6] sh/mm: Stop using [p4d|pud|pmd]_ERROR()
Message-ID: <3bruvrvxg5blgzuhqg2f27yvfjvvsycx6lmt3jcianvpuqcs5n@zdgzfhmmhvom>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
 <20260811042119.3652929-5-anshuman.khandual@arm.com>
 <94b52871-9cfc-42d6-b30f-545b722e71a0@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94b52871-9cfc-42d6-b30f-545b722e71a0@kernel.org>

On Wed, Aug 12, 2026 at 01:21:28PM +0200, David Hildenbrand (Arm) wrote:
> On 8/11/26 06:21, Anshuman Khandual wrote:
> > Stop using [p4d|pud|pmd]_ERROR() in __get_pte_phys() as the pgtable entries
> > are known to be NULL and hence could not really be accessed.
> > 
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Cc: Rich Felker <dalias@libc.org>
> > Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Cc: linux-sh@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> >  arch/sh/mm/init.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> > index b3c7fd84ceb4..0bb8555568a4 100644
> > --- a/arch/sh/mm/init.c
> > +++ b/arch/sh/mm/init.c
> > @@ -58,22 +58,16 @@ static pte_t *__get_pte_phys(unsigned long addr)
> >  	}
> >  
> >  	p4d = p4d_alloc(NULL, pgd, addr);
> > -	if (unlikely(!p4d)) {
> > -		p4d_ERROR(*p4d);
> > +	if (unlikely(!p4d))
> >  		return NULL;
> > -	}
> >  
> >  	pud = pud_alloc(NULL, p4d, addr);
> > -	if (unlikely(!pud)) {
> > -		pud_ERROR(*pud);
> > +	if (unlikely(!pud))
> >  		return NULL;
> > -	}
> >  
> >  	pmd = pmd_alloc(NULL, pud, addr);
> > -	if (unlikely(!pmd)) {
> > -		pmd_ERROR(*pmd);
> > +	if (unlikely(!pmd))
> >  		return NULL;
> > -	}
> >  
> >  	return pte_offset_kernel(pmd, addr);
> >  }
> 
> Do we want to print an error like "allocating p4d table failed"?

Sure, will add error prints like the following.

--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -56,16 +56,22 @@ static pte_t *__get_pte_phys(unsigned long addr)
                return NULL;

        p4d = p4d_alloc(NULL, pgd, addr);
-       if (unlikely(!p4d))
+       if (unlikely(!p4d)) {
+               pr_err("allocating p4d table failed\n");
                return NULL;
+       }

        pud = pud_alloc(NULL, p4d, addr);
-       if (unlikely(!pud))
+       if (unlikely(!pud)) {
+               pr_err("allocating pud table failed\n");
                return NULL;
+       }

        pmd = pmd_alloc(NULL, pud, addr);
-       if (unlikely(!pmd))
+       if (unlikely(!pmd)) {
+               pr_err("allocating pmd table failed\n");
                return NULL;
+       }

        return pte_offset_kernel(pmd, addr);
 }

> 
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> -- 
> Cheers,
> 
> David


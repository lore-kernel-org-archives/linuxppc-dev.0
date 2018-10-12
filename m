Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D1BC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 11:21:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3072077C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 11:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="qeudmJU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3072077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42WllV0rvxzF3Qm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 22:21:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="qeudmJU6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=shutemov.name
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=kirill@shutemov.name; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=shutemov-name.20150623.gappssmtp.com
 header.i=@shutemov-name.20150623.gappssmtp.com header.b="qeudmJU6"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WlTV5PwMzF3Rn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 22:09:14 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id r64-v6so6020224pfb.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 04:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=RX5FjI3wwkptc5sfX4+NkcctA+fCkcVF8HC/oTZQueA=;
 b=qeudmJU6+nqktNq8hagWevdDYJTTFMn+WENyVU02czllfS+fQup8X2aAcQtu2Lo0Fp
 dhBWK+IUAJCVJxMgLR2Q+5FdwzcoZDri19DNWDDMDN459vxsWd4gd90pvEzqmj7i/Fk+
 4GmiBbPPBQxYkEOU63G/QIHHt6iTrlm7BZWRGLnI42WPtnHHGUwiFQgxxz6a5lmwlVkh
 RLNcciTpu4deyuzzSogUrxoQpB41XxnBfDW3RTICetpaoKpeC37wL/mNktpm48Nj7dgI
 Xa/aCwwYycAOdNSNZVdcW5B/PKAoIddEyh93084VotBhdiNKJBPYH3SrKS+IeMKOkimb
 sY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RX5FjI3wwkptc5sfX4+NkcctA+fCkcVF8HC/oTZQueA=;
 b=OUXX9gB2NNzYUOrrxfQl2guoK01c5odyT77sXFE3nZknjNpuDoRNTlUqipykifGvH0
 atjULJubUIefpy5j+aduQyiBlwY7ScgebloUFol+S05oXEqrPNOo0KPZUMCAEj7+Y9ph
 e2BstI58m6meF7cnFmvF1Se/SzJPHuoDb6r7li/wnwwSwg51K+13dzLZrqfyHmkZGa8I
 qa+xi4lkFuawCCuKb5oecULoREvKQy3NF69DUOxDozg48n/1e58cw9/DcGaEZ9NggD66
 tntYUQzwHlPljS2ATuKTnA3zgmyj5KdDKyRSxXkGyFGvRfNzL1GZUUg9TwLUg+SU8NfT
 XawA==
X-Gm-Message-State: ABuFfohS92ZGY7PH7pqLKR24M6RREegZ1g3gQ3Nu4w6+21ajErP5jdXi
 Hd+UJ38mZVNA+QZJWfHKb6PHUA==
X-Google-Smtp-Source: ACcGV62AMJmSqYHUXksz43gsqwXiRDEZmpQoYbBa2QiJukAYc0ejyNX8clN1YjM/qERtSA9meBw2Jg==
X-Received: by 2002:a63:2356:: with SMTP id
 u22-v6mr5097385pgm.122.1539342552151; 
 Fri, 12 Oct 2018 04:09:12 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.42])
 by smtp.gmail.com with ESMTPSA id r18-v6sm1479496pgj.51.2018.10.12.04.09.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Oct 2018 04:09:10 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
 id B9B73300030; Fri, 12 Oct 2018 14:09:06 +0300 (+03)
Date: Fri, 12 Oct 2018 14:09:06 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
Message-ID: <20181012110906.fpfttp4nhvsr2ps7@kshutemo-mobl1>
References: <20181012013756.11285-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012013756.11285-1-joel@joelfernandes.org>
User-Agent: NeoMutt/20180716
X-Mailman-Approved-At: Fri, 12 Oct 2018 22:18:29 +1100
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
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>,
 linux-s390@vger.kernel.org, dancol@google.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 Fenghua Yu <fenghua.yu@intel.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, nios2-dev@lists.rocketboards.org,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>,
 Tony Luck <tony.luck@intel.com>, Richard Weinberger <richard@nod.at>,
 linux-parisc@vger.kernel.org, pantin@google.com,
 Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
 minchan@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 11, 2018 at 06:37:55PM -0700, Joel Fernandes (Google) wrote:
> diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
> index 12fe700632f4..4399d712f6db 100644
> --- a/arch/m68k/include/asm/mcf_pgalloc.h
> +++ b/arch/m68k/include/asm/mcf_pgalloc.h
> @@ -12,8 +12,7 @@ extern inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>  
>  extern const char bad_pmd_string[];
>  
> -extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -	unsigned long address)
> +extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>  {
>  	unsigned long page = __get_free_page(GFP_DMA);
>  
> @@ -32,8 +31,6 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
>  #define pmd_alloc_one_fast(mm, address) ({ BUG(); ((pmd_t *)1); })
>  #define pmd_alloc_one(mm, address)      ({ BUG(); ((pmd_t *)2); })
>  
> -#define pte_alloc_one_fast(mm, addr) pte_alloc_one(mm, addr)
> -

I believe this was one done manually, right?
Please explicitely state everthing you did on not of sematic patch

...

> diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/include/asm/pgalloc.h
> index 7c89390c0c13..f4cc9ffc449e 100644
> --- a/arch/microblaze/include/asm/pgalloc.h
> +++ b/arch/microblaze/include/asm/pgalloc.h
> @@ -108,10 +108,9 @@ static inline void free_pgd_slow(pgd_t *pgd)
>  #define pmd_alloc_one_fast(mm, address)	({ BUG(); ((pmd_t *)1); })
>  #define pmd_alloc_one(mm, address)	({ BUG(); ((pmd_t *)2); })
>  
> -extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
> +extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
>  
> -static inline struct page *pte_alloc_one(struct mm_struct *mm,
> -		unsigned long address)
> +static inline struct page *pte_alloc_one(struct mm_struct *mm)
>  {
>  	struct page *ptepage;
>  
> @@ -132,20 +131,6 @@ static inline struct page *pte_alloc_one(struct mm_struct *mm,
>  	return ptepage;
>  }
>  
> -static inline pte_t *pte_alloc_one_fast(struct mm_struct *mm,
> -		unsigned long address)
> -{
> -	unsigned long *ret;
> -
> -	ret = pte_quicklist;
> -	if (ret != NULL) {
> -		pte_quicklist = (unsigned long *)(*ret);
> -		ret[0] = 0;
> -		pgtable_cache_size--;
> -	}
> -	return (pte_t *)ret;
> -}
> -

Ditto.

-- 
 Kirill A. Shutemov

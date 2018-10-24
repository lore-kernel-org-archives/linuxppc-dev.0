Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AB5C004D3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 13:20:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0951920824
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 13:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxvOMkoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0951920824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42g9ql2sPPzDrMp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 00:20:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rxvOMkoP";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=bsingharora@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rxvOMkoP"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42g7zr374PzDrKW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 22:57:40 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id b11-v6so644369pfi.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 04:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=r4S1JZtjtEoZRmv1cmbD7oqQ5fBxxZJ0gckdgeOcI14=;
 b=rxvOMkoPR1fl+wChK1gmiyTy80jYizuSzzLNsN1UW/nn68lcvDelAzg7q5xRULAFwF
 88m9+eaacj9fu1oQRgbn9o9rL5OobsROYLsUPy8Jgnz+ao671RDA5Lk1ggZYlGqX9SbG
 9RUUixIOumM9W9fFeC11ng0GECm2HV0kpOJEacCyBhFOab2Q3i4VFHF0QbnxQWZzkmCY
 Lire1m9l7AF9VgUbUKgofuhPxpehLdKNOXRb6mUKntibxqs2pslottwNtAIjzUINJV13
 bV4f1WLD9yCA7Iyr+h+lgaNFbMHR6/U4tmHoxnhQ/7prUqBNDcYtn35v7xWxzF+rGnLI
 1zrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=r4S1JZtjtEoZRmv1cmbD7oqQ5fBxxZJ0gckdgeOcI14=;
 b=UKcUupGi1cRL2ivIzh5VwvUP62sSpeZRa1CIJmIKIYI0oN9HiAaryA00JweZw04nu0
 RLxWma/IXNeTVmEoiB+u7XHP8cUDOOusAorXVv8a5rXU4ZNhIJ6dGKOkhUXQ+aHVb5uV
 W3nzJAo3pwHVi3KBGPJim5T0RUopDSCydSiM5EA76x4drkSjWmaJ3lbZRNf/p5LonnZj
 ueqfBtUHpn/Wu+HD+51JsaPm8ys6i2/48apM89WfN5Gm7yMSl7/9gi8yN7oz1UJArYFw
 IfkJzu5l9CvKatnoYu+kb0YMVmRBSOJceSDDdnSgCw1BZVYiEsg3/DrmHfns55X211FK
 0bxQ==
X-Gm-Message-State: AGRZ1gKs9GMnDUqtB7VQZR7Re5IT/K6XqQJFf11x9JY+I6bgZUzvUTeQ
 ZEumK7D8Obs3xsKRHEOlHYM=
X-Google-Smtp-Source: AJdET5fJWm/yEunoAdHkJCNfHZyAKT69zWrP0KZ/06Nf8Zmi/6rvBn7LEzBt+uDaB55Nx51vc0n+3g==
X-Received: by 2002:a62:6383:: with SMTP id
 x125-v6mr2334785pfb.13.1540382257876; 
 Wed, 24 Oct 2018 04:57:37 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
 by smtp.gmail.com with ESMTPSA id
 t5-v6sm3677450pfm.26.2018.10.24.04.57.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 Oct 2018 04:57:36 -0700 (PDT)
Date: Wed, 24 Oct 2018 22:57:33 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v2)
Message-ID: <20181024115733.GN8537@350D>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Thu, 25 Oct 2018 00:18:02 +1100
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
 mhocko@kernel.org, linux-mm@kvack.org, lokeshgidra@google.com,
 "Joel Fernandes \(Google\)" <joel@joelfernandes.org>,
 linux-riscv@lists.infradead.org, elfring@users.sourceforge.net,
 Jonas Bonn <jonas@southpole.se>, kvmarm@lists.cs.columbia.edu,
 dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 kasan-dev@googlegroups.com, anton.ivanov@kot-begemot.co.uk,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 Fenghua Yu <fenghua.yu@intel.com>, linux-s390@vger.kernel.org,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 nios2-dev@lists.rocketboards.org, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, Chris Zankel <chris@zankel.net>,
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

On Wed, Oct 24, 2018 at 01:12:56PM +0300, Kirill A. Shutemov wrote:
> On Fri, Oct 12, 2018 at 06:31:58PM -0700, Joel Fernandes (Google) wrote:
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 9e68a02a52b1..2fd163cff406 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -191,6 +191,54 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
> >  		drop_rmap_locks(vma);
> >  }
> >  
> > +static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
> > +		  unsigned long new_addr, unsigned long old_end,
> > +		  pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
> > +{
> > +	spinlock_t *old_ptl, *new_ptl;
> > +	struct mm_struct *mm = vma->vm_mm;
> > +
> > +	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
> > +	    || old_end - old_addr < PMD_SIZE)
> > +		return false;
> > +
> > +	/*
> > +	 * The destination pmd shouldn't be established, free_pgtables()
> > +	 * should have release it.
> > +	 */
> > +	if (WARN_ON(!pmd_none(*new_pmd)))
> > +		return false;
> > +
> > +	/*
> > +	 * We don't have to worry about the ordering of src and dst
> > +	 * ptlocks because exclusive mmap_sem prevents deadlock.
> > +	 */
> > +	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
> > +	if (old_ptl) {
> 
> How can it ever be false?
> 
> > +		pmd_t pmd;
> > +
> > +		new_ptl = pmd_lockptr(mm, new_pmd);


Looks like this is largely inspired by move_huge_pmd(), I guess a lot of
the code applies, why not just reuse as much as possible? The same comments
w.r.t mmap_sem helping protect against lock order issues applies as well.

> > +		if (new_ptl != old_ptl)
> > +			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> > +
> > +		/* Clear the pmd */
> > +		pmd = *old_pmd;
> > +		pmd_clear(old_pmd);
> > +
> > +		VM_BUG_ON(!pmd_none(*new_pmd));
> > +
> > +		/* Set the new pmd */
> > +		set_pmd_at(mm, new_addr, new_pmd, pmd);
> > +		if (new_ptl != old_ptl)
> > +			spin_unlock(new_ptl);
> > +		spin_unlock(old_ptl);
> > +
> > +		*need_flush = true;
> > +		return true;
> > +	}
> > +	return false;
> > +}
> > +
> -- 
>  Kirill A. Shutemov
> 

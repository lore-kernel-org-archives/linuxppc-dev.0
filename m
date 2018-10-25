Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B6EC46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 13:52:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED7A2083E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 13:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LAnJhDOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED7A2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gpV62fkyzF37D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 00:52:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LAnJhDOq";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="LAnJhDOq"; dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gVtK2LSbzDrHF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 13:09:12 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id r64-v6so3365101pfb.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 19:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=G78I9uM4gXdiLalpqQZcUQ0k8S9gAvq6zBmyUxhGe0M=;
 b=LAnJhDOqLDe5rJ8W4SiC2EjUQZvQu/r5ZibVfgxKfT2epX8iHZwYQmEjB6a8btC1dW
 r6dDSvdCvkPgsk5m3K0hxUEc1ohpdLPr/504o7kJ7XSyqWkNXqLU77+seSO2HzOgNvQs
 hVyNi6MDrJlz77EflnU3vSDe0xbeuTe8cghrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=G78I9uM4gXdiLalpqQZcUQ0k8S9gAvq6zBmyUxhGe0M=;
 b=Lvpfk75n06K45R4jxAKp/LkUVY4ppQVCsLmIO0csqgOuSRzHATHof1dneHhSLkibYP
 /YamXGOjNh9N13q+VrkcowVOB2V3NYZ35YX/0cKgMcuKJGwSWVd9QIHDq5nKkNbArZE3
 hwOyUEjT8o3hEXoJWoDfKvSE6sdgRE+GrmLf/YHJWfkjrcX9Brbny5px8rqiDxpOtwmq
 TJN3Z1sMZ60z1xruan6zhyPGjTj54sJrsHLQhtZLz/7uf6Ft3WqiNiWO4j1VK5u5yxJK
 77EZ3nxzh2B+jzGeuT/F0cx1SZK2tQyqnpw62d2cRquwjhHrfljElHuAs5D/tQeEIhkv
 BMRg==
X-Gm-Message-State: AGRZ1gI9upU5Kv8qKEAVQ7T4toCq0Q9+stLdeKHvQjfmaF2a8Dax8nQw
 bi7dAt+Hccfxmay3wjiQy1OZSQ==
X-Google-Smtp-Source: AJdET5dUEfywPWvzS+489PJ55mfHZNUk9qKPmDa0EsEQ3lYTg7j+ER6qGO2BektCxwt9F6U/VdSRSA==
X-Received: by 2002:aa7:814f:: with SMTP id
 d15-v6mr5054081pfn.78.1540433350578; 
 Wed, 24 Oct 2018 19:09:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
 by smtp.gmail.com with ESMTPSA id 68-v6sm6748192pfg.136.2018.10.24.19.09.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 Oct 2018 19:09:08 -0700 (PDT)
Date: Wed, 24 Oct 2018 19:09:07 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v2)
Message-ID: <20181025020907.GA13560@joelaf.mtv.corp.google.com>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
 <20181024115733.GN8537@350D>
 <20181024125724.yf6frdimjulf35do@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024125724.yf6frdimjulf35do@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Fri, 26 Oct 2018 00:50:26 +1100
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
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>,
 kvmarm@lists.cs.columbia.edu, dancol@google.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org,
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

On Wed, Oct 24, 2018 at 03:57:24PM +0300, Kirill A. Shutemov wrote:
> On Wed, Oct 24, 2018 at 10:57:33PM +1100, Balbir Singh wrote:
> > On Wed, Oct 24, 2018 at 01:12:56PM +0300, Kirill A. Shutemov wrote:
> > > On Fri, Oct 12, 2018 at 06:31:58PM -0700, Joel Fernandes (Google) wrote:
> > > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > > index 9e68a02a52b1..2fd163cff406 100644
> > > > --- a/mm/mremap.c
> > > > +++ b/mm/mremap.c
> > > > @@ -191,6 +191,54 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
> > > >  		drop_rmap_locks(vma);
> > > >  }
> > > >  
> > > > +static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
> > > > +		  unsigned long new_addr, unsigned long old_end,
> > > > +		  pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
> > > > +{
> > > > +	spinlock_t *old_ptl, *new_ptl;
> > > > +	struct mm_struct *mm = vma->vm_mm;
> > > > +
> > > > +	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
> > > > +	    || old_end - old_addr < PMD_SIZE)
> > > > +		return false;
> > > > +
> > > > +	/*
> > > > +	 * The destination pmd shouldn't be established, free_pgtables()
> > > > +	 * should have release it.
> > > > +	 */
> > > > +	if (WARN_ON(!pmd_none(*new_pmd)))
> > > > +		return false;
> > > > +
> > > > +	/*
> > > > +	 * We don't have to worry about the ordering of src and dst
> > > > +	 * ptlocks because exclusive mmap_sem prevents deadlock.
> > > > +	 */
> > > > +	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
> > > > +	if (old_ptl) {
> > > 
> > > How can it ever be false?

Kirill,
It cannot, you are right. I'll remove the test.

By the way, there are new changes upstream by Linus which flush the TLB
before releasing the ptlock instead of after. I'm guessing that patch came
about because of reviews of this patch and someone spotted an issue in the
existing code :)

Anyway the patch in concern is:
eb66ae030829 ("mremap: properly flush TLB before releasing the page")

I need to rebase on top of that with appropriate modifications, but I worry
that this patch will slow down performance since we have to flush at every
PMD/PTE move before releasing the ptlock. Where as with my patch, the
intention is to flush only at once in the end of move_page_tables. When I
tried to flush TLB on every PMD move, it was quite slow on my arm64 device [2].

Further observation [1] is, it seems like the move_huge_pmds and move_ptes code
is a bit sub optimal in the sense, we are acquiring and releasing the same
ptlock for a bunch of PMDs if the said PMDs are on the same page-table page
right? Instead we can do better by acquiring and release the ptlock less
often.

I think this observation [1] and the frequent TLB flush issue [2] can be solved
by acquiring the ptlock once for a bunch of PMDs, move them all, then flush
the tlb and then release the ptlock, and then proceed to doing the same thing
for the PMDs in the next page-table page. What do you think?

- Joel


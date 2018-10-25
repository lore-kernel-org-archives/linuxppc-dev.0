Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4DBC46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 13:59:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8172075D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 13:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="bXy1o7gB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8172075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gpfG4ghzzF3CG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 00:59:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="bXy1o7gB";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=shutemov.name
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=kirill@shutemov.name; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=shutemov-name.20150623.gappssmtp.com
 header.i=@shutemov-name.20150623.gappssmtp.com header.b="bXy1o7gB"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gjtm6SNhzDrPm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 21:25:19 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id b11-v6so2291148pfi.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 03:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=NN9j8rpITBLmXn0s4bCI/Rhv1UTafbrEZVV+5fg1umY=;
 b=bXy1o7gBqEG05Ywgx9/FrojpzTDhWv0EkEXVi0IVnfJNaXyjBAccGyM9GDwNX/9AO5
 5c3353pMwtFoNPHIz1yi0K7TGWwx5F/cf9+vXWAf6emqwwhT2O0UVxm/EYw4K9od7nUp
 kQJJB/ZD8mVABPMc8/eZG5E3FsU/2f1/34566e+LfSLfvNFQxYaUmReyfpQf6+h+nd9N
 DS2otEO8dvj8DjqaiAMoMtmDiCF3R7gg+N70qTfvna2jTzoi4pGKqKOZXdviecnoqgKO
 ckfGiAGunlFPSXWlqRRH/J1tdarE+zwuAL8bCT4RZVOrp42w0RyNPc72HtdsyY/ZvYBF
 iZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NN9j8rpITBLmXn0s4bCI/Rhv1UTafbrEZVV+5fg1umY=;
 b=DnBkfFAHlJ+VZxWqSBpH1nUs7ZqVVXbz6iPsXam46wPB6uzVh6JRu9Bg/c26VxoSCm
 RhyGCyOTdBo6PWUyNeWOIKOFAKIKG825Lq25s0O59qWKc/noTcTx0y98Hy8VsSeipChZ
 BgrPXVkW+/tqtNdq020RgvVuy4RT4oykmGP93OScCMYHJpOXuJw4Qc15dpMqVk/XAyCZ
 9U1Qowc+ZHOpjiYRLu+Gu6q+TWi3mSTOnvyCIwNdPONqYS0o65jG0zwRRJ8jd2YHF8lQ
 x9cPe8CcpbPo2BJ+OtkPBzfhZxMGbv/921lkX64on+vwrRVQK5SODQKMi39SUJ9L+NN0
 eZ7w==
X-Gm-Message-State: AGRZ1gK1z3tYlk9jfL6mXbWjNLhQfdUw9ejJeBerGQunm94zvYT0Tf8N
 vH7YCJZtRTNnarUwO3wCPCSI9w==
X-Google-Smtp-Source: AJdET5ddcNEf3GxIvgmksgLUNAlw5ZNsWaLvtabg1u62mstKpdrWr9kG4myQ0Z6ADq9hZPo9K2gwxA==
X-Received: by 2002:a62:8dcd:: with SMTP id
 p74-v6mr966898pfk.217.1540463117240; 
 Thu, 25 Oct 2018 03:25:17 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.41])
 by smtp.gmail.com with ESMTPSA id h5-v6sm9026081pgh.42.2018.10.25.03.25.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Oct 2018 03:25:16 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
 id 756F2300225; Thu, 25 Oct 2018 13:19:00 +0300 (+03)
Date: Thu, 25 Oct 2018 13:19:00 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v2)
Message-ID: <20181025101900.phqnqpoju5t2gar5@kshutemo-mobl1>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
 <20181024115733.GN8537@350D>
 <20181024125724.yf6frdimjulf35do@kshutemo-mobl1>
 <20181025020907.GA13560@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025020907.GA13560@joelaf.mtv.corp.google.com>
User-Agent: NeoMutt/20180716
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

On Wed, Oct 24, 2018 at 07:09:07PM -0700, Joel Fernandes wrote:
> On Wed, Oct 24, 2018 at 03:57:24PM +0300, Kirill A. Shutemov wrote:
> > On Wed, Oct 24, 2018 at 10:57:33PM +1100, Balbir Singh wrote:
> > > On Wed, Oct 24, 2018 at 01:12:56PM +0300, Kirill A. Shutemov wrote:
> > > > On Fri, Oct 12, 2018 at 06:31:58PM -0700, Joel Fernandes (Google) wrote:
> > > > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > > > index 9e68a02a52b1..2fd163cff406 100644
> > > > > --- a/mm/mremap.c
> > > > > +++ b/mm/mremap.c
> > > > > @@ -191,6 +191,54 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
> > > > >  		drop_rmap_locks(vma);
> > > > >  }
> > > > >  
> > > > > +static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
> > > > > +		  unsigned long new_addr, unsigned long old_end,
> > > > > +		  pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
> > > > > +{
> > > > > +	spinlock_t *old_ptl, *new_ptl;
> > > > > +	struct mm_struct *mm = vma->vm_mm;
> > > > > +
> > > > > +	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
> > > > > +	    || old_end - old_addr < PMD_SIZE)
> > > > > +		return false;
> > > > > +
> > > > > +	/*
> > > > > +	 * The destination pmd shouldn't be established, free_pgtables()
> > > > > +	 * should have release it.
> > > > > +	 */
> > > > > +	if (WARN_ON(!pmd_none(*new_pmd)))
> > > > > +		return false;
> > > > > +
> > > > > +	/*
> > > > > +	 * We don't have to worry about the ordering of src and dst
> > > > > +	 * ptlocks because exclusive mmap_sem prevents deadlock.
> > > > > +	 */
> > > > > +	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
> > > > > +	if (old_ptl) {
> > > > 
> > > > How can it ever be false?
> 
> Kirill,
> It cannot, you are right. I'll remove the test.
> 
> By the way, there are new changes upstream by Linus which flush the TLB
> before releasing the ptlock instead of after. I'm guessing that patch came
> about because of reviews of this patch and someone spotted an issue in the
> existing code :)
> 
> Anyway the patch in concern is:
> eb66ae030829 ("mremap: properly flush TLB before releasing the page")
> 
> I need to rebase on top of that with appropriate modifications, but I worry
> that this patch will slow down performance since we have to flush at every
> PMD/PTE move before releasing the ptlock. Where as with my patch, the
> intention is to flush only at once in the end of move_page_tables. When I
> tried to flush TLB on every PMD move, it was quite slow on my arm64 device [2].
> 
> Further observation [1] is, it seems like the move_huge_pmds and move_ptes code
> is a bit sub optimal in the sense, we are acquiring and releasing the same
> ptlock for a bunch of PMDs if the said PMDs are on the same page-table page
> right? Instead we can do better by acquiring and release the ptlock less
> often.
> 
> I think this observation [1] and the frequent TLB flush issue [2] can be solved
> by acquiring the ptlock once for a bunch of PMDs, move them all, then flush
> the tlb and then release the ptlock, and then proceed to doing the same thing
> for the PMDs in the next page-table page. What do you think?

Yeah, that's viable optimization.

The tricky part is that one PMD page table can have PMD entires of
different types: THP, page table that you can move as whole and the one
that you cannot (for any reason).

If we cannot move the PMD entry as a whole and must go to PTE page table
we would need to drop PMD ptl and take PTE ptl (it might be the same lock
in some configuations).

Also we don't want to take PMD lock unless it's required.

I expect it to be not very trivial to get everything right. But take a
shot :)

-- 
 Kirill A. Shutemov

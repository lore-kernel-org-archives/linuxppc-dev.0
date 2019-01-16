Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B127CC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 14:34:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B29D20675
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 14:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="umaZGSlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B29D20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fqVJ0Vf3zDqMv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 01:34:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="umaZGSlS"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fq9s1plHzDqGT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 01:20:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SOzqtRQnhrzBV/2kqoR/jW1DTahkUHWwkEGG0EIDlt8=; b=umaZGSlS/Mx6cAOQCY2BhcS56F
 JTft6i3pABnXS+1yEzVxc6J/HnMUqGhP0z1/U/ELpC9SPiGJZcpycToje9yk1SCtTpJbuIjaAZfmP
 9hgJTa4oK7erwr+7pkqsEdHsRPFYxHJAVeOHEDkR3daRz6oJ+hfPDRkmAFSHXgwkYW03JUr4iiiII
 pwe6c5cQNXDArfmTdHshCR5u/eyVvFEO+8x+kCLvbRtYRUabVSSELftUY6vgPIKuKwP7gszL4UsYi
 SgiqQeZoXMooGlZZ0v46pl3O6+uIH4DVqAg7COtrdlYJg5fVyENBSsXIpN1paT+qMmm9LyeLLhLV1
 yd5Thhxg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gjm3C-0006U0-M1; Wed, 16 Jan 2019 14:20:14 +0000
Date: Wed, 16 Jan 2019 06:20:14 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH V2] mm: Introduce GFP_PGTABLE
Message-ID: <20190116142014.GJ6310@bombadil.infradead.org>
References: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com>
 <20190116065703.GE24149@dhcp22.suse.cz>
 <20190116123018.GF6310@bombadil.infradead.org>
 <07d6a264-dccd-78ab-e8a9-2410bbef7b97@arm.com>
 <20190116131827.GH6310@bombadil.infradead.org>
 <521d8511-4c87-49c6-de03-67a71d5bacca@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <521d8511-4c87-49c6-de03-67a71d5bacca@c-s.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: mark.rutland@arm.com, christoffer.dall@arm.com, linux-sh@vger.kernel.org,
 peterz@infradead.org, catalin.marinas@arm.com, palmer@sifive.com,
 will.deacon@arm.com, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 aneesh.kumar@linux.ibm.com, greentime@andestech.com, linux@armlinux.org.uk,
 mingo@redhat.com, linux-arm-kernel@lists.infradead.org, rientjes@google.com,
 dave.hansen@linux.intel.com, Anshuman Khandual <anshuman.khandual@arm.com>,
 marc.zyngier@arm.com, rppt@linux.vnet.ibm.com, shakeelb@google.com,
 kirill@shutemov.name, tglx@linutronix.de, vbabka@suse.cz,
 ard.biesheuvel@linaro.org, linuxppc-dev@lists.ozlabs.org, steve.capper@arm.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com, akpm@linux-foundation.org,
 robin.murphy@arm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 16, 2019 at 02:47:16PM +0100, Christophe Leroy wrote:
> Le 16/01/2019 à 14:18, Matthew Wilcox a écrit :
> > I disagree with your objective.  Making more code common is a great idea,
> > but this patch is too unambitious.  We should be heading towards one or
> > two page table allocation functions instead of having every architecture do
> > its own thing.
> > 
> > So start there.  Move the x86 function into common code and convert one
> > other architecture to use it too.
> 
> Are we talking about pte_alloc_one_kernel() and pte_alloc_one() ?
> 
> I'm not sure x86 function is the best common one, as it seems to allocate a
> multiple of PAGE_SIZE only.

And that's the common case.  Most architectures use a single page for at
least one level of the pte/pmd/pud/p4d/pgd hierarchy.  Some use multiple
pages and some use a fraction of a page.

> Some arches like powerpc use pagetables which are smaller than a page, for
> instance powerpc 8xx uses 4k pagetables even with 16k pages, which means a
> single page can be used by 4 pagetables.

Those can be added later.  Note I said "one or two", and that's what I
had in mind; I think we want one function that allocates just a page
and another that allocates a page fragment.  Then we can have a good
discussion about what method we use; s390 and ppc use different techniques
today and there's really no good reason for that.

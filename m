Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3984FC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 07:03:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670C120660
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 07:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670C120660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dPZc2SXwzDqSS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 18:03:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=mhocko@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dPXT44yGzDqQh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 18:01:45 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4F069AE72;
 Mon, 14 Jan 2019 07:01:41 +0000 (UTC)
Date: Mon, 14 Jan 2019 08:01:37 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
Message-ID: <20190114070137.GB21345@dhcp22.suse.cz>
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190113173555.GC1578@dhcp22.suse.cz>
 <f9f333a5-5533-996a-dc8e-1ff1096c1d19@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9f333a5-5533-996a-dc8e-1ff1096c1d19@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: mark.rutland@arm.com, linux-sh@vger.kernel.org, peterz@infradead.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kvmarm@lists.cs.columbia.edu,
 linux@armlinux.org.uk, mingo@redhat.com, vbabka@suse.cz, rientjes@google.com,
 marc.zyngier@arm.com, rppt@linux.vnet.ibm.com, shakeelb@google.com,
 kirill@shutemov.name, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org, robin.murphy@arm.com, steve.capper@arm.com,
 christoffer.dall@arm.com, james.morse@arm.com, aneesh.kumar@linux.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon 14-01-19 09:30:55, Anshuman Khandual wrote:
> 
> 
> On 01/13/2019 11:05 PM, Michal Hocko wrote:
> > On Sat 12-01-19 15:56:38, Anshuman Khandual wrote:
> >> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
> >> __GFP_ZERO) and using it for allocating page table pages. This causes some
> >> code duplication which can be easily avoided. GFP_KERNEL allocated and
> >> cleared out pages (__GFP_ZERO) are required for page tables on any given
> >> architecture. This creates a new generic GFP flag flag which can be used
> >> for any page table page allocation. Does not cause any functional change.
> > 
> > I agree that some unification is due but GFP_PGTABLE is not something to
> > expose in generic gfp.h IMHO. It just risks an abuse. I would be looking
> 
> Why would you think that it risks an abuse ? It does not create new semantics
> of allocation in the buddy. Its just uses existing GFP_KERNEL allocation which
> is then getting zeroed out. The risks (if any) is exactly same as GFP_KERNEL.

Beucase my experience just tells me that people tend to use whatever
they find and name fits what they think they need.

> > at providing asm-generic implementation and reuse it to remove the code
> 
> Does that mean GFP_PGTABLE can be created but not in gfp.h but in some other
> memory related header file ?

I would just keep it close to its users. If that is a single arch
generic place then only better. But I suspect some arches have special
requirements.

> > duplication. But I haven't tried that to know that it will work out due
> > to small/subtle differences between arches.
> 
> IIUC from the allocation perspective GFP_ACCOUNT is the only thing which gets
> added with GFP_PGTABLE for user page table for memcg accounting purpose. There
> does not seem to be any other differences unless I am missing something.

It's been some time since I've checked the last time. Some arches were
using GPF_REPEAT (__GFP_RETRY_MAYFAIL) back then. I have removed most of
those but some were doing a higher order allocations so they probably
have stayed.
-- 
Michal Hocko
SUSE Labs

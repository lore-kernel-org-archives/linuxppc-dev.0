Return-Path: <linuxppc-dev+bounces-24831-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3E9C531D0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2026 19:21:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6vps2XW6z2yFg;
	Sun, 26 Jul 2026 05:21:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785001122;
	cv=none; b=cAJSbZk23UZlIvZJNUA4hezFgIefYK3PUe1w3Pc0BdaJa85N20eCAtTS8FxPtz/VHcpvxEqS49dKAoK1h1/qcPaODjPsMyXB0bgIMHBhAibngKnrJGjq1lNcl+Effl5MITdhKejVOoLlqOB3rU7lNZYxBCqJ2RMbvyNEi4OQT8IldIiiEcabHEoaLITcipzvPagleyh07wBtRVQ3meOgruum9efcj4kGn2skzcW4dWlxJFKCKHA8JR0O7OofcEWFuQphq2fyfMCHns2qSUd0KJataQqAVN3ogacc7XUQQaB1XfRsgLV46/6tNibel08oLQiEImWzV12npv2QnKbkjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785001122; c=relaxed/relaxed;
	bh=QylY0Jj+M9aiGs5V5SL5IjP/iHtiFsye8Zowe/lAKfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hm3/RCoEnBrsixhnb3kcXLisgo9om0QcVNbs2tAOlCJsVrIo63JN9NRez+z3RQsw1gFMLSmDXV6/YHlKAJ5Lpy3QOb3aPkSd4xkTgxhpcRDF5Sf49WYENwaKlV1uSqoGpYpOabbO3x4fVgCNNmUkOttt7Eo13e0IX8StMc6IAEUfik35N8Dzb8BRLeIPcIF++qHjpVXxQ+MOkefcMDjuou1DyLjuit5aurDvAA2zslt8wfFbPghtzDqE6Z41WAdpkKLg6d5DJkIOQTEFVMsmGGQvTDSBVjpSdREPP819A3VL2q2BJ7oZy1sjJXUYkuKMRA4k89dJf1f1G9g6p0CToA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hbLGkWpN; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=deller@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hbLGkWpN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=deller@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6sXd1xYXz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 03:38:41 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1D17243C37;
	Sat, 25 Jul 2026 17:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C003D1F000E9;
	Sat, 25 Jul 2026 17:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785001112;
	bh=QylY0Jj+M9aiGs5V5SL5IjP/iHtiFsye8Zowe/lAKfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hbLGkWpNrMM4k73a7LkMKOLXC3oYWnMbIQUTX9a1AMPyP+ZB2YtDGSKAOO7LnRTqG
	 vBTBVOyCfgkBM0MWbOb/NoVC5YN9xSGoda6NWf0PzmMOT1fw/XOO6vHcoZm2T9Hnp5
	 55ibAzms1bMqsEcamK0sa477Sp/cRJs/DtF2sButDQG4u1jm7nFthZJfCS76oVES0q
	 WsTkfomIff31rzlYsktIJhBXeK7omGcTHPA60jUlZ+1E5GFmI8FYxCp3658BnzoxL3
	 TPxHPEdFzInIhLMkWjbdj7ZY/o7vUtkGVxUVFRul5xDUBZdBWJw09bqSEyMu0nLWef
	 YF/1c7ceJP17Q==
Date: Sat, 25 Jul 2026 19:38:23 +0200
From: Helge Deller <deller@kernel.org>
To: John David Anglin <dave.anglin@bell.net>,
	Usama Arif <usama.arif@linux.dev>
Cc: Helge Deller <deller@gmx.de>, Pedro Falcato <pfalcato@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm/parisc: constify ptep_get() argument
Message-ID: <amT0j_bBT3CCxPcg@p100>
References: <20260724102017.141532-1-pfalcato@suse.de>
 <20260724102017.141532-4-pfalcato@suse.de>
 <0fd713a8-e4ab-4c07-b36e-79dd138b4a86@linux.dev>
 <amNzLXuwflIZFKtI@casper.infradead.org>
 <253f7ac0-205b-42f1-9fb5-d19eceb581b6@linux.dev>
 <amOEUZlp1BxYh6_t@pedro-suse>
 <fd239383-dcbe-4daf-b337-32facef07076@linux.dev>
 <3e9dece8-4e86-4ce5-bd74-b3ec305f3003@gmx.de>
 <4606e13f-6827-45d0-b3b8-6bc26358f7ae@bell.net>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4606e13f-6827-45d0-b3b8-6bc26358f7ae@bell.net>

* John David Anglin <dave.anglin@bell.net>:
> On 2026-07-25 12:27 p.m., Helge Deller wrote:
> > On 7/24/26 17:48, Usama Arif wrote:
> >>
> >>
> >> On 24/07/2026 16:32, Pedro Falcato wrote:
> >>> On Fri, Jul 24, 2026 at 04:03:44PM +0100, Usama Arif wrote:
> >>>>
> >>>>
> >>>> On 24/07/2026 15:14, Matthew Wilcox wrote:
> >>>>> On Fri, Jul 24, 2026 at 02:36:59PM +0100, Usama Arif wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 24/07/2026 11:20, Pedro Falcato wrote:
> >>>>>>> ptep_get() does not need write access to the PTE.
> >>>>>>>
> >>>>>>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> >>>>>>> ---
> >>>>>>>   arch/parisc/include/asm/pgtable.h | 2 +-
> >>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>>
> >>>>>> hmm I think you might break build bisectibility if
> >>>>>> you separate out the patches, you should squash patch 3 and 4,
> >>>>>> with patch 1.
> >>>>>
> >>>>> I don't see how this breaks bisectability.  Can you elaborate on what
> >>>>> you think would break?
> >>>>
> >>>> Patch 1 does:
> >>>>
> >>>> -static inline pte_t ptep_get_lockless(pte_t *ptep)
> >>>> +static inline pte_t ptep_get_lockless(const pte_t *ptep)
> >>>>   {
> >>>>       return ptep_get(ptep);
> >>>>   }
> >>>>
> >>>>
> >>>> ptep_get() takes a non-const arg till patch 3 for example for parsic.
> >>>> I don't think you can pass a const variable to non const function arg?
> >>>>
> >>>> So parsic won't compile in patch 1 and 2, powerprc wont compile
> >>>> for patches 1, 2 and 3..
> >>>
> >>> Aha, yes, nice catch! I'll have to rethink that. Maybe squashing the patches
> >>> would be the cleanest way forward.
> >>>
> >>
> >> Yes, squashing is the simplest way forward.
> >>
> >>> FWIW, the vast majority of architectures aren't doing funny things on
> >>> ptep_get(). E.g PA-RISC, loongarch only define these so they can use it in
> >>> their own asm/pgtable.h. I'd really like to delete these but I can't tell
> >>> if they are *actually* required.
> >>>
> >>
> >> Ah maybe there is something in git history on why it was needed?
> >>
> >> If not, hopefully someone from the arch lists could clarify..
> > I tried to remove ptep_get() and ptep_test_and_clear_young() from
> > arch/parisc/include/asm/pgtable.h, but this then triggers compile errors:
> > 
> >  CC      arch/parisc/kernel/asm-offsets.s
> > In file included from /home/cvs/parisc/git-kernel/linus-linux-2.6/include/linux/mm.h:31,
> >                  from /home/cvs/parisc/git-kernel/linus-linux-2.6/include/linux/pid_namespace.h:7,
> >                  from /home/cvs/parisc/git-kernel/linus-linux-2.6/include/linux/ptrace.h:10,
> >                  from /home/cvs/parisc/git-kernel/linus-linux-2.6/arch/parisc/kernel/asm-offsets.c:21:
> > /home/cvs/parisc/git-kernel/linus-linux-2.6/include/linux/pgtable.h: In function ‘clear_young_dirty_ptes’:
> > /home/cvs/parisc/git-kernel/linus-linux-2.6/include/linux/pgtable.h:683:25: error: implicit declaration of function ‘ptep_test_and_clear_young’;
> > did you mean ‘pmdp_test_and_clear_young’? [-Wimplicit-function-declaration]
> >   683 |                         ptep_test_and_clear_young(vma, addr, ptep);
> >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> >       |                         pmdp_test_and_clear_young
> > 
> > So, I think the answer is, that the local copy of ptep_get() is used in the parisc implementation of
> > ptep_test_and_clear_young() function.
> > 
> > Switching to the default include/linux/pgtable.h seems not easy doable....
> 
> Did you remove define for __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG in parisc version of pgtable.h?

Indeed, I missed to remove that.

Usama, if you want you can add the patch below to your patch set, thus
simplifying your series?

Helge

------

From: Helge Deller <deller@gmx.de>
Date: Sat, 25 Jul 2026 19:19:55 +0200
Subject: [PATCH] parisc: Drop own implementations for ptep_get() and
 ptep_test_and_clear_young()

Switch to the generic implementations, which are identical.

Suggested-by: Usama Arif <usama.arif@linux.dev>
Suggested-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 467b8547ac8b..d92dee9fef3f 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -432,25 +432,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 	return pte;
 }
 
-static inline pte_t ptep_get(pte_t *ptep)
-{
-	return READ_ONCE(*ptep);
-}
-#define ptep_get ptep_get
-
-static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *ptep)
-{
-	pte_t pte;
-
-	pte = ptep_get(ptep);
-	if (!pte_young(pte)) {
-		return false;
-	}
-	set_pte_at(vma->vm_mm, addr, ptep, pte_mkold(pte));
-	return true;
-}
-
 bool ptep_clear_flush_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
 pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
 
@@ -491,7 +472,6 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT


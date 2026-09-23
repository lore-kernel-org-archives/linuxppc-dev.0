Return-Path: <linuxppc-dev+bounces-27987-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA530C9830B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 08:16:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqVD76k3Qz2yqq;
	Wed, 23 Sep 2026 18:16:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790151383;
	cv=none; b=NJmjW6Lm47YruRSXQnra4rHJg34WoS+GNZxeZWlpRm6PUqiALqoB6v7gbqYFnuOthQWw6Xp0B/MrzOS8NPY5b1BegPK7murIwDhyYixkT3bPTmy5sqH3fLfPSgZMTPJyWVK1uVffns3ukTlv3ZRRBAp3KjDyl7CmAarzNLGaCi9lrkaBZ2iEAcfuGAC/2Ts+Zv6v/vWQDTIiKcDKk6mfPucYYsas8nAQnHIX8OtgsVu54C+BVz3kMftUDFwNYyt8bW2H1yQTMbfSco6SYu923AEFS//p41XJqRwMhVqoGht1UFO3E36gLPPXJSg7lHzLpEz1F8rgG1NeNl0Idvah4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790151383; c=relaxed/relaxed;
	bh=gkbaaSNAYtW2x8Ye+X/x3ROsO8U5+sLZrnhf7gfW0AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS0wHdxWqhka1ItTOyG/dKQgENVR26dabkf+J53ZGWRAPDGkP1DJTunXQTt4pa7pHIvBho4ylcpK4J3LehlobXTLFP1mu92+KgnyFZMP1gJZsG2JIyy9z5XLfOSUjazjGCnoEmZqpUFYZ+cSSxGNCbOJ8Tt33G/X6pR6eF55lGqkYxpF7itorn8bK/qyXDlvKzCSQdZPUsfRHyubwbY+z1uZwK1M1qbcJN3LTvZQTrPh9L38LkA4hhrG3c/apf4HFjXJ1fPBK8vaX7rbmI58ORDJLW2QbaIWtq70aIYInsXkJ0GSdlmBSi4hQeV2JS4/f6Sr5MMq+diS+xugATNSKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWzv7yYP; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWzv7yYP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqVD67100z2yqL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 18:16:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0AFFD42003;
	Wed, 23 Sep 2026 08:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFAF1F000FF;
	Wed, 23 Sep 2026 08:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790151380;
	bh=gkbaaSNAYtW2x8Ye+X/x3ROsO8U5+sLZrnhf7gfW0AU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XWzv7yYPoIuMX44YD8j0VCMsdDvMOX4ZVAIwX6BWM0BUqWc3RxIQZSbE4cGZBLrge
	 gWLBh7F6BN09sSHOwzXLTPhMBdbgGZ6ISWHW4/1i53Zn5SSXa2PnleA4qBPK1HJpi/
	 etoE+9oM5tkUI97Gx9MHEzowWO3SL5laHbhNb2bs+YqJnehf7FqQ+20aklCnDvyxBU
	 dQufrR0quNaM8Nwo+uAfom4D3GQWDgMFE29WL99bcadsidF86S38WdLPg0fZu1yARz
	 kesEf0L+KRr0RP7uSr/Fj7nY9fKSeYTI9jz8Iy6In6IVSX3cWmDThsfmnJAvkoqJYQ
	 5vOTP2yUpOXvw==
Date: Wed, 23 Sep 2026 09:15:57 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, liam@infradead.org, nico.pache@linux.dev, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, usama.arif@linux.dev, kas@kernel.org, 
	guoren@kernel.org, bcain@kernel.org, geert@linux-m68k.org, dinguyen@kernel.org, 
	schuster.simon@siemens-energy.com, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, 
	shorne@gmail.com, dalias@libc.org, glaubitz@physik.fu-berlin.de, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, linux@armlinux.org.uk, 
	vgupta@kernel.org, monstr@monstr.eu, chris@zankel.net, jcmvbkbc@gmail.com, 
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org, 
	davem@davemloft.net, andreas@gaisler.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, catalin.marinas@arm.com, mark.rutland@arm.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	arnd@arndb.de, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com, 
	ysato@users.sourceforge.jp, shakeel.butt@linux.dev, corbet@lwn.net, rdunlap@infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, hughd@google.com, 
	qi.zheng@linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 04/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU arm
Message-ID: <arOKtMvZk_3tPJE-@gremlin>
References: <20260922-rcu-pagetable-freeing-v4-4-fe1ad1f1e303@kernel.org>
 <20260923080523.9480-1-lance.yang@linux.dev>
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
In-Reply-To: <20260923080523.9480-1-lance.yang@linux.dev>

On Wed, Sep 23, 2026 at 04:05:23PM +0800, Lance Yang wrote:
>
> On Tue, Sep 22, 2026 at 04:35:35PM +0100, Lorenzo Stoakes (ARM) wrote:
> >Commit a0ad5496b2b3 ("arm: mm: enable HAVE_RCU_TABLE_FREE logic") enabled
> >CONFIG_MMU_GATHER_RCU_TABLE_FREE (then named HAVE_RCU_TABLE_FREE) for SMP
> >arm architectures with LPAE enabled.
> >
> >Regardless of whether CONFIG_ARM_LPAE is enabled or not, the same page
> >table freeing functions __pte_free_tlb() and __pmd_free_tlb() are used.
> >
> >Non-LPAE PMD page tables are folded into the PGD and freed by
> >pgd_free() (PGD freeing is not part of mmu_gather page table freeing in any
> >case), so this is a noop in this case.
> >
> >Since commit 358d1c39c82a ("arm: convert various functions to use ptdescs")
> >both LPAE and non-LPAE PTE page table freeing uses tlb_remove_ptdesc().
> >
> >Thus all page table freeing is performed under RCU with
> >CONFIG_MMU_GATHER_RCU_TABLE_FREE enabled for LPAE and non-LPAE and thus it
> >need not be gated on LPAE.
> >
> >A UP arm system can set CONFIG_PREEMPT_RCU, so a future pure RCU page
> >table walker requires MMU_GATHER_RCU_TABLE_FREE to be enabled on UP as
> >well, even if concurrent GUP fast is not possible there.
> >
> >Therefore, it is both safe and desirable to set
> >CONFIG_MMU_GATHER_RCU_TABLE_FREE for all MMU arm architectures (nommu does
> >not perform mmu_gather operations).
> >
> >This forms part of an overall effort to switch every architecture to this
> >mode.
> >
> >Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> >Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >---
>
> Tested under heavy page-table teardown load on qemu-system-arm,
> with and without ARM_LPAE. No issues seen :D
>
> Tested-by: Lance Yang <lance.yang@linux.dev>
>
> Also, feel free to add:
>
> Acked-by: Lance Yang <lance.yang@linux.dev>

Thanks, much appreciated! :)

>
>
> > arch/arm/Kconfig | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >index 408aa58a2a5b..72b9afc6ae10 100644
> >--- a/arch/arm/Kconfig
> >+++ b/arch/arm/Kconfig
> >@@ -134,7 +134,7 @@ config ARM
> > 	select HAVE_PERF_REGS
> > 	select HAVE_PERF_USER_STACK_DUMP
> > 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
> >-	select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
> >+	select MMU_GATHER_RCU_TABLE_FREE if MMU
> > 	select HAVE_REGS_AND_STACK_ACCESS_API
> > 	select HAVE_RSEQ
> > 	select HAVE_RUST if CPU_LITTLE_ENDIAN && CPU_32v7 && !KASAN
> >
> >--
> >2.55.0
> >
> >

--
Cheers, Lorenzo


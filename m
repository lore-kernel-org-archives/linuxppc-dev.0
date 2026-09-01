Return-Path: <linuxppc-dev+bounces-26412-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E09C624D6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 17:25:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZCSC26kMz2xmh;
	Wed, 02 Sep 2026 03:25:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788283547;
	cv=none; b=eqfF4Gu1WVQ7U8zATfUJ2kSYU89sL2xpraIc/B2H6oXnXBfJq3MvnlT4HY1w2QUWm0n0t1gGRBZeuWQuUE9jlJh0LZDSNoV36xQZLbbaH886yu3kTJlorpYIHpzICAcyWVUj7qFyvvIGrN1LUOQIMeFwoOrdNXNpIJSCiLOYPYbYmqR+pFbJFeJk3iERhUXKAokW/CrIFyf2l0TLRKQCwkq4xNTxQQZwY6FnSWIBqjyz3Wq+xnpeJDls5Nbt54HwGFQI8Z/dGI4RV2hbP1e0pTUVi3LOhkCdHh1CIa6YaYPjBDLUZOqx7pBP8LzOdILyz9y91OR1itMOjPSDK5ep3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788283547; c=relaxed/relaxed;
	bh=RU/XHZsQrPB/KjzCrGwIunh3KbYqDQIpxjG/zB2SrYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UI+uCTzS7Ml7K8i3WECs5GaOXlqvfhP2S6mNGh7+AlhgUtMd+sxquyLG1VO0ciPfFoJjvHPTS1S4OBonYNR3JPd7aDPanozHDzQ/6bWvbJMexOAXj5VEFPLvrI0K/PxAZl356Dydf5sNmUR4J9rdCCl4Kuk7eSsu+1s9qxG3arKQKYJ9odswx9qdTCSb1IrIYxCNx7dbZG6gk567OLyOGHXTn5PdfMpnLgK/XzHpUQiqRJ9PaJdI34q7ZWC/ne318o98hNSWq3PdPH6ilU3aRlhQ31JnpzwKCQbSR+po745s1RzWmVOdLrmi08NG1zrUkINOheCNNk8OwVfGLQNaKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yi2t1tkD; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yi2t1tkD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZCSB3FpQz2xGt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 03:25:46 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9F5C86020D;
	Tue,  1 Sep 2026 17:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F38E1F000E9;
	Tue,  1 Sep 2026 17:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788283543;
	bh=RU/XHZsQrPB/KjzCrGwIunh3KbYqDQIpxjG/zB2SrYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yi2t1tkD7CbVI2GlNVLMPxmx2y6uQ0N17KQVN6tfdVVmsc8e3U70HKz60pHNwlQs3
	 1uaubu11GEhlMNqEwwCAnmGwy18sQmPBDQlkl4HFerFnkf9qqSXhXZRQB4AbUCIy65
	 +F5eg8cH3mV8+ZyrzWtQ7QlVH0tfsCC88xh+SXAYBAqn1Leh14VC/K7s9GATAG+x4E
	 KI4pAxyEdR503wQD7kpPC4DxKOGSs/zzQQ249JbOJTrJb8Tg6ICIFvJvGHbD91pyny
	 gkZbMWCaIAhY75HIF/43FdM8kRnN6lg6QLV7LnJhpcpnHrbOS/0Iht1oAeMIckn9b0
	 Sr0NCrNgxEH6Q==
Date: Tue, 1 Sep 2026 18:25:26 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon@siemens-energy.com>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Russell King <linux@armlinux.org.uk>, 
	Vineet Gupta <vgupta@kernel.org>, Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 12/12] mm: change the contract for free_pgtables(),
 update docs
Message-ID: <apcJhtvnd45EkjJI@gremlin>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-12-5456a81c8212@kernel.org>
 <apbUpMDJglS99_yK@thinkstation>
 <apbfzUwBQyxe3P9R@gremlin>
 <apcH74QsR5I-DIbL@thinkstation>
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
In-Reply-To: <apcH74QsR5I-DIbL@thinkstation>

On Tue, Sep 01, 2026 at 06:15:17PM +0100, Kiryl Shutsemau wrote:
> On Tue, Sep 01, 2026 at 03:31:26PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Sep 01, 2026 at 02:57:13PM +0100, Kiryl Shutsemau wrote:
> > > On Tue, Sep 01, 2026 at 12:01:32PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > > diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> > > > index b91b1a98029c..ff8ff3706485 100644
> > > > --- a/mm/pgtable-generic.c
> > > > +++ b/mm/pgtable-generic.c
> > > > @@ -386,9 +386,21 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
> > > >   * be read-only/read-write protected.
> > > >   *
> > > >   * Note that free_pgtables(), used after unmapping detached vmas, or when
> > > > - * exiting the whole mm, does not take page table lock before freeing a page
> > > > - * table, and may not use RCU at all: "outsiders" like khugepaged should avoid
> > > > - * pte_offset_map() and co once the vma is detached from mm or mm_users is zero.
> > > > + * exiting the whole mm, does not take the page table lock before freeing a
> > > > + * table.
> > > > + *
> > > > + * However, the PMD entry is cleared first, and the table freed only after
> > > > + * an RCU grace period, so a walker that mapped the table under
> > > > + * rcu_read_lock() stays safe, and the pmd_same() recheck in
> > > > + * pte_offset_map_lock() detects the teardown.
> > > > + *
> > > > + * Therefore it is safe for "outsiders" like khugepaged to use
> > > > + * pte_offset_map() and co. for VMAs that might be undergoing page table
> > > > + * teardown.
> > >
> > > Is it strictly true?
> > >
> > > free_pte_range() clears the pmd without taking the PTL, so the
> > > pmd_same() recheck in pte_offset_map_lock() can pass and the pmd gets
> > > cleared right after.
> > >
> > > Readers are fine -- __pte_offset_map() holds rcu_read_lock() until
> > > pte_unmap(), so the table cannot go away.
> > >
> > > khugepaged is an odd example here. collapse_pte_mapped_thp() and
> > > retract_page_tables() don't rely on this recheck -- they take pmd_lock()
> > > plus the ptl and do their own pmd_same() under both.
> > >
> > > Can we say walks are safe and leave the write rule where it is?
> >
> > Hmm yeah, ah page tables, what a rabbit hole of horror :)
> >
> > I guess this is effectively a reflection of the 'write lock on write, RCU load
> > on read' pattern in RCU itself generally.
> >
> > So, maybe something like:
> >
> >  * Note that free_pgtables(), used after unampping detached vmas, or when
> >  * exiting the whoel mm, does not take a page table lock before freeing a page
> >  * table.
> >  *
> >  * As page table freeing itself is RCU-safe, page table readers can safely run
> >  * concurrently with page table teardown. However, writers cannot, as without
> >  * a lock nothing prevents concurrent teardown.
> >  */
> >
> > Instead? What do you think?
>
> s/whoel/whole/

Haha yup the inevitable typo...

>
> Otherwise, LGTM.

Thanks! :)

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

--
Cheers, Lorenzo


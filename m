Return-Path: <linuxppc-dev+bounces-28013-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1DCC9830B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 11:56:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqb5V3WC3z2yr0;
	Wed, 23 Sep 2026 21:55:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790164558;
	cv=none; b=fmquOW7Q/5cDGZ3CmwkD9LbohDGMR1igOdYUQ6/7NGxlPHNqN2eQV0L76C5vfFCq8u7nHHzwA/JqdesQ5DKMz0QqzgmA/OnVkSXcoOWlDVSoQBk9L6FuDLehGgg4ko0HYSiWos7j9tIQCCqkhREoq06uPS9nmoMmMuEWh+FBcMKQo8s2HxXW2OLUmhKoQh36odZwPM1uQk9wPP6nUXSFIn/a+PqXQFbgpjFBhSr7qzy8duOYOz954YBGtRIRJnFKHgNX8MP3BygQIvVMu65dmH6nQzHF6sUBH/UcJGiTGA/3gLi3l6fJEoqW1IHT2G2IKPZtB+Yodumnskc2MwqskQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790164558; c=relaxed/relaxed;
	bh=QFgWbkSrnnzB4diBo+Fp62kuEHCA64AGOW6NYy35L6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbSxax9SO2bdcvrMdzuR/6UC1NeKRQDuB2OK7BEH6m6YoKuPMMb7fwqG9kvA5+Dlxlm4rlJ8CxYKLsXREiEd2rEyve1pS4MhW1pSyNzIGoJATpy2FVbtVnuUrvpX74VKMC9mjsfBCloBRkzCsSUfUyWYd2SUGhgC56FpuNnx27TSBphBcq3penc4pmaQdJHlUruhhnO64mSL18B6e1F+hadkw9w3GXwNfMyHsDXLB6D0Wq7fQJJQFlIKlrbS9CJUMI7UQMBEI+Wzw7phgofuAIyJEPy2s7q4AyIooOWqYdpiXqO0zowDflbO3+E8SaHLz8HcFN7879PWeryBee/YtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYz1Pt5P; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYz1Pt5P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqb5T4PzDz2yqq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 21:55:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1E97060214;
	Wed, 23 Sep 2026 11:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE8B1F000FF;
	Wed, 23 Sep 2026 11:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790164554;
	bh=QFgWbkSrnnzB4diBo+Fp62kuEHCA64AGOW6NYy35L6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gYz1Pt5PUhNtjbLXn1RLrw2dFysefT++UNiHs/SY0zWy5shyg/oEU6E0yjY37gDeZ
	 9rsf10akyHx7s8T7g8XCeeIKm6JD/TBTo+rbL9FidMwyb4MQL2taRuxWv6XNsJ2Tt4
	 N784KzTEgcnkVGUYZhttWOE8oa6UAPy77g1bCEwXeUUTBuPyaUy79r/OgIPnXhbNZN
	 GAd8MzN+orb0DLZflODRpffDhPgXrHiWn71IMcOoF/KLaOTeF7y9kFNYkCXycUbuH8
	 FWnYsVp3707DiRyWGtxaVY+tnF+ffZNWg/NkRfDfo3LM1TPERhDg1+mA0b1Bx5ZIl+
	 J0ITAsTfBBCkA==
Date: Wed, 23 Sep 2026 12:55:31 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Dinh Nguyen <dinguyen@kernel.org>, Simon Schuster <schuster.simon@siemens-energy.com>, 
	Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
	Stafford Horne <shorne@gmail.com>, Rich Felker <dalias@libc.org>, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 12/12] mm: change the contract for free_pgtables(),
 update docs
Message-ID: <arO855eMmfBYoAON@gremlin>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922-rcu-pagetable-freeing-v4-12-fe1ad1f1e303@kernel.org>
 <92b52e07-39e0-4df0-8b8d-ffa18ccc8820@kernel.org>
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
In-Reply-To: <92b52e07-39e0-4df0-8b8d-ffa18ccc8820@kernel.org>

On Wed, Sep 23, 2026 at 11:08:11AM +0200, David Hildenbrand (Arm) wrote:
> On 9/22/26 17:35, Lorenzo Stoakes (ARM) wrote:
> > Now that page tables are freed after an RCU grace period, it is safe for
> > read-only page table walkers to walk page table ranges that are being
> > concurrently torn down, provided the mm is kept alive via mmgrab().
> >
> > It is however unsafe for writers to do so, as they must obtain an
> > appropriate lock to do so safely.
> >
> > Update the pte_offset_map_lock()'s comment block to reflect this.
> >
> > Similarly update the process addresses documentation.
> >
> > Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  Documentation/mm/process_addrs.rst |  6 ++++++
> >  mm/pgtable-generic.c               | 15 +++++++++++----
> >  2 files changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
> > index a7296f251799..b1f4f44d75eb 100644
> > --- a/Documentation/mm/process_addrs.rst
> > +++ b/Documentation/mm/process_addrs.rst
> > @@ -537,6 +537,12 @@ We establish basic locking rules when interacting with page tables:
> >  * When changing a page table entry the page table lock for that page table
> >    **must** be held, except if you can safely assume nobody can access the page
> >    tables concurrently (such as on invocation of :c:func:`!free_pgtables`).
> > +* Page tables may be *walked* under RCU alone, as page tables are freed only
> > +  after an RCU grace period has elapsed. However, any entry found must be
> > +  revalidated after the page table lock is taken (such as the
> > +  :c:func:`!pmd_same` recheck performed by :c:func:`!pte_offset_map_lock`)
> > +  before it is acted upon. Changing an entry requires the page table
> > +  lock and one of the locks that excludes teardown (mmap or VMA lock).
>
> While we can walk the page tables, I assume there are some limits to what we can
> actually do with leaf entries. E.g., Doing a careless pte->folio lookup might be
> dangerous.

Yes.

>
> I wonder if we want to hint at that here: that walking under RCU (traversing
> page tables) is something different than actually operating on the leaf entries.

Yeah I can add a new entry in the list perhaps like:

* When traversing page tables under RCU alone it is important to take care when
  operating upon leaf entries - if the value is operated upon (for instance
  getting the folio associated with a PTE) an appropriate lock must be taken to
  prevent concurrent modification.

?

>
> Apart from that LGTM.
>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo


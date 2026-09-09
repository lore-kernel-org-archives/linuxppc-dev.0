Return-Path: <linuxppc-dev+bounces-26985-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDECC88E40
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 16:43:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg67S4LKLz2yyJ;
	Thu, 10 Sep 2026 02:43:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788972196;
	cv=none; b=g54j1VK8qpRb+8H40GqlggjZHbbkNba8ykG2ZltroxHWtAFZ/Ij3o7vj6tk6wAZ6ltmjXwGD3tgjhPIl0m7uif467TR0uJUjIOxfA4LOa4y5hbiYe9Wk9SWld4FZSQ24DBN5oHVW9DZTNJarA7HaYfWS608tXM4IMTBuycYjYXenievemTxBsEv3C2jH1sBm2us68Dwf34rDm+3X9rHq1Dwd7+O4rr7waifUmuwn4yBv2f/TpTwAUt07ntGq0RUWPTsX4yGzvX/mrEBxPYWEiIa00N/nWRqDaVu2qo/grnzD534hpx7k6/HRcFFviJoSDeOpfXhhoAFx5JsTlzcXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788972196; c=relaxed/relaxed;
	bh=+bb9T4qzNzmlycp9ThZUfYsXOaxsYgWc9M6tavwahvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKo5Vovk/E6gFglqeRG8r9WGXXbnhnAB3/HusUOrlOn8TU41hNotBPKlsM6Hokx6Lsxsv+vhbC1+6nmO+qol0xCpPVa9qVk+fU8c/HfCVGcWC74jP0xo0HEH/r/7QfDGiQqqjgcTdYs/FgebeLb+nlO4XJy0H5PKMIlVWTLRV5FipESTMALT5gtszuxlrvcUEyg5dLkgrZ7j8c7Aqy6+JIzieNwosaLiOqCqSj7F/vsUAOteQn2xFXYsUrTIpo8CT4tNetec2WI2XcFnJNkv8F3J0pdAwq3vwZ/hy4hXtE4A2Gl+pbzKYpS4laIfQUrhHHCFFnPJU4E7HJrF9irrNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIPVuofi; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIPVuofi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg67R0Bcvz2xWV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 02:43:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 822CC439C2;
	Wed,  9 Sep 2026 16:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4721F000FF;
	Wed,  9 Sep 2026 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788972191;
	bh=+bb9T4qzNzmlycp9ThZUfYsXOaxsYgWc9M6tavwahvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gIPVuofiiuXzwRKr3oimigWerGVK3163gi1cAcgzOdWIHvv7vHRHaOOm70oBmvuof
	 gM+DrCV50r5q2fX37AG+T2Z9/95C3wKDpEICIKuj714cWc9kpK2a643U857hnxKrt6
	 F+VhD/Iigk9dREUeU4ysQJtISisTduJzSnmSk21qc6hooSphBl5H9CJ0/x7dZKu/Q6
	 u+L9ir5TwzY1RhFgoDiNZuSP0ijZXhIOTL8sytWHlzA6zcGHNHpORsIUOjNpgYzeac
	 YkdgjhwiwM1Yl/vDXjEBIxQFkvn0uBOf3YaFLZFvbyOIKYs37Ib6WZ5TYOCA3N7iFE
	 8WN0ksIUU49KQ==
Date: Wed, 9 Sep 2026 17:42:45 +0100
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
Subject: Re: [PATCH v2 12/12] mm: change the contract for free_pgtables(),
 update docs
Message-ID: <aqGMefM9TIqUvZrp@gremlin>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
 <20260908-rcu-pagetable-freeing-v2-12-1f60b64e878e@kernel.org>
 <aqEkfKww9XDq15ZF@thinkstation>
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
In-Reply-To: <aqEkfKww9XDq15ZF@thinkstation>

On Wed, Sep 09, 2026 at 10:24:21AM +0100, Kiryl Shutsemau wrote:
> On Tue, Sep 08, 2026 at 01:32:21PM +0100, Lorenzo Stoakes (ARM) wrote:
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
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  Documentation/mm/process_addrs.rst |  6 ++++++
> >  mm/pgtable-generic.c               | 15 +++++++++++----
> >  2 files changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
> > index a7296f251799..1e65b139f355 100644
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
> > +  before it is acted upon. Changing an entry always requires the page table
> > +  lock.
>
> This says the PTL plus a recheck is enough to act on the entry. It is
> not: free_pte_range() clears the PMD without the PTL, so pmd_same() can
> pass and the table is torn down right after. That is the case we settled
> on for the pte_offset_map_lock() comment, and the two now disagree.
>
> Something like "Changing an entry requires the page table lock and one
> of the locks that excludes teardown (mmap or VMA lock)" would match the
> comment.

Ack will change!

--
Cheers, Lorenzo


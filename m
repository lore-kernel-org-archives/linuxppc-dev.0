Return-Path: <linuxppc-dev+bounces-27996-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31964C98308
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 09:05:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqWJh4F4qz2yqq;
	Wed, 23 Sep 2026 19:05:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790154324;
	cv=none; b=GUiiwCsyKlgpOdgPSXeQdLDUpmzuj9J/nbRTLpMvpQTfA52qNh6j07SKOGFe2ao9BrdqIlT67fLVjEnUNJXO4BAqsP8bGDOlDyZRyNGQVKz2j0gsZb4/jQSR13qX26ytyHrCofMZ87M8VuOG4o8nx6X5cMzPECwo3ymGhIXvUYfG8m5osWMZiwD3en9hc698wKKvovO27RJtPCcEivBODzOOlLiTtyXSHf6pksXKfcz9SjHdG8Rz+x00qky28Hbq/BSWILdh6AHqDVnxL3KX6WVuHee+mG4w4VIZ9rN62N5+gqet7OqZsgn+gXhAyYtOR+lza2YUF6CYxc0u2z6wNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790154324; c=relaxed/relaxed;
	bh=2o4rQDYiHbtVqFkAN2kWkZun12rmMLs4YnN5p0vVmiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CK88YAt2J62Ka7uu6DO+GgTmD2vxJiMfSpa35etLGJSpw9z/+gdiy2ep3zTKFMGKxgejr4Bz14uECnFI2SOmXatD5OUTitM/EcXV1U0gh0OaAp/zBS8ssDzHzJddCQQ+MSSFbmuEBxKiPsNccwnw9JQeWZKkUBdLlRePJ2y2JR+QisVz9bHOZ1zQ/0um1yHt9Ujv2uwE6UcLB5rx/uWOGqecQa2EfzoNcgk6J/r7nbASOroeezRkZXUr/KEX/fjneKZAelVE8+kl1ItLLZf8A6GG8kPRVDmxkO+WhVF5uEML0Liy38QB8Z7syXEcPbwOHTOr/+Gs6LYEqIK00i7rKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDCmOLtH; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDCmOLtH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqWJg4zynz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 19:05:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 787D940204;
	Wed, 23 Sep 2026 09:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E23B1F000FF;
	Wed, 23 Sep 2026 09:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790154321;
	bh=2o4rQDYiHbtVqFkAN2kWkZun12rmMLs4YnN5p0vVmiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZDCmOLtH6oBzineU5ofDYtw3CW3mtwyk5V3xT/lkkCtxB1Q+OwDra0xNToTtg8iIm
	 u7rGJ/xDe6BKL7MrOMEn8bDOMYTCV4aEzKQKJIt00q1BsH3wSVTQo2Ook3KjVOJMIR
	 AB4sDPrnTg2fF+LMD5pG93PhRaZQ302+w7tBmfT4/Q4oKOmPfIeb2DOtAbjc8G/HBr
	 9DhsZ+uSqRYGiIaloX4OWTC1NUs9xiLQ6o7nt/X/EFVExrVXn1dH9PmU3LwdrRgVG5
	 Odt7Cl6nzQ4qviO/2kqxNclnZdLZjOTUWiY2xDH0cr58TUDFGwa6IBWPTdeie3ekC9
	 ipydVMPWKNSiA==
Date: Wed, 23 Sep 2026 10:04:58 +0100
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
Subject: Re: [PATCH v4 00/12] mm: make userland page table freeing RCU-safe
Message-ID: <arOVbT5B1FOMe1wb@gremlin>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922160021.a2fc65d05d9b867a141e5457@linux-foundation.org>
 <9dcde7e4-dadb-4644-9dff-7fd8a26e29a6@kernel.org>
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
In-Reply-To: <9dcde7e4-dadb-4644-9dff-7fd8a26e29a6@kernel.org>

On Wed, Sep 23, 2026 at 10:45:33AM +0200, David Hildenbrand (Arm) wrote:
> On 9/23/26 01:00, Andrew Morton wrote:
> > On Tue, 22 Sep 2026 16:35:31 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
> >
> >> The majority of architectures in the kernel defer page table freeing until
> >> an RCU grace period has elapsed, this series converts all remaining
> >> architectures to do so too and eliminates CONFIG_MMU_GATHER_RCU_TABLE_FREE
> >> altogether.
> >>
> >> This is important because it enables safe lockless page table walking under
> >> RCU alone.
> >
> > Do we have reason to believe that anyone is seeing any effects from
> > their arch's failure to rcu-free the page tables?
> >
> > This sounds like a rather long-standing wart, yes?
> >
> > The patchset is thinly reviewed and mm.git is bursting at the seams
> > again.  I'll play wait-and-see on this series.
> Do we want to nudge arch maintainers to review?

(Just to note that I replied separately, 'thinly reviewed' is incorrect, it's
been in -next for weeks and the whole thing was reviewed by Kiryl.)

The only places where that would be useful is m68k motorola, sparc32.

But in any case it has been heavily tested including on every single arch
listed with stress testing performed (I think I cover that in the cover
letter).

The changes are not controversial so I don't think that's a blocker, but
it'd be nice?

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo


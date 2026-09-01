Return-Path: <linuxppc-dev+bounces-26393-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97B2C624D8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 14:04:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ6zQ1K6qz2xmh;
	Wed, 02 Sep 2026 00:04:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788271442;
	cv=none; b=NV9nCaJKGtxL0EyoKfouZs7vFdu9+0Hjwg9VisDBnQ/S6BaqS97LfKDSFWHETqe8yDp/T2YSdF8bIGmAghGFDvsMkSfcogY3mqhcIMZtwux2CXvLyYe4s5WjjVw20nnBH/V+QT0wkJ7mRIknxSIlTNhpgiamJPt6HDwAKsebRvwqkIpmHp2VnlhTxtO0JLSm1vloqyliGHxoO3zh/gqjqs0nDGCwELKb8sV2YbcWoReAhrtM3Rwp4mb7tMpC7QvLb/+JCl9XFjzZyd0urzTafardOCWM5jkKtBIHbBfwWwAKvn4CrhOxdQZB7/oJC1wdqOgBic8ygGa94fYiY0bikg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788271442; c=relaxed/relaxed;
	bh=utZgOAk3glT+w9jGyIL1e4+wDW3VgIywx5aDJ+IClBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuM16Vi7sxKIbPTufyDhEXv5zbLcnagCzZDHg2om/OkcQRk7qvyqKSYxs09CkkAprbD5KI3wiWKzCE3+VEyMSSuuhxHHoi46aTbv9kKNBNtXJsZBnMAwMSoF/BvYilbUHjDt9YppK/AZOdoeuRF97XnnWsLw2RoEagP3e1IsWJfVc7wInP36UizynsTuoXywjC49aF3+CLIVpWWyg+iJHBWvQpsW6QhmpTqleSdAu14tvb9wMBJlsIlhp31ILGYscbvgBTq2+LiwRxOrNcV+WkF/J7Rd3taj5CZ0Gm2CkO60w3vdj4rBbSZ071ZIT0ongbc4eDAS+1v4aWdPwbvPyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VkHIyhIL; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VkHIyhIL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ6zP1clMz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 00:04:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9425B60214;
	Tue,  1 Sep 2026 14:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9601A1F00A3E;
	Tue,  1 Sep 2026 14:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788271438;
	bh=utZgOAk3glT+w9jGyIL1e4+wDW3VgIywx5aDJ+IClBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VkHIyhIL5RYsevDjObNKXZqn+SdY5WQb69y59u2HEPU8+koXsjF39lkchtgGfID2/
	 RRta8sEiyqrYHeGZADgvcepo/d6BCIy1rew63LXlaVY0Xupe7DXsdoMNSJ2LwTdz2t
	 9L5dRACEK20PlxkRCThhZUhUvCQOFVCbvgosbtCrmvTH2mK9HkGA5IIhEFa7R3t6KR
	 sYprPzYjwJdozsniM15JaMhNn3suHrmHgExLHHHmoISXD5OQ3cY25wcuADGpitpChH
	 /n/kgOyZ1a5axdohia++5dysGbeDD/F5NBdm+JhIfjt3j2SloNQlLySaTEevH9y1p5
	 qVSTayD4zeHWQ==
Date: Tue, 1 Sep 2026 15:03:34 +0100
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
Subject: Re: [PATCH 11/12] mm: make userland page table freeing RCU-safe
Message-ID: <apbZwZHOkExAqOPA@gremlin>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-11-5456a81c8212@kernel.org>
 <apbSaL0YaQqtO9XB@thinkstation>
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
In-Reply-To: <apbSaL0YaQqtO9XB@thinkstation>

On Tue, Sep 01, 2026 at 02:33:14PM +0100, Kiryl Shutsemau wrote:
> On Tue, Sep 01, 2026 at 12:01:31PM +0100, Lorenzo Stoakes (ARM) wrote:
> > With this change in place the kernel policy is now that all page tables are
>
> s/all/userspace/ as subject implies?

Right yeah :) I hoped that the summary line would clarify that but can edit that
also.

>
> BTW, what is your take on kernel page tables? Do we want the same policy
> there. pagetable_free_kernel() is not RCU-safe as it is.

Yeah I think so too. I may follow up with a series to that effect also!

>
> > freed after an RCU grace period, and thus it is now safe to unconditionally
> > perform page table walks under RCU, safe in the knowledge that page tables
> > will not be freed underneath the walker.
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

--
Cheers, Lorenzo


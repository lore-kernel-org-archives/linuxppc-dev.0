Return-Path: <dhowells@redhat.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D372AB7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jul 2009 22:46:12 +1000 (EST)
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 58EF0DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Jul 2009 22:46:11 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20090715074952.A36C7DDDB2@ozlabs.org>
References: <20090715074952.A36C7DDDB2@ozlabs.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] mm: Pass virtual address to [__]p{te, ud,
	md}_free_tlb()
Date: Mon, 20 Jul 2009 13:46:03 +0100
Message-ID: <13548.1248093963@redhat.com>
Sender: dhowells@redhat.com
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
	linuxppc-dev@ozlabs.org, Hugh Dickins <hugh@tiscali.co.uk>,
	linux-kernel@vger.kernel.org, Linux Memory Management <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Upcoming paches to support the new 64-bit "BookE" powerpc architecture
> will need to have the virtual address corresponding to PTE page when
> freeing it, due to the way the HW table walker works.
> 
> Basically, the TLB can be loaded with "large" pages that cover the whole
> virtual space (well, sort-of, half of it actually) represented by a PTE
> page, and which contain an "indirect" bit indicating that this TLB entry
> RPN points to an array of PTEs from which the TLB can then create direct
> entries. Thus, in order to invalidate those when PTE pages are deleted,
> we need the virtual address to pass to tlbilx or tlbivax instructions.
>
> The old trick of sticking it somewhere in the PTE page struct page sucks
> too much, the address is almost readily available in all call sites and
> almost everybody implemets these as macros, so we may as well add the
> argument everywhere. I added it to the pmd and pud variants for consistency.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: David Howells <dhowells@redhat.com> [MN10300 & FRV]

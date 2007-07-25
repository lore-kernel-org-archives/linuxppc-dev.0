Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D52CFDDE9B
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 09:22:54 +1000 (EST)
Subject: Re: pte_offset_map for ppc assumes HIGHPTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jewswodqcn.fsf@sykes.suse.de>
References: <acbcf3840707251516w301f834cj5f6a81a494d359ed@mail.gmail.com>
	<jewswodqcn.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Thu, 26 Jul 2007 09:22:45 +1000
Message-Id: <1185405765.5439.371.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-07-26 at 01:18 +0200, Andreas Schwab wrote:
> Satya <satyakiran@gmail.com> writes:
> 
> > hello,
> > The implementation of pte_offset_map() for ppc assumes that PTEs are
> > kept in highmem (CONFIG_HIGHPTE). There is only one implmentation of
> > pte_offset_map() as follows (include/asm-ppc/pgtable.h):
> >
> > #define pte_offset_map(dir, addr)               \
> >          ((pte_t *) kmap_atomic(pmd_page(*(dir)), KM_PTE0) + pte_index(addr))
> >
> > Shouldn't this be made conditional according to CONFIG_HIGHPTE is
> > defined or not
> 
> kmap_atomic is always defined with or without CONFIG_HIGHPTE.
> 
> > (as implemented in include/asm-i386/pgtable.h) ?
> 
> I don't think that needs it either.

Depends... if you have CONFIG_HIGHMEM and not CONFIG_HIGHPTE, you are wasting
time going through kmap_atomic unnecessarily no ? it will probably not do anything
because the PTE page is in lowmem but still...

Ben.

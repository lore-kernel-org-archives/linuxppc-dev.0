Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E48FDDEC0
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 09:10:27 +1000 (EST)
Subject: Re: pte_offset_map for ppc assumes HIGHPTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Satya <satyakiran@gmail.com>
In-Reply-To: <acbcf3840707251516w301f834cj5f6a81a494d359ed@mail.gmail.com>
References: <acbcf3840707251516w301f834cj5f6a81a494d359ed@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 26 Jul 2007 09:10:15 +1000
Message-Id: <1185405015.5439.369.camel@localhost.localdomain>
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

On Wed, 2007-07-25 at 17:16 -0500, Satya wrote:
> hello,
> The implementation of pte_offset_map() for ppc assumes that PTEs are
> kept in highmem (CONFIG_HIGHPTE). There is only one implmentation of
> pte_offset_map() as follows (include/asm-ppc/pgtable.h):
> 
> #define pte_offset_map(dir, addr)               \
>          ((pte_t *) kmap_atomic(pmd_page(*(dir)), KM_PTE0) + pte_index(addr))
> 
> Shouldn't this be made conditional according to CONFIG_HIGHPTE is
> defined or not (as implemented in include/asm-i386/pgtable.h) ?
> 
> the same goes for pte_offset_map_nested and the corresponding unmap functions.

Do we have CONFIG_HIGHMEM without CONFIG_HIGHPTE ? If yes, then indeed,
we should change that. Though I'm not sure I see the point of splitting
those 2 options.

Ben.
 

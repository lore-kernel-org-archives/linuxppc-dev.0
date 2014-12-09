Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 92D641A01E2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 21:18:41 +1100 (AEDT)
In-Reply-To: <20141208141629.912861A5D5B@localhost.localdomain>
To: LEROY Christophe <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, scottwood@freescale.com,
 aneesh.kumar@in.ibm.com
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc32: missing accessors to pgprot_t objects
Message-Id: <20141209101841.7D9241400D2@ozlabs.org>
Date: Tue,  9 Dec 2014 21:18:41 +1100 (AEDT)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-08-12 at 14:16:29 UTC, LEROY Christophe wrote:
> Compilation with #define STRICT_MM_TYPECHECKS in arch/powerpc/include/asm/page.h
> fails due to missing use of pgprot_val() when using pgprot_t objects.

Hmm, looks like 64 bit doesn't build either.

Aneesh I think you added this, mind fixing it up?

In file included from ../arch/powerpc/include/asm/thread_info.h:34:0,
                 from ../include/linux/thread_info.h:54,
                 from ../include/asm-generic/preempt.h:4,
                 from arch/powerpc/include/generated/asm/preempt.h:1,
                 from ../include/linux/preempt.h:18,
                 from ../include/linux/spinlock.h:50,
                 from ../include/linux/mmzone.h:7,
                 from ../include/linux/gfp.h:5,
                 from ../include/linux/mm.h:9,
                 from ../arch/powerpc/mm/tlb_hash64.c:25:
../arch/powerpc/mm/tlb_hash64.c: In function ‘__flush_hash_table_range’:
../arch/powerpc/include/asm/page.h:286:24: error: request for member ‘pte’ in something not a structure or union
 #define pte_val(x) ((x).pte)
                        ^    
../arch/powerpc/mm/tlb_hash64.c:219:37: note: in expansion of macro ‘pte_val’
    trace_hugepage_invalidate(start, pte_val(pte));
                                     ^    
make[2]: *** [arch/powerpc/mm/tlb_hash64.o] Error 1


cheers

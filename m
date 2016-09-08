Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVGJC46B5zDsTS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 20:08:43 +1000 (AEST)
Date: Thu, 8 Sep 2016 20:08:36 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Ellerman <michael@ellerman.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] powerpc/mm: Speed up computation of base and
 actual page size for a HPTE
Message-ID: <20160908100836.GA4965@fergus.ozlabs.ibm.com>
References: <20160902114759.GA12433@fergus.ozlabs.ibm.com>
 <20160902115055.GC12433@fergus.ozlabs.ibm.com>
 <20160907061709.GD21443@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160907061709.GD21443@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 07, 2016 at 04:17:09PM +1000, Paul Mackerras wrote:
> This replaces a 2-D search through an array with a simple 8-bit table
> lookup for determining the actual and/or base page size for a HPT entry.
> 
> The encoding in the second doubleword of the HPTE is designed to encode
> the actual and base page sizes without using any more bits than would be
> needed for a 4k page number, by using between 1 and 8 low-order bits of
> the RPN (real page number) field to encode the page sizes.  A single
> "large page" bit in the first doubleword indicates that these low-order
> bits are to be interpreted like this.
> 
> We can determine the page sizes by using the low-order 8 bits of the RPN
> to look up a 256-entry table.  For actual page sizes less than 1MB, some
> of the upper bits of these 8 bits are going to be real address bits, but
> we can cope with that by replicating the entries for those smaller page
> sizes.
> 
> While we're at it, let's move the hpte_page_size() and hpte_base_page_size()
> functions from a KVM-specific header to a header for 64-bit HPT systems,
> since this computation doesn't have anything specifically to do with KVM.
> 
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
> v2: added more comments as suggested by Aneesh
> 
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h | 37 ++++++++++++
>  arch/powerpc/include/asm/kvm_book3s_64.h      | 87 +++------------------------
>  arch/powerpc/include/asm/mmu.h                |  1 +
>  arch/powerpc/mm/hash_native_64.c              | 42 +------------
>  arch/powerpc/mm/hash_utils_64.c               | 55 +++++++++++++++++

This of course touches two maintainers' areas.  Michael and Paolo, how
do you want to proceed here?  Can this just go through Michael's tree?
Or should I make a topic branch off Linus' tree that you can both
pull, or should I split the patch into two (i.e. everything except the
kvm_book3s_64.h change in the first patch, and the kvm_book3s_64.h
change in the second) and get Michael to put the first one in a topic
branch that I can then pull and apply the second patch onto?

Thanks,
Paul.

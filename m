Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKzlM2PS5zDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 17:44:47 +1000 (AEST)
Message-ID: <1464853486.19646.8.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: use _raw variant of page table accessors
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Date: Thu, 02 Jun 2016 17:44:46 +1000
In-Reply-To: <20160601221311.GB5658@ram.oc3035372033.ibm.com>
References: <1464692382-29698-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160601221311.GB5658@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-06-01 at 15:13 -0700, Ram Pai wrote:
> On Tue, May 31, 2016 at 04:29:42PM +0530, Aneesh Kumar K.V wrote:
> > diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> > index 71e9abced493..9db83b4e017d 100644
> > --- a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> > +++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
> > @@ -31,7 +31,7 @@ static inline int pgd_huge(pgd_t pgd)
> >  	 * leaf pte for huge page
> >  	 */
> >  	if (radix_enabled())
> > -		return !!(pgd_val(pgd) & _PAGE_PTE);
> > +		return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PTE));
> 
> pgd_raw() will not do the endian swapping.
> But instead cpu_to_be64(_PAGE_PTE) will now do the endian swapping. So does it
> really optimize anything? i tend to think it just moves the endian
> swapping overhead from one place to the other. no?

> Is cpu_to_be64(constant) faster than cpu_to_be64(variable)  ?

Yes, the compiler will do it at compile time for constants, or anything it can
prove is a constant.

You can also see from the asm dump that Aneesh posted that it drastically
improves the generated code.

cheers

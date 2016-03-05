Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BF4501A0311
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Mar 2016 21:41:28 +1100 (AEDT)
Date: Sat, 5 Mar 2016 21:41:25 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 2/2] powerpc/mm: Replace _PAGE_USER with _PAGE_PRIV
Message-ID: <20160305104125.GA4175@fergus.ozlabs.ibm.com>
References: <1456456850-2679-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456456850-2679-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160302010759.GB3160@oak.ozlabs.ibm.com>
 <87lh5xs4z5.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87lh5xs4z5.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 05, 2016 at 01:59:02PM +0530, Aneesh Kumar K.V wrote:
> Paul Mackerras <paulus@ozlabs.org> writes:
> 
> > [ text/plain ]
> > On Fri, Feb 26, 2016 at 08:50:50AM +0530, Aneesh Kumar K.V wrote:
> >> _PAGE_PRIV means the page can be accessed only by kernel. This is done
> >> to keep pte bits similar to PowerISA 3.0 radix PTE format. User
> >> pages are now makred by clearing _PAGE_PRIV bit.
> >
> >
> 
> .....
> 
> >> @@ -40,6 +40,11 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> >>  		if (unlikely(access & ~old_pte))
> >>  			return 1;
> >
> > This check is going to do a different thing now as far as
> > _PAGE_USER/_PAGE_PRIV is concerned: previously it would prevent a
> > non-privileged access to a privileged page from creating a HPTE, now
> > it prevents a privileged access to a non-privileged page from creating
> > a HPTE.  A privileged access means an access by the kernel to a high
> > address, and arguably we would never have a non-privileged PTE at a
> > high (i.e. kernel) address, but it's still a semantic change that
> > should have been flagged in the patch description.
> 
> 
> We don't set _PAGE_PRIVILGED when we have a privilged acess to a non
> privilged page. We set it as below (with updated comments)
> 
> 	/*
> 	 * We set _PAGE_PRIVILEGED only when
> 	 * kernel mode access kernel space.
> 	 *
> 	 * _PAGE_PRIVILGED is NOT set
> 	 * 1) when kernel mode access user space
> 	 * 2) user space access kernel space.
> 	 */
> 	if (!(msr & MSR_PR) && !(REGION_ID(ea) == USER_REGION_ID))
> 		access |= _PAGE_PRIVILEGED;

You're confusing a page in the user part of the address space with a
non-privileged page.  Now, we would certainly expect that all pages in
the user part of the address space would be non-privileged pages and
all pages in the kernel part would be privileged pages, but nothing
actually enforces that.  The semantic change is that if we did somehow
happen to have a non-privileged page (one without _PAGE_PRIVILEGED
set) in the kernel part of the address space, we can no longer access
it from the kernel.  Now you can argue that we never have
non-privileged pages in the kernel part of the address space, and so
the change doesn't matter.  That is probably a good argument, but you
do need to mention the change and make that argument in your patch
description.

Paul.

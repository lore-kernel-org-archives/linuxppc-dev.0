Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40H7mf2CTszF1XC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 02:38:09 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w35Gc5Ud039877
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Apr 2018 12:38:07 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h5nuud505-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Apr 2018 12:38:06 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 5 Apr 2018 17:37:53 +0100
Date: Thu, 5 Apr 2018 09:37:46 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 1/2] powerpc/swiotlb: Dont free up allocated SWIOTLB slab
 on POWER
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180404030301.25019-1-khandual@linux.vnet.ibm.com>
 <87fu4bcf34.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fu4bcf34.fsf@concordia.ellerman.id.au>
Message-Id: <20180405163746.GA5775@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 04, 2018 at 10:48:31PM +1000, Michael Ellerman wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> > Even though SWIOTLB slab gets allocated and initialized on powerpc with
> > swiotlb_init() called during mem_init(), it gets released away again on
> > POWER platform because 'ppc_swiotlb_enable' never gets set. The function
> > swiotlb_detect_4g() checks for 4GB memory and then sets the variable
> > 'ppc_swiotlb_enable' which prevents freeing up the SWIOTLB slab. Lets
> > make POWER platform call swiotlb_detect_4g() during setup_arch() which
> > will keep the SWIOTLB slab through out the runtime.
> >
> > A previous commit cf5621032f ("powerpc/64: Limit ZONE_DMA32 to 4GiB in
> > swiotlb_detect_4g()") enforced 4GB limit on ZONE_DMA32 which is is not
> > applicable on POWER (CONFIG_PPC_BOOK3S_64) platform. Lets remove this
> > unnecessary restriction.
> 
> You're using "POWER" to mean Book3S 64-bit, but "POWER" is something
> else (the ISA for POWER1/POWER2).
> 
> So please just say "Book3S 64-bit" or talk about a specific CPU, eg.
> Power9.
> 
> > After the patch, SWIOTLB slab does not get released.
> >
> > [0.410992] software IO TLB [mem 0xfbff0000-0xffff0000] (64MB) mapped
> > at [00000000767f6cb3-000000004a10114f]
> 
> But we don't want SWIOTLB on any existing Book3S 64-bit platforms, so
> leaving it enabled is just wasting memory.
> 
> > diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> > index d73ec518ef80..c4db844e0b0d 100644
> > --- a/arch/powerpc/kernel/setup-common.c
> > +++ b/arch/powerpc/kernel/setup-common.c
> > @@ -944,6 +944,7 @@ void __init setup_arch(char **cmdline_p)
> >  	/* Initialize the MMU context management stuff. */
> >  	mmu_context_init();
> >  
> > +	swiotlb_detect_4g();
> 
> You shouldn't be calling this, your use case has nothing to do with 4GB.
> 
> Instead when you detect that you're running under the ultravisor then
> you should set ppc_swiotlb_enable = 1.

Please assume that you will have a interface to detect if you are
running in a protected-environment(AKA secure-environment).

So maybe you can rename swiotlb_detect_4g() to swiotlb_detect() 
and modify that function to enable or disable ppc_swiotlb_enable
depending on the availability of 4g or availability of 
protected-environment?

RP

Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHm8V66GgzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 17:55:38 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id y134so5852345pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 00:55:38 -0700 (PDT)
Date: Mon, 22 Aug 2016 17:55:28 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 2/2] Detect instruction fetch denied and report
Message-ID: <20160822075528.GA24002@350D>
Reply-To: bsingharora@gmail.com
References: <1471831017-18167-1-git-send-email-bsingharora@gmail.com>
 <1471831017-18167-2-git-send-email-bsingharora@gmail.com>
 <87vaytibin.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87vaytibin.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 22, 2016 at 11:35:36AM +0530, Aneesh Kumar K.V wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
> > ISA 3 allows for prevention of instruction fetch and execution
> > of user mode pages. If such an error occurs, SRR1 bit 35
> > reports the error. We catch and report the error in do_page_fault()
> >
> 
> But what does the error mean ? A buggy application ? IIUC, it indicate a
> buggy kernel isn't it ?. So should we kill the application or panic() ?
>

We oops.. basically we get a kernel fault. We handle it the same way
we handle other kernel faults.
 
> 
> > Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> > ---
> >  arch/powerpc/mm/fault.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> > index a4db22f..f162e77 100644
> > --- a/arch/powerpc/mm/fault.c
> > +++ b/arch/powerpc/mm/fault.c
> > @@ -404,6 +404,10 @@ good_area:
> >  		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
> >  		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
> >  			goto bad_area;
> > +#ifdef CONFIG_PPC_RADIX_MMU
> > +		if (radix_enabled() && regs->msr & PPC_BIT(35))
> > +			goto bad_area;
> > +#endif
> >  #ifdef CONFIG_PPC_STD_MMU
> >  		/*
> >  		 * protfault should only happen due to us
> 
> -aneesh
> 

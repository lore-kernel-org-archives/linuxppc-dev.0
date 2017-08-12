Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTqgC24h5zDr4T
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 15:09:42 +1000 (AEST)
Date: Sat, 12 Aug 2017 08:09:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [bug report] powerpc/mm/radix: Avoid flushing the PWC on every
 flush_tlb_range
Message-ID: <20170812050905.rz5ax4cdq3xm5pf6@mwanda>
References: <20170811201544.jybwkrtd2oebtlld@mwanda>
 <e7eca4cb-23c1-f8c7-4c03-276b8f55b820@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e7eca4cb-23c1-f8c7-4c03-276b8f55b820@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 11, 2017 at 03:16:08PM -0700, Tyrel Datwyler wrote:
> On 08/11/2017 01:15 PM, Dan Carpenter wrote:
> > Hello Benjamin Herrenschmidt,
> > 
> > This is a semi-automatic email about new static checker warnings.
> > 
> > The patch 424de9c6e3f8: "powerpc/mm/radix: Avoid flushing the PWC on 
> > every flush_tlb_range" from Jul 19, 2017, leads to the following 
> > Smatch complaint:
> > 
> > arch/powerpc/mm/tlb-radix.c:368 radix__flush_tlb_collapsed_pmd()
> > 	 error: we previously assumed 'mm' could be null (see line 362)
> > 
> > arch/powerpc/mm/tlb-radix.c
> >    361	
> >    362		pid = mm ? mm->context.id : 0;
> >                       ^^
> > Check for NULL.
> > 
> >    363		if (unlikely(pid == MMU_NO_CONTEXT))
> >    364			goto no_context;
> >    365	
> >    366		/* 4k page size, just blow the world */
> >    367		if (PAGE_SIZE == 0x1000) {
> >    368			radix__flush_all_mm(mm);
> >                                             ^^
> > Unchecked dereference.
> 
> Appears to be a false positive. MMU_NO_CONTEXT I believe is defined as "0". So, maybe it
> would be clearer that we take the goto branch if this line read:
> 
> 362		pid = mm ? mm->context.id : MMU_NO_CONTEXT;
> 

Ah...  This is because I'm compiling code for other arches in a "best
effort" way.  It doesn't pull in the right headers so it doesn't know
the value of MMU_NO_CONTEXT.  Otherwise it would read the code correctly
and not complain.

Sorry for that.

regards,
dan carpenter

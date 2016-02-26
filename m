Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC5681A0B7D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 21:14:21 +1100 (AEDT)
Message-ID: <1456481658.25691.6.camel@ellerman.id.au>
Subject: Re: [PATCH 04/12] powerpc/ftrace: Prepare for -mprofile-kernel
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com,  pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org,  mbenes@suse.cz
Date: Fri, 26 Feb 2016 21:14:18 +1100
In-Reply-To: <20160225135205.GF21932@lst.de>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-4-git-send-email-mpe@ellerman.id.au>
 <20160225135205.GF21932@lst.de>
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

On Thu, 2016-02-25 at 14:52 +0100, Torsten Duwe wrote:
> On Thu, Feb 25, 2016 at 01:28:27AM +1100, Michael Ellerman wrote:
> > @@ -450,17 +448,44 @@ static unsigned long stub_for_addr(const Elf64_Shdr *sechdrs,
> >  	return (unsigned long)&stubs[i];
> >  }
> >  
> > +#ifdef CC_USING_MPROFILE_KERNEL
> > +static int is_early_mcount_callsite(u32 *instruction)
> > +{
> > +	/* -mprofile-kernel sequence starting with
> > +	 * mflr r0 and maybe std r0, LRSAVE(r1).
> > +	 */
> > +	if ((instruction[-3] == PPC_INST_MFLR &&
> > +	     instruction[-2] == PPC_INST_STD_LR) ||
> > +	    instruction[-2] == PPC_INST_MFLR) {
> > +		/* Nothing to be done here, it's an _mcount
> > +		 * call location and r2 will have to be
> > +		 * restored in the _mcount function.
> > +		 */
> > +		return 1;
> > +	}
> > +	return 0;
> > +}
> > +#else
> 
> *You* said this might page fault :)

It does :) - I fixed it up in patch 6, sorry I realise that's hard to review.

> Did we agree yet whether we insist on a streamlined compiler?
> (GCC commit e95d0248dace required)?

No we didn't really. I think you're right that it's not /too/ hard to support
both sequences. But we may change our mind in future :)

cheers

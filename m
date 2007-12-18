Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id DAD9ADDEF5
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 03:14:36 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 18 Dec 2007 09:14:33 -0700
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/10] powerpc: Add kexec support for PPC_85xx platforms
Message-ID: <20071218161433.GA28931@xyzzy.farnsworth.org>
References: <20071122154607.GA26447@xyzzy.farnsworth.org>
	<1197699385.6696.43.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1197699385.6696.43.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 15, 2007 at 05:16:25PM +1100, Benjamin Herrenschmidt wrote:
> > index 8b642ab..db0e749 100644
> > --- a/arch/powerpc/kernel/misc_32.S
> > +++ b/arch/powerpc/kernel/misc_32.S
> > @@ -816,6 +816,75 @@ relocate_new_kernel:
> >  	/* r4 = reboot_code_buffer */
> >  	/* r5 = start_address      */
> >  
> > +#ifdef CONFIG_E500
> > +	/*
> > +	 * Since we can't turn off the MMU, we must create an identity
> > +	 * map for kernel low memory.  We start by invalidating the
> > +	 * TLB entries we don't need.
> > +	 *
> > +	 * First, invalidate the TLB0 entries
> > +	 */
> > +	li	r6, 0x04
> > +	tlbivax	0, r6
> > +#ifdef CONFIG_SMP
> > +	tlbsync
> > +#endif
> > +	msync
> > +
> 
> This is really E500 specific or should it be CONFIG_FSL_BOOKE ?
> 
> Ben.

I agree that CONFIG_FSL_BOOKE is more appropriate.  I'll reflect that
in the next respin.

Thanks,
-Dale

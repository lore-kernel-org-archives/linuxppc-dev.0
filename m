Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Mar 2007 10:31:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/4] powerpc: Add device tree utility functions to zImage
Message-ID: <20070321233131.GA2295@localhost.localdomain>
References: <20070321063150.04BA4DDE9F@ozlabs.org>
	<d33fab3c1f5376bc078ea1b805babbdc@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d33fab3c1f5376bc078ea1b805babbdc@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, Mar 21, 2007 at 06:10:21PM +0100, Segher Boessenkool wrote:
> > @@ -262,6 +253,10 @@ void start(void *sp)
> >  	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r",
> >  	       _start, sp);
> >
> > +	/* Ensure that the device tree has a /chosen node */
> > +	if (! finddevice("/chosen"))
> > +		create_node(NULL, "chosen");
> > +
> >  	vmlinux = prep_kernel();
> >  	initrd = prep_initrd(vmlinux, loader_info.initrd_addr,
> >  			     loader_info.initrd_size);
> 
> So this is done early, and unconditional now?  Just
> double checking, not enough context (for me, anyway)
> in the patch itself.

Yes, that's right.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

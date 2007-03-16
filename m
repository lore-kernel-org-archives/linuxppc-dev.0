Return-Path: <dgibson@ozlabs.org>
Date: Fri, 16 Mar 2007 11:14:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 8/15] zImage: Cleanup and improve zImage entry point
Message-ID: <20070316001429.GD6784@localhost.localdomain>
References: <20070305032307.GB31417@localhost.localdomain>
	<20070305032452.810C1DDF1B@ozlabs.org>
	<20070315223529.GA1314@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070315223529.GA1314@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 15, 2007 at 03:35:29PM -0700, Mark A. Greer wrote:
> On Mon, Mar 05, 2007 at 02:24:52PM +1100, David Gibson wrote:
> 
> Hi David,
> 
> <snip>
> 
> > Index: working-2.6/arch/powerpc/boot/ops.h
> > ===================================================================
> > --- working-2.6.orig/arch/powerpc/boot/ops.h	2007-02-19 14:01:38.000000000 +1100
> > +++ working-2.6/arch/powerpc/boot/ops.h	2007-02-19 14:01:43.000000000 +1100
> 
> <snip>
> 
> > @@ -100,4 +106,8 @@ static inline void exit(void)
> >  	for(;;);
> >  }
> >  
> > +#define BSS_STACK(size) \
> > +	static char _bss_stack[size]; \
> > +	void *_platform_stack_top = _bss_stack + sizeof(_bss_stack);
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> >  #endif /* _PPC_BOOT_OPS_H_ */
> 
> Statically initializing _platform_stack_top (or any variable) won't
> work when you download/run the zImage at a location different than
> where its linked at.  Yes, I know the image is "relocatable" but that
> doesn't work for addresses put into variables/structs at link time
> like this one.  That type of assignment has to be done at runtime.
> 
> What happens is the linker puts 0x0040_1234, say, into
> _platform_stack_top but when you download the image to 0x0080_0000
> it still has a value of 0x0040_1234 even though its running at
> 0x00800_0000+.

Ah, good point.  In this case we should be able to fix this by having
crt0.S relocate the pointer before loading it into r1, yes, in the
same way it relocates the GOT entries?

Incidentally I would have preferred not to store the stack address in
a variable, but just generated a symbol for the stack top and loaded
that directly in crt0.S.  But I couldn't think of a way in the C macro
to generate the necesary symbol at the end of the stack.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

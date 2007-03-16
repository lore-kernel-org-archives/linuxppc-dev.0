Return-Path: <dgibson@ozlabs.org>
Date: Fri, 16 Mar 2007 12:50:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 8/15] zImage: Cleanup and improve zImage entry point
Message-ID: <20070316015023.GA6868@localhost.localdomain>
References: <20070305032307.GB31417@localhost.localdomain>
	<20070305032452.810C1DDF1B@ozlabs.org>
	<20070315223529.GA1314@mag.az.mvista.com>
	<20070316001429.GD6784@localhost.localdomain>
	<20070316010116.GC10786@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316010116.GC10786@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 15, 2007 at 06:01:16PM -0700, Mark A. Greer wrote:
> On Fri, Mar 16, 2007 at 11:14:30AM +1100, David Gibson wrote:
> > On Thu, Mar 15, 2007 at 03:35:29PM -0700, Mark A. Greer wrote:
> 
> <snip>
> 
> > > On Mon, Mar 05, 2007 at 02:24:52PM +1100, David Gibson wrote:
> > > Statically initializing _platform_stack_top (or any variable) won't
> > > work when you download/run the zImage at a location different than
> > > where its linked at.  Yes, I know the image is "relocatable" but that
> > > doesn't work for addresses put into variables/structs at link time
> > > like this one.  That type of assignment has to be done at runtime.
> > > 
> > > What happens is the linker puts 0x0040_1234, say, into
> > > _platform_stack_top but when you download the image to 0x0080_0000
> > > it still has a value of 0x0040_1234 even though its running at
> > > 0x00800_0000+.
> > 
> > Ah, good point.  In this case we should be able to fix this by having
> > crt0.S relocate the pointer before loading it into r1, yes, in the
> > same way it relocates the GOT entries?
> >
> > Incidentally I would have preferred not to store the stack address in
> > a variable, but just generated a symbol for the stack top and loaded
> > that directly in crt0.S.  But I couldn't think of a way in the C macro
> > to generate the necesary symbol at the end of the stack.
> 
> What about something like this:
> 
> #define BSS_STACK(size) \
> 	static char _bss_stack[size]; \
> 	u32 _platform_stack_size = size;
> 
> Then in crt0.S add value of _platform_stack_size to _bss_stack to get r1?
> That should relocate correctly.

That sounds reasonable, though it's slightly more involved that the
current code.  I'm wrangling another stack of bootloader patches at
the moment, you want to send something to implement this?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id CE0A9DDE10
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 14:44:48 +1100 (EST)
Date: Thu, 15 Mar 2007 20:45:39 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 8/15] zImage: Cleanup and improve zImage entry point
Message-ID: <20070316034539.GB22233@mag.az.mvista.com>
References: <20070305032307.GB31417@localhost.localdomain>
	<20070305032452.810C1DDF1B@ozlabs.org>
	<20070315230230.GB3342@mag.az.mvista.com>
	<20070316001819.GE6784@localhost.localdomain>
	<20070316004717.GB10786@mag.az.mvista.com>
	<20070316005016.GI6784@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316005016.GI6784@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 16, 2007 at 11:50:16AM +1100, David Gibson wrote:
> On Thu, Mar 15, 2007 at 05:47:17PM -0700, Mark A. Greer wrote:
> > On Fri, Mar 16, 2007 at 11:18:19AM +1100, David Gibson wrote:
> > > On Thu, Mar 15, 2007 at 04:02:30PM -0700, Mark A. Greer wrote:
> > > > On Mon, Mar 05, 2007 at 02:24:52PM +1100, David Gibson wrote:
> > > > > In addition the wrapper script is rearranged to ensure that the
> > > > > platform .o is always linked first.  This means that platforms where
> > > > > the zImage entry point is at a fixed address or offset, rather than
> > > > > being encoded in the binary header can be supported using option (1).
> > > > 
> > > > But now you don't have a fixed address for _zimage_start when you use
> > > > option 2).  I don't know what address _zimage_start is at so I can't
> > > > start it.  This is an issue for fw's that don't understand ELF and simply
> > > > download a bucket of bits.  You have to tell the fw where to jump to
> > > > (e.g., go 0x410010).
> > > 
> > > The patch already includes an example that deals with this case,
> > > uImage.  The wrapper script pulls the ELF entry point information out
> > > using objdump and puts it into uboot's structure.
> > 
> > Sure, you're putting the addr into a struct in the uimage that u-boot
> > knows enough to get.
> > 
> > 'u-boot' == smart
> > 'my firmware' == dumb
> > 
> > I'm talking about a fw that knows *nothing* about what its downloading/
> > running--its just a bucket of bits/instructions.  It doesn't get an address
> > out of the image.  It has to be told explicitly where to download the image
> > to and where to jump to.  As in, by someone sitting at the console who went
> > and dug out the start addr.  Or, more likely with a prestored jump cmd that
> > someone figured out the right address for and stored.  But, when the start
> > addr changes, suddenly it won't boot and someone has to figure out why,
> > find the the new start addr, modify the prestored cmd(s), and its good
> > until the next time the start addr changes.
> 
> Sorry, I misunderstood.  That sort of firmware - and the even dumber
> sort where the start address isn't configurable at all - is exactly
> what option (1) is for.  You'll need an asm platform file which
> defines _zimage_start to a fixed offset.  In your case you could
> probably just make it a jump to the generic _zimage_start.

Arg, I was afraid you were going to say that.  What I don't like is that
I'll simply duplicate the functionality of crt0.S verbatim just so I know
where the start addr is.  It really has nothing to do with crt0.S and
everything to do with the link order.

/me still thinks there's a better way.

<rant>
Actually, I like it less than I'm letting on.  Basically, you changed
something that has existed for a long time and worked fine for everyone.
In the process, my stuff and others were broken.  All of this to support
an option that there are no users of yet (AFAIK).  I think this needs to
go back to the old link order and/or a better solution found.
</rant>

Mark

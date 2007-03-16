Return-Path: <dgibson@ozlabs.org>
Date: Fri, 16 Mar 2007 11:50:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 8/15] zImage: Cleanup and improve zImage entry point
Message-ID: <20070316005016.GI6784@localhost.localdomain>
References: <20070305032307.GB31417@localhost.localdomain>
	<20070305032452.810C1DDF1B@ozlabs.org>
	<20070315230230.GB3342@mag.az.mvista.com>
	<20070316001819.GE6784@localhost.localdomain>
	<20070316004717.GB10786@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316004717.GB10786@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 15, 2007 at 05:47:17PM -0700, Mark A. Greer wrote:
> On Fri, Mar 16, 2007 at 11:18:19AM +1100, David Gibson wrote:
> > On Thu, Mar 15, 2007 at 04:02:30PM -0700, Mark A. Greer wrote:
> > > On Mon, Mar 05, 2007 at 02:24:52PM +1100, David Gibson wrote:
> > > > In addition the wrapper script is rearranged to ensure that the
> > > > platform .o is always linked first.  This means that platforms where
> > > > the zImage entry point is at a fixed address or offset, rather than
> > > > being encoded in the binary header can be supported using option (1).
> > > 
> > > But now you don't have a fixed address for _zimage_start when you use
> > > option 2).  I don't know what address _zimage_start is at so I can't
> > > start it.  This is an issue for fw's that don't understand ELF and simply
> > > download a bucket of bits.  You have to tell the fw where to jump to
> > > (e.g., go 0x410010).
> > 
> > The patch already includes an example that deals with this case,
> > uImage.  The wrapper script pulls the ELF entry point information out
> > using objdump and puts it into uboot's structure.
> 
> Sure, you're putting the addr into a struct in the uimage that u-boot
> knows enough to get.
> 
> 'u-boot' == smart
> 'my firmware' == dumb
> 
> I'm talking about a fw that knows *nothing* about what its downloading/
> running--its just a bucket of bits/instructions.  It doesn't get an address
> out of the image.  It has to be told explicitly where to download the image
> to and where to jump to.  As in, by someone sitting at the console who went
> and dug out the start addr.  Or, more likely with a prestored jump cmd that
> someone figured out the right address for and stored.  But, when the start
> addr changes, suddenly it won't boot and someone has to figure out why,
> find the the new start addr, modify the prestored cmd(s), and its good
> until the next time the start addr changes.

Sorry, I misunderstood.  That sort of firmware - and the even dumber
sort where the start address isn't configurable at all - is exactly
what option (1) is for.  You'll need an asm platform file which
defines _zimage_start to a fixed offset.  In your case you could
probably just make it a jump to the generic _zimage_start.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

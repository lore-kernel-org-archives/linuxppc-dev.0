Return-Path: <dgibson@ozlabs.org>
Date: Fri, 16 Mar 2007 11:18:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 8/15] zImage: Cleanup and improve zImage entry point
Message-ID: <20070316001819.GE6784@localhost.localdomain>
References: <20070305032307.GB31417@localhost.localdomain>
	<20070305032452.810C1DDF1B@ozlabs.org>
	<20070315230230.GB3342@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070315230230.GB3342@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 15, 2007 at 04:02:30PM -0700, Mark A. Greer wrote:
> On Mon, Mar 05, 2007 at 02:24:52PM +1100, David Gibson wrote:
> 
> <snip>
> 
> > 1) It can define a _zimage_start, in which case the platform code gets
> >    control from the very beginning of execution.  In this case the
> >    platform code is responsible for relocating the zImage if necessary,
> >    clearing the BSS, performing any platform specific initialization, and
> >    finally calling start() to load and enter the kernel.
> > 
> > 2) It can define platform_init().  In this case the generic crt0.S
> >    handles initial entry, and calls platform_init() before calling
> >    start().  The signature of platform_init() is changed, however, to
> >    take up to 5 parameters (in r3..r7) as they come from the platform's
> >    initial loader, instead of a fixed set of parameters based on OF's
> >    usage.
> 
> <snip>
> 
> > In addition the wrapper script is rearranged to ensure that the
> > platform .o is always linked first.  This means that platforms where
> > the zImage entry point is at a fixed address or offset, rather than
> > being encoded in the binary header can be supported using option (1).
> 
> But now you don't have a fixed address for _zimage_start when you use
> option 2).  I don't know what address _zimage_start is at so I can't
> start it.  This is an issue for fw's that don't understand ELF and simply
> download a bucket of bits.  You have to tell the fw where to jump to
> (e.g., go 0x410010).

The patch already includes an example that deals with this case,
uImage.  The wrapper script pulls the ELF entry point information out
using objdump and puts it into uboot's structure.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

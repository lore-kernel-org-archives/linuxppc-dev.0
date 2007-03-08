Return-Path: <dgibson@ozlabs.org>
Date: Thu, 8 Mar 2007 11:24:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 11/15] zImage wrapper for Ebony
Message-ID: <20070308002400.GB3950@localhost.localdomain>
References: <20070305032307.GB31417@localhost.localdomain>
	<20070305032452.EDB2BDDF1D@ozlabs.org>
	<20070305171053.GC32672@mag.az.mvista.com>
	<20070306000905.GC4728@localhost.localdomain>
	<20070307194732.GB30721@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070307194732.GB30721@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 07, 2007 at 01:47:32PM -0600, Scott Wood wrote:
> On Tue, Mar 06, 2007 at 11:09:05AM +1100, David Gibson wrote:
> > On Mon, Mar 05, 2007 at 10:10:53AM -0700, Mark A. Greer wrote:
> > > I think we more-or-less agreed to go with Scott Wood's 'wrap' method
> > > (unless there is a problem with it).
> > 
> > Oh, we had?
> > 
> > > http://ozlabs.org/pipermail/linuxppc-dev/2007-February/031337.html
> > 
> > Um.. I'm pretty uneasy about that, because I'm not at all sure that
> > the wrapper script does the right thing w.r.t. where it puts the .dtb
> > file, when building with a VPATH.
> 
> My patches don't change where the dtb goes as far as I can tell.  If
> there's a problem, it can be addressed with an additional patch (or if my
> patches do change it, please tell me how).

If you're building so that the object files go in a separate tree from
the source, with your patch the dtb will still go in the source tree.
The trouble is that this is fiddlier to fix with the -s option as you
use to the wrapper than the -d option, because the correct path for
the dtb must also be passed into the script.

> > Actually, longer term what I think might be a better option is to
> > build *all* the dts files into asm (with different symbolic names) and
> > fold them into the wrapper library.
> 
> I can see potential benefit in allowing multiple dtbs to be included, to
> be chosen at runtime (such as from a board ID passed from the bootloader,
> or based on detection of how the board is configured (such as detecting
> whether an MDS board is plugged into a PCI backplane, or is acting as a
> PCI agent, or is standalone)).  But why all of them?

Simplicity, and a better chance to pick up syntax errors at least for
obscure platforms.  Note that they'd be going as separate modules into
a .a, so only the relevant ones would be included in the final zImage.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

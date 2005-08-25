Return-Path: <glikely@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.197])
	by ozlabs.org (Postfix) with ESMTP id A097668093
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Aug 2005 16:28:05 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id b11so374366rne
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 23:28:04 -0700 (PDT)
Date: Thu, 25 Aug 2005 00:24:25 -0600
To: T Ziomek <ctz001@email.mot.com>, linuxppc-embedded@ozlabs.org
Message-ID: <20050825062425.GA5607@siegfried.thelikelysolution.ca>
References: <20050824134404.B1DF668108@ozlabs.org>
	<EDFB2B1ED0A1D7118A0A00065BF2490D1E3A601B@il06exm13>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EDFB2B1ED0A1D7118A0A00065BF2490D1E3A601B@il06exm13>
From: Grant Likely <glikely@gmail.com>
Subject: Re: Source of xparameter_ml300.h
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Aug 24, 2005 at 08:20:48PM -0500, T Ziomek wrote:
> On Wed, 24 Aug 2005 akonovalov@ru.mvista.com wrote:
> >
> >Grant Likely wrote:
> >But if you are speaking about the xparameters_ml300.h in the community
> >trees (linuxppc-2.4 and the 2.6 one from kernel.org), this file
> >is for the reference design by Xilinx:
> >
> >http://www.xilinx.com/ise/embedded/edk6_2docs/ml300_edk3.zip
> 
> Also, be aware that the differences between 'xparameters.h' and
> 'xparameters_ml300.h' are not all you need to worry about.
> 
> 
> MontaVista's port to the ML300 also modified various Xilinx driver source
> files (the code that appears under .../ppc405_0/include and
> .../ppc405_0/libsrc, at least for me).
>    Starting with MV's port to the ML300, you need to figure out which IP
> versions it was created for (for example, "emac_v1_00_b").  Then you need
> to compare that with the IP version used in your system [NOTE 1].  They'll
> probably be different, so then you need to either merge MV's changes into
> the newer Xilinx code or Xilinx's changes into the MV-modified drivers.
> This leaves you with software drivers that match the IP and have the chang-
> es needed to work in Linux.
Ah, yes.  I was wondering how much grief I would be dealing with in that
regard.  One of my goals is to get somewhat flexable drivers for basic
cores into mainline, so I'm sure I'll be fighting with this.
> 
>    It also looks like the Xilinx software driver bugs that MV found were
> not reported to Xilinx but just worked around, so those bugs are probably
> still present in your design.  They were in ours...
Thank's for the heads up.  Your email addr's getting a permanent place
in my address book.  :)

> 
> 
> NOTE 1:  And don't depend on Xilinx's rev numbers changing when their dri-
>          ver code does.  I regularly run across situations where consecu-
>          tive FPGA designs both use, say, the "gpio_v2_00_a" IP and driver
>          yet the driver code has changed.  It is important that you 'diff'
>          or whatever all of the driver code for changes each time you re-
>          ceive a new FPGA design generated from an XPS with *any* changes
>          at all (new version, patches, etc.), even if it appears that the
>          patch should not affect any driver code.
Hmm, lovely.

> 
> 
> In the end, MV's port of Linux is to an ML300 with an old reference design
> (even though the ML300 *board* hasn't changed, if that's true).  You're
> presumably using more current Xilinx tools and IP, so you'll have to update
> the port.  And you'll probably have to do so repeatedly.
Ai, I expect so.

IMHO the mainline code should be as simple as possible to adapt to new
boards and their associated xparameters.h.  I've created an xparameters
'abstraction layer' that keeps changes to the board more or less
isolated to the platform bus initialization data structures.  It also
prevents having to recompile the world everytime I use a different
bitstream.  However, that doesn't solve the changes to logic cores (as
you so eloquently pointed out).  At the very least I'd like to get a set
of core drivers ported/written that use #defs to adapt to the
appropriate core version.  I'll never be able to support every core
version, but I should be able to support a number of the more recent
cores.

The difficulty that I have with the current port is that there is still
a fair bit of work to adapt from one xparameters to another.

There is a very real possibilty that I'll be taking on
lots of v2pro work in the near future and I'd like to have a comfortable
foundation to start from.
> 
> 
> It's analagous to MV porting to the [non-FPGA] Acme RealCool rev A board
> while you're starting with the RealCool rev C and moving to revs D, E,
> etc. every few weeks or months.
>    This -- the relatively rapid change of FPGA 'hardware' compared to the
> typically much slower changes to a board -- is a fundamental difference be-
> tween FPGA and non-FPGA-based systems that you have to deal with.  I'm not
> sure MV fully comprehends the consequences of that; if they did I would ex-
> pect their port to document what specific IP versions it works with (not to
> mention what functionality wasn't ported, but that applies to non-FPGA
> hardware as well).
indeed

> 
> Of course, even if they did that we'd still have to suffer Xilinx's tenden-
> cy to release multiple versions of things without changing their rev num-
> bers  :-(
Yes, but we keep coming back because we love it.

s/love it/gluttons for punishment/
> 
> 
> I've been where you're going...
I feel a great sense of foreboding in that remark...  Thanks for the
long response; good info.

Did you use a 2.4 or 2.6 kernel in your work?  Are your driver changes
available for download anywhere?

Thanks,
g.

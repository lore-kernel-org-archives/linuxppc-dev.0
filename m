Return-Path: <john.bonesio@xilinx.com>
From: John Bonesio <john.bonesio@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: ppc440 caches - change proposal [RFC]
Date: Wed, 9 Apr 2008 11:00:40 -0700
References: <20080408225329.5EC171A8007D@mail11-dub.bigfish.com>
	<1207695415.14711.11.camel@pasglop>
	<fa686aa40804081615n284aa750n12ceb0bf1d1bcce1@mail.gmail.com>
In-Reply-To: <fa686aa40804081615n284aa750n12ceb0bf1d1bcce1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <20080409180042.511531370055@mail134-sin.bigfish.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

I have a question about your patch. It appears as if the cache setup code is in a file that would be used only on Xilinx FPGA devices.

I understand that many people are using a bootloader that already sets up the cache for the kernel, but I'm wondering if Xilinx boards are really a special case, or if there may be other non-Xilinx related systems that would also not be using a bootloader.

I also understand the desire to avoid code that does the same work more than once, but I wonder if in this case, it's creating too strong a dependence on the specific behavior of a certain bootloader.
I also wonder if arch/powerpc is being made more complex by trying to split out this code change into a Xilinx specific area, when the change could just be rolled into head_40x.S and we could do away with virtex405-head.S.

Just some thoughts,

- John

On Tuesday 08 April 2008 16:15, you wrote:
> On Tue, Apr 8, 2008 at 4:56 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >
> >  On Tue, 2008-04-08 at 15:53 -0700, John Bonesio wrote:
> >  > I was thinking it might be good to have the kernel initialize these
> >  > cache control registers in it's own start up code. Or perhaps this
> >  > could be done in the kernel's simple bootloader. We could probably put
> >  > this change in a Xilinx specific startup file, but this change doesn't
> >  > seem specific to Xilinx FPGA boards.
> >
> >  The kernel's wrapper would be a good place to put that I suspect. That's
> >  the kind of thing that should be provided as a "library" function to be
> >  optionally called by platform code. Either in the wrapper or the main
> >  kernel platform code.
> 
> Code is already queued up for 2.6.26 to do exactly this on ppc405
> virtex platforms.  We can do the same thing for 440.  Look at
> virtex405-head.S in the following patch:
> 
> http://patchwork.ozlabs.org/linuxppc/patch?person=486&id=17410
> 
> Cheers,
> g.
> 
> 
> -- 
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> 
> 

Message-Id: <5.1.0.14.2.20021014181528.0230c538@falcon.si.com>
Date: Mon, 14 Oct 2002 18:30:24 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Binary Compatibility of various flavors of PPC
In-Reply-To: <005AF3F9.C21188@qlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You have unreasonable expectations.  The PowerPC architecture does not
aspire to maintain total code compatibility at all levels.  It specifically
disclaims any aspirations of achieving full code compatibility.

Reference: "PowerPC Microprocessor Family: The Programming Environments"
Section 1.1.2 "The Levels of the PowerPC Architecture":

"All PowerPC devices adhere to the UISA [User Instruction Set Architecture
gvb], ensuring binary compatibility among all PowerPC application
programs.  However, there may be different versions of the VEA [Virtual
Environment Architecture gvb] and the OEA [Operating Environment
Architecture gvb] than those described here.  For example, some devices,
such as embedded controllers, may not require some of the features as
defined by this VEA and OEA, may implement a simpler or modified version of
those features."

Bottom line: if you wish to have one executable for 4xx, 8xx, 603e-core,
7xx, 74xx, etc. binaries, you will be working REALLY REALLY hard to achieve
something IBM and Motorola never intended to supply.

You best gamble (and it would be a gamble) would be to make a single image
that contained several OS executables and have your power up code detect
the processor type, load the applicable OS image into RAM and run out of
RAM.  Your application code should work unmodified, assuming you hid all
the architecture idiosyncrasies as IBM/Mot intended (such as emulating FP
on the FP-less CPUs).  Note that the application portability trick is
theoretically possible but, as several others have pointed out already, is
non-trivial.

gvb


At 04:37 PM 10/14/2002 -0400, Bret.Indrelee@qlogic.com wrote:

>On Mon, 13 Oct 2002, Kumar Gala wrote:
> > On Monday, October 14, 2002, at 01:15  PM, Matt Porter wrote:
> > > On Mon, Oct 14, 2002 at 12:13:52PM -0500, Mark Hatle wrote:
> > >> Bret Indrelee wrote:
>[ Looking to have compatible System and User binary image ]
> > >>> We are currently looking at the 405GPX, 8250, 8245, and PowerQUIC
> > >>> III.
>[ snip ]
> > >> If I was building a range of systems that required varying PowerPC
> > >> CPUs with a
> > >> common userspace I would stick to the 82xx/7xx/74xx families today.
> > >
> > > I'd have to agree with that.  Classic PPC core implementations
> > > currently
> > > offer the broadest selection of userspace binary compatible processors.
> >
> > I agree, but it depends on how important floating point is to ones
> > userspace.  If they do not care about FP then all of the PPC processors
> > 4xx/8xx/82xx/7xx/74xx/e500 all provide a compatible integer instruction
> > set.
>
>Float isn't important to us, we could have all float be emulated for as
>little of it we do.
>
>We need the bzImage.gz and RAM disk image have to be the same binary.
>
>The reason is simple, we don't want the customer to have the mess of
>'which of these N firmware images do I need' when trying to upgrade. We
>want the whole line of products to use the same binary image.
>
>We want a process that uses lower power and board space processor than
>the Intel but still allows us to use the same binary across the line of
>products. Our best guess of the performance levels needed are going to
>be from about a 300MHz CPU to 800MHz or 1GHz. Having even higher
>performance options in the future would be a definate plus.
>
>-Bret
>
>--
>Bret Indrelee                 QLogic Corporation
>Bret.Indrelee@qlogic.com      6321 Bury Driver, St 13, Eden Prairie, MN 55346
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

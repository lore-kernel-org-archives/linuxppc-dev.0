Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 7752FDDEDF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 04:22:27 +1000 (EST)
Date: Mon, 7 May 2007 11:23:51 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 12/13] powerpc: Add bootwrapper support for Motorola
	PrPMC2800 platform
Message-ID: <20070507182351.GC30132@mag.az.mvista.com>
References: <35d250938c0c5d7dae6a8735343059b7@bga.com>
	<20070430181954.GB7673@mag.az.mvista.com>
	<d47bc8a8db1e8b703595cd7dca25b33a@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d47bc8a8db1e8b703595cd7dca25b33a@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 30, 2007 at 11:10:08PM -0500, Milton Miller wrote:
> 
> On Apr 30, 2007, at 1:19 PM, Mark A. Greer wrote:
> 
> >On Mon, Apr 30, 2007 at 11:15:23AM -0500, Milton Miller wrote:
> >>On Thu Apr 26 10:02:27 EST 2007, Mark A. Greer wrote:
> >>>Add support for Motorola ECC PrPMC280/PrPMC2800 Platform.
> >>>The PrPMC280 sits on an F101 baseboard and the PrPMC2800 sits on a
> >>>F101e baseboard.  Logic has been added to determine which board
> >>>(and variant thereof) the code is being run on.
> 
> >>>+               setprop(devp, "device_type", "mv64362",
> >>>strlen("mv64362") + 1);
> >>That is not a device_type.   It might be a model,   Or even a
> >>compatable.  but not a type.
> >How about "host-bridge" or is that too generic?
> That would be ok but that could be precompiled, vs set in code.
> 
> I was thinking you wanted to expose the vpd determined specific
> bridge to the kernel / user.

Yes, I do want to expose that.  How about:

	device_type = "host-bridge"; /* not touched by code */
	model = "mv64360" or "mv64362"; /* set by bootwrapper code */
	compatible = "mv64x60"; /* not touched by code */

> >>>+/* Following code is put at very beginning of zImage (64KB into ELF
> >>>file) */
> >>>+asm (" .globl _zimage_start\n\
> >>>+       _zimage_start:\n\
> >>>+               mfmsr   10\n\
> >>>+               rlwinm  10,10,0,~(1<<15)        /* Clear MSR_EE */\n\
> >>>+               sync\n\
> >>>+               mtmsr   10\n\
> >>>+               isync\n\
> >>>+               b _zimage_start_lib\n\
> >>>+");
> >>>
> >
> >Yes, its a poorly worded comment.
> >
> >>Also, the 1<<15 seems magic.  I would like to see it as a constant in
> >>reg.h,
> >
> >It probably makes sense to add some MSR definitions to reg.h.
> >
> >>but to use that you would have to pass it as an i parameter, so
> >
> >I don't follow.  What's wrong with '#define MSR_EE (1<<15)'
> >in reg.h and 'rlwinm  10,10,0,~MSR_EE'?
> 
> I think you will find that cpp doesn't replace the define inside
> the string.   And by the time you stop the string, stringify the
> define, and restart the string, you might as well pass it as a
> parameter.  Also, in C we sometimes add things like ULL that
> aren't valid in assembler, although that's more of a 64 bit issue.

Okay, I'll take a look.  Thanks for your comments, Milton.

Mark

Return-Path: <chuckmeade@mindspring.com>
Received: from elasmtp-dupuy.atl.sa.earthlink.net
	(elasmtp-dupuy.atl.sa.earthlink.net [209.86.89.62])
	by ozlabs.org (Postfix) with ESMTP id DD21EDE077
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 23:21:11 +1000 (EST)
Message-ID: <4A19465D.3040503@mindspring.com>
Date: Sun, 24 May 2009 09:06:37 -0400
From: Chuck Meade <chuckmeade@mindspring.com>
MIME-Version: 1.0
To: Hunter Cobbs <hunter.cobbs@gmail.com>
Subject: Re: PPC405EX based irq flooding with USB-OTG and usbserial device
References: <ad84a70a0905222048i4e7ae5ddp66418f96d531f5f3@mail.gmail.com>	<20090523181422.794B3832E416@gemini.denx.de>
	<ad84a70a0905231150s18026213r9360eb6807ab842e@mail.gmail.com>
In-Reply-To: <ad84a70a0905231150s18026213r9360eb6807ab842e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hunter Cobbs wrote:
> On Sat, May 23, 2009 at 1:14 PM, Wolfgang Denk <wd@denx.de
> <mailto:wd@denx.de>> wrote:
> 
>     Dear Hunter,
> 
>     In message
>     <ad84a70a0905222048i4e7ae5ddp66418f96d531f5f3@mail.gmail.com
>     <mailto:ad84a70a0905222048i4e7ae5ddp66418f96d531f5f3@mail.gmail.com>>
>     you wrote:
>     >
>     > This is my first post to the PPC dev list as my company has just
>     started
>     > developing a new project based on Linux.  The good news is, this
>     post is not
>     > debug-related as much as it is an introduction and query while I
>     download
>     > the latest DENX kernel(only place I know that has the DWC_OTG driver).
> 
>     there is a strong reason why we decided  not  to  try  to  push  this
>     driver  upstream:  it  is not in a state that would have a chance for
>     being accepted for mainline. The problems you  are  experiencing  are
>     probably   not   the   only  one.  Please  consider  this  driver  as
>     unsupported.
> 
>     Best regards,
> 
>     Wolfgang Denk
> 
>     --
>     DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
>     HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>     Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email:
>     wd@denx.de <mailto:wd@denx.de>
>     "Ada is PL/I trying to be Smalltalk.                 - Codoso diBlini
> 
> 
> Which leads me to another question.  Since I should consider this
> unsupported, is there a better driver out there as my company is already
> well down the road with our design?  Or would you recommend just
> creating our own driver for the USB-OTG? 
> 
> I'm developing with the Kilauea, and I guess I should ask how unstable
> is Linux support for this Processor.
> -- 
> Hunter Cobbs

Hi Hunter,

First, thanks very much for the email, and for the patches to fix the DMA.  I had
assumed, both when I saw the DMA warnings and when I saw the defines in the Makefile,
that DMA was absolutely not ready for primetime on PPC405EX USB.  Needless to say I
will be testing out your DMA patches here.

If that works for me, that should mitigate some of this interrupt overhead.  So thanks
in advance -- I am hoping that this will make a real difference.

To answer your recent question, I have had no other difficulties with the PPC405EX.
I actually work with 3 different custom targets right now using the PPC405EX (one uses
the PPC405EXr variant), and have had no problems outside of USB.

I do not know of any other driver for the PPC405EX USB controller.

My other remaining USB issue on this controller is a bandwidth issue.  There is another
USB host controller called ehci commonly found on PCs, and I see that they have a
configurable scheduler tweak called CONFIG_USB_EHCI_TT_NEWSCHED.  The description in
the drivers/usb/host/Kconfig file for that config item under ehci (in the Kconfig file
search for USB_EHCI_TT_NEWSCHED) is *exactly* the problem I am having now on the PPC405EX
USB controller.  Of course that scheduler tweak is for a totally different USB controller,
so that doesn't help me directly, but it serves as an example.  If anybody else out there
has fixed this USB bandwidth issue on PPC405EX (the one described in the ehci solution
for this under USB_EHCI_TT_NEWSCHED), please let me/us know.

Thanks,
Chuck

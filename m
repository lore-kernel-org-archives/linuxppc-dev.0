Return-Path: <BillF@optiscan.com>
Received: from mail.optiscan.com (mail.optiscan.com [203.26.112.1])
	by ozlabs.org (Postfix) with ESMTP id 48E63DDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Jan 2007 14:46:30 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Boot w/ VGA console - PCI nvidia
Date: Tue, 30 Jan 2007 14:46:29 +1100
Message-ID: <34E73CC1202BF246B7DE3463BEBC0689303D84@postie.optiscan.com>
In-Reply-To: <000c01c74417$913d51c0$6405a8c0@absolut>
References: <mailman.1354.1170085533.9285.linuxppc-embedded@ozlabs.org>
	<000c01c74417$913d51c0$6405a8c0@absolut>
From: "Bill Farrow" <BillF@optiscan.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Russell McGuire wrote:
> Thanks for the info. Looking around I see that there
> is some aged code in the U-boot tree under the MIA
> board that is a BIOS emulator. Seems like a huge mess
> to get a video card to turn on.

Yes, I came across that code in my investigation as well. As Xiao points
out in his email, this code is an earlier version of the SciTech code.
I didn't get around to comparing it with the Xorg code either.

> I am using a Freescale MPC8360 so yes, ppc
> architecture and thus the problems with BIOS emulation
> with PCI.
>
> Do we still need a BIOS emulator if we don't want to
> run the VGA console during bootup, but only for post
> boot?

I'm pretty sure that you don't need uboot to do the emulation if you
don't need graphics at this point. As long as you are happy to wait
until Xorg has started before you can display anything.

> I.e. does the NVIDIA driver have enough smarts to
> initialize the card after Linux is 100% booted up?
> I really only need to be able to use the graphics card
> for user applications, and booting with it is not a
> requirement. If somehow I could boot with the serial
> console, and then run a user mode application that
> initiated the card?

I think you will find that the Xorg driver will use it's own x86emu to
initialise the card properly when X starts.  I haven't confirmed this
myself yet, I guess I need to look at the Xorg code and then actually
try it out.  This was the impression that I got from talking to one of
the video driver hackers at Linux.Conf.au a couple of weeks back,
specifically about running x86 graphics cards on PPC.

Are you able to get your kernel to mount a PPC distro via NFS so that
you have a full Xorg installation to test with, without having to build
it yourself ?

Bill

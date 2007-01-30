Return-Path: <rmcguire@uwbt.com>
Received: from mail19k.g19.rapidsite.net (mail19k.g19.rapidsite.net
	[204.202.242.122]) by ozlabs.org (Postfix) with SMTP id 2D45FDDFAC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Jan 2007 13:37:38 +1100 (EST)
Received: from mx104.stngva01.us.mxservers.net (198.173.112.41)
	by mail19k.g19.rapidsite.net (RS ver 1.0.95vs) with SMTP id
	3-0375814648 for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Jan 2007 21:37:32 -0500 (EST)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.1354.1170085533.9285.linuxppc-embedded@ozlabs.org>
Subject: RE: Boot w/ VGA console - PCI nvidia
Date: Mon, 29 Jan 2007 18:37:17 -0800
Message-ID: <000c01c74417$913d51c0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.1354.1170085533.9285.linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bill / ALL

Thanks for the info. Looking around I see that there is some aged code in
the U-boot tree under the MIA board that is a BIOS emulator. Seems like a
huge mess to get a video card to turn on.

I am using a Freescale MPC8360 so yes, ppc architecture and thus the
problems with BIOS emulation with PCI.

Do we still need a BIOS emulator if we don't want to run the VGA console
during bootup, but only for post boot?

I.e. does the NVIDIA driver have enough smarts to initialize the card after
Linux is 100% booted up? I really only need to be able to use the graphics
card for user applications, and booting with it is not a requirement. If
somehow I could boot with the serial console, and then run a user mode
application that initiated the card?

-Russ



Russell McGuire wrote:
> Next I have plugged in a nVidia GeForce FX5200 PCI card,
> and compiled in the nvidafb driver.
>
> I can see clearly the PCI card is being detected and the
> nvidiafb driver is being registerd, it can even detect
> the monitor I have connected.
>
> However, when I enabled the kernel to use the framer
> buffer console, by compiling in that feature, it just 
> 'seems' to hang after the console_init call.

Hi Russ,
I got to the same point last year with an ATI PCI card on a MPC8560
system. At this stage, I believe that to get the card displaying
graphics you will need to run the card's Video BIOS to initialise the
card correctly.

I'm guessing that you are running a PPC cpu :-) and that the FX5200 is a
consumer x86 graphics card.  If so, the Video BIOS will be x86
instructions and you will need to run it with an emulator.

A company called SciTech is maintaining an x86emu project for doing
this:
  http://www.scitechsoft.com/products/dev/x86_emulator.html

I believe that Xorg also has a x86emu module, so I was going to see if I
could get an Xorg installation going and let it do it's magic.

For us, getting Xorg running would prove the graphics capability of our
platform and we can start writing a GUI.  Then it would be just a matter
of getting uBoot to display something during boot to keep the customers
happy...


Bill

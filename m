Return-Path: <jonsmirl@gmail.com>
Received: from mail-yx0-f181.google.com (mail-yx0-f181.google.com
	[209.85.210.181]) by ozlabs.org (Postfix) with ESMTP id 732AFB7B93
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 22:16:00 +1000 (EST)
Received: by yxe11 with SMTP id 11so3046102yxe.15
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 05:15:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1253803279.4632.91.camel@allano>
References: <1253803279.4632.91.camel@allano>
Date: Fri, 25 Sep 2009 08:15:57 -0400
Message-ID: <9e4733910909250515p60e0b0e0v8c10063326fe882c@mail.gmail.com>
Subject: Re: lite5200b kernel not booting
From: Jon Smirl <jonsmirl@gmail.com>
To: Asier Llano Palacios <asierllano@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Aitor Arzuaga <a.arzuaga@usyscom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 24, 2009 at 10:41 AM, Asier Llano Palacios
<asierllano@gmail.com> wrote:
> Hi Grant,
>
> We've been working with a lite5200b for a while, we have been working
> with the ppc platform in linux 2.6.x for 5 years and it worked properly
> until 2.6.25 included. We want to switch to the powerpc platform but it
> doesn't seem to work.
>
> After the bootloader (tested with the uboot 1.2.0 and 2009.08) starts
> the cuImage.lite5200 it doesn't show anything in the console.
>
> I'd like to know if the lite5200b is still supported and which version
> is known to work with it and what is the default configuration. I want
> to test it like the developers do, until I configure it myself.
>
> I've managed to do some debugging in assembler, to know that it works
> properly until DCACHE is enabled in setup_common_caches of
> arch/powerpc/kernel/cpu_setup_6xx.S. If I skip enabling the DCACHE it
> continues properly until the MMU is enabled.
>
> I'm only debugging it writing to the serial port registers in assembler,
> so I'm not very sure if it continues properly or if I am not able to
> debug it after the DCACHE is enabled or the MMU is enabled. I want to
> debug it with a JTAG debugger, but I still don't have one (do you
> recommend me anyone?).

No one has tried the Macraigor USB wiggler on the mpc5200 and reported
back if it works.

Chart says it is supported...
http://www.macraigor.com/cpus.htm

It's a $250 device so it would good to know if it works.
http://www.macraigor.com/usbWiggler.htm

uboot 1.2 is very old. That may be the cause of your problems. For
example old u-boots don't initialize the PCI hardware correctly on
systems that don't have PCI implemented.

In general the current powerpc kernel works fine on the mpc5200b. We
are running it on four different CPU boards but I don't have a
lite5200b.

We use the Phytec dev boards. We've never had any trouble with them.
http://www.phytec.de/de/produkte/rapid-development-kits/linux-kits/produktdetails.html?tx_ttproducts_pi1[backPID]=270&tx_ttproducts_pi1[product]=62&cHash=6fbc8dcdb2

http://www.phytec.com/products/rdk/PowerPC/phyCORE-MPC5200B-tinyRDK.html



>
> Kind regards and thank you for the help,
> Asier
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



-- 
Jon Smirl
jonsmirl@gmail.com

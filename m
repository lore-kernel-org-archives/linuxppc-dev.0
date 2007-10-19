Return-Path: <Leonid@a-k-a.net>
Received: from mis011-1.exch011.intermedia.net
	(mis011-1.exch011.intermedia.net [64.78.21.128])
	by ozlabs.org (Postfix) with ESMTP id 7106BDDF32
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 02:03:21 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: powerpc 440 monitor program
Date: Fri, 19 Oct 2007 08:51:12 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3C02528FA0@ehost011-3.exch011.intermedia.net>
In-Reply-To: <20071019034904.GA4407@localhost.localdomain>
References: <f3566d60710182032h69e2d2bejafd96f18dae95829@mail.gmail.com>
	<20071019034904.GA4407@localhost.localdomain>
From: "Leonid" <Leonid@a-k-a.net>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	"Bai Shuwei" <baishuwei@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In order to achieve your goal you must do at least following things:

1) enable FRAMEBUFFER_CONSOLE option in the kernel.
2) Upon reboot make getty for the monitor terminal device (could be
tty1, but you must check).

You may add line to your inittab file

tty1::respawn:/sbin/getty 38400 tty1

Speed parameter is irrelevant and may not be needed for your getty
version.

3) To see the penguin logo you must also enable one of BOOT_LOGO defines
in kernel.

Of course I assume that framebuffer is working in your system. You may
try to check it by typing "cat /dev/zero > /dev/fb0". Terminal must be
cleaned then.

You also can try "dirty" hack to ensure framebuffer functionality. Type:

sh > /dev/tty1 2>&1 < /dev/tty1

You must get prompt on monitor (your serial will hang) and if you have
working (USB?) keyboard, you will be able to use monitor.

Thanks,

Leonid.
-----Original Message-----
From: linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org
[mailto:linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org] On =
Behalf
Of David Gibson
Sent: Thursday, October 18, 2007 8:49 PM
To: Bai Shuwei
Cc: linuxppc-dev@ozlabs.org; linuxppc-embedded@ozlabs.org
Subject: Re: powerpc 440 monitor program

On Fri, Oct 19, 2007 at 11:32:33AM +0800, Bai Shuwei wrote:
> all,
>     hi, when I boot my system, there are no output on the screen.
> I choice the framebuffer and my monitor card is ATI PAGE 128 PCI, qt/e
GUI.
> When i compile the kernel, the boot logo and aty 128fb has be compiled
into
> kernel patched with videoboot, and x86emu. The video parameters set:
>      video=3Daty128fb:640x480-16@7.
>     The kenel can recognize the monitor card, and the frame buffer
device
> has run.
> The output showed below:
>=20
>     videoboot: Booting PCI video card bus 0, function 0, device 6
>    aty128fb: Found Intel x86 BIOS ROM Image
>    aty128fb: Rage128 BIOS located
>    aty128fb: Rage128 RK PCI [chip rev 0x2] 32M 64-bit SDR SGRAM (2:1)
>    fb0: ATY Rage128 frame buffer device on Rage128 RK PCI
>=20
> My problem is there is no output on the monitor,and cannot see the
penguin
> boot logo.

Uh.. most 440 systems use a serial console.  It ought in theory to be
possible to use a framebuffer instead, but it wouldn't surprise me if
rather a lot of debugging was necessary.

--=20
David Gibson			| I'll have my music baroque, and my
code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_
_other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

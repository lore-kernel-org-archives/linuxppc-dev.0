Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 114EFDDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 May 2007 22:42:36 +1000 (EST)
Message-ID: <4656D9BE.3000809@anagramm.de>
Date: Fri, 25 May 2007 14:42:38 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Bill Farrow <BillF@optiscan.com>
Subject: Re: MPC8560 Gianfar driver hangs after soft reboot
References: <34E73CC1202BF246B7DE3463BEBC068998EE82@postie.optiscan.com>
In-Reply-To: <34E73CC1202BF246B7DE3463BEBC068998EE82@postie.optiscan.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Bill!

Bill Farrow schrieb:
> The Gianfar driver is hanging during boot-up after a soft reboot.  It
> works fine when the board is power cycled.
> 
> Any hints on where to look further on this issue?

I have had some rare issues with PHY initialization on the PM854
with the u-boot-1.2.0 not being able to download something
via TFTP. There is an entry somewhere in the U-Boot wiki (I think)
that the TQM8540 board can have some issues... well the boards
are quite similar.
Pushing the reset button (Never needed to power that off) solves
the issue.

> 3. After rebooting, the system starts up Linux and it hangs after:
> 
>   eth0: Gianfar Ethernet Controller Version 1.2, 00:40:42:01:00:00
>   eth0: Running with NAPI enabled
>   eth0: 256/256 RX/TX BD ring size

The Kernels I 've tried (2.6.13 up to 2.6.21-rc5 and some latest gits)
never stopped there...
I would just try another kernel. Checkout the code in the latest
git.

> Also tried soft rebooting without the network cable and the kernel boots
> without hanging, but the network does not work when the re-connected.
> The PHY seems to be working because when we plug the cable back in it
> detects the link and writes this console message:
> 
>   [ 1557.465085] PHY: 0:01 - Link is Up - 100/Full
> 
> Note that there are two Ethernet controllers on the board (eth0 and
> eth1).  Only eth1 is connected to the network.

What PHY's do you have on these ports?
(MV88E1111 over here)

> Background info:
> Kernel version 2.6.20.4 PPC
> Uboot version 1.2.0
> Busybox version 1.5.0
> ELDK: 4.1
> JTAG: BDI-2000
> Board : Microsys PM856 - with MPC8560 processor.

Looks good. I am using the PM854.

Well, some other thing: I had some instabilities on my prototyping
hardware in the beginnging, but I guess due to EMI and the sloppy setup.
After I got all the stuff nailed down onto some aluminum-plate, the
boards is working _very_ stable (24/7).

Greets,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com

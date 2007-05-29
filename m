Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id DA8B5DE093
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 May 2007 21:41:52 +1000 (EST)
Message-ID: <465C1185.7040204@anagramm.de>
Date: Tue, 29 May 2007 13:41:57 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Bill Farrow <BillF@optiscan.com>
Subject: Re: MPC8560 Gianfar driver hangs after soft reboot
References: <34E73CC1202BF246B7DE3463BEBC068998EE82@postie.optiscan.com>	<4656D9BE.3000809@anagramm.de>
	<34E73CC1202BF246B7DE3463BEBC068998EE91@postie.optiscan.com>
In-Reply-To: <34E73CC1202BF246B7DE3463BEBC068998EE91@postie.optiscan.com>
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

Hello, Bill!

Bill Farrow schrieb:
> On 25 May 2007 Clemens Koller wrote:
>> Bill Farrow schrieb:
>>> The Gianfar driver is hanging during boot-up after a soft
>> reboot.  It works fine when the board is power cycled.
>>> Any hints on where to look further on this issue?
>> I have had some rare issues with PHY initialization on the
>> PM854 with the u-boot-1.2.0 not being able to download something via 
>> TFTP. There is an entry somewhere in the U-Boot wiki (I think) that 
>> the TQM8540 board can have some issues...
>> well the boards are quite similar.
>> Pushing the reset button (Never needed to power that off) solves the 
>> issue.
> 
> We have found a work around for this problem: If the network interfaces
> are disabled before doing a soft reboot then everything works properly.
> We are using the ramdisk from the ELDK 4.1 and are no rc scripts for
> busybox to call to shutdown the network interfaces before rebooting.  We
> will just add our own script to do this when rebooting.

Something like:

          /sbin/ip route del default
          /sbin/ip link set eth0 down
          /sbin/ip addr del 192.168.1.200/24 dev eth0
(or something similar using the ifconfig <foo>)

Or how do you define to "shutdown the network interfaces"?

I guess I am lucky that I always had rc scripts running on my system.
(native distribution on harddisk, based on http://crux.nu )

> Agreed. I did look at some future kernel versions to see what changes
> had been made to the gianfar source code, but your right, we should try
> some out on the actual hardware.

Yup, there were lots of changes, also in the PHY/MII interface.

> We are using the Microsys carrier board with the PM856 module and has
> been quite stable.

Same over here. It's good stuff!

Best greets,
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

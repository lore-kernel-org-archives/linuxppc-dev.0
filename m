Content-Type: text/plain; charset=iso-8859-1
MIME-Version: 1.0
To: Bo.Yu@motorola.com
Cc: linuxppc-embedded@lists.linuxppc.org
From: acurtis@onz.com
Subject: Re: Does linux (for target 82xx) clear DPRAM after boot
Date: Wed, 09 Oct 2002 11:17:34 -0700 (PDT)
Message-Id: <20021009111736.29321.h003.c007.wm@mail.directvinternet.com.criticalpath.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Does Linux for powerpc 82xx clear DPRAM (immr to immr+64k) ? The reason I
> ask is to verify if I can comment out all the port pin configuration in
> uart.c and
> fcc_enet.c or not as the boot code (vxWorks based) already configure pins
> correctly.

There isn't one place where DPRAM is "cleared". UART stuff is modified in
multiple places. FCC ethernet is confined to the driver. (but the UART stuff
could affect ethernet)

> Currently I am able to see printouts in serial port smc1 but I
> could not see any frames even bad frames using ethereal sniffer. But
> apparently
> the kernel is trying to send out DHCP requests. But I did see periodical
> blink
> of the link LED on the hub. The only thing I could think that could be wrong
> is
> mii pin configuration. The board is using intel Lxt 971 phy and i think the
> default
> setting will work after hard reset without explicit configuration thru MDIO.

You should be able to build with MII configuration disabled. (depending on the
kernel version) The problem you are experiencing if probably related to incorrect
configuration of full/half duplex and speed. Look in the driver initilialization.
(default driver will setup for half duplex is you are not using MII to get the
mode from the PHY)


> Another question is how to remove
>
> ttyS1 on SMC2 at 0x0040, BRG2
> ttyS2 on SCC1 at 0x8000, BRG3
> ttyS3 on SCC2 at 0x8100, BRG4

I think there are conditional compiles in 8260_io/uart.c
. If not, modify the array.

------------------------------------------------------------
Allen Curtis              |  All good things come to those
Ones and Zeros, Inc.      |  who wait. Some of us have to
mailto:acurtis@onz.com    |  wait a little longer.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

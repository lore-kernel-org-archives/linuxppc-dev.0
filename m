Message-ID: <3BC5B5B6.1070308@capflow.com>
Date: Thu, 11 Oct 2001 17:07:34 +0200
From: Laurent Pinchart <laurent.pinchart@capflow.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: possible bug in arch/ppc/8xx_io/fec.c
References: <3BC58BE6.8000302@capflow.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Reply-To: laurent.pinchart@capflow.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I think I found a bug in arch/ppc/8xx_io/fec.c. When I boot a 2.4.7
linux kernel on a FADS860T board, I get an oops in mii_link_interrupt.
After a few experiments, I found out the following.

My PHY chipset is a LXT970A. The FDS/MDINT pin, which is connected to
IRQ2 on the MPC860T, has 2 functions on the LXT970A. When bit 17.1 (bit
1 of the PHY register 17) is set, an active low output on this pin
indicates status change. When bit 17.1 is not set, the pin indicates
full-duplex status.

At boot time, bit 17.1 is not set, and thus the FDS/MDINT signal is low
when the network cable is disconnect. The PHY interrupt handler
(mii_link_interrupt) gets registered when fec_enet_init() is called, and
thus spurious interrupts are generated which causes the kernel to oops
because at that time the pointers used in the interrupt handler are not
yet initialized. The 17.1 bit is set only much later when the
phy->startup command is executed, which is when fec_enet_open() is called.

So, for the FADS860T to boot correctly, it needs the network cable to be
connected at boot time, and to be in full duplex mode. After bootup, as
soon as fec_enet_open() is called, things work fine again and the cable
can be disconnected.

What would be the best way to correct that bug ? I was thinking about
adding a phy->init command, which would be called right after PHY
detection, in mii_discover_phy3(), and to register the
mii_link_interrupt() interrupt handler only after PHY detection,
possibly in fec_enet_open().

All comments are welcome.

Laurent Pinchart


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <3BD4070D.9040405@capflow.com>
Date: Mon, 22 Oct 2001 13:46:21 +0200
From: Laurent Pinchart <laurent.pinchart@capflow.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem using FEC on a860T
References: <sbd43a78.005@tms-pty.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Reply-To: laurent.pinchart@capflow.com
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>
>when I compile without "MDIO for PHY configuration"
>the kernel prints forever the message  "fec.c[1374] mii_link_interrupt:
>unexpected Link interrupt
>on the console at boottime.
>
>when I compile with it, the kernel Oopses.
>after carefull debugging, I tracked it down to the line 1367 in
>arch/ppc/8xx_io/
>    mii_do_cmd(dev, fep->phy->ack_int);
>
>it is a kernel access of bad area.
>
There is a problem in the FEC driver. The MII link interrupt gets
enabled too soon, before the PHY interface chip is configured. I believe
that the problem has been fixed in the linuxppc_2_4_devel tree. It was
supposed to be fixed much sooner, but the patch got lost somewhere
between the developpers and the development tree.

The problem should not occur if a full duplex ethernet link is connected
to the board at boot time.

Laurent Pinchart


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Fri, 23 Jul 2004 10:36:28 -0500
From: David Wolfe <david.wolfe@freescale.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC5200, Hang in send() to a socket
Message-ID: <20040723153628.GA32654@orthanc.sps.mot.com>
References: <42A622EB18325843894BB8E1040E3DF50227A4@sinaexchf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42A622EB18325843894BB8E1040E3DF50227A4@sinaexchf>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[ I?igo Lopez Barranco writes: ]
> Hi. I'm testing a program to send files thru a TCP socket on an MPC5200.

> programs stops forever in one of the writings to the socket after
> having sent a random number of packets. Strace says that it stops on a
> send(), and netstat shows that the connection is stablished, and stays
> this way:

I see this problem too during a FTP put operation. The network remains up
as a concurrently executing ping has no problem and I can restart the FTP
transfer which will happily transfer an random number of packets before
halting again. I also noticed a nasty memory leak associated with this
-- if I rerun the FTP transfer enough times the system will run out of
memory. It may be related to lost RX packets. The RX error count seen
from "ifconfig" adds up very quickly on a put. FTP get doesn't provoke
this bug nearly as much.

I'm looking into the driver, though I am quite unfamiliar with Linux
networking kernel code.

--
David Wolfe
Digital Audio, Radio & Telematics
Freescale Semiconductor

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

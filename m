From: "Georg Klug" <gklug@giga-stream.de>
To: "KISHINAMI Masaya" <kishinami@cs.fujitsu.co.jp>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: AW: 405GP Networking issue
Date: Fri, 28 Feb 2003 14:59:11 +0100
Message-ID: <FFECLICFNBJAHONLGAKMAEINCIAA.gklug@giga-stream.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <200302281227.AA02348@kishinami.cs.fujitsu.co.jp>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Kishinami,

> We are debugging a custom board designed based on the 405GP
> (200MHz) and have a problem not being sent ECHO REPLY ping
> packet from custom board to our PC via repeater hub on the
> heavy traffic under 10Mbps and half duplex condition.

> ...

> Following are the our simplest duplication process and the
> results.
>
> 1. Connect the repeater hub to backbone LAN.
> 2. Connect custom board, test PC to ping and other PCs to the
>    repeater hub to the full. This case, 10 or more PCs are
>    connected to repeater hub and each PC works normally by
>    using network.
> 3. Increase the traffic by using ftp command. The ftp data was
>    never addressed to the custom board.
> 4. Ping from our PC to custom board at one time.
> 5. The 60% pings were lost such condition.
> 6. We investigated the ping lost case.
>    - LAN protocol analyzer captured the ECHO REQUEST which was
>      address to custom board. It shows ECHO REQUEST was issued
>      from our PC to LAN cable.
>    - Logic analyzer captured the same ping packet which was
>      already been captured by LAN analyzer between PHY(Intel
>      LXT971A) and EMAC. It shows ECHO REQUEST was reached just
>      before the EMAC.
>    - The LAN device driver's receive buffer did not receive the
>      ECHO REQUEST by using printk command. We suspected that the
>      ECHO REQUEST was not issued to the MAL(Memory Access Layer),
>      therefore ECHO REQUEST was not translated to the receive
>      buffer.
>
> At the same time, many 4 byte short packet(0x000000f0) which was
> not addressed to custom board was received to the LAN device driver's
> receive buffer with error status. According to 405GP manual, EMAC
> discards the packet which is not of its own.

to me it looks like an half duplex issue. You should check whether both:
sender and receiver know that they are connected to a half duplex hub.
Otherwise collisions could occur which are not detected by the receiver
and also not by the transmitting entity. So you should make sure that
FDE is set to 0 in the EMAC Mode register 1 (EMAC0_MR1) according to
the Users manual)

Georg


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

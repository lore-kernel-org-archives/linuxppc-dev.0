In-Reply-To: <v04220801b4daa2e26f84@[10.0.0.42]>
Date: Thu, 24 Feb 2000 12:12:10 +0100
To: "Timothy A. Seufert" <tas@mindspring.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: PCI I/O address problems on B&W G3
Message-Id: <20000224121210.030675@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Feb 24, 2000, Timothy A. Seufert <tas@mindspring.com> wrote:

>01:04.0 SCSI storage controller: Adaptec 7899A (rev 01)
>	Subsystem: Adaptec: Unknown device f620
>	Flags: bus master, 66Mhz, medium devsel, latency 16, IRQ 25
>	BIST result: 00
>	I/O ports at fe000000
>	Memory at 80883000 (64-bit, non-prefetchable)
>	Expansion ROM at 80900000 [disabled]
>	Capabilities: [dc] Power Management version 2
>
>01:04.1 SCSI storage controller: Adaptec 7899A (rev 01)
>	Subsystem: Adaptec: Unknown device f620
>	Flags: bus master, 66Mhz, medium devsel, latency 16
>	BIST result: 00
>	I/O ports at fe000000
>	Memory at 80882000 (64-bit, non-prefetchable)
>	Expansion ROM at 808e0000 [disabled]
>	Capabilities: [dc] Power Management version 2


Hum... Both cards are behind the PCI<->PCI bridges, and so they should
both have io addresses in the range fe001000 -> fe001fff

The fact that they are at fe000000 seems to indicate that the io base
address is 0 (and so was apparently _not_ assigned at all). Could you
break into OF, dev to those devices, and send me the output of
.properties ? (I need the content of the "reg" and "assigned addresses"
properties). I want to see what OF did with the cards exactly.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

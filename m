Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Thomas Geffert" <thomas.geffert@keymile.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: tqm 8260 scc ethernet crc errors
Date: Fri, 8 Nov 2002 08:05:10 -0800
Message-ID: <NCBBIINEHIPFGJPLBEIFAEHIDOAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <l64rb1xyw2.fsf@de-h-tge-lx.de-h.dt.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Check that all the flags are properly configured for full-duplex mode. I had
a similar problem with FCC ethernet where a bit was missing on the config
options.

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Thomas
> Geffert
> Sent: Friday, November 01, 2002 4:23 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: tqm 8260 scc ethernet crc errors
>
>
>
> Hello,
>
> I've problems with receiving packets with an TQM8260 board on the SCC
> 10Mbit ethernet interface.
>
> If I connect two tqm boards directly via an ethernet crossover cable and
> send udp packets from one board to another the receiving CPM marks
> 1-15% of all packets with an crc error flag (this depends on packet
> size and send speed).  When I check the udp checksum of the received
> packets this check only ails for approx 5-10% of the marked packets,
> e.g.
>
> Send packets in 5s      CPM says CRC-Error[1]   UDP checksum error
> =====================================================================
> 6000 (512 bytes each)   591 / 9.8%              94 / 1.6%
> 4850 (512 bytes each )  220 / 4.5%              34 / 0.7%
>
> 6000 (128 bytes each)   182 / 3%                43 / 0.7%
>
> The faster the packets are send and the longer the packets are
> the more errors
> are detected. If I send the packets with a rate <50 packets/s I got almost
> no crc errors.
>
> I'm very surprised over the errors, as I use a direct connection
> between the boards and send only in one direction. In such a case I
> would expect to get no errors. Can this be an EMI error of the
> physical SCC ethernet interface of the tqm boards?
>
> I also connected the tqm board via a switch to a PC 10Mbit ethernet
> interface and got slightly smaller error rates, but they are still
> there. If I use the FCC ethernet interface I don't get this problems.
>
> Did anyone make similiar experiences or has an idea how this
> errors can happen?
>
> I use the DENX linux-2.4.4-2002-10-06 (patched for RTAI linux 24.1.10)
> and enabled full duplex mode in the SCC enet.c driver (without full
> duplex I got also crc errors and lots of dropped packets).
>
> Thomas Geffert
>
> Footnotes:
> [1]  I got this value from the scc1 parameter ram field crcec.
>
> --
> Dipl.-Ing. Thomas Geffert
> KEYMILE / Datentechnik Intercom GmbH
> Frankenring 14, 30855 Langenhagen, Germany
> Tel +49 (0)511 978197-669 / Fax +49 (0)511 978197-670
> mailto:thomas.geffert@keymile.com / http://www.keymile.com
>
> <<< Since 1st of October 2002 Datentechnik & Ascom Transmission serve
> you as KEYMILE >>>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

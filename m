Subject: Re: FEC on MPC862P freezes CPM
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3EBFDDD4.5010707@net.hcc.nl>
References: <3EBFDDD4.5010707@net.hcc.nl>
Content-Type: text/plain
Date: 13 May 2003 09:55:59 +0100
Message-Id: <1052816159.29719.2.camel@zambia>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I don't understand what you mean by "SCC1 is used for ethernet".  You
already said that you're using the FEC!  Either use FEC for ethernet or
use an SCC.  You cannot use both - after all there's only one MII bus!

Alex

On Mon, 2003-05-12 at 18:45, Willy Jacobs wrote:
>
> We are using a MPC862P (XPC862PCZP80B, 2K26A silicon) in a system with
> UTOPIA (master) and FEC simultaneously in UTOPIA muxed bus mode. The
> processor runs at 50 MHz (CPM and bus). For references in the MPC862
> Users' Manual, see figure 35-1 (page 35-4), table 41-6 (page 41-7), and
> figure 42-3 (page 42-7). The FEC MII signals are mapped on PCMCIA port A.
>
> For testing we are using Linux. The Linux console is mapped onto SCC3,
> and SCC1 is used for ethernet. Initialization for SCC3 is done first,
> followed by the initialization of the FEC (as described on paragraph
> 41.3 (page 41-8)): ECNTRL[FEC_PINMUX]=1; setup the buffer descriptors;
> UTMODE[SPLIT]=0, PDPAR[UT]=1; PDPAR[8]=1 (MDII_MDC). A printk to SCC3 in
> above situation will "freeze" the CPM in the transmit of the SCC3
> buffers. More concrete it will never pass this while loop:
> 	while (bdp->cbd_sc & BD_SC_READY) ;
> The UTIOPIA initialization will be done later.
>
> With PDPAR[UT]=0 SCC3 and UTOPIA works without any problem.
> Note that above CPM "freeze" problem also occurs using another RTOS
> (VRTX) and a similar use of SCCs, FEC, and UTOPIA.
>
> Is this problem known?
> Is there another initialization sequence needed?
> --
> willy
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <75DF04AC5ED4D511A9810090273CB416615564@user4.sw.co.il>
From: Eli Brin <elib@rokonet.co.il>
To: "'Alex Zeffertt'" <ajz@cambridgebroadband.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: FEC on MPC862P freezes CPM
Date: Tue, 13 May 2003 13:24:41 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Alex,

The FEC and SCC Ethernet don't share the PHY chip and each one has its own
bus to the PHY, so way cant you use both FEC and SCC for Ethernet ?

Actually we did configure FEC and SCC for Ethernet both on the u-boot and
kernel (ELDK on TQM860L) and we got eth0 and eth1.

I have noticed that u-boot (and ppc-boot) prohibits this on the FADS860T
board (don't know why).

Regards,
Eli Brin


-----Original Message-----
From: Alex Zeffertt [mailto:ajz@cambridgebroadband.com]
Sent: Tuesday, May 13, 2003 10:56 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: FEC on MPC862P freezes CPM



I don't understand what you mean by "SCC1 is used for ethernet".  You
already said that you're using the FEC!  Either use FEC for ethernet or use
an SCC.  You cannot use both - after all there's only one MII bus!

Alex

On Mon, 2003-05-12 at 18:45, Willy Jacobs wrote:
>
> We are using a MPC862P (XPC862PCZP80B, 2K26A silicon) in a system with
> UTOPIA (master) and FEC simultaneously in UTOPIA muxed bus mode. The
> processor runs at 50 MHz (CPM and bus). For references in the MPC862
> Users' Manual, see figure 35-1 (page 35-4), table 41-6 (page 41-7),
> and figure 42-3 (page 42-7). The FEC MII signals are mapped on PCMCIA
> port A.
>
> For testing we are using Linux. The Linux console is mapped onto SCC3,
> and SCC1 is used for ethernet. Initialization for SCC3 is done first,
> followed by the initialization of the FEC (as described on paragraph
> 41.3 (page 41-8)): ECNTRL[FEC_PINMUX]=1; setup the buffer descriptors;
> UTMODE[SPLIT]=0, PDPAR[UT]=1; PDPAR[8]=1 (MDII_MDC). A printk to SCC3
> in above situation will "freeze" the CPM in the transmit of the SCC3
> buffers. More concrete it will never pass this while loop:
> 	while (bdp->cbd_sc & BD_SC_READY) ;
> The UTIOPIA initialization will be done later.
>
> With PDPAR[UT]=0 SCC3 and UTOPIA works without any problem. Note that
> above CPM "freeze" problem also occurs using another RTOS
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

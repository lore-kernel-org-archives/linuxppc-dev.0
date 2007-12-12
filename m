Return-Path: <kari.davidsson@marel.is>
Received: from mail.marel.com (mail.marel.com [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id C19E1DDF64
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Dec 2007 21:36:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: LPC burst accesses
Date: Wed, 12 Dec 2007 10:36:56 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB027FEE75@is-hdq-exchange.marel.net>
In-Reply-To: <14274105.post@talk.nabble.com>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kari.davidsson@marel.is>
To: <linuxppc-embedded@ozlabs.org>
Cc: WITTROCK <jwittrock@maginst.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks,

Using this configuration of the SCLPC I was able to get burst accesses.

Getting bursts with the SDMA general purpose task (without the SCLPC =
fifo) is
still a mistery to me. I somehow have the feeling that with the CPU one =
can only
get bursts if we are capable of executing code out of the bank, which =
implies=20
multiplexed mode of the bank. Multiplexed mode I am not able to do, at =
least
not at this time.

rg
kd=20


--=20
K=E1ri Dav=ED=F0sson                   | kari.davidsson@marel.is
Hugb=FAna=F0arger=F0                   | www.marel.com
Tel: +354 563 8156 Fax: +354 563 8001
Iceland

-----Original Message-----
From: linuxppc-embedded-bounces+karidav=3Dmarel.is@ozlabs.org =
[mailto:linuxppc-embedded-bounces+karidav=3Dmarel.is@ozlabs.org] On =
Behalf Of WITTROCK
Sent: 11. desember 2007 13:43
To: linuxppc-embedded@ozlabs.org
Subject: Re: LPC burst accesses


I remember doing something like this a while back.  I ended up not =
implementing it in my project for other reasons, but here is some =
correspondence I had with Freescale:


The question
---------------------------------------------------------------------
I am using the LocalPlus bus and BestComm on a MPC5200B to communicate =
with an external FPGA.

I am currently using CS2 as the chip select for the FPGA.  If I =
configure the chip select 2 configuration register for a 16bit address =
width and 2 byte bus width then all works well (MBAR + 0x0308 =3D =
0x00003500).

I am now trying to configure CS2 to operate in LargeFlash mode with 2 =
byte bus width and 26bit address (MBAR + 0x0308 =3D 0x00003D00) in order =
to support a burst read.  I have configured the Chip Select Burst =
Control Register (BRE2=3D1), and ensured that PCI is disabled, however I =
do not see a burst read performed on the bus.

Before I investigate any further, should it be possible to use the LP in =
LargeFlash mode together with its assosciated FIFO and BestComm to =
perform a burst read?


The Reply
Local Plus controller performs burst read from LargeFlash or MostGraphic =
memory only if an XLB master (CPU) or SCLPC interface initiates burst =
access.

In the case of CPU, you should enable cache for Local Plus memory.
In the case of SCLPC, you should define BPT=3D8 in the SCLPC Control =
Register (MBAR + 0x3C08).

Other configurations doesn't force bursting.

Thank you for your interest in Freescale Semiconductor products and for =
the opportunity to serve you.
Should you need to contact us with regard to this message, please see =
the notes below.

I hope its of some use.

-WITTROCK



--
View this message in context: =
http://www.nabble.com/LPC-burst-accesses-tp14270986p14274105.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

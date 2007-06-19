Return-Path: <kashiwagi@co-nss.co.jp>
Received: from nssinet2.co-nss.co.jp (nssinet2.co-nss.co.jp [150.96.0.5])
	by ozlabs.org (Postfix) with ESMTP id 12A9FDDF3F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jun 2007 02:15:35 +1000 (EST)
MIME-Version: 1.0
Date: Wed, 20 Jun 2007 00:51:04 +0900
Subject: Re: Virtex 4 Avnet Mini-Module Networking.
From: Yoshio Kashiwagi <kashiwagi@co-nss.co.jp>
To: Glenn.G.Hart@us.westinghouse.com, linuxppc-embedded@ozlabs.org
Message-ID: <JC2007062000510426.11290234@co-nss.co.jp>
Content-Type: text/plain; charset=ISO-2022-JP
In-Reply-To: <OF3C9BCACE.144FD16A-ON852572FF.004F2888-852572FF.005457E7@ct.wec.com>
References: <OF3C9BCACE.144FD16A-ON852572FF.004F2888-852572FF.005457E7@ct.wec.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Glenn-san,

The PLB TEMAC driver is supporting checksum off loading (checksum
calculation by hardware).
If the same kernel source is used, isn't the hardware checksum
of PLB TEMAC disabled by the MHS file of Mini-Module?

BEGIN plb_temac
 PARAMETER INSTANCE = plb_temac_0
 PARAMETER HW_VER = 3.00.a
 PARAMETER C_PLB_CLK_PERIOD_PS = 10000
 PARAMETER C_TXFIFO_DEPTH = 131072
 PARAMETER C_RXFIFO_DEPTH = 131072
 PARAMETER C_MAC_FIFO_DEPTH = 64
 PARAMETER C_BASEADDR = 0x80000000
 PARAMETER C_HIGHADDR = 0x8000ffff
 PARAMETER C_INCLUDE_RX_CSUM = 1    <--- H/W checksum enable
 PARAMETER C_INCLUDE_TX_CSUM = 1    <--- H/W checksum enable
 PARAMETER C_RX_DRE_TYPE = 2
 PARAMETER C_TX_DRE_TYPE = 2

Yoshio Kashiwagi - Nissin Systems

> I am having trouble using the network on the Avent Mini-Module.  I had 
the
> network working on the ML403 board with Linux 2.6.19.
> 
> The kernel comes up fine with the Mini-Module and the network seems to 
work
> until I try to use it.  I can configured the ethernet with ifconfig 
and can
> even ping another machine on the network.
> 
> The problem is with the TCP layer.  It seems almost everytime the
> Mini-Module sends TCP information the checksum is reported an wrong 
(via
> ethereal).  The only thing that comes to mind is the ML403 uses a 
Marvell
> PHY and the Mini-Module has a Broadcom PHY.  I do not know enough 
about
> low-level networking to know where the problem is.  Is the checksum
> generated in the PHY?  Could something be wrong in Linux programming 
the
> Broadcom PHY and not the Marvell PHY?  Why is it only the TCP 
information
> (the IP information has the correct checksum)?
> 
> Thanks for any information you can offer.
> 
> Glenn

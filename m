Return-Path: <jlburr@cadence.com>
Received: from mx-sanjose.cadence.com (mx-sanjose.Cadence.COM [158.140.2.60])
	by ozlabs.org (Postfix) with ESMTP id AF716DDF7E
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 09:16:49 +1100 (EST)
Received: from MAILNA1.global.cadence.com (localhost [127.0.0.1])
	by mx-sanjose.cadence.com (8.12.9/8.12.9) with ESMTP id mBAJhGTp006872
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 11:43:26 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: ppc440spe-adma: ADMA driver for PPC440SP(e) and 64-bit physical
	addresses
Date: Wed, 10 Dec 2008 14:42:06 -0500
Message-ID: <2315F4A3362D0045AA06DFA9999664EC027921D0@MAILNA1.global.cadence.com>
From: "John Burr" <jlburr@cadence.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am confused about the capabilities of the PPC440SPe DMA hardware.  I'm =
wondering if I can use it to transfer data between system memory and a =
PCI Express slave-only device.  To do that, the DMA scatter-gather list =
entry used by the DMA hardware would need to support addresses > 32-bits =
as the PCI Express slave memory is mapped by Linux above the 4GB line =
(i.e. 440SPe hardware uses a 36-bit physical address).
=20
The AMCC PPC440SPe User's Manual V1.27 chapter 20 on the I20/DMA core =
indicates (among other things):
=20
DMA0 features include:
* Any source PLB address to any destination address
* 64-bit addressing
=20
These items lead me to think I should be able to do this.  However, =
section 20.5.1, "Basic Command Descriptor Block Structure" indicates:
=20
"The DMA engine only supports the simple addressing Scatter/Gather List =
(SGL) format defined in I2O (v1.5).  No other SGL formats are =
supported."
=20
>From what I can see from the I20 V1.5 specification, only 32-bit =
physical addresses are supported in the SGL entry. =20
=20
I looked over the recent post of the ppc440spe-adma ADMA driver and see =
the physical addresses used seem to be type dma_addr_t.  That's 32-bits =
on the PPC440SPe powerpc Linux platform.  So, this leads me to believe I =
cannot use the DMA hardware to address above the 4GB line.
=20
I don't get why the 440SPe DMA hardware goes to such lengths to support =
the placement of the CDBs anywhere in memory (these do use 64-bit =
addresses) while then limiting the SGL addresses for the data itself to =
32-bits.  I believe the completely different DMA hardware on the 440GX =
did not have this kind of "weirdness".
=20
Is there any way to use the 440SPe hardware to transfer data to a PCI =
Express slave device?  If so, are there any drivers that show how to do =
it?
=20
I realize that my PCI Express device should really be a master and do =
its own transfer.  But that's not an option in the near term.  I'm =
trying to use DMA to try to get higher-performing burst transfers on the =
PCI Express interface (as compared to the quite-slow CPU-based memcpy =
I'm using now).
=20
Thanks for your help.
=20
John Burr
=20
=20

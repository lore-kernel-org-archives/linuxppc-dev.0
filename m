Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id DA67867B52
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 13:26:22 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k7P3QK8s009144 for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 20:26:20 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k7P3QIMV019636
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 22:26:19 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Cache coherency question
Date: Fri, 25 Aug 2006 11:26:16 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263511B7A0@zch01exm21.fsl.freescale.net>
In-Reply-To: <821B2170E9E7F04FA38DF7EC21DE487106282397@VCAEXCH01.hq.corp.viasat.com>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Martin, Tim" <tim.martin@viasat.com>, "ppc" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Tim> I'm using an MVME6100 with Linux 2.6.14 and experiencing what=20
Tim> I think is a cache coherency problem.  An external PCIX=20
Tim> master performs a DMA transfer of a well known data pattern=20
Tim> into SDRAM, but when the device driver goes to look at the=20
Tim> data it is mostly okay, but occasionally has garbage.

If the hardware is reliable, I think you are right. The cache coherency
problem.

Tim> I'm allocating the memory using alloc_skb, then giving a PCI=20
Tim> translated pointer to the PCIX master.  Since I think it is a=20
Tim> cache coherency problem, I tried to use the dma_cache_inv=20
Tim> macro to invalidate the cache before looking at the data, but=20
Tim> realized that for this board, that function does nothing=20
Tim> since CONFIG_NOT_COHERENT_CACHE is undefined.  So
Tim> questions:

If the CONFIG_NOT_COHERENT_CACHE is not set.
You are assuming and using the hardware cache coherency mechanism.

Tim> 1) Should the processor bus cache snooping actually work on=20
Tim> an MVME6100?
Tim> E.g. is it correct that CONFIG_NOT_COHERENT_CACHE is undefined?

Yes, you can undefine the CONFIG_NOT_COHERENT_CACHE, but you must
make sure the host bridge did the snooping setup for PCI inbound
transaction.
If you setup the snooping window, I think the host bridge will assert
/GLB signal
to processor. The processor will snoop the 60x/MPX bus to keep cache
coherence.

Also, you can define the CONFIG_NOT_COHERENT_CACHE, then you are
assuming
The system has not hardware coherency. You need use the software to keep
the cache
coherency.

Tim> 1a) Does this type of bus snooping work when a bus master=20
Tim> physically external to the PowerPC chip is doing the transfer?

As above, you must tell the bridge what address need snoop. If you did,
The proceesor will do snooping.

Tim> 2) If this really is a cache coherency problem, are there=20
Tim> other cache management functions available in ppc linux=20
Tim> besides the dma_cache_inv, dma_cache_wback,=20
Tim> dma_cache_wback_inv macros I should be looking at?

I think it is a cache coherency problem,
if you define the CONFIG_NOT_COHERENT_CACHE
You can get these functions, dma_map_single


-Dave

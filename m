Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 04DD267C45
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Aug 2006 02:05:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Cache coherency question
Date: Fri, 25 Aug 2006 09:05:01 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE4871062827EA@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: "Liu Dave-r63238" <DaveLiu@freescale.com>,
	"ppc" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>=20
> Tim> I'm using an MVME6100 with Linux 2.6.14 and experiencing what I=20
> Tim> think is a cache coherency problem.  An external PCIX master=20
> Tim> performs a DMA transfer of a well known data pattern into SDRAM,=20
> Tim> but when the device driver goes to look at the data it is mostly=20
> Tim> okay, but occasionally has garbage.
>=20
> If the hardware is reliable, I think you are right. The cache=20
> coherency problem.

The hardware is reliable.

>=20
> Tim> 1) Should the processor bus cache snooping actually work on an=20
> Tim> MVME6100?
> Tim> E.g. is it correct that CONFIG_NOT_COHERENT_CACHE is undefined?
>=20
> Yes, you can undefine the CONFIG_NOT_COHERENT_CACHE, but you=20
> must make sure the host bridge did the snooping setup for PCI=20
> inbound transaction.
> If you setup the snooping window, I think the host bridge=20
> will assert /GLB signal to processor. The processor will=20
> snoop the 60x/MPX bus to keep cache coherence.
>=20

Ah.  This must be the problem.  I have a few PCI devices, and on one of
them it looked like snooping was working.  I just assumed the other
device was setup correctly.

> Also, you can define the CONFIG_NOT_COHERENT_CACHE, then you=20
> are assuming The system has not hardware coherency. You need=20
> use the software to keep the cache coherency.
>=20

I tried this, and got compiler errors.

>=20
> Tim> 2) If this really is a cache coherency problem, are there other=20
> Tim> cache management functions available in ppc linux besides the=20
> Tim> dma_cache_inv, dma_cache_wback, dma_cache_wback_inv=20
> macros I should=20
> Tim> be looking at?
>=20
> I think it is a cache coherency problem, if you define the=20
> CONFIG_NOT_COHERENT_CACHE You can get these functions, dma_map_single
>=20

I added some inline assembly dcbi/dcbf (invalidate/flush) instructions
to the particular code in question, and the problems went away.  So
definitely a cache problem.  As I said above, defining
CONFIG_NOT_COHERENT_CACHE causes compiler errors, so I'm going to look
into this more.  I suppose whatever file implements the
include/linux/dma-mapping.h stuff isn't BSP specific, so its probably
just not being compiled in?  Will look into it.

Thanks for you help,
Tim

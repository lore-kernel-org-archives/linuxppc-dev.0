Return-Path: <B38951@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A03382C034C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 21:12:37 +1100 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>
Subject: RE: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Tue, 5 Mar 2013 10:12:26 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01BE9527@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1362386425-20149-1-git-send-email-B38951@freescale.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7173@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7173@saturn3.aculab.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: David Laight [mailto:David.Laight@ACULAB.COM]
> Sent: Tuesday, March 05, 2013 1:16 AM
> To: Jia Hongtao-B38951; linuxppc-dev@lists.ozlabs.org;
> galak@kernel.crashing.org
> Cc: Wood Scott-B07421
> Subject: RE: [PATCH V4] powerpc/85xx: Add machine check handler to fix
> PCIe erratum on mpc85xx
>=20
> > A PCIe erratum of mpc85xx may causes a core hang when a link of PCIe
> > goes down. when the link goes down, Non-posted transactions issued via
> > the ATMU requiring completion result in an instruction stall.
> > At the same time a machine-check exception is generated to the core to
> > allow further processing by the handler. We implements the handler
> > which skips the instruction caused the stall.
>=20
> Just skipping the instruction doesn't seem a good idea.
> But I suspect that re-initialising the PCI interface is also almost
> impossible.

This *skipping* is the best way I thought for this errata.
It's not perfect but works.

-Hongtao.

>=20
> Does the mpc83xx have the same errata?
> We've seen machine-check faults using the CSB bridge on an 83xx doing a
> 'pio' access after a PEX_DMA transfer to certain target addresses stalls
> - software gives up waiting for the dma.
> The target is an fpga, nothing is mapped at those addesses - but we'd
> expect to get ~0u back as happens on other slave windows.
>=20
> I also remember some problems with single word DMA.
>=20
> 	David
>=20
>=20

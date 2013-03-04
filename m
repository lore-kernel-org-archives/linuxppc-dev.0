Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id B16292C0325
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 04:17:09 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 00625-09 for <linuxppc-dev@lists.ozlabs.org>;
 Mon,  4 Mar 2013 17:17:03 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Mon, 4 Mar 2013 17:15:42 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7173@saturn3.aculab.com>
In-Reply-To: <1362386425-20149-1-git-send-email-B38951@freescale.com>
References: <1362386425-20149-1-git-send-email-B38951@freescale.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Jia Hongtao" <B38951@freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <galak@kernel.crashing.org>
Cc: B07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> A PCIe erratum of mpc85xx may causes a core hang when a link of PCIe
> goes down. when the link goes down, Non-posted transactions issued
> via the ATMU requiring completion result in an instruction stall.
> At the same time a machine-check exception is generated to the core
> to allow further processing by the handler. We implements the handler
> which skips the instruction caused the stall.

Just skipping the instruction doesn't seem a good idea.
But I suspect that re-initialising the PCI interface is also
almost impossible.

Does the mpc83xx have the same errata?
We've seen machine-check faults using the CSB bridge on an 83xx
doing a 'pio' access after a PEX_DMA transfer to certain target
addresses stalls - software gives up waiting for the dma.
The target is an fpga, nothing is mapped at those
addesses - but we'd expect to get ~0u back as happens on other
slave windows.

I also remember some problems with single word DMA.

	David

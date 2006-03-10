Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D1B50679E1
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Mar 2006 10:13:38 +1100 (EST)
Subject: Re: Unmapping pages from the linear addressing without HIGHMEM	support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <22544.1141981797@www088.gmx.net>
References: <1141942301.3603.12.camel@localhost.localdomain>
	<22544.1141981797@www088.gmx.net>
Content-Type: text/plain
Date: Sat, 11 Mar 2006 10:13:30 +1100
Message-Id: <1142032411.4057.31.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> That would mean I cannot reuse the code in dma-mapping.c, right? Killing the
> BAT mappings or limiting the memory size covered by the BATs seems to be
> fairly easy, but I guess I have to setup my own page table for the reserved
> DMA memory area and implement my own alloc_pages() function!?

No, just limit the size of the BAT mapping and mark some of the top
pages of the address space reserved... That should be enough.

Ben.

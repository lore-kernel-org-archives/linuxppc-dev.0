Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 28EDADE28E
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 09:28:13 +1100 (EST)
Subject: Re: __pa giving strange phys address on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "dibacco@libero.it" <dibacco@libero.it>
In-Reply-To: <KD4CZC$63E26AC2C9F30D8D9F146E56F7574045@libero.it>
References: <KD4CZC$63E26AC2C9F30D8D9F146E56F7574045@libero.it>
Content-Type: text/plain
Date: Thu, 08 Jan 2009 09:27:59 +1100
Message-Id: <1231367279.2142.25.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-01-07 at 21:59 +0100, dibacco@libero.it wrote:
> Hi all,
> 
> I'm using a linux 2.6.19 (from Denx ELDK) on a PPC MPC880. In a driver
> (that uses TDM channels) I have some calls to __pa to get the physical
> address corresponding to a virtual address. The physical address
> returned by __pa is higher than the maximum physical memory I have on
> the board. This result make my driver hang. The driver I'm trying to
> use was written for a 2.4 kernel and I'm wondering if I have to
> replace the calls to __pa with some other API/MACRO.

__pa can only be used on memory coming from the kernel linear mapping.

You probably need to change your driver to use the proper DMA mapping
APIs instead

Cheers,
Ben.

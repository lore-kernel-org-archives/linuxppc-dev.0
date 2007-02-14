Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id ADD5BDDE37
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 08:59:07 +1100 (EST)
Message-ID: <45D38624.2010604@freescale.com>
Date: Wed, 14 Feb 2007 15:59:00 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
References: <20070213060904.GA6214@localhost.localdomain>	<20070213061026.5837FDDDE9@ozlabs.org>	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>	<1171470754.4003.101.camel@zod.rchland.ibm.com>	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B86F@az33exm25.fsl.freescale.net>	<9df9bf3adf511f4c1a7945e022fdd447@kernel.crashing.org>	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B8EF@az33exm25.fsl.freescale.net>
	<1171489360.20192.184.camel@localhost.localdomain>
In-Reply-To: <1171489360.20192.184.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>>The current practice seems to be that an "soc" node contains
>>all the on chip devices (regardless of the physical bus internal
>>to the soc).
> 
> 
> That's the current FSL practice yes. As I said, I'm not too fan of it. I
> prefer a more precise representation of the internal bus layout.

I think it makes sense at least for the FSL SoCs, in that from an 
addressing perspective it is like a bus -- the entire block of devices 
can be relocated by writing to one IMMRBAR register, and the only 
hardcoded address is the offset into that block.

Putting the devices at the root level would make it harder to implement 
a template dts fragment for a given SoC that can be included in a board 
dts, where different boards may want to put the IMMR in different 
places.  It could be done with macros and addition, but it'd be simpler 
to be able to just update reg and ranges in the soc node.

-Scott

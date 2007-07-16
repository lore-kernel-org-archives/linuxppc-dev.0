Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E8733DDE07
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 07:55:16 +1000 (EST)
Message-ID: <469BE93E.1070702@freescale.com>
Date: Mon, 16 Jul 2007 16:55:10 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>	<9696D7A991D0824DBA8DFAC74A9C5FA3030669AF@az33exm25.fsl.freescale.net>	<28A3F6B9-512B-4D86-8E0D-A7680CCE2354@kernel.crashing.org>
	<1184622446.25235.89.camel@localhost.localdomain>
In-Reply-To: <1184622446.25235.89.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> I would personally be inclined to define that whatever spec we come up
> with always require #address-cells/#size-cells for any node that can
> have either device children or interrupt children, and ban default
> values alltogether.

When is #size-cells used in the interrupt tree at all?

And given the odd behavior of using an interrupt map in an interrupt 
parent that is not the device parent (you're potentially using keys from 
different domains that could clash, be a different sizes, etc), if we 
make any changes in that regard, I'd forbid interrupt maps in interrupt 
controllers with no device children, and thus #address-cells has no 
meaning there.

-Scott

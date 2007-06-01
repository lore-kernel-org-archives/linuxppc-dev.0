Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5E547DDEB7
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 09:27:05 +1000 (EST)
Subject: Re: [PATCH 6/8] Let subordinate transparent bridges be transparent.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1180720134.14219.66.camel@ld0161-tx32>
References: <1180720134.14219.66.camel@ld0161-tx32>
Content-Type: text/plain
Date: Sat, 02 Jun 2007 09:26:56 +1000
Message-Id: <1180740416.19517.476.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-01 at 12:48 -0500, Jon Loeliger wrote:
> In pcibios_fixup_bus(), bridges that are subordinate
> to transparent bridges were still relocating their
> IORESOURCE_IO start and end values.
> 
> Fix this by preventing the transparent bridge from
> relocating the start and end values, thus allowing the
> subordinate non-transparent bridge full molestation rights.
> 
> Signed-off-by: York Sun <yorksun@freescale.com>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> ---

NAK. The mem case needs a similar fix. I think we should instead do

- 			if (!res->flags)
- 				continue;
+ 			if (!res->flags || bus->self->transparent)
+ 				continue;


Cheers,
Ben.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE13DDDE1A
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 07:13:38 +1000 (EST)
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <4662EAA9.70104@ru.mvista.com>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<bd6ef296692e8cfb81118f2dc85189a5@kernel.crashing.org>
	<4662EAA9.70104@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 04 Jun 2007 07:12:00 +1000
Message-Id: <1180905120.31677.22.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-06-03 at 20:22 +0400, Sergei Shtylyov wrote:
> 
>     No, it doesn't -- since that info is almost *absolutely* useless
> (the only 
> exception is "cfi") in the context of Linux MTD subsys.
>     Please, try to understand that knowing that chip is CFI compatible
> in 
> itself doesn't yet guarantee that you can access the chip -- it all
> depends on 
> its mapping to the real physical address range, therefore this group
> IMO 
> cannot even constitute a valid "compatible" property.

You make no sense to me. It's like saying that knowing that a 8250 chip
on ISA cannot be accessed if you don't know it's IO ports so it
shouldn't say "8250" in compatible property ?!?!?!?

Also, whatever shortcomings of the linux MTD drivers are totally
irrelevant to what is correct to have in a device-tree. While we do
tailor our device-tree specification around linux needs in most cases,
there are cases like this one where common sense should be enough to
understand that it's not because the linux MTD subsystem, as of today,
cannot be told what programming interface to use, that we shouldn't
provide that information in the tree.

Regarding physical address ranges for the flash mapping, I suppose the
best is to define a property for flash chips for it. 

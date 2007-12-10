Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 17B1ADDE02
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 17:20:08 +1100 (EST)
Subject: Re: [PATCH] pci: Fix bus resource assignment on 32 bits with 64b
	resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg Kroah-Hartman <greg@kroah.com>
In-Reply-To: <20071210061559.2E3DDDDE02@ozlabs.org>
References: <20071210061559.2E3DDDDE02@ozlabs.org>
Content-Type: text/plain
Date: Mon, 10 Dec 2007 17:19:55 +1100
Message-Id: <1197267595.6563.58.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-12-10 at 17:15 +1100, Benjamin Herrenschmidt wrote:
> The current pci_assign_unassigned_resources() code doesn't work properly
> on 32 bits platforms with 64 bits resources. The main reason is the use
> of unsigned long in various places instead of resource_size_t.
> 
> This fixes it, along with some tricks to avoid casting to 64 bits on
> platforms that don't need it in every printk around.
> 
> This is a pre-requisite for making powerpc use the generic code instead of
> its own half-useful implementation.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> This version now uses casts as Greg asked for and adds proper setup
> of the prefetchable base & limit "upper" registers when using 64 bits
> resources.

Crap ! Ignore it. I forgot to quilt ref again... won't build.

Sending it again, with a separate patch fixing a warning in setup-res.c
that isn't directly related to the changes to setup-bus.c

Cheers,
Ben.

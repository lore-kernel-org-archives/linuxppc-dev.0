Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31FABDDDE9
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 14:22:45 +1100 (EST)
Subject: Re: [PATCH] pci: Fix bus resource assignment on 32 bits with 64b
	resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg Kroah-Hartman <greg@kroah.com>
In-Reply-To: <20071205064116.D849BDE10A@ozlabs.org>
References: <20071205064116.D849BDE10A@ozlabs.org>
Content-Type: text/plain
Date: Thu, 06 Dec 2007 14:22:27 +1100
Message-Id: <1196911347.7033.15.camel@pasglop>
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


On Wed, 2007-12-05 at 17:40 +1100, Benjamin Herrenschmidt wrote:
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
> This version fixes some stupid warnings when using 32 bits resources

 ... and has warnings on 64 bits platforms... GRRRR

This whole issue of printk vs. resource_size_t is a terrible mess :-(

Part of the problem is that resource_size_t can be either u32 or u64..

that is  it can be either unsigned int, unsigned long or unsigned long
long... and we have no way to reliably printk that.

Any clever idea before I start pushing filthy macros up linux/types.h ?

Cheers,
Ben.

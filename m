Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9ED71DDDFB
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 18:59:19 +1100 (EST)
Subject: Re: [PATCH] pci: Fix bus resource assignment on 32 bits with 64b
	resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20071206063940.GA16474@kroah.com>
References: <20071205064116.D849BDE10A@ozlabs.org>
	<1196911347.7033.15.camel@pasglop> <20071206063940.GA16474@kroah.com>
Content-Type: text/plain
Date: Thu, 06 Dec 2007 18:58:54 +1100
Message-Id: <1196927934.7033.39.camel@pasglop>
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


On Wed, 2007-12-05 at 22:39 -0800, Greg KH wrote:
> > that is  it can be either unsigned int, unsigned long or unsigned
> long
> > long... and we have no way to reliably printk that.
> 
> We do this already just fine.  Take a look in the kernel, I think we
> just always cast it to long long to be uniform.

I wanted to avoid that for two reasons:

 - casts are fugly
 - it adds support code to cast & handle 64 bits to 32 bits platforms
   that wouldn't normally need it

Now, if you really think that's the way to go, I'll respin with casts
(I've used cast in subsequent patches merging bits & pieces of the
powerpc 32 and 64 bits PCI code too in fact).

I was just hoping somebody had a better idea, like a way to add a new
format specifier to printk without losing gcc type checking :-)

Cheers,
Ben.

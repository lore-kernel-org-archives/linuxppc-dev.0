Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17E18DE486
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 21:37:08 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] 4xx: Add endpoint support to 4xx PCIe driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200804101221.43154.sr@denx.de>
References: <1207149149-17107-1-git-send-email-sr@denx.de>
	<1207819649.6958.3.camel@pasglop>  <200804101221.43154.sr@denx.de>
Content-Type: text/plain
Date: Thu, 10 Apr 2008 20:35:35 +1000
Message-Id: <1207823735.6958.7.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-04-10 at 12:21 +0200, Stefan Roese wrote:
> 
> Sure, this would be optimal. But frankly, I currently have no need for
> this 
> non U-Boot mode, and therefore I didn't implement it. This can be
> added later 
> when really needed don't you think?

It can... but on the other hand, it's not hard :-)

> Good. But again, I would really prefer to first include this U-Boot
> style 
> endpoint support and later add this independent device tree endpoint 
> configuration when really needed.

Well, you are the one with a use case... but I do think we should
differenciate a PCI in host mode vs. endpoint mode right away. We don't
want the PCI stack from kicking in at all in endpoint mode, we don't
want to bother with creating the PCI infrastructure and config space
accessors etc...

> Good idea. How about "vendor-id" and "device-id"? And we probably need
> some 
> for endpoint mode too now. "vendor-id-endpoint" and
> "device-id-endpoint"?

If the host bridge in EP mode has a different name/type than the host
bridge one, just 'vendor-id' and 'device-id' will do there too.

> And how should we handle the backward compatibility? Should I set the
> old 
> values as default when those properties are not available?

Yup.

Cheers,
Ben.

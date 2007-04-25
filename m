Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E153DDF2C
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 08:17:02 +1000 (EST)
Subject: Re: [PATCH 3/6] Consolidate of_find_property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <462F93F0.5090608@genesi-usa.com>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
	<20070403224340.5533abc9.sfr@canb.auug.org.au>
	<20070403224505.5d5a1495.sfr@canb.auug.org.au>
	<20070403224610.b61c7377.sfr@canb.auug.org.au>
	<20070403224937.f6a07e56.sfr@canb.auug.org.au>
	<20070403225059.e735b5e4.sfr@canb.auug.org.au>
	<20070403225222.88e92221.sfr@canb.auug.org.au>
	<20070403230505.f96ea210.sfr@canb.auug.org.au>
	<20070403232406.ab9a3c86.sfr@canb.auug.org.au>
	<20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070412153424.bf3957f4.sfr@canb.auug.org.au>
	<20070424223245.78f4fdfb.sfr@canb.auug.org.au>
	<20070424223930.1dab0e28.sfr@canb.auug	.org.au>
	<06c51eb59847d80d9225cd6454f1957e@kernel.crashing.org>
	<17966.45645.902486.793443@cargo.ozlabs.ibm.com>
	<1177477630.14873.185.camel@localhost.localdomain>
	<c249005137aa3e50c25221f6849a70ea@kernel.crashing.org>
	<462F93F0.5090608@genesi-usa.com>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 08:16:44 +1000
Message-Id: <1177539404.14873.199.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	"David S. Miller" <davem@davemloft.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-04-25 at 18:46 +0100, Matt Sealey wrote:

> Can't the ata/ATA thing be fixed by simply fixing device trees where it
> happens? strncmp seems the standards-compliant route to take.. why clutter
> the common parsing routines with fixes for deviant platforms?

In that specific case, it's even fixed by having the driver have both
spellings in it's match list.

> The Mac obviously has a few of_platform things where you can add a
> compatible search for ata then ATA, keeping it all in the drivers (where
> relevant) and in the platform setup (where necessary)

The main problem with dropping case insensitive comparison is finding
all the other cases of broken device-trees and make sure we have
appropriate workarounds. I don't have access to all of the old apple
machines (though I have access to a quite nice sample of them) and I
generally dislike breaking something that works :-)

But I agree that in the long run, it's a better approach

Ben.

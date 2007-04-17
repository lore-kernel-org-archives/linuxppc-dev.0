Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 271AADDE37
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 09:28:29 +1000 (EST)
In-Reply-To: <200704172322.23362.arnd@arndb.de>
References: <20070417210745.GA3567@aepfle.de>
	<200704172322.23362.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <17b634b08cf34bfd093dda9fe2e18d14@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] generic check_legacy_ioport
Date: Wed, 18 Apr 2007 01:28:18 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I could be wrong, but I think I've seen fake 'isa' bus nodes in the 
> device tree
> for machines that don't actually have isa. I probably saw this on very 
> early
> cell blades (not the ones currently shipping), but perhaps others have
> made the same mistake.

JS2x SLOF pretends the LPC bus is ISA (although the two
are not completely compatible!) because otherwise
Linux wouldn't find the serial ports.  I suppose I could
have fixed the Linux code instead but it was hard enough
to understand already, and really hard to change (since
that would require testing on all previously supported
platforms).

> How about simply defining a new common function like
>
> int generic_deny_legacy_ioport(unsigned long base_port)
> {
> 	return -EINVAL;
> }
>
> so that not every platform has to define their own but can either
> set ppc_md.check_legacy_ioport to NULL, to generic_deny_legacy_ioport
> or their own function if they do something fancy?

I'd rather deny everything legacy x86 by default, and
only allow a few ranges on the few platforms that really
want that.


Segher

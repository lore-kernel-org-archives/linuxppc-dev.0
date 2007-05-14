Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 208C9DDF1D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 01:04:42 +1000 (EST)
In-Reply-To: <200705141637.19572.arnd@arndb.de>
References: <20070514075415.7999BDDEC8@ozlabs.org>
	<200705141637.19572.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <850bd1e3d0b6c5e23a2fe43154591fd9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: Rewrite IO allocation & mapping on powerpc64
Date: Mon, 14 May 2007 17:04:02 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Do you think it's ok to not treat the range between 64k and 1M special?
> There might be ISA drivers that expect devices in there.

ISA I/O space is 16-bit addressing only.

> Maybe we should
> start PHB_IO_BASE after a 1M guard area where nothing is mapped.

This can cause problems, many PCI bridges and devices
don't decode all 32 bits of the legacy I/O address space.

> Where should Olof's PCMCIA space go? The ISA or the PHB range?

It uses the legacy IDE I/O addresses, so it needs to
go to the 64kB space.  It isn't ISA though.


Segher

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3420DDEE6
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 07:52:54 +1100 (EST)
Subject: Re: [PATCH 0/4] drivers/ata: add low-level I/O calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <45A7BE3A.40508@garzik.org>
References: <200701120958.l0C9wICB019343@toshiba.co.jp>
	<45A7BE3A.40508@garzik.org>
Content-Type: text/plain
Date: Sat, 13 Jan 2007 07:50:34 +1100
Message-Id: <1168635034.5011.27.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> libata intentionally provides higher level hooks than just I/O accessors.
> 
> A low level I/O hook approach makes it difficult to take into account 
> platform-specific details like mmiowb(), especially on embedded platforms.
> 
> The high level hook approach also enables greater efficiency.  For 
> example, an embedded platform could do
> 
> 	__raw_writeb(datum, mmio_address + ATA_REG_FOO);
> 	__raw_writeb(datum, mmio_address + ATA_REG_BAR);
> 	eieio();
> 
> to optimize an entire taskfile-read or taskfile-write operation.

I've been looking at that for them and for Efika but it's acutally quite
a bit of a mess. I'd be happy if you could have a look as well, but it's
not simple to find the "right" level of abstraction to be able to use
the reset/probe handling with special reset accessors. And hooking at
the toplevel is such a wastage (LOTS of code duplication) that it's
really no fun (it's what Toshiba initial patch does, though you haven't
commented on it).

So some hints as to where you think the right hooks/abstractions would
be would be much welcome.
 
Ben.

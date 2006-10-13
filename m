Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7DA8B67A5E
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 10:04:57 +1000 (EST)
Subject: Re: Recently removed io accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
In-Reply-To: <873b9twnbb.fsf@sleipner.barco.com>
References: <873b9twnbb.fsf@sleipner.barco.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 10:04:21 +1000
Message-Id: <1160697861.4792.177.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-10-12 at 17:44 +0200, Peter Korsgaard wrote:
> Hi,
> 
> Commit 661f1cdb8b3e3c2c44e97df122c1d5643c054ce8 ([POWERPC] remove
> unused asm routines) removed the _insl / _outsl routines for 32bit
> copies with byteswap.
> 
> I've been working on adding ppc support to drivers/net/smc911x.c, and
> I was unfortunately using those routines (The ethernet controller can
> be configured for big endian mode, but the contents of the internal
> packet buffers is still little endian, so you need to byteswap in the
> tx/rx routines).
> 
> Any chance of getting them back or should I implement a (slower) loop
> myself before submitting the patch?

Well, a "packet buffer" should have no endian. When streaming in our out
a fifo, you basically stream bytes that happen to come out 2 at a time.
So unless somebody wired the hardware backward, you should do no
swapping when using the fifo.

Ben.

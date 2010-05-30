Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CD199B7D4F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 30 May 2010 15:13:14 +1000 (EST)
Subject: Re: mmio_nvram.c users ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <201005300254.22984.arnd@arndb.de>
References: <1274773439.1931.238.camel@pasglop>
	<1275104704.1931.528.camel@pasglop>
	<20100529134143.GL24511@zod.rchland.ibm.com>
	<201005300254.22984.arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 30 May 2010 15:13:03 +1000
Message-ID: <1275196383.1931.538.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2010-05-30 at 02:54 +0200, Arnd Bergmann wrote:
> The reason we have the driver is so that we're able to use the kernel
> internal functions for arch/powerpc/kernel/nvram_64.c on it, which
> operated on the well-defined interface for partitions inside of the
> nvram memory.
> 
> mtd/phram provides a completely different abstraction, which is normally
> used for block- or file system based access. They also both have
> the character device, but that's not really the main point.
> 
> The part that is unfortunate is the device_type matching in the driver,
> which was a result of clueluess firmware and Linux developers (i.e. me)
> at the time. 

Right. Which is why I want to change it to be a platform device, so that
platforms explicitely instanciate it, which is probably the best thing
for now. That way, platforms that don't want the ppc specific nvram
stuff don't have to instanciate it, or platforms who want to use the mtd
bits, etc...

Cheers,
Ben.
 

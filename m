Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F4D5DDE98
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 09:37:40 +1100 (EST)
Subject: Re: PCI reading without endian conversion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <b5e2fc790902201057of113946yea9ccc7405e31926@mail.gmail.com>
References: <b5e2fc790902201057of113946yea9ccc7405e31926@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 21 Feb 2009 09:37:30 +1100
Message-Id: <1235169450.8805.193.camel@pasglop>
Mime-Version: 1.0
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-02-20 at 12:57 -0600, Matt Sealey wrote:
> Hi guys,
> 
> What's the correct way to read from PCI address space (basically it's
> guaranteed to be non-coherent memory bar) without flipping bits like
> ioread32() does?

ioread32be() ? :-) But from what you say below, it seems the wrong
approach.

> I need to be able to copy a bank of registers from PCI address space
> into a temporary buffer so I can compare them in userspace through
> UIO. Because of the flipping and the difference between the original
> kernel driver (which used ioread32() and therefore "saw" big endian)
> and the userspace app (which has a direct view of the PCI space, and
> therefore "sees" little endian) I decided to give userspace an
> absolutely consistent little-endian view seeing as this may get ported
> to ARM in the coming months.

Your sentence above doesn't seem to make much sense to me ... Why don't
you just have your userspace use lwbrx and "see" the same thing as the
kernel ? Which would also happen to be the same thing as an ARM in LE
mode would see...

> I want to put as little code in there as possible and not laboriously
> manually flip from my ioread32() big endian values to little endian
> again (waste of time and code) if I can help it. Being able to read
> the raw value would help a lot, and if I need to do calculations on a
> small portion of the data then I can do the flips manually then (using
> le32_to_cpu and cpu_to_le32 which will be a noop on ARM), reducing the
> amount of porting I need to do in both kernel and userspace alike.
>
> So, is there something like a direct ioread32le() or so, which will
> not change behaviour across architectures, is present on ARM and PPC,
> and will handle both PCI address space, and "normal" "ioremapped"
> memory?

Little of what you say above make sense, you mix unrelated concepts and
all other weirdness mangled with purely false assumptions but from what
I can tell, what you should do is something along the line of:

 - kernel uses normal ioread32 on all platforms
 - userspace use lwbrx on powerpc and normal loads on LE platforms via
   some kind of macro you define for that

That will give you a consistent view accross the board.

Cheers,
Ben.

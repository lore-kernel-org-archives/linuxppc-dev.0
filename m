Return-Path: <neko@genesi-usa.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id B574ADDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 05:57:38 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so375903ywb.39
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 10:57:37 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 20 Feb 2009 12:57:36 -0600
Message-ID: <b5e2fc790902201057of113946yea9ccc7405e31926@mail.gmail.com>
Subject: PCI reading without endian conversion
From: Matt Sealey <matt@genesi-usa.com>
To: PowerPC dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi guys,

What's the correct way to read from PCI address space (basically it's
guaranteed to be non-coherent memory bar) without flipping bits like
ioread32() does?

I need to be able to copy a bank of registers from PCI address space
into a temporary buffer so I can compare them in userspace through
UIO. Because of the flipping and the difference between the original
kernel driver (which used ioread32() and therefore "saw" big endian)
and the userspace app (which has a direct view of the PCI space, and
therefore "sees" little endian) I decided to give userspace an
absolutely consistent little-endian view seeing as this may get ported
to ARM in the coming months.

I want to put as little code in there as possible and not laboriously
manually flip from my ioread32() big endian values to little endian
again (waste of time and code) if I can help it. Being able to read
the raw value would help a lot, and if I need to do calculations on a
small portion of the data then I can do the flips manually then (using
le32_to_cpu and cpu_to_le32 which will be a noop on ARM), reducing the
amount of porting I need to do in both kernel and userspace alike.

So, is there something like a direct ioread32le() or so, which will
not change behaviour across architectures, is present on ARM and PPC,
and will handle both PCI address space, and "normal" "ioremapped"
memory?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

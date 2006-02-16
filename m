Return-Path: <mgreer@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [63.81.120.158])
	by ozlabs.org (Postfix) with ESMTP id 4222F679E0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Feb 2006 05:04:40 +1100 (EST)
Date: Thu, 16 Feb 2006 10:46:55 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Phil Nitschke <Phil.Nitschke@avalon.com.au>
Subject: Re: scatter/gather DMA and cache coherency
Message-ID: <20060216174655.GC16848@mag.az.mvista.com>
References: <kw4q2zg45r.fsf@lamorak.int.avalon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <kw4q2zg45r.fsf@lamorak.int.avalon.com.au>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 16, 2006 at 05:51:20PM +1030, Phil Nitschke wrote:

> The problem is, that sometimes the data is corrupt (usually on the first
> transfer).  We've concluded that the problem is related to cache
> coherency.  The Artesyn 2.6.10 reference kernel (branched from the
> kernel at penguinppc.org) must be built with CONFIG_NOT_COHERENT_CACHE=y,
> as Artesyn have never successfully verified operation with hardware
> coherency enabled.
> My understanding is that their Marvel system controller (MV64460)
> supports cache snooping, but their Linux kernel support hasn't caught up
> yet.

It would have been useful if you had given the actual hardware you're
using.  It sure sounds like you're using a katana or a very similar
board.  Coherency can't work on the katana b/c there is a hw
erratum of the bridge that is not implemented on that board so
"CONFIG_NOT_COHERENT_CACHE=y" is the only option.  Fix the hardware
and the kernel will work with coherency enabled with a flip of a
switch (on the latest kernel).

For the record, don't assume that this is Artesyn's fault.  Artesyn says
that the erratum workaround is impractical and they may be right.
I don't know, I just write software...

> So if I understand my situation correctly, the device driver must use
> software-enforced coherency to avoid data corruption.  Is this correct?

It looks like Eugene is guiding you on this.  Listen to him.  I will add
that you should align your buffers on cacheline boundaries and make the
allocation sizes multiples of the cacheline size otherwise you could
have other data sharing the first and/or last cacheline of your buffers
and mess up your software cache mgmt.

Mark

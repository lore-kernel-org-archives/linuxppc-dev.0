Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DCD24B7BC6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Dec 2009 08:11:11 +1100 (EST)
Subject: Re: Recommended functions for accessing internal registers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Fortini Matteo <matteo.fortini@mta.it>
In-Reply-To: <4B179DF5.90600@mta.it>
References: <4B1547E5.6050301@mta.it> <1259787475.2076.1160.camel@pasglop>
	<4B179DF5.90600@mta.it>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Dec 2009 08:10:55 +1100
Message-ID: <1259874655.2076.1225.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-12-03 at 12:16 +0100, Fortini Matteo wrote:
> I'm on an embedded system, so every resource counts.
> One of the biggest impacts is when writing to a communication/memory 
> access FIFO or reading/writing configurations.
> In these cases, I'd just need to make sure that there's no I/O 
> reordering and/or subsequent r/w are not optimized away, I believe.
> 
> Should I switch to the deprecated "volatile" attribute?

If it's a single register fifo, you can use the _outs/_ins functions or
the iomap.h variants which are cleaner.

If it's a linear region, look at memcpy_to_io...

You can always go directly poking at it but you need appropriate memory
barriers in and around your accesses.

The reason there's a twi/isync pair inside in_* is to ensure that the
read is actually performed immediately. Without this, it could be
delayed until the CPU decides to "consume" the data which could cause
timing issues when a read is followed by a delay for example. There's a
few other reasons why it's a good idea to do so.

Cheers,
Ben.

> Thank you.
> 
> Cheers,
> Matteo
> 
> Il 02/12/2009 21.57, Benjamin Herrenschmidt ha scritto:
> > On Tue, 2009-12-01 at 17:44 +0100, Fortini Matteo wrote:
> >    
> >> I see that throughout the kernel source, internal PPC registers are
> >> accessed through [in|out]_be[32|16|8]() functions. However, they are
> >> translated into 3 inline assembly instructions, one of which is an
> >> isync, which has a huge performance hit.
> >> I tried using readl_be() which seems to be the right function according
> >> to the Documentation/ dir, but it is translated directly to in_be32(),
> >> so no luck.
> >>
> >> Is it really necessary to use all those instructions? I know I could use
> >> a (volatile u32 *) variable to avoid subsequent read/writes to be
> >> optimized out, but it seems to be a deprecated use.
> >>      
> > There are good reasons why the accessors contain those barriers. What
> > are you doing that would be performance critical enough for those to be
> > a problem ?
> >
> > Cheers,
> > Ben.
> >
> >
> >    

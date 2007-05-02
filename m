Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ECA15DDF63
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 04:05:53 +1000 (EST)
In-Reply-To: <4638B673.4090504@freescale.com>
References: <20070501165542.GA31285@ld0162-tx32.am.freescale.net>
	<65f0b79871a670eb595cca7d78e2f4e9@kernel.crashing.org>
	<4638B673.4090504@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4334c860f893dbc537a51999cea25532@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] gianfar: Add I/O barriers when touching buffer descriptor
	ownership.
Date: Wed, 2 May 2007 20:05:43 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> AFAICS you need stronger barriers though; {w,r,}mb(),
>> to prevent _any_ reordering of those memory accesses,
>> not just the compiler-generated ones.
>
> My impression was that the eieio used by iobarrier would be sufficient 
> for that, as we're not trying to synchronize between accesses to 
> different types of memory.  Is sync really required here?

For accesses to main system memory, eieio only orders
writes, not reads, so iobarrier_r() doesn't do what
you want; and iobarrier_w() isn't meant to be used for
main memory access ordering either.

Also, it is better to not use powerpc-specific interfaces
in a device driver if you don't have a strong reason to.


Segher

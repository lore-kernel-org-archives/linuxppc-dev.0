Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35A02B7043
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 02:10:25 +1000 (EST)
In-Reply-To: <alpine.LRH.2.00.0909211539520.16077@vixen.sonytel.be>
References: <alpine.LRH.2.00.0909211539520.16077@vixen.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <87FFD936-384D-4A04-AD6D-90BBDD3DAD18@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [LTP] mmapstress03 weirdness? (fwd)
Date: Mon, 21 Sep 2009 18:10:32 +0200
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux Test Project <Ltp-list@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>         if (mmap((caddr_t)(1UL << (POINTER_SIZE  - 1)) - pagesize,
>                 (size_t)((1UL << (POINTER_SIZE - 1)) - pagesize),
>                 PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_FIXED| 
> MAP_SHARED, 0, 0)
>                 != (caddr_t)-1)

> With 32-bit userland, this boils down to:
>
> | mmap addr 0x7fff0000 size 0x7fff0000
> | mmap returned 0x7fff0000
>
> i.e. mmap() succeeds,

Yes, on a powerpc64 kernel, every 32-bit userspace process has 4GB
available (well, except the lowest few pages).  The process text sits
normally at 1M and the shared libs around 256M.

> but (1) the test expects it to fail, so the test returns
> TFAIL,

That's a bug in the test then.

> but (2) ltp-pan still reports that the tests passed?

Sounds like another bug.

> In addition, sometimes mmapstress03 fails due to SEGV. I created a  
> small test
> program that just does the above mmap(), and depending on the  
> distro and what
> else I print later it crashes with a SEGV, too. Probably this  
> happens because
> the mmap() did succeed, and corrupted some existing mappings,

It probably killed the stack, which sits all the way up near 4G.

> JFYI, with 64-bit userland, this boils down to:
>
> | mmap addr 0x7fffffffffff0000 size 0x7fffffffffff0000
> | mmap returned 0xffffffffffffffff
>
> i.e. mmap() fails as expected, and the test succeeds.

It tries to map space that is reserved for the kernel (c000...)

> Does all of this sound OK?

Seems to me everything works fine, except the tests themselves.


Segher

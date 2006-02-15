Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1111B679F8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Feb 2006 10:34:15 +1100 (EST)
Date: Wed, 15 Feb 2006 17:25:20 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: risc10@freescale.com
Subject: Re: Cache-inhibited region for certain exception handler(e500 chips,
	2.4 kernel)?
In-Reply-To: <000201c6327c$1a2b80f0$b07c520a@fsl.freescale.net>
Message-ID: <Pine.LNX.4.44.0602151722050.30048-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Wed, 15 Feb 2006, Xianghua Xiao wrote:

> Is there a way to put certain exception handler(e.g. machine check) on e500
> to a cache-inhibited region? 
>  
> 1. The e500 kernel puts exception handlers at the starting of the physical
> memory.
> 2. All the physical memory are covered by a few TLB1s to do
> 0xc0000000-0x00000000 translation.
> 3. We can not add a new TLB1 to map a small piece of memory, because it has
> boundary limitation(4K...256M). We can not use two TLB1 to overlap since it
> will cause program error.
> 4. When we tried to move a handler(e.g. machine check) to a different
> location, the kernel won't boot.
> 5. We don't want to map all the exceptional handlers to be cache inhibited,
> say, the first 1MB, the performance will be horrible if we do so.
>  
> Is there a way at all to tweak things like this, i.e., put an exception
> handler into a piece of memory that is cache-inhibited?
>  
> I also thought about use mlock/mmap on /dev/mem, move the specific exception
> handler to a high address then use a separate TLB1 to cover it(need change
> link script?),etc. 
>  

Why exactly do you the mcheck handler to be cache inhibited?  One simple 
way would be to setup a temp mapping in kernel virtual address space 
somewhere and have the first thing the current handler does is jump to 
that location.

- kumar

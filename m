Message-ID: <39525027.A7343F66@embeddededge.com>
Date: Thu, 22 Jun 2000 13:43:03 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Mark S. Mathews" <mark@absoval.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can't mmap the top 1MB of /dev/mem?
References: <Pine.LNX.3.96.1000622130831.10550A-100000@tristar.cc.absoval.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Mark S. Mathews" wrote:


> ...... One thing I've noticed is that it won't let me mmap the
> top 1MB of the address space.

That should work, I do this quite regularly.  What actually fails,
the mmap() or your access to the mapped region?

There is what I do:

	mem_addr = (u_char *)mmap(NULL, FLASH_MEM_SIZE,
			(PROT_READ | PROT_WRITE), MAP_SHARED,
			mem_fd, FLASH_MEM_ADDR);

#define FLASH_MEM_SIZE and FLASH_MEM_ADDR accordingly.  I hope there
isn't some weird arithmetic rounding problem when we hit the top.  I
just usually tell this to map the upper 8M bytes.

The MMU doesn't care, if the generic Linux VM subsystem creates the PTEs
it just loads them.  I don't remember any code in the mem driver that
would prevent this either.  None of this is unique to the 8xx.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

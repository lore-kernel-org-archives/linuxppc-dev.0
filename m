Message-ID: <A33AEFDC2EC0D411851900D0B73EBEF73D9BE0@NAPA>
From: Hua Ji <hji@netscreen.com>
To: jerry <jerry.nguyen@serialsystem.com.sg>,
	Dan Malek <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: how to get the physival address
Date: Thu, 5 Apr 2001 09:58:46 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>Yes, if I use kmalloc is OK, either __pa or virt_to_phys will return the
>physical address.
>But it does not work  for  defined variable (it was defined in driver so it
>should be in kernel space, isn't it?). I  wonder  which memory space, this
>variable belong to?

My 2 cents:

Given that ONLY 2 alternatives you can use for memory allocation when
working with kernel, which
are kmalloc and vmalloc, you are facing different memory usages:

Before talking further, you may have realized:

>From 0xC0000000 to 0XC0000000 + physical_memory_size is 1:1 mapped to
0x000000~physical memory size-1.

Surely, kernel also manages virtual memory from  0XC0000000 +
physical_memory_size + 8M hole to 4G

Therefore, if you used kmalloc to allocate memory, surely, you will easily
find: virtual address-3G is the physical address. However, for vmalloc, the
case is otherwise. The reason now is clear: That virtual address is very
probably from  0XC0000000 + physical_memory_size + 8M hole to 4G. This is
REALLY dynamic. Kernel's vmalloc, just like libc malloc, will go through the
free_area to find a first-bit(libc malloc is not first fit) block for you.

Anyway, back to your question. Your variable is in a memory space after 3G.
But it is byond the 3G+physical_memory_size + 8M. For example, your machine
have a 256M memory, so your variable virtual address is possible:
3G+256M+8M+SOME_VALUE.

Wish helpful,

Mike


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

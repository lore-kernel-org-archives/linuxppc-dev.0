Mime-Version: 1.0
Message-Id: <p04330100b642f3621d2e@[192.168.0.1]>
Date: Thu, 23 Nov 2000 11:37:17 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: whacked: looking for problematic __ioremap
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Another in the "whacked-out" series of posts. I sprinkled printk
statements in __ioremap liberally to see why there appears to be a
kernel panic there, related to a call from the aic7xxx driver. Here
are the results, based on a Paulus 2.2.18pre21 init.c source:

void *
__ioremap(unsigned long addr, unsigned long size, unsigned long flags)
{
	unsigned long p, v, i;

	p = addr & PAGE_MASK;
	size = PAGE_ALIGN(addr + size) - p;

	[runtime result: p = 80901000 and size = 4096]

	if ( mem_init_done && (p < virt_to_phys(high_memory)) ) {
		[false, not executed]
	}

	if (size == 0) {
		[false, not executed]
	}

#ifndef CONFIG_8xx
	if ( (v = p_mapped_by_bats(p)) /*&& p_mapped_by_bats(p+size-1)*/ ) {
		[false, not executed]
		goto out;
	}
#endif /* CONFIG_8xx */

	if (mem_init_done) {
		[true, executed]
		struct vm_struct *area;
		area = get_vm_area(size);
		if (area == 0) {
			[false, not executed]
		}
		v = VMALLOC_VMADDR(area->addr);
		[runtime result: v = d0181000]
	} else {
		[false, not executed]
	}
	if ((flags & _PAGE_PRESENT) == 0) {
		[runtime result: flags = 3a5]
	}
	if (flags & (_PAGE_NO_CACHE | _PAGE_WRITETHRU)) {
		[runtime result: flags = 3ad]
	}
	for (i = 0; i < size; i += PAGE_SIZE) {
		map_page(v+i, p+i, flags);
		[runtime result: lots of output I can't capture, PAGE_SIZE = 4096]
	}
out:
	[runtime result: v + (addr & ~PAGE_MASK) = d0181000]
	return (void *) (v + (addr & ~PAGE_MASK));
}

I note the following 3 observations:

1. In the #ifndef CONFIG_8xx section above, is the statement v =
p_mapped_by_bats(p) correct? Inside of an if statement, it is easy to
accidently type "=" instead of "==".

2. It's hard to catch during the boot, but it sure looked like all
the other PCI devices that were being probed found the same if(v =
p_mapped_by_bats(p)) to be true, and jumped to out. AFAICT, only the
aic7xxx call did not jump to out.

3. given that v = d0181000, is it expected that the returned result,
v + (addr & ~PAGE_MASK, is the -same- value? IOW, addr & ~PAGE_MASK
is ZERO. (I didn't yet record the actual values of addr and
~PAGE_MASK.



Thanks for any comments or observations or suggestions of where to go
next. I don't know much about what any of the above means, but I can
follow the code.



Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-Id: <5.1.0.14.2.20020612200144.00ab2398@mail.zultys.com>
Date: Wed, 12 Jun 2002 20:22:23 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: Eugene Surovegin <ebs@innocent.com>
Subject: consistent_alloc from an interrupt context
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

Current PPC implementation of consistent_alloc cannot be called from an
interrupt context.
This function is used by pci_alloc_consistent when
CONFIG_NOT_COHERENT_CACHE is defined.

Unfortunately it contradicts Documentation/DMA-mapping.txt which clearly
states that pci_alloc_consistent can be called from an interrupt context,
and some drivers breaks under PPC because of it.

The only part of consistent_alloc that may sleep is a call to get_vm_area.

I did quick (and dirty) fix for this problem.
I reserved a virtual address space  of a reasonable size (16M), and later
just use some part of it for real page allocations when called from
interrupt context. No deallocation support :( though

Correct implementation will require something like stuff from vmaloc.c and
it seems like a lot of code duplication to me.

So, my question to "big guys" here :), is there a better way to implement this?

Thanks,

  Eugene Surovegin <mailto:ebs@innocent.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

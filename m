Message-ID: <3D0912F4.4020300@embeddededge.com>
Date: Thu, 13 Jun 2002 17:47:32 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Eugene Surovegin <ebs@innocent.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
References: <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com> <20020613205824.GX13541@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:


> It looks okay.

It's not quite right.......

The consistent_alloc() should not always call get_vm_area() with GFP_ATOMIC
set.  It should use the 'gfp' that is passed into consistent_alloc().
Normally, you will call consistent_alloc() with GFP_KERNEL, and
interrupt functions must know to call the consistent allocators with GFP_ATOMIC.

> ..... But I don't see (immediatly) why the change to
> pci_alloc_consistent was needed as well.

It was a mistake on my part......when CONFIG_NOT_COHERENT_CACHE is used,
the consisten_alloc() returns the dma_handle, and we have to ensure we
don't do the virt_to_bus later to get it (because it will be wrong once
iopa() is discarded :-)


> But aside from that, it looks good and the next step would be to try and
> get the generic changes into 2.5 (and the 2.4.20-pre1, 2.4.19 is more or
> less frozen, esp for a change like this I suspect).

Good Luck ;-)


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

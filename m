Message-Id: <5.1.0.14.2.20020613151628.02e439e8@pop.prodigy.net>
Date: Thu, 13 Jun 2002 15:23:00 -0700
To: Dan Malek <dan@embeddededge.com>
From: Eugene Surovegin <ebs@innocent.com>
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3D0912F4.4020300@embeddededge.com>
References: <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com>
 <20020613205824.GX13541@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

At 02:47 PM 6/13/2002, you wrote:
>It's not quite right.......
>
>The consistent_alloc() should not always call get_vm_area() with GFP_ATOMIC
>set.  It should use the 'gfp' that is passed into consistent_alloc().
>Normally, you will call consistent_alloc() with GFP_KERNEL, and
>interrupt functions must know to call the consistent allocators with
>GFP_ATOMIC.

I don't think that we should use gfp passed to consisten_alloc as a
parameter for get_vm_area().

This is gfp for _memory_ itself and may contain GFP_DMA for example. I
didn't want to allocate
struct vm_area from DMA pool in that case.

May be the better solution is to mask out GFP_KERNEL or GFP_ATOMIC from gfp
and use it.

What do you think?

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

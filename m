Message-ID: <3D0951C8.6030400@embeddededge.com>
Date: Thu, 13 Jun 2002 22:15:36 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@innocent.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
References: <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com> <20020613205824.GX13541@opus.bloom.county> <5.1.0.14.2.20020613151628.02e439e8@pop.prodigy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eugene Surovegin wrote:

> This is gfp for _memory_ itself and may contain GFP_DMA for example. I
> didn't want to allocate
> struct vm_area from DMA pool in that case.

Well, you are using it for DMA, aren't you? :-)

> May be the better solution is to mask out GFP_KERNEL or GFP_ATOMIC from
> gfp and use it.
>
> What do you think?

I don't recall if deep in the VM code it already does this.  I guess we
can just to make sure.  I think anyone that would test for these flags
should do the masking to ensure they get the proper indicator.

My only concern is we should honor the flag passed to us rather than
always force GFP_ATOMIC.  Mask them if you wish :-)


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

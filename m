From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15625.11286.524300.137708@argo.ozlabs.ibm.com>
Date: Fri, 14 Jun 2002 09:34:46 +1000 (EST)
To: Eugene Surovegin <ebs@innocent.com>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
In-Reply-To: <5.1.0.14.2.20020613151628.02e439e8@pop.prodigy.net>
References: <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com>
	<20020613205824.GX13541@opus.bloom.county>
	<5.1.0.14.2.20020613151628.02e439e8@pop.prodigy.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eugene Surovegin writes:

> I don't think that we should use gfp passed to consisten_alloc as a
> parameter for get_vm_area().
>
> This is gfp for _memory_ itself and may contain GFP_DMA for example. I
> didn't want to allocate
> struct vm_area from DMA pool in that case.
>
> May be the better solution is to mask out GFP_KERNEL or GFP_ATOMIC from gfp
> and use it.
>
> What do you think?

Maybe the best answer is to change get_vm_area to use

	(in_interrupt()? GFP_ATOMIC: GFP_KERNEL)

instead of GFP_KERNEL in the kmalloc call, and eliminate the need to
add the extra parameter.  I'll run that past davem and see what he
thinks.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

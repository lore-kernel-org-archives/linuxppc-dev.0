Message-ID: <3D3428FF.5090401@embeddededge.com>
Date: Tue, 16 Jul 2002 10:09:03 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: consistent_alloc() revisited
References: <20020716021313.GQ22786@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> In addition, the following seem to me like desirable (to a greater or
> lesser extent) properties for consistent_alloc():
> 	a. one of the return values can be used as a single "handle"
> so that consistent_free() only needs one parameter.

We want the implementation API to be identical across all architectures.
Until there is a consistent way of handling devices that are on local
processor busses, platforms with these types of devices may call these
functions directly.    This is particularly true of some host USB controllers
on embedded systems that don't have PCI busses.

> 	b. works on both cache coherent and non cache coherent
> machines

The original purpose of the consistent_* functions was to provide support
for processors that aren't cache coherent.  The pci_* (and any other functions)
can call these if appropriate, but I still believe the decision should  be
made at a higher level.  Obviously, these consistent_* functions will
be implemented differently on non- or cache coherent processors, and across
different architectures.  The PCI functions (or others) should still do their
thing as they always have, and call these consistent_* functions when
appropriate.


> 	c. be able to use highmem pages

You think there will be non-coherent processors with this much memory? :-)


> -	if (in_interrupt())
> -		BUG();
> +	BUG_ON(in_interrupt());

We should be able to call these functions from interrupt, let's push
the remainder of the changes though get_free_pages() to make this happen.


Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

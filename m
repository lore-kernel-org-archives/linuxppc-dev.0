Date: Thu, 6 Jun 2002 18:17:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
Message-ID: <20020606081754.GZ2630@zax>
References: <20020531042153.GD16537@zax> <3CFC0D3F.9030901@embeddededge.com> <20020604035947.GH2762@zax> <3CFCFC20.80101@embeddededge.com> <15614.37065.549142.218906@argo.ozlabs.ibm.com> <3CFEE9A3.5060300@embeddededge.com> <15614.63160.272890.683586@argo.ozlabs.ibm.com> <3CFF1624.2070808@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CFF1624.2070808@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 06, 2002 at 03:58:28AM -0400, Dan Malek wrote:
> Paul Mackerras wrote:
> >.... If a driver uses
> >consistent_alloc or pci_alloc_consistent, the driver should save and
> >use the physical address returned by those functions.
>
> But, that's a relatively new addition and the support of these functions
> in a non cache coherent system requires the use of something like iopa().
> We allocate a contiguous virtual space to remap the pages we wish to
> change cache attributes.  We can't find the physical addresses associated
> with these pages unless we search the page tables.  Prior to having
> consistent_* we had to do this behind the curtains and needed iopa() to
> get the proper mapping result.

Not true.  consistent_alloc() first obtains the memory with
__get_free_pages() - which will return an address within the kernel
mapping of lowmem.  So the physical address can be obtained simply by
subtracting KERNELBASE.  *Then* it allocates virtual memory to create
the new uncached mapping.

In 2.5 virt_to_bus() uses iopa() only on APUS.  consistent_alloc()
works fine.  I've now managed to boot 2.5 with nfsroot on a 405GP,
after tracking down what looks like a hardware bug.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

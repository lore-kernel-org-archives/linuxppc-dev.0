Message-ID: <3D0ADE69.6040905@embeddededge.com>
Date: Sat, 15 Jun 2002 02:27:53 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: consistent_free()
References: <20020614042928.GK26146@zax>	<20020614153954.GL13541@opus.bloom.county> <15626.55392.839931.746121@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:

> "Consistent" means "the cpu and the device see the same stuff in
> memory".  On a cache-coherent system that is true of all normal
> memory.  Surely that is obvious?

Not really.  You have seen enough messages about people wanting to
get "uncached" memory, even though this isn't necessary.

We also don't want to be remapping 'consistent' space on those
processors that don't require it, one of the primary functions
of consistent_alloc() so it works properly on noncoherent processors.

Basically, David Gibson moved an 'ifdef' from one place to another,
and then had to write a consistent_alloc function for processors that
didn't need it before, placing more code in an include file no less.
How does that add value to the kernel?  It just complicated the
maintenance of a function that is similar across multiple architectures.

A more logical thing to do would be to have pci_consistent() always
allocate the pages, and in the case of noncoherent processors perform
the additional mapping step.  Then, have consistent_alloc() just call
pci_consistent() with a NULL hardware device pointer.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

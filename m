Message-ID: <3D095015.8020704@embeddededge.com>
Date: Thu, 13 Jun 2002 22:08:21 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Eugene Surovegin <ebs@innocent.com>,
	Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
References: <20020613215635.GB13541@opus.bloom.county> <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com> <20020613205824.GX13541@opus.bloom.county> <3D0912F4.4020300@embeddededge.com> <20020613215635.GB13541@opus.bloom.county> <5.1.0.14.2.20020613180327.02e11f68@pop.prodigy.net> <20020614013352.GF26146@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

 > ......  Likewise with __get_free_pages()
> which is what pci_alloc_consistent() uses on cache-coherent processors
> now.

....and my concern is you are replacing a call to __get_free_pages() with
a call to kmalloc().  Are you sure you want to be doing this?  There may
be users of pci_alloc_consistent that assume page alignment which may not
happen when you call kmalloc().


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3D0B464F.1050101@embeddededge.com>
Date: Sat, 15 Jun 2002 09:51:11 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: consistent_free()
References: <20020614042928.GK26146@zax>	<20020614153954.GL13541@opus.bloom.county>	<3D0A1D53.6040205@embeddededge.com>	<15626.55930.673731.803194@argo.ozlabs.ibm.com>	<3D0AE1EE.201@embeddededge.com> <15627.4284.922612.834048@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:

> implied to me that if you wanted 40kB it only allocated 10 pages, not
> 16, but in fact it sounds like the ARM implementation will actually
> allocate 16 pages too.

The current ARM implementation (that I want to copy again) :-) will
first allocate the 16 pages using alloc_pages().  It will then return
six pages from the end of the allocation back to the free pool.  This
is the only way you can get an arbitrary number of contiguous pages.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3BD0DDE4.9E87E2BE@mvista.com>
Date: Fri, 19 Oct 2001 22:13:56 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: pci_dma_sync_single
References: <15308.8725.416230.867981@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> There are basically two ways to get a dma_handle:

Right, and here is what happend....The comment first existed when
we were mapping uncached pages (for any reason, including
pci_alloc_consistent) into a VM space that was not mapped 1:1
with the kernel (it was actually vmalloc()'ed under the covers).
In this case, bus_to_virt() wouldn't work, then I changed it to
use iopa() to scan the page tables, so it worked again, then I
changed pci_alloc_consistent() to just change the attributes on
the individual pages, and now with large pages sizes I have to
allocate the non-1:1 VM space again.  So, the code has changed
a bunch without me changing the comment :-).  I'm going to
settle on large pages with the non-1:1 mapping again, for real,
for the last time.  I'll change the comment to say the right thing.

I think you have the right end of the stick :-).  You shouldn't
have to sync_single on alloc_consistent space, but I couldn't find
consistent use of all of these functions among existing drivers.

Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

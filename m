Date: Fri, 14 Jun 2002 14:29:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Paul Mackerras <paulus@samba.org>
Subject: consistent_free()
Message-ID: <20020614042928.GK26146@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In attempting to make consistent_alloc/free() work sensibly on
processors which are cache coherent I ran into a problem.
consistent_free() doesn't take a size argument.  We don't need it in
the case of not cache coherent processors - in that case
consistent_alloc() sets up a vm_area() so there's enough information
to get the size.  However for cache coherent processors we probably
want consistent_alloc() to degenerate to __get_free_pages(), in which
case consistent_free() must degenerate to free_pages(), which takes a
size argument.

I suggest we change consistent_free() to take the virtual addresss,
size and the physical address (dma_addr_t), which will make our
consistent_free() match the one on ARM.  I know we don't need the
third argument in any existing situation.

Patch coming...

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

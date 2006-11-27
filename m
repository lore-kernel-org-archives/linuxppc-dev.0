Return-Path: <dgibson@ozlabs.org>
Date: Mon, 27 Nov 2006 16:59:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-dev@ozlabs.org
Subject: libfdt - flat tree manipulation library
Message-ID: <20061127055905.GA6428@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, Mark Greer has already written some library functions for
handling flat device trees, which are included in
arch/powerpc/boot/flatdevtree.c (but could be used elsewhere).  For
several reasons, I don't like the interface very much though.  So,
here's my own somewhat different approach to a flat device tree
library.  Read-only and some very limited write functions so far -
more complete read-write support still in progress (some prototypes
are there already).

Notable design points:
	- Read-only functions are strictly stateless.  That is they
can be invoked directly on a blob without having to create a context
or any other setup.
	- No context management.  I'm pretty sure I can implement even
the read-write functionality by folding the small amounts of extra
context needed into the blob itself, avoiding the need for the caller
to separately set up a context structure.
	- No allocator callback.  The library functions never use
malloc() / realloc() or similar.  Instead read-write functions rely on
the caller explicitly handing blocks of available memory to the
library.  Expanding write calls can fail with "no space".  This makes
some uses more fiddly (but I think that can be mitigated with some
wrappers), but also means read-only functions can be used without an
allocated at all, and read-write functions can be used in (say) a
bootloader with a trivial allocater tracking only a single allocated
block - or simply by giving the library a block so big reallocation
will never be needed.
	- Multiple interfaces for multiple use-cases.  The functions
are divided into groups for different sorts of device tree
manipulation:  read-only functions, in-place-write functions (changes
such as replacing a property value with another of the same size,
which don't require rearrangement of existing structure), sequential
write functions (for creating a full tree from scratch) and
full random-access read-write functions.
	- No phandles.  Instead the library uses structure offsets to
reference nodes.  These can change when functions which insert or
delete information are used.  Persistent phandles are nice, but IMO
not worth the complexity to implement them.  I do plan to implement
functions that will find nodes via the "linux,phandle" property, but
haven't done so yet.

The code, such as it is, is at:
	git://ozlabs.org/home/dgibson/git/libfdt.git

Distribution notes:
	- I'm thinking about merging the library code into the dtc
tree (if nothing else it will make testing dtc rather easier).
	- License is GPL for now.  I'm looking into the red tape to
get it released as BSD or other non-restrictive license, so that it
can be used in closed bootloaders.
	- It's currently pacakaged as a userspace library, but should
be easy to drop into kernel or bootloader context.
	- The tree includes a small testsuite.
	- I don't consider the API final or stable at this stage.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

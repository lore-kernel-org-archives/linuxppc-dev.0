Message-ID: <3ABA291D.A7A82D8A@mvista.com>
Date: Thu, 22 Mar 2001 11:32:29 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ralph Blach <rblach@intrex.net>
Cc: linuxppc-embedded@lists.linuxppc.org,
	David Blythe <blythe@routefree.com>
Subject: Re: Proposed new kernel noncaching memory allocator for the 405gp
References: <3ABA1B6A.87C5FE9B@intrex.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:

> I propose a kmalloc_noncache and a kfree_noncached.
>
> These would be module and would be loaded when necessary.  They would
> operate allocating say 16k (could be any size)  of memory during boot
> time
> and then mapping it non cached.


That's a simplistic start, but not the right implementation.  It
should be a clone of kmalloc/kfree that will dynamically allocate
and free pages when necessary.  I've implemented the simplistic
version of these functions specifically for the MPC8xx CPM and
associated drivers, just copy those and use them if you want.

You have to carefully trade off using uncached memory against the
cache management (flush, invalidate, etc.) functions.  Using uncached
memory is a significant performance loss, and I know the USB is
already implemented to use cached memory and the management functions.
This works on all of the existing processor architectures, so there
isn't any reason to go back and change it.

Why don't you just go ahead and write and test these functions and
submit them as a patch against a recent kernel?  That would be much
more useful than just suggesting things and being upset when the
rest of us don't implement them because we have higher priority projects
to work on.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

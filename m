Message-ID: <3DFF5466.3050606@embeddededge.com>
Date: Tue, 17 Dec 2002 11:44:22 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Pantelis Antoniou <panto@intracom.gr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kmalloc and startup process
References: <3DFF1DF4.8010005@intracom.gr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pantelis Antoniou wrote:


> At what point in the startup process is it OK to call
> kmalloc?

Before you start hacking up things that are "broken", you
should probably take a moment to understand why they are
currently implemented the way they are.

The CPM support functions are called _very_ early in the
kernel to support such features as KGDB on the serial ports.
Currently, the host memory allocator uses bootmem pages
because they are only option for allocating memory that early.

There are three host memory allocators that are used to
support CPM functions.  One is the 'cpm_hostalloc()' space,
which is available early and used for small objects like
uart fifos.  Second is the consistent DMA functions which
are used in the places like the Ethernet driver.  Third is
the kernel kmalloc() function which must be futher managed
with the cache coherency functions.  They all have advantages
and features that meet various driver requirements.  You may
need to use several layers of initialization to make this
happen, just like any other Linux driver.  Some must be
done at kernel initialization, others can be postponed until
later.  When you think driver support functions are "broken"
you may want to stop and consider that maybe your driver
writing techniques are broken and investigate how these
functions are working successfully for others.

I would strongly suggest that the only thing to "fix" is to
add a trivial space manager to some statically configurable
number of bootmem pages.  The old UNIX resouce map allocator
would be a perfect algorithm to manage this space.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3C7B0605.3080308@embeddededge.com>
Date: Mon, 25 Feb 2002 22:50:29 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Ashley <dash@xdr.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
References: <200202260315.g1Q3Fmt18809@dave.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Ashley wrote:


> Maybe you can point me to some discussion of how linux operates? I mean,
> once the memory is mapped with the page tables, what happens once the
> process does a read to a page? Does that generate a page fault?

It isn't really unique to Linux.  Yes, the access can generate a page
fault, which will cause a kernel exception to load the TLB.  This can
generate some weird looking, early terminated bus timing, which is
perfectly within the specifications of the hardware but isn't something
the designers always consider.  I've seen this quite often on the 8xx,
but fortunately have never had to attach a logic analyzer to a 60x bus.

So, I doubt it is any Linux or software problem, but more likely something
wrong with the timing on the bus that is resulting in incorrect data
returned to a memory access.

> ....... It seems like all discussions on this are
> outdated and only apply to older kernels...

The basic concepts of how all of this works hasn't changed much.  There
have been lots of detailed updates to make it more efficient or flexible.
IIRC, somewhere around the 2.4.7 timeframe was a major VM change,
we were also making changes for tracking changed attributes and Paulus
made some other instruction page invalidate enhancements.  Except at
the lowest level of processor specific MMU details, all of the PowerPC
and Linux VM is the same.  A bug in the lower level functions is usually
quite obvious and quickly addressed.



	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

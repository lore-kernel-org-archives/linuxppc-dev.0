Message-ID: <38C7368A.7B28E61E@netx4.com>
Date: Thu, 09 Mar 2000 00:28:42 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Steve Calfee <calfee@kerbango.com>
CC: Bjvrn Lundberg <bjorn.lundberg@inu.se>,
        "linuxppc-embedded@lists.linuxppc.org"
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: USB driver for MPC850/823
References: <4.2.2.20000308153704.00a601f0@mail.kerbango.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Calfee wrote:

> .... The CPM wants to access
> physical memory addresses. You use a macro __pa for this, but I dont think
> that works for all cases of user and kernel memory.

It will certainly never work for user memory, you should only copyin/out
user addresses for a variety of reasons.

> Look at virt_to_phys(x); but that only does kmalloc'ed memory.

The virt_to_phys() and __pa() do the same thing.  Both work on kmalloc'ed
memory.  Neither will work with vmalloc'ed memory.

When using the CPM on the 8xx, you have to be careful about the cache
attributes on the pages as the 8xx doesn't have bus snooping to ensure
coherency.  I use a couple of different methods to get memory allocated
in the kernel for the CPM, sometimes they are cached and require software
management, other times not cached.  Depends upon how it is used.

You can use kmalloc() or __get_free_pages() to allocate memory for the
CPM.  Just make sure kmalloc() gives you something that is properly
aligned, as some CPM functions have rather large alignment boundaries.
When allocated in this way, you have to chase down the pte's and modify
the cache attributes yourself if desired.

> Does anyone have a pointer to a document that thoroughly describes memory
> mapping, both for the x86 and the ppc?

It would probably be correct only until the next source update.  While
trying to keep up with the 2.3.xx source tree, I have changed the CPM
memory interfaces at least three times.  I think we are back where we
started, at least this week.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Tue, 18 Jul 2000 15:03:03 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Nathan Ingersoll <ningerso@d.umn.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Malloc bug?
In-Reply-To: <Pine.SO4.4.02.10007181457570.7001-100000@ub.d.umn.edu>
Message-ID: <Pine.LNX.3.96.1000718145017.7613B-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 18 Jul 2000, Nathan Ingersoll wrote:

> I've been working on a GTK program for a while now, and I've been
> experiencing segfaults within malloc. I was under the impression that
> malloc should always return successfully (at least that's what the man
> page says).


Sounds like the man page is wrong.  :-)  Malloc returns NULL if:

1.	the machine's virtual memory is exhausted
2.	the process's maximum virtual memory (set by ulimit) is exhausted
3.	the process's virtual memory has been hosed.

There may be other cases, but I can't think of them, if there are.  The
first two are fairly trivial, and shouldn't happen unless you're
allocating in an infinite loop or something.

There are four ways to get #3 that I can think of, probably more, but
these are the first ones that come to mind:

a.	call free() on an unitialized pointer (containing random data).
b.	call free() twice on the same memory region.
c.	call free() on the middle of a malloc'ed region.
d.	call free() on a variable allocated by something other than
	malloc, e.g. a stack variable (in a function or a function call),
	a static variable (or any global variable), or a region allocated
	by the C++ new function.

Anyway, you should always check the return value of malloc.  :-)


> Any ideas what may be causing this? I don't know if this has
> anything to do with it, but the kernel I was using generated lots of
> vm_do_try_free_pages failed error logs but not necessarily during program
> execution.

No idea about that.  The earlier points are machine-independent.  The
above looks like it's specific to the PPC monolithic kernel and/or GTK,
neither of which I do much with.


David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

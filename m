Date: Sun, 1 Apr 2001 17:24:18 -0400 (EDT)
From: Bill Fink <billfink@capu.net>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
	linuxppc-dev@lists.linuxppc.org, billfink@capu.net
Subject: Re: xine, ppc and illegal instructions
In-Reply-To: <01040116021700.15950@localhost>
Message-ID: <Pine.LNX.4.21.0104011709010.9900-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Sun, 1 Apr 2001, Kevin B. Hendricks wrote:
>
> Hi,
>
> couple of  things:
>
> - was the shared library loaded by dlopen properly built with -fPIC or -fpic?

I assume so.  It's Franz Sirl's latest 2.1 glibc RPM.

> - could there be a cache flushing bug?  When run in gdb if you set some
> breakpoints in the shared library, it will flush the icache (to make sure the
> breakpoint gets flushed out of data cache and any preloaded instruction are
> thrown away) this in turn seems to "fix" the cache flush problem if one
> exists.

That makes sense to me.

> - can you set ulimit -c unlimited and generate a core file from xine
>   and post the resulting backtrace.
>
>   If it looks empty, try the following:
>   x/20i $lr -32
>   in gdb just in case the problem was a branch out into the weeds

I was never able to get a core dump.  My coredumpsize is unlimited.
Earlier in the xine code, I could force a core dump by doing a "*0 = 1"
before the first call to pthread_create, but I couldn't get a core dump
by doing the same thing right after that call.

> (if we are lucky lr will have the return address so that we can
> possibly see at least where the bad branch comes from).  One way to get
> an illegal instruction is to follow a calculated branch into the weeds
> (happens sometimes in some C++ code during tailcalls when compiled above -O0).

As reported in my previous message, it's now working using the latest
BenH kernel (2.4.3 final) instead of the Paulus kernel (2.4.3-pre8) I
was previously trying with, so I'm happy.

						-Thanks

						-Bill


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

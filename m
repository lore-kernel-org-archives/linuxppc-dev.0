Message-ID: <3A687848.B7BE3116@mvista.com>
Date: Fri, 19 Jan 2001 12:24:24 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Gareth Hughes <gareth@valinux.com>
CC: michdaen@iiic.ethz.ch, dri-devel@lists.sourceforge.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [Dri-devel] Re: PPC Lockup (ati-pcigart-branch)
References: <3A67B401.8282A00F@relog.ch> <3A67BAC3.94EFEA3A@mvista.com> <3A67E467.74544C4C@valinux.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gareth Hughes wrote:

> Pages is definitely the number of pages (at least when I wrote the
> code...).

Hmmm....vmalloc() definitely works fine, we use it all of the
time in the kernel.  The only way it would hang is if you call
it too soon, or if the number of pages was too large.

> .....and we really should be using
> vmalloc_32(...) instead (which will result in exactly the same code, but
> it is cleaner).

It's no longer the same.  Linux has the "highmem" configuration now,
and vmalloc() allows that to be used, while vmalloc32() does not.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

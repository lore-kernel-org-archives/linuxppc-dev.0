From: Gareth Hughes <gareth@valinux.com>
To: Dan Malek <dan@mvista.com>
Date: Sat, 20 Jan 2001 11:45:59 +1100
Message-ID: <3A68DFC7.20F2A56D@valinux.com>
MIME-Version: 1.0
CC: michdaen@iiic.ethz.ch, dri-devel@lists.sourceforge.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [Dri-devel] Re: PPC Lockup (ati-pcigart-branch)
References: <3A67B401.8282A00F@relog.ch> <3A67BAC3.94EFEA3A@mvista.com> <3A67E467.74544C4C@valinux.com> <3A687848.B7BE3116@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
>
> Hmmm....vmalloc() definitely works fine, we use it all of the
> time in the kernel.  The only way it would hang is if you call
> it too soon, or if the number of pages was too large.

Yes.

> > .....and we really should be using
> > vmalloc_32(...) instead (which will result in exactly the same code, but
> > it is cleaner).
>
> It's no longer the same.  Linux has the "highmem" configuration now,
> and vmalloc() allows that to be used, while vmalloc32() does not.

If you look, we've just included the vmalloc_32() code inline, using
__vmalloc().  We're not using the regular highmem vmalloc().

-- Gareth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Fri, 16 Jun 2000 10:04:22 -0400 (EDT)
From: James Simmons <jsimmons@acsu.buffalo.edu>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Adrian Cox <apc@agelectronics.co.uk>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [linux-fbdev] Re: copy_from_user in drivers/video/fbmem.c
In-Reply-To: <Pine.LNX.4.05.10006161312290.5039-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.10006160953580.414-100000@maxwell.futurevision.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Which do people think is wrong:
> > Is copy_from_user() on PPC wrong, because it can't write to uncached
> > space.
> > Is fbmem.c wrong, because it tries to use copy_from_user() to memory
> > mapped IO?
>
> Congratulations! You found a bug in fbmem.c! Fbmem.c should not use direct
> memory accesses to access the frame buffer, but must use fb_writel() and
> friends instead.

Let me guess, fb_write and fb_read. I have seen problems also with using
memset on a mmap framebuffer on the PPC. Geert I like to suggest we move
fb_write, fb_read, and fb_memset to fb.h so userland apps can use them.
Also I have though about having generic functions for register access
based on what is in atyfb.c for userland to use as well. Something like.

static inline u32 ld_le32(unsigned int regindex, struct fb_info *info);
etc.

Actually this problem is more general. We really should have a generic
access MMIO region function. I believe some sound cards can be mmapped as
well.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

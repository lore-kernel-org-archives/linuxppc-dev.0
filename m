Date: Mon, 11 Sep 2000 14:36:00 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ani Joshi <ajoshi@shell.unixbox.com>
cc: linux-fbdev@vuser.vu.union.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: radeonfb ver. 0.0.5
In-Reply-To: <Pine.LNX.4.10.10009102355450.6727-101000@shell.unixbox.com>
Message-ID: <Pine.LNX.4.10.10009111424330.380-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 11 Sep 2000, Ani Joshi wrote:
> Attatched is a somewhat initial release of radeonfb for ATI Radeon
> chipset.  Its a patch against 2.4.0-test8.
>
> Anyhow, ATI requested I write this driver because it is apparent that the
> Radeon will be in the next series of Apple machines.  These machines
> aren't shipping yet so this release is relatively premature.

This is really cool! Has ATI (finally) seen The Light?

> Yet another school year has begun around here and free time for hacking is
> a rare thing so if anyone would like to help, please do, I will try my
> best to maintain it for as long as possible.

Thanks a lot!

I know it's preliminary, but I do have some comments:

  - The code is not 64-bit clean:

	struct radeonfb_info {
	    ...
	    u32 mmio_base_phys;
	    u32 fb_base_phys;

    These should be `unsigned long'.

	    u32 mmio_base;
	    u32 fb_base;

    These should be some pointer type, e.g. `void *'.

	    ...
	};

  - As long as the request_mem_region() calls are commented out, please put
    the initialization call in fbmem.c _after_ those for offb and vesafb.

  - You don't have to provide an empty fb_ioctl() function, a NULL pointer in
    fb_ops is sufficient.

  - In DIRECTCOLOR mode, there is a colormap (32 entries for rgb555, 64 for
    rgb565, 256 for rgb888)

  - There's no need to include <video/fbcon-cfb24.h> if you don't support 24
    bpp.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

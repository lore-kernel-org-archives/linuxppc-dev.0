Message-Id: <200008181922.VAA03812@piglet.grunz.lu>
Date: Fri, 18 Aug 2000 21:22:18 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: some stuff about controlfb in 2.2
To: olh@suse.de, linuxppc-dev@lists.linuxppc.org
cc: geert@linux-m68k.org
In-Reply-To: <20000818134234.A11762@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Olaf,

On  18 Aug, this message from Olaf Hering echoed through cyberspace:
> while trying to get xf4 to work on all machines here at suse I used this
> patch for the controlfb driver in a 7500/100 and 7600/132.
> The (basic) diff can be found on Micheals homepage.

What's on my page is really only what I needed to get it working in my
case, as you have noted below...

> My question is: How can we improve the support for the controlfb? The
> xf4 patch is needed to remove the offset problem. It is no perfect yet.
> 16bit does not work, colors are screwed up. 8bit has some shift to the
> left (proably one byte/ 8 pixels). 24bit worked fine with 832x624 on the
> 7500. I can not use that high colordepth on the 7600, only 2mb vram.

Geert or the other XFree 'developers' on the lost might be able to help
here...

> I would like to attach the mentioned kernel patch to improve
> performance, have no idea yet how to benchmark it.

x11perf -scroll500

For a comparison, I get around 36 scrolls/sec on my 7600 (XF4.0 at 1152
x 870 @ 24bpp), caching patch applied, with a 2.2 kernel. Without the
caching patch, I get below 10 scrolls/sec.

> diff -urN linux-2.2.16.SuSE.orig/drivers/video/fbmem.c linux-2.2.16.SuSE/drivers/video/fbmem.c
> --- linux-2.2.16.SuSE.orig/drivers/video/fbmem.c        Thu Aug 17 02:23:14 2000
> +++ linux-2.2.16.SuSE/drivers/video/fbmem.c     Fri Aug 18 11:04:46 2000
> @@ -577,7 +577,13 @@
>                 pgprot_val(vma->vm_page_prot) |= _PAGE_NOCACHE_S;
>         }
>  #elif defined(__powerpc__)
> -       pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE|_PAGE_GUARDED;
> +       /* set mode for controlfb in PowerMacs
> +        * see http://www.cpu.lu/~mlan/linux/dev/xf4.html
> +        */
> +       if(find_devices("control"))
> +               pgprot_val(vma->vm_page_prot) |= _PAGE_WRITETHRU;
> +       else
> +               pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE|_PAGE_GUARDED;
>  #elif defined(__alpha__)
>         /* Caching is off in the I/O space quadrant by design.  */
>  #elif defined(__i386__)
>
> Is this patch ok for the kernel?
> Maybe we should  `flag = find_devices("control");` to be safe.

I think the better way to handle this would be to provide a
device-specific mmap function in the framebuffers that benefit from the
changed caching. On Macs, all unaccelerated framebuffers should fall
under that category.

Or, one could also argue that _PAGE_WRITETHRU should be the default, and
those framebuffers that need something else should provide that
themselves.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

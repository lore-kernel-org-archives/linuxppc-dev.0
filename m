Message-ID: <39C155BF.1A150162@wanadoo.fr>
Date: Fri, 15 Sep 2000 00:48:31 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: per-fb mmap for platinumfb and valkyriefb in 2.4 (and 2.2)
References: <200009140546.HAA00808@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:

> > Tried it for valkyriefb: Doesn't work. It works in console mode, where
> > it actually feels like it is scrolling fast, but starting X gives an
> > immediate system freeze. I tried it twice, but now I'll go to bed.

> Can you have a look and see what might be wrong? Ill do the same,
> hopefully tonight, but no guarantee...

I don't really understand these things (as usual), but from staring at
your code it seemed to me that inserting the following line might be a
good idea (this is for the 2.4.0 case; I haven't tried the 2.2.x patch,
but there a corresponding line is present):

--- drivers/video/valkyriefb.c~ Wed Sep 13 23:18:59 2000
+++ drivers/video/valkyriefb.c  Thu Sep 14 23:58:12 2000
@@ -308,6 +308,7 @@
                pgprot_val(vma->vm_page_prot) |= _PAGE_WRITETHRU;
        }
        start &= PAGE_MASK;
+       off += start;
        vma->vm_pgoff = off >> PAGE_SHIFT;
        if (io_remap_page_range(vma->vm_start, off,
            vma->vm_end - vma->vm_start, vma->vm_page_prot))

In any case, it is working now. In fact, I don't see any difference
between the situation before and after the patch. For x11perf
--scroll500, I get exactly as before 36.2/sec for 1024x768 at 8bit. This
is with XFree68-4.0.1; used to be 13/sec with older X servers.

One funny thing: In X, my Alt keys don't work correctly ("ModeShift")
any more, they give "Alt_R" now. In the console, this is still OK. I
suppose this cannot come from the mmap stuff, so this must come from
some of the other changes in the bitkeeper tree in the last 2 days. I
didn't change anything else in my config.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <381A6CF9.67FE83E2@wanadoo.fr>
Date: Sat, 30 Oct 1999 05:58:49 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: linux-2.2.13pre15 stability w/ head.S patch
References: <3818908A.8A6539B6@chpc.utah.edu> <19991028212456.B13879@chimaera.ppc.kernel.org> <3819E3D7.B9D7E4F3@chpc.utah.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Lou Langholtz wrote:
> 
> Cort Dougan wrote:
> 
> > The Linus tree is in sync with by the 2.2 and 2.3 right now.  Have you
> > tried 2.3.24 and/or 2.3.13?
> 
> That's great news. My bandwidth is so limited that checking this fact is
> impracticle. So this helps a lot to know. I haven't tried 2.3.24 or 2.3.13 or
> 2.2.13 out yet either. Seems like 2.2.14's due out soon and I figured I'd just
> wait.

Sorry to spoil the fun, but I personally feel that the linux kernel
sources for the pmac are in a rather sorry state right now. Both the
vger cvs and the samba rsync archives have gone into hibernation, and
the kernel.org kernels just don't work. After having spent many hours
during the last couple of days trying unsuccessfully to compile a recent
kernel for a B&W G3, I and the colleague for whose G3 this was meant (he
has a self-compiled 2.2.10 kernel, but the USB mouse doesn't work, so I
suggested naively to try a more recent kernel) are rather disappointed.

On my 6400, I have a 2.2.13 kernel from the vger cvs archive that works,
but these sources don't contain the right USB keyboard stuff nor the
aty128fb driver.

I also have a working (on the 6400) 2.3.22 kernel from Paul M's rsync
archive on samba. This one doesn't boot on the G3 either. To compile it
on the G3, we had to patch some mutilated files (I think
include/asm/keyboard.h) that are still not corrected, although this fact
has been mentioned on the list weeks ago (keyword "retureycode"). 

We also had to switch on CONFIG_PMAC_PBOOK, because some mediabay stuff
is outside of #ifdef CONFIG_PMAC_PBOOK clauses. This latter bug persists
in the kernel.org 2.3.{23|24} sources. 

The USB keyboard stuff had to be patched for non-US keyboards (this
shouldn't be necessary in the kernel, right?). Also the
drivers/usb/mkmap.adb script is not executable, so compilation stops
there, and one has not only to chmod +x this file, but to remove the
resulting keymap-mac.c file which otherwise is not regenerated.

The aty128fb driver exists in the rsync 2.3.22 kernel, but it cannot be
compiled in, because the config and makefiles don't know about it. In
the kernel.org sources, the config and makefiles are corrected and allow
you to choose the aty128fb driver, but it doesn't compile, because
FB_ACCEL_ATI_RAGE128 has been forgotten in include/linux/fb.h.

There are a couple of other such problems (like the init/main.c that
doesn't compile with initrd configured, probably some kind of weird
Finnish humor), so that it took us hours to get one of these kernels to
compile. And then none of them boots. After the first few lines ("kernel
xxx booting ...") they just sit there. No error message that would give
any hint. 

I never got any of the kernel.org 2.3.{23|24} kernels to boot on my 6400
either.

In the good old days (like 2 months ago :-() when the vger cvs tree was
still actively maintained and was used to collect all the right patches
for the pmac, life was definitely better.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: duncanp@research.canon.com.au
Date: Fri, 17 Mar 2000 15:39:08 +1100 (EST)
Subject: Re: problems with PPC860/ADS board/8xxrom-0.3.0/mpc8xx-2.2.13/patch
 es  (from Raphael Bossek)
To: Eisenzopf Thomas <thomas.eisenzopf@siemens.at>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <D53137D1F3DDD211A3750800060DA31301702339@viee122a.erd.siemens.at>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Message-Id: <20000317043910.EF344355F0@elph.research.canon.com.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 15 Mar, Eisenzopf Thomas wrote:
>
> Hello!
>
> I´m trying to get embedded Linux running on an ADS board with a PowerPC 860.
>
> For the beginning I used the informations from Raphael Bossek´s WWW-page
> http://www.s4l.de/powerpc.html.
>
> My main problem at this time is, that the patches (from Magnus Damm and
> Raphael Bossek) from this internet page do not seem to fit to
> mpc8xx-2.2.13.tgz; the dates of the files differ, and the patch program
> delivers errors (e.g. Hunk #1 FAILED at 459....). But without these patches
> I cannot build the system.

Are you using the version of mpc8xx-2.2.13.tgz from Raphaels's web
page? I haven't used this kernel, but the kernels on ftp.ppc.kernel.org
are newer, and the patches on Raphaels page almost certainly won't apply
cleanly to them.

>
> Does anyone have some advice for me? Is there somewhere a complete archive
> of the needed files (including the patches)? Where can I get additional
> information?

Probably the easiest thing to do would be to grab the kernel source
tree from ftp.ppc.kernel.org/pub/linuxppc/embedded/ , which should just
work on your board (it has most of the stuff included in the patches on
Raphaels site plus more). There should be a more up to date kernel on
mail.netx4.com, but it appears to have dissapeared....

The kernel will need a couple of tweaks to allow you to build the 8xxrom
bootloader. I think the only file you'll need to modify is
include/asm-ppc/ads.h - have a look in the patchfile
patch-2.2.13-mpc8xx-damm.diff on Raphaels site to see what needs doing
in there.

To build 8xxrom, first configure and build the kernel tree, then make a
symlink called 'linux' in your 8xxrom directory to the kernel source,
and a symlink called 'romsys' in your 8xxrom directory which points to
the m8xx directory. Have a look at config.h and make sure things look
OK for your board, and then type 'make s19' and cross your fingers....

Having said all that, I've never actually done this, but I have just got
8xxrom working on an Embedded Planet cllf board, so hopefully my advice
is near to the mark.

Good luck,
Dunk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

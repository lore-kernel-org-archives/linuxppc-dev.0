Message-Id: <200009132037.WAA00873@piglet.grunz.lu>
Date: Wed, 13 Sep 2000 22:36:58 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: per-fb mmap for platinumfb and valkyriefb in 2.4
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Below is the per-fb mmap implementation I already posted here for
controlfb, but this time for the other two powermacfb drivers:
valkyriefb and platinumfb.

Patch is against Paul's rsync tree at 2.4.0-test7, but since I don't
expect much change in this area it should apply equally well to anything
more recent ;-)

Since I don't have any of these hardware devices, it's untested. If you
do test, expect a 2-to-4-times performance boost on scrolling:

[mlan@piglet ~]$ x11perf -scroll500

I get around 35/sec on controlfb at 1152x870@32bpp with XF4.0; around
9/sec without the optimized caching in the mmap().

Have fun!

Michel

PS Will appear on sourceforge soon.....

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Wed, 30 Dec 1998 11:37:16 +0100
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: grackle, patches, MMU, ...
Message-Id: <19981230113716.015659@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All !

I finally read the pmac_pci.c file and it looks like my grackle.h file
(which comes from experiments I made on MacOS some time ago for another
issue) is absolutely not needed, grackle is just device 0 on bus 0 and
it's register can be accessed by ordinary pci config accesses. However,
since I know no easy way of knowing which bridge in the list is actually
grackle, if we want to add power management support for it in idle.c,
we'll still have to hard code device 0 / bus 0 and hope it will always be
this way.

I'll post a cleaned up set of patches with only the safe ones to simplify
merging (I'm waiting some stuff from Tom Rini to complete the ADB+mice
patches) but do you (you=people doing the merge with Linus tree) prefer
patches against current vger (still at 2.1.130) or directly against Linus
2.2-pre1 ?

I also spent some time looking at the MMU initialisations, and it looks
like we are using one BAT on powermacs for mac-io and that's all. PREP is
using two, APUS too. BATs 2 and 3 are used to map physical RAM for the
kernel, that's it ?

So we have one free BAT (#1) only on pmac and chrp, but if we plan to
switch BATs along with process contexts (for mapping fbdevs with BATs for
example), then we would have all BATs free for user processes. Am I correct ?

I was wondering if, instead of using the remaining free BAT to map the
framebuffer for the kernel (to speed up console), why couldn't we use a
BAT to map the entire assigned PCI memory space for the kernel ? This
would speed-up accesses to all devices (including framebuffers). We
already map the entire mac-io (at least the first one on machines with
two of them).

Finally, a last question: on machines with two mac-io's, like the recent
PowerBooks, the /proc/device-tree is broken when booting with bootx: the
names inside pathnames don't have the '@xxxxxx' that OF appends and so
both mac-io have the same pathname. That makes almost impossible to reach
the second one from /proc.

I plan to fix that by adding @xxxxxx from bootx when building the
device-tree, but I'm annoyed because the find_path_device routine is not
smart enough to skip them when there is no confusion. For example,
find_path_device("/pci/mydevice") will fail if the full path of mydevice
is actullally "/pci@xxxxxxx/mydevice@yyyyyyy". Should I also fix that or
should we expect callers of find_path_device() to provide an exact path
all the time ? My idea was to make find_path_device ignore the @xxxxxx
except if they are specifically specified in the searched path.

Also, I don't know which value I'll put in xxxxxx, maybe just a ordering
number (begins with 0, incremented with each entry). The goal is just to
make sure that path are unique.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

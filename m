Message-ID: <3785A99B.E1DF943C@mpifr-bonn.mpg.de>
Date: Fri, 09 Jul 1999 09:49:47 +0200
From: Albrecht Dre_ <ad@MPIfR-Bonn.MPG.de>
MIME-Version: 1.0
To: Peter Handel <phandel@cise.ufl.edu>
CC: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-user@lists.linuxppc.org,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>,
        Linux/Powermac <linux-pmac@samba.anu.edu.au>
Subject: Re: linux-pmac 2.2.10: media bay panics on PBG3
References: <Pine.GSO.4.05.9907081145280.1822-100000@eclipse.cise.ufl.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Peter Handel wrote:
[snip]
> Looks like it's time to bust out "diff" ... You could write a quick
> /bin/sh script that does something like:
[snip]
> ...although I bet they're just different ac releases of 2.2.10.

There are LOTS of differences...  Unfortunately, I do not understand that much
of the kernel...

As a response to Ben's comment about the io addresses: I added a printk to
mediabay.c to check the ide base addresses, and comparing kernel.org's and
paulus' dmesg output, it results in:

2.2.10 from kernel.org:
ide0 at 0xf3020000-0xf3020007,0xf3020160 on irq 13
...
mediabay: 0: base=0xf3021000 irq=14 idx=-1
mediabay: 1: base=0xd080a000 irq=78 idx=-1

2.2.10 form the paulus dir:
ide0 at 0xf5020000-0xf5020007,0xf5020160 on irq 13
...
mediabay: 0: base=0xf5021000 irq=14 idx=-1
mediabay: 1: base=0xd280a000 irq=78 idx=-1

Checking the diffs, I noticed that in arch/ppc/pmac_setup.c and
drivers/block/ide_pmac.c some code was adden in the "paulus" versions,
especially some adds of "_IO_BASE".  Might this be a source of the problems?

Thanks, Albrecht.

-- 
+-----------------------------------------------------------------------------+
| Dr.-Ing. Albrecht Dre\ss                                     ----           |
| Max-Planck-Institut f\"ur Radioastronomie   |\       /      /o  o\          |
| Abteilung f\"ur Infrarot-Interferometrie    |  \    /      |  /   |         |
| Auf dem H\"ugel 69                          |    \ |        \ ---/          |
| D-53121 Bonn (Germany)          ------------+------+-------------------     |
|                                             |    / |                        |
| Phone (+49) 228 525 319                     |  /  /                         |
| Fax   (+49) 228 525 411                     |/   /                          |
| Mail  ad@mpifr-bonn.mpg.de                                                  |
+-------------- electrical engineers do it with less resistance --------------+

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

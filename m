Date: Fri, 29 Mar 02 16:42:22 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203300042.AA13129@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] ev64260 bi_rec patch
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark A. Greer <mgreer@mvista.com> wrote:

> It *is* in the kernel source (and not the bootloader).

I don't understand what you are talking about.

find_bootinfo looks for bi_recs in a magic location in memory. An external
bootloader has no way of knowing where in memory that is and thus can't put
bi_recs in a place where the kernel will find them. A port that uses
find_bootinfo() can't be booted by anything except the wrapper.

> Also, 15 of the *_setup.c
> files in arch/ppc/platforms call find_bootinfo

That's because no one has bothered so far to boot any of those 15 ports with
any bootloader other than the wrapper. And that's in turn because I haven't
worked on any of those ports. :-) See k2_setup.c and adir_setup.c for the
difference.

> including ev64260_setup.c before I
> modified it.

In my patch I changed it.

> I think the R3 way of doing things is out of date now but maybe Tom
> can elaborate.

It can't be out of date w.r.t. find_bootinfo(), as first everyone used the
latter then I screamed and screamed and screamed and got the K2 port changed.

As the wrapper now puts its bi_recs in the magic location *and* sets R3 to
point to them, either way will work for you, but the R3 way makes it work for
me too.

> You may have a point here.

This is not a may, it's certain.

> I thought the bi_rec's were left around but I need to
> verify.

They aren't.

> I took a quick look and didn't see it being reused but I may have missed it.

You won't see the kernel explicitly reusing the bi_recs memory because it
doesn't even know where that memory is! The bootloader can put the bi_recs
absolutely anywhere in memory. They can be parsed in platform_init because
Linux memory management hasn't started yet, but once it's started the memory
belongs to Linux and you can't expect some random bytes in the middle of memory
to be preserved for eternity.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15312.5879.511865.946406@cargo.ozlabs.ibm.com>
Date: Fri, 19 Oct 2001 22:05:11 +1000 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods
In-Reply-To: <0110152132.AA08287@ivan.Harhan.ORG>
References: <0110152132.AA08287@ivan.Harhan.ORG>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov writes:

> But currently the vmlinux boot interface is defined per platform: the generic
> code passes the initial R3-R7 to platform_init(). It should be possible for a
> board port maintainer to change this interface in his/her port without
> affecting anyone else.

Yes, that is a very good point.

> In arch/ppc/kernel/setup.c
> change the division of labor between machine_init and parse_bootinfo. Move the
> current logic for locating bi_recs in memory from parse_bootinfo to
> machine_init, passing the pointer to bi_recs to parse_bootinfo() as an
> argument. Then new board ports can be designed with a bi_recs interface instead
> of the current traditional one by doing something like parse_bootinfo(r3) in
> platform_init.

An excellent suggestion.  Thank you.  Is anyone using the bi_recs in
anger yet?

For CONFIG_ALL_PPC, we need to make a wrapper which can be booted
using existing installed versions of BootX/quik/yaboot, which will
accept the parameters as provided by those loaders and make up a set
of bi_recs.  Then we can require that pmac/prep/chrp _always_ use a
wrapper, and then start to move the Open Firmware calls into the
wrapper.

Other platform maintainers can use a wrapper or not as they choose.
For consistency and simplicity it would be nice if there was a
standard register assignment on entry, for example having the physical
address of the bi_recs in r3, but that is not essential.

We should all agree on a comment set of bi_rec tags and the format for
each type of entry.  And I like Ben's suggestion of keeping the bi_recs
around.

Reactions?  Thoughts?  Comments?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

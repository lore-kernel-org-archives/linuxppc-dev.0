Date: Mon, 7 Jun 2004 11:12:42 +0200 (CEST)
From: Marius Groeger <mgroeger@sysgo.com>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC] Simple ioremap cache
In-Reply-To: <20040607084812.GA5808@gate.ebshome.net>
Message-ID: <Pine.LNX.4.56.0406071100110.11623@mag.sysgo.com>
References: <20040605002915.GA17603@gate.ebshome.net>
 <Pine.LNX.4.56.0406070931180.3147@mag.sysgo.com> <20040607084812.GA5808@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 Jun 2004, Eugene Surovegin wrote:

> With my patch only _one_ TLB mapping will be required for _all_ 4K-sized
> ioremaps of 0x0000000140000000:

Yes, now I understand. You're after a different kind of optimization
which I had in mind. It makes absolutely sense to me, and should also
be portable to other cores.

> > Have you counted them to prove it?
>
> No, it seemed quite obvious to me :)

Yeah to me, too now ... :-)

> > To do this, I think you also need
> > to flag a bigger virtual page size to the MMU, eg. program a different
> > PAGESZ_* value (see include/asm-ppc/mmu.h). If you don't, the MMU has to
> > manage diffent chunks all the same, they just happen to be virtually
> > contiguous.
>
> I don't follow you here, sorry. Could you give some examples with
> the real TLB contents for the cases you are describing?

What I mean is to merge/coaelsce individual mappings within the same
IO area. Eg., consider an IO area with multiple resources at
0xd000.0000 spanning more than one 4k page. Now, driver A requests
access to a page at 0xd0000.0100, and driver B wants to access
0xd0003.0400. Usually, this would lead to 2 diffent mapping entries
for the following phys base/size pairs (0xd0000.0000, 0x1000);
(0xd0003.0000, 0x1000). With optimization, this could be handled by
one mapping at 0xd0000.0000 spanning a 16k page. It's a bit like when
BATs are used to cover larger chunks.

Again, this was an idea we had a while ago. I don't know how much real
remedy is in implementing it. There once was also talk about a "big
TLB" patch. I haven't checked if this is already part of 2.5/2.6.

> What do you mean "just mapping entries" ? TLB slots contain these "mapping
> entries", that's the whole purpose of TLB.

Yes, but 4xx allows for variable sized TLBs.

Sorry for the confusion. But maybe this tickles your inspiration :-)

Regards,
Marius

--
Marius Groeger <mgroeger@sysgo.com>           Project Manager
SYSGO AG                      Embedded and Real-Time Software
Voice: +49 6136 9948 0                  FAX: +49 6136 9948 10
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Mon, 7 Jun 2004 01:48:12 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Marius Groeger <mgroeger@sysgo.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC] Simple ioremap cache
Message-ID: <20040607084812.GA5808@gate.ebshome.net>
References: <20040605002915.GA17603@gate.ebshome.net> <Pine.LNX.4.56.0406070931180.3147@mag.sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.56.0406070931180.3147@mag.sysgo.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jun 07, 2004 at 09:46:16AM +0200, Marius Groeger wrote:
> I'm not sure, however, whether your current patch actually saves _TLB_
> misses.

Huh?

Let's consider two drivers - serial & emac on 44x. Both of them ioremap
different parts of the same phys page, but without the patch these will be
_different_ virtual mappings, e.g. if they access their respective I/O registers
_two_ TLB entries will be used.

Here is real example (see my original e-mail):

UART0 ioremaps 0x0000000140000200 and gets 0xfdfea200 as a virtual kernel
address

EMAC0 ioremaps 0x0000000140000800 and gets 0xd1000800.

You'll need _two_ TLB entries for these mappings:

0xfdfea000 -> 0x0000000140000000
0xd1000000 -> 0x0000000140000000

With my patch only _one_ TLB mapping will be required for _all_ 4K-sized
ioremaps of 0x0000000140000000:

0xfdfea000 -> 0x0000000140000000

440GP has a 64 entry TLB and believe me, when you are running user mode app,
there are a lot of TLB misses, and decreasing TLB pressure (e.g. requiring less
TLB entries for driver I/O) _will_ save you some TLB misses.

> Have you counted them to prove it?

No, it seemed quite obvious to me :)

> To do this, I think you also need
> to flag a bigger virtual page size to the MMU, eg. program a different
> PAGESZ_* value (see include/asm-ppc/mmu.h). If you don't, the MMU has to
> manage diffent chunks all the same, they just happen to be virtually
> contiguous.

I don't follow you here, sorry. Could you give some examples with the real TLB
contents for the cases you are describing?

> So I think what you're saving right now is just mapping entries (which also
> is a valid thing to gain).

What do you mean "just mapping entries" ? TLB slots contain these "mapping
entries", that's the whole purpose of TLB.

Eugene.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

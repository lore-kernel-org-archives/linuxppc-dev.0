From: Benjamin Herrenschmidt <benjamin.herrenschmidt@wanadoo.fr>
To: Dan Malek <dan@mvista.com>
Cc: Linuxppc-Commit <linuxppc-commit@source.mvista.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: status of linuxppc_2_4_devel for ppc405gp
Date: Wed, 22 Aug 2001 22:04:04 +0200
Message-Id: <20010822200404.21295@smtp.wanadoo.fr>
In-Reply-To: <3B83D895.C5738613@mvista.com>
References: <3B83D895.C5738613@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>Will you please check that in?  I pused the files but couldn't
>decide which method of initialization was "current" :-).
>
>I'm still sorting out the bootloader stuff.

I'll do tomorrow when I'm at work.

Note that I still didn't manage to get userland to work on
my 405GP. I'm suspecting an issue between Paulus/DaveM new
cache flush avoidance code and the weird cache design of the
405. But it might not...

If I understand correctly the 405GP docs the instruction cache
is indexed with a sort of mixup of virtual & physical addresses,
which has the side effect of causing aliasing problems if the
page size is lower than 16k (which is our case).

I'm not sure I get it completely yet, but it appears that with
a 4k size, we are supposed to invalidate a line _and_ the line
with bit 29 xor'ed whenever we want a given address to be safe
for instructions. Since the "shadow" line may not be in the same
page and that same page is not necessarily mapped when we do
the invalidate, the best solution, for now, would be to have
_all_ of the instruction cache invalidate functions inval. the
entire instruction cache. (You currently do it only on one of
"callbacks" in asm/pgtable.h, not in the other routines in
the .S files). That would be true for userland as well.

Ben.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Mon, 1 Apr 02 11:52:16 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204011952.AA28527@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] ev64260 bi_rec patch
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> IIRC, your original patch did the parsing in parse_bootinfo() or so in
> arch/ppc/kernel/setup.c which means each new driver bi_rec needs to
> modify arch/ppc/kernel/setup.c,

Yes.

> which isn't nice.

Agreed.

> What we need is
> something like how we save Motorola residual data or bd_info stuffs
> (memcpy in platform_init).

Both of those structures are fixed-length and are copied to static variables.
The bi_recs list has a variable length and can't be copied to a static variable
(unless we agree on a maximum size for it and make a static buffer of that
size, but someone other than me has to make that decision), and I don't know
how to make a dynamic memory allocation that early.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

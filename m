Message-ID: <002501c3ea75$eb7eba10$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Franz Sirl" <Franz.Sirl-ppc@lauterbach.com>
Cc: "Linuxppc-Dev@Lists. Linuxppc. Org (E-mail)" <linuxppc-dev@lists.linuxppc.org>
References: <000501c3ea56$60935060$0a01a8c0@LUMENTIS02> <6.0.2.0.2.20040203161335.035fde58@mail.lauterbach.com>
Subject: Re: TASK_UNMAPPED_BASE
Date: Tue, 3 Feb 2004 17:51:03 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Franz

Thanks for replying.

> At 14:05 03.02.2004, Joakim Tjernlund wrote:
>
> >Hi All
> >
> >Currently TASK_UNMAPPED_BASE in PPC is defined to:
> >#define TASK_UNMAPPED_BASE (TASK_SIZE / 8 *3) which is 0x30000000
> >
> >in glibc ldso's JMP_SLOT you have:

[SNIP]

> >
> >The if (delta << 6 >> 6 == delta) is commonly false.
>
> Well, if that is true for you, then you must have a really large app, since
> this covers relative branches +/-32M.

32M == 0x2000000 which is <  0x30000000-0x10000000
So "branches" to any library function will not fit into the 32M space, right?

>
> >If finaladdr is <= 0x01fffffc then the relocation is much cheaper than the
> >last else statement.
> >But since TASK_UNMAPPED_BASE is 0x30000000, finaladdr will never be <=
> >0x01fffffc unless
> >a shared library asks for a low address.
>
> But nearly nothing loads at 0x30000000, usually only ld.so. The executable
> itself (note that I haven't looked at PIE executables yet) is at 0x10000000
> and the shared libs are loaded initially below that until that space is
> filled and then above ld.so IIRC.

Yes, thats true for glibc. I wonder why glibc supply its own load address for all
libs but ld.so?

However, I forgot to mention uClibc. UClibc does not insist on its own load address, but lets
the kernel handle that.  So for uClibc, ld.so will load at 0x30000000 and the rest will follow
after ld.so.

>
> >I changed TASK_UNMAPPED_BASE to well under 0x01fffffc and it worked as well.
> >
> >My question: Why is TASK_UNMAPPED_BASE=0x30000000 and would changing it to
> >something
> >less, say 0x00100000 be a problem?
>
> Hmm, might work, but it can also break in subtle ways, cause the shared lib
> loading algorithm makes a few assumptions about the used address ranges
> IIRC. But I don't see any use for it if you consider what I said above.

OK, but are there other considerations as well? What is the address space below 0x10000000 used for?

 Jocke
>
> Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

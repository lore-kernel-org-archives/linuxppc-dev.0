MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16575.53851.142603.669967@cargo.ozlabs.ibm.com>
Date: Fri, 4 Jun 2004 11:37:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Stef Simoens" <stef.simoens@pi.be>
Cc: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: align.c handling of lswi / stswi
In-Reply-To: <HYMQXY$68CD56C10E486DAA5C77966D406CE84C@scarlet.be>
References: <HYMQXY$68CD56C10E486DAA5C77966D406CE84C@scarlet.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Stef Simoens writes:

> While testing the PPC601 MQ patch, some programs were giving
> reproducible BUS errors. gcc 601-optimized code uses lswi / stswi,
> and the fix_alignment function didn't know how to handle this. I
> worked the alignment fix out for these instructions
> (arch/ppc/kernel/align.c)
>
> My changes work (testing right now, with the MQ patch), however I'm
> not sure if my coding style is OK.
> The main changes are:
> - "union data" to "union data[7]" to store up to 4 * 8 = 32 bytes.

Hmmm, it would be nice to do lswx/stswx as well as lswi/stswi, and the
x versions can do up to 128 bytes.  I think we should just have
special cases for lsw* and stsw* instead of trying to use the existing
LD and ST cases.

> I looked in the 64-bit alignment code (arch/ppc64/kernel/align.c)
> and found 'switch (nb)' cleaner than the existing 'for (i = 0; i <
> nb; ++i)'.

It's a matter of taste; the for loop is certainly more compact.

> Is my patch to fix the alignment of stswi / lswi wanted? I'm not
> planning to use #ifdef because stswi/lswi are valid ppc instructions
> (however, because of timing, gcc probably won't generate them on non
> 601).

I think it would be good to handle lswi/stswi properly.  While we are
at it we should do lswx/stswx and lwm/stmw as well.

> Is it wanted to 'restyle' the ppc32 align.c to the ppc64 version --
> with only ppc32 instructions and the same functionality of the
> existing ppc32 align.c of course...

Not particularly.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

In-Reply-To: <Pine.SOL.4.10.10001061137170.262-100000@sunflower.bio.indiana.edu>
Date: Thu, 6 Jan 2000 19:16:00 +0100
To: Naoki Takebayashi <ntakebay@bio.indiana.edu>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Does 2.2.14 Break SMP for PPC?
Message-Id: <20000106191600.011735@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 6, 2000, Naoki Takebayashi <ntakebay@bio.indiana.edu> wrote:

>From patch-2.2.14:
>
>@@ -245,13 +233,16 @@
>        bl      prom_init
>        .globl  __secondary_start
> __secondary_start:
>-/*
>- * Use the first pair of BAT registers to map the 1st 16MB
>+/* Switch MMU off, clear BATs and flush TLB */
>+       bl      mmu_off
>+       bl      clear_bats
>+       bl      flush_tlbs
>+
>+/* Use the first pair of BAT registers to map the 1st 16MB
>  * of RAM to KERNELBASE.  From this point on we can't safely
>  * call OF any more.
>  */
>        lis     r11,KERNELBASE@h
>
>Well, I don't know PPC assembly, but I commented out the three "bl ... "
>lines.  Then the 2nd CPU stack message went away and SMP was enabled.
>However it it really unstable, though.  So the problem with 2.2.14 SMP
>seems to be around here.  Probably someone who knows PPC assembly can
>help here...

I'm the one responsible for those few lines of code, I'm a bit annoyed
that it broke SMP since I don't have an SMP card to play with.

Cort, Paul, any clue about what's wrong ? I'm wondering if it's related
to the physical address returned by OF and used in mmu_off which might be
wrong for the second CPU...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

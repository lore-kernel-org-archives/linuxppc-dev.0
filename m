Message-Id: <20010329222953.Postino-006016@smtp01.highway.ne.jp>
Date: Thu, 29 Mar 2001 22:29:53 +0900
To: Tom Gall <gall@rochcivictheatre.org>
Cc: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: spin_lock problem in recent kernel
In-Reply-To: <3AC2352D.384B57CA@rochcivictheatre.org>
References: <20010329021803.Postino-029218@smtp01.highway.ne.jp>
 <3AC2352D.384B57CA@rochcivictheatre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi

This is booing message when kernel-2.4.3pre8-SMP.

<snip>
TCP: Hash tables configured (established 8192 bind 8192)
ip_conntrack(2048 buckets,16384 max)
_spin_lock(c02cc470) CPU# 1 NIP c0033404 holder: cpu 1 pc C002B384
_spin_lock(c02ce740) CPU# 0 NIP c0015890 holder: cpu 1 pc C0015890
_spin_lock(c02cc470) CPU# 1 NIP c0033404 holder: cpu 1 pc C002B384
_spin_lock(c02ce740) CPU# 0 NIP c0015890 holder: cpu 1 pc C0015890
_spin_lock(c02cc470) CPU# 1 NIP c0033404 holder: cpu 1 pc C002B384
_spin_lock(c02ce740) CPU# 0 NIP c0015890 holder: cpu 1 pc C0015890
_spin_lock(c02cc470) CPU# 1 NIP c0033404 holder: cpu 1 pc C002B384
_spin_lock(c02ce740) CPU# 0 NIP c0015890 holder: cpu 1 pc C0015890

continue same messages

Any help
Kaoru




From: Tom Gall <gall@rochcivictheatre.org>
To: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: spin_lock problem in recent kernel
Date: Wed, 28 Mar 2001 13:02:05 -0600
CC: linuxppc-dev@lists.linuxppc.org

> Hi Kaoru,
>
>   I've found much the same as you... however I've also found that the
> patch you have below (which is exactly the same as a change I have made
> to the kernel I've been debugging) hasn't helped me too much. The
> page_table_lock would still get messed up during the boot sequence on
> Power3 with SMP on.
>
>   I don't have any other great enlightenment as I'm taking the day off
> ... be back at it tomorrow!
>
>   Regards,
>
>   Tom
>
> Kaoru Fukui wrote:
> >
> > Hi!
> >
> > I had tried SMP kernel using paulus rsync tree and 2_4 bk tree.
> > Since 2.4.3pre6 it has spin_lock problem in both tree.
> >
> > I used that patch when pre6,pre7
> > Then I could boot kernel and it's work well.
> >
> > 2.4.3pre8 is not boot that has the other spin_lock problem.
> > (around ip_tables loading)
> >
> > When i used this patch when pre6, pre7.
> >
> > Please check spin_lock problem of pre8 with SMP kernel.
> >
> > the machine is G4 dual
> > Thanks
> >
> > Kaoru
> >
> > diff -urN base/arch/ppc/mm/init.c fixed/arch/ppc/mm/init.c
> > --- base/arch/ppc/mm/init.c     Thu Mar 22 19:29:46 2001
> > +++ fixed/arch/ppc/mm/init.c    Fri Mar 23 05:52:33 2001
> > @@ -436,11 +436,11 @@
> >          * Should check if it is a candidate for a BAT mapping
> >          */
> >
> > -       spin_lock(&init_mm.page_table_lock);
> > +//     spin_lock(&init_mm.page_table_lock);
> >         err = 0;
> >         for (i = 0; i < size && err == 0; i += PAGE_SIZE)
> >                 err = map_page(v+i, p+i, flags);
> > -       spin_unlock(&init_mm.page_table_lock);
> > +//     spin_unlock(&init_mm.page_table_lock);
> >         if (err) {
> >                 if (mem_init_done)
> >                         vfree((void *)v);
> >
>
> --
> Regards,
>
> Tom
>
> --------------------------------------------------------------
> Linux Guy             "My heart is human, my blood is boiling,
> gall@rochcivictheatre.org    my brain IBM" -- Mr Roboto, Styxx
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

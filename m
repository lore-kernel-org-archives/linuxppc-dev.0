From: acurtis@directvinternet.com
Reply-To: <acurtis@directvinternet.com>
To: <joakim.tjernlund@lumentis.se>,
	"Eugene Surovegin" <ebs@innocent.com>
Cc: <linuxppc-dev@lists.linuxppc.org>, <acurtis@directvinternet.com>
Subject: RE: Is the preemptive kernel patch unsafe for 8xx/PPC?
Date: Mon, 16 Dec 2002 06:41:50 -0800
Message-ID: <NCBBIINEHIPFGJPLBEIFAECOEAAA.acurtis@directvinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <IGEFJKJNHJDCBKALBJLLMEMJFIAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I ran this patch on 2.4.19 and here were my results.

> > 1) arch/ppc/kernel.entry.S
> >
> > diff -urN linux-2.4.20/arch/ppc/kernel/entry.S
> linux/arch/ppc/kernel/entry.S
> > --- linux-2.4.20/arch/ppc/kernel/entry.S        2002-11-28
> > 18:53:11.000000000 -0500
> > +++ linux/arch/ppc/kernel/entry.S       2002-12-11
> 02:34:47.000000000 -0500
> > @@ -278,6 +278,41 @@
> >           */
> >          cmpi    0,r3,0
> >          beq     restore
> > +#ifdef CONFIG_PREEMPT
> > +       lwz     r3,PREEMPT_COUNT(r2)
> > +       cmpi    0,r3,1
> > +       bge     ret_from_except
> > +       lwz     r5,_MSR(r1)
> > +       andi.   r5,r5,MSR_PR
> > +       bne     do_signal_ret
> >
> >      <rest of the diff is skipped>
> >
> > I had to change the last command to "bne ret_from_except".
> > I checked MontaVista tree, and they have "ret_from_except" there also.
>
> This I can not comment on, but my 8xx runs fine with it.

I did not make the above code change and it appears to run. Any comments?

> > 2) include/asm-ppc/pgalloc.h  There are curly brackets missing in
> > get_pgd_fast()
>
> Yes, they are missing in the else part.

I had to fix this too.

> > 3) to support 440GP you have to modify
> arc/ppc/kernel/irc.c:preempt_intercept:
> >
> > #if !defined(CONFIG_4xx) || defined(CONFIG_440)
> >          case 0x900:
> > #else
> >          case 0x1000:
> > #endif

I could not test these changes either. Any feedback from Robert Love?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

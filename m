Message-ID: <20030527084124.5312.qmail@web12703.mail.yahoo.com>
Date: Tue, 27 May 2003 10:41:24 +0200 (CEST)
From: =?iso-8859-1?q?vincent=20poirson?= <poirsonv@yahoo.fr>
Subject: Re: [MPC8260] accessing I/Os while MMU is off
To: gary@mlbassoc.com
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1053953308.4694.387.camel@hermes>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Surprisingly, I can move my I/O with BDI2000 by
modifing directly the PDATC value at the telnet
server. The BDI doc says the adress written at the
telnet server are never translated. So I guess I got
the physical adress. However, I tried translating the
adress and I do not get satisfying results either.


 --- Gary Thomas <gary@mlbassoc.com> a écrit : > On
Mon, 2003-05-26 at 06:39, vincent poirson wrote:
> > Well, I forgot one operand in the addis
> instruction
> > but otherwise my code is OK. I checked that the
> right
> > PDATC adress was in the GPR.
> > I also forgot to say that my code works when I put
> it
> > in a interrupt handler in a normal kernel module.
> > What I do not understand is why the kernel keeps
> going
> > in machine check exception when I try to load
> PDATC
> > contents or store a value in PDATC.
> >
>
> Are you sure that the address you are using is
> correct?  In particular,
> this may be a mapped (via MMU) address.  The
> physical address can often
> be different.  When you are executing in this mode,
> you must use the
> physical address.
>
> >
> >
> >  --- None Atall <linux_meis@yahoo.com> a écrit : >
> You
> > missed a small shift... :)
> > >
> > > -----------------------
> > > li r16,r16,0x10
> > > li r13, 0xf001
> > > slw  r13,r13,r16
> > > addis r13, 0x0d50
> > > stw r14, 0(r13)
> > > -----------------------
> > >
> > >                    Dimitris.
> > >
> > > --- vincent poirson <poirsonv@yahoo.fr> wrote:
> > > >
> > > > Hello,
> > > >
> > > > I want to change my PDATC value while in
> > > > HardwareInterrupt code (in kernel/head.S)
> where
> > > MMU
> > > > is
> > > > off. So I simply do :
> > > > li r13, 0x0d50
> > > > addis r13, 0xf001
> > > > stw r14, 0(r13)
> > > > // where 0xf0010d50 is my PDATC adress and r14
> the
> > > > value I want to store
> > > > I do not understand why my kernel crahes and
> goes
> > > in
> > > > machine exception. Surprisingly, I can change
> > > PDATC
> > > > with BDI2000 but not with assembler code. Is
> this
> > > an
> > > > adress translation problem ?
> > > > Am I missing something obvious ? Any help will
> be
> > > > appreciated.
> > > >
> > > > Thanks in advance.
> > > >
> > > >
> > > >
> > >
> > >
> > > =====
> > >
> >
>
------------------------------------------------------------
> > > -Dhmhtrios Meidanis
> > > -Degree in Mathematics, University of the
> Aegean.
> > > -Master in Computer Architecture and Digital
> > >  Systems, University of Crete.
> > >  Greece.
> > >
> >
>
------------------------------------------------------------
> > >
> >
> >
> --
> Gary Thomas <gary@mlbassoc.com>
> MLB Associates
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

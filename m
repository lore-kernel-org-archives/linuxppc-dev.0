Message-ID: <20030526123940.45233.qmail@web12702.mail.yahoo.com>
Date: Mon, 26 May 2003 14:39:40 +0200 (CEST)
From: =?iso-8859-1?q?vincent=20poirson?= <poirsonv@yahoo.fr>
Subject: Re: [MPC8260] accessing I/Os while MMU is off
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030526082722.86882.qmail@web9706.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Well, I forgot one operand in the addis instruction
but otherwise my code is OK. I checked that the right
PDATC adress was in the GPR.
I also forgot to say that my code works when I put it
in a interrupt handler in a normal kernel module.
What I do not understand is why the kernel keeps going
in machine check exception when I try to load PDATC
contents or store a value in PDATC.



 --- None Atall <linux_meis@yahoo.com> a écrit : > You
missed a small shift... :)
>
> -----------------------
> li r16,r16,0x10
> li r13, 0xf001
> slw  r13,r13,r16
> addis r13, 0x0d50
> stw r14, 0(r13)
> -----------------------
>
>                    Dimitris.
>
> --- vincent poirson <poirsonv@yahoo.fr> wrote:
> >
> > Hello,
> >
> > I want to change my PDATC value while in
> > HardwareInterrupt code (in kernel/head.S) where
> MMU
> > is
> > off. So I simply do :
> > li r13, 0x0d50
> > addis r13, 0xf001
> > stw r14, 0(r13)
> > // where 0xf0010d50 is my PDATC adress and r14 the
> > value I want to store
> > I do not understand why my kernel crahes and goes
> in
> > machine exception. Surprisingly, I can change
> PDATC
> > with BDI2000 but not with assembler code. Is this
> an
> > adress translation problem ?
> > Am I missing something obvious ? Any help will be
> > appreciated.
> >
> > Thanks in advance.
> >
> >
> >
>
>
> =====
>
------------------------------------------------------------
> -Dhmhtrios Meidanis
> -Degree in Mathematics, University of the Aegean.
> -Master in Computer Architecture and Digital
>  Systems, University of Crete.
>  Greece.
>
------------------------------------------------------------
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

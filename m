From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 2.6.5 kernel build: 'macro "mfmsr" passed 1 arguments, but takes just 0'
Date: Sat, 8 May 2004 17:05:00 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHKENPCFAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.LNX.4.58.0405081014260.13274@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On Sat, 8 May 2004, Joakim Tjernlund wrote:
>
> > >   as did someone else on this list recently, i did a first attempt at
> > > compiling the stock 2.6.5 kernel for an MPC8xx board.  from a verbose
> > > build:
> > > ====================================================================
> > > ...
> > [SNIP]
> >
> > The stock kernel is not up to date. Use the PPC tree,
> > http://ppc.bkbits.net:8080/linuxppc-2.5, instead. That tree should
> > compile, but still has run time problems.
>
> ok, thanks.  regarding the run-time problems, it's not like i wanted to
> get a production-ready system right now -- i'll be satisfied to see just
> how far i can get.  more a curiosity thing than anything else.

I think you will get to early user space. Dan Malek knowns more.

Also, I think the MachineCheck exception in head_8xx.S is broken.
I think is should be:
	. = 0x200
MachineCheck:
 	EXCEPTION_PROLOG
 	mfspr	r4,DAR
 	stw	r4,_DAR(r11)
 	mfspr	r5,DSISR
 	stw	r5,_DSISR(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_EE(0x200, MachineCheckException)
>
> rday
>
> p.s.  BTW, is this the right forum to discuss getting a 2.5/2.6 kernel
> running on an MPX8xx board?

Yes

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

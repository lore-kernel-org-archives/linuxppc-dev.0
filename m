From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15347.21652.410313.109535@cargo.ozlabs.ibm.com>
Date: Thu, 15 Nov 2001 16:37:24 +1100 (EST)
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: floating-point under ppc/linux
In-Reply-To: <Pine.LNX.4.33.0110301820520.10911-100000@gra-lx1.iram.es>
References: <15326.8355.242681.874353@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.33.0110301820520.10911-100000@gra-lx1.iram.es>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert writes:

> > I am thinking that the FE0 and FE1 bits in the MSR will be set
> > according to the disposition of the SIGFPE signal: SIG_IGN => 00
> > (disabled), SIG_DFL => 01 (imprecise nonrecoverable mode), user
> > handler => 10 (imprecise recoverable mode).
>
> I'd rather put 11 for user handler. I want to be able to pinpoint the
> instruction which caused the fault in the handler. Besides, most
> processors these days only implement the ignore and precise FP exceptions
> modes. I suspect that it is because once you have implemented the
> hardware for out of order and speculative execution, implementing the
> imprecise exception modes would be a lot of work for little gain.

I did some research.  It turns out that the 604 family are the only
PPCs that implement anything other than 00 and 11.  The 604 also
implements mode 01 (imprecise nonrecoverable mode).  I have no idea
whether mode 01 would be faster than mode 11.  No implementation does
mode 10 differently from mode 11.  So I'm happy to use mode 11 instead
of 10.

> I am
> firmly convinced that all signal handlers should always be entered with a
> known FPSCR value, 0, and that it should be documented too...

Good idea.  Let's do that.  That would solve the major problem.

> On the other hand, the ability to control FE0 and FE1, values that can be
> global to a program, through a system call would be a good thing. I wanted
> long ago to add this capability to prctl but never came around to it.

It seems to me that if we are only using modes 00 and 11 then using
the SIGFPE disposition to control it is adequate.  If people want to
use mode 01 but still catch the signals then we would need a prctl or
something.  Does anyone use 604s for FP-intensive stuff these days, I
wonder?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3041E2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jun 2013 14:31:42 +1000 (EST)
Message-ID: <1370665868.3766.451.camel@pasglop>
Subject: Re: fsqrt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <d6malek@digitaldans.com>
Date: Sat, 08 Jun 2013 14:31:08 +1000
In-Reply-To: <4A771AC5-37F2-4EC2-A733-52FFAAAB3C92@digitaldans.com>
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38.camel@pasglop> <51947A00.9010504@windriver.com>
 <1368685307.9603.39.camel@pasglop> <51947E35.30808@windriver.com>
 <1368686426.9603.49.camel@pasglop> <5194800D.3010606@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C498@039-SN2MPN1-012.039d.mgd.msft.net>
 <1368687133.9603.51.camel@pasglop>
 <CAOZdJXU79kqEGk_nqv1NSzna7c=bgwSv+6WFgaTVjR4Rj4cZVg@mail.gmail.com>
 <1370577138.3766.342.camel@pasglop> <1370579976.3766.345.camel@pasglop>
 <3E027F8168735B46AC006B1D0C7BB0020B2135A0@039-SN2MPN1-012.039d.mgd.msft.net>
 <1370580426.3766.349.camel@pasglop>
 <3E027F8168735B46AC006B1D0C7BB0020B213817@039-SN2MPN1-012.039d.mgd.msft.net>
 <1370590884.3766.357.camel@pasglop>
 <3E027F8168735B46AC006B1D0C7BB0020B213A62@039-SN2MPN1-012.039d.mgd.msft.! !
 net>
 <137 0595190.3766 .359.camel@pasglop> <1370595557.3766.362.camel@pasglop>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7279@saturn3.aculab.com>
 <1370607245.3766.386.camel@pasglop>
 <B90B185D-AC79-4A39-91F1-57F371D9D732@kernel.crashing.org>
 <1370647431.3766.432.camel@pasglop> <1370647524.3766.433.camel@pasglop>
 <1370647812.3766.436.camel@pasglop>
 <0CCB5C3E-E239-4269-B29C-93BF9D8201D6@digitaldans.com>
 <1370651667.3766.441.camel@pasglop>
 <4A771AC5-37F2-4EC2-A733-52FFAAAB3C92@digitaldans.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Liu Qiang-B32616 <B32616@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>, Timur Tabi <timur@tabi.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 David Laight <David.Laight@ACULAB.COM>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-06-07 at 18:13 -0700, Dan Malek wrote:
> Hi Ben.
> 
> On Jun 7, 2013, at 5:34 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> 
> > The question is whether this is still relevant ?
> 
> The only answer I could provide is that it's dependent upon the
> libraries and how the distributions are built.  It's also dependent
> upon processors with hardware FP that don't implement all instructions
> in hardware (who had that bright idea? :))  If distributions are fully
> all soft-fp in user space or all hardware FP, it removes the one
> reason that started the whole partial emulation option.

I'm not questioning the relevance of math-emu as a whole, but of the
tiny subset which is duplicated in math-emu and softemu8xx, which
emulates only load/stores/fmr.

If userspace is built with hard FP it is likely to use more than just
those handful of instructions...

> > …  And if the answer is
> > yes,
> 
> There are multiple options, but I believe they are solved today.  One
> is the libraries coded with hardware load/store that are used by
> soft-fp, another is hardware FP that doesn't implement all
> instructions in hardware (which it seems is the basis of this thread,
> although I thought was already solved). 

Yes, it's indeed the basis of that thread, and yes, I though it was
already solved as well but unless I missed something it is not, because
the current Program Check handler calls do_mathemu without first
flushing the hard FP state into the thread_struct.

However it's quite possible (I'll test when I get back to the office)
that this it the only fix necessary, which is a one liner, to make
CONFIG_MATH_EMULATION work just fine in that case.

> The variation here is that in the first case you have to read/write
> user space soft-fp stack "registers," while in the latter you
> read/write real FP registers. 

We never do any "user space soft-fp stack registers" handling in the
kernel. If we use full math emu (ie, no FP at all in HW), we simply use
the normal thread_struct storage of FPRs to store the "virtual" user FP
regs used by the emulation.

If use space uses full soft-fp (ie, -msoft-float), we should never see
any of it in the kernel.

>  There used to be the third variation where the stack was allocated
> and the emulation had to write both places due to compiler function
> APIs or optimizations.  Of course, then there is the full-up kernel
> emulation where hardware is entirely lacking.

I don't know anything about that "3rd option", it certainly doesn't have
any kernel impact that I can see :-) Full up emulation is of course
still there.

> > … we still want that "minimum" emulation of load/stores/fmr as an
> > option, is there any reason why we can't replace the one in
> softemu8xx
> > with the existing (and unused) equivalent in do_mathemu ?
> 
> It appears to me that 8xx custom code can be removed.  I guess I
> should try to boot it up, if anyone even cares these days. :)

Thanks,

Cheers,
Ben.

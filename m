Return-Path: <d6malek@digitaldans.com>
Received: from digitaldans.com (digitaldans.com [69.36.177.99])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6EBFD2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jun 2013 10:30:25 +1000 (EST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: fsqrt
From: Dan Malek <d6malek@digitaldans.com>
In-Reply-To: <1370647812.3766.436.camel@pasglop>
Date: Fri, 7 Jun 2013 17:20:25 -0700
Message-Id: <0CCB5C3E-E239-4269-B29C-93BF9D8201D6@digitaldans.com>
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
 <3E027F8168735B46AC006B1D0C7BB0020B213A62@039-SN2MPN1-012.039d.mgd.msft.!
 net> <137 0595190.3766 .359.camel@pasglop> <1370595557.3766.362.camel@pasglop>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7279@saturn3.aculab.com>
 <1370607245.3766.386.camel@pasglop>
 <B90B185D-AC79-4A39-91F1-57F371D9D732@kernel.crashing.org>
 <1370647431.3766.432.camel@pasglop> <1370647524.3766.433.camel@pasglop>
 <1370647812.3766.436.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Zang Roy-R61911 <r61911@freescale.com>,
 Xie Shaohui-B21989 <B21989@freescale.com>,
 Liu Qiang-B32616 <B32616@freescale.com>, Timur Tabi <timur@tabi.org>,
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


On Jun 7, 2013, at 4:30 PM, Benjamin Herrenschmidt =
<benh@kernel.crashing.org> wrote:

> Right, looking more, the code really sucks.

Hey!  :)

> =85.  Either you use the existing
> apparent ability for MATH_EMU to operate in minimal mode, ie,
> load/store/fmr only (which seems to do exactly the same thing as the
> code in softemu8xx.c which we can then get rid of), or just get rid of
> that minimal mode altogether.

The purpose for that "minimal code" was the signal handlers were =
hand-coded assembly that always did the FPU load/store regardless of =
compiler flags.  Over time, it became convenient to emulate a few =
others, even with user space math emulation, for similar reasons.

> And while at it make it a general config option for all soft-emu
> processors (there is no bloody reason why that should be 8xx specfic) =
or
> just get rid of the whole concept of half-emulation.

Looks like the code just evolved and the 8xx was never cleaned up.

The partial emulation is a convenience for the libraries that may still =
have FP instructions directly coded.  There are also permutations of =
real FPU but not all instructions, and no FPU to consider for fetching =
operands and storing results to be considered for the various =
configuration options.

Thanks.

	-- Dan

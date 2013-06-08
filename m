Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 654FB2C0178
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jun 2013 10:34:47 +1000 (EST)
Message-ID: <1370651667.3766.441.camel@pasglop>
Subject: Re: fsqrt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <d6malek@digitaldans.com>
Date: Sat, 08 Jun 2013 10:34:27 +1000
In-Reply-To: <0CCB5C3E-E239-4269-B29C-93BF9D8201D6@digitaldans.com>
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
 <3E027F8168735B46AC006B1D0C7BB0020B213A62@039-SN2MPN1-012.039d.mgd.msft.! net>
 <137 0595190.3766 .359.camel@pasglop> <1370595557.3766.362.camel@pasglop>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7279@saturn3.aculab.com>
 <1370607245.3766.386.camel@pasglop>
 <B90B185D-AC79-4A39-91F1-57F371D9D732@kernel.crashing.org>
 <1370647431.3766.432.camel@pasglop> <1370647524.3766.433.camel@pasglop>
 <1370647812.3766.436.camel@pasglop>
 <0CCB5C3E-E239-4269-B29C-93BF9D8201D6@digitaldans.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Fri, 2013-06-07 at 17:20 -0700, Dan Malek wrote:

> The purpose for that "minimal code" was the signal handlers were
> hand-coded assembly that always did the FPU load/store regardless of
> compiler flags.  Over time, it became convenient to emulate a few
> others, even with user space math emulation, for similar reasons.

The question is whether this is still relevant ? And if the answer is
yes, we still want that "minimum" emulation of load/stores/fmr as an
option, is there any reason why we can't replace the one in softemu8xx
with the existing (and unused) equivalent in do_mathemu ?

Cheers,
Ben.

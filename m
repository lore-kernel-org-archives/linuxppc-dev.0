Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BE85E2C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Jun 2013 16:32:43 +1000 (EST)
Message-ID: <1370759535.3766.477.camel@pasglop>
Subject: Re: fsqrt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <d6malek@digitaldans.com>, Kumar Gala <galak@kernel.crashing.org>
Date: Sun, 09 Jun 2013 16:32:15 +1000
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

The interesting thing I'm finding is that our math-emu is actually
quite busted :-)

For example look at fsqrt. It's defined as type AB which is incorrect,
it should be type XB. It ends up looking for it's arguments in the wrong
registers, same for fsrqts, fre, and a few others.

Also quite a few functions are simply left unimplemented... (fre is
completely missing from the decode, fres is there but returns -ENOSYS,
as does frsqrte, etc...)

I'll post a quick for for fsqrt{s} that I need for anaconda, but I
would strongly encourage somebody from FSL (primary users of that
stuff still) to have a close look at the rest. It shouldn't be terribly
hard to fix them up and add the few missing instructions, even if not
with the amount of precision requested by the spec (better than -ENOSYS)

Cheers,
Ben.

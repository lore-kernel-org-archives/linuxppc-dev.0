Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6BBB32C007E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2013 22:14:19 +1000 (EST)
Message-ID: <1370607245.3766.386.camel@pasglop>
Subject: Re: fsqrt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
Date: Fri, 07 Jun 2013 22:14:05 +1000
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7279@saturn3.aculab.com>
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
 <3E027F8168735B46AC006B1D0C7BB0020B213A62@039-SN2MPN1-012.039d.mgd.msft.net>
 <137 0595190.3766 .359.camel@pasglop> <1370595557.3766.362.camel@pasglop>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7279@saturn3.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Liu Qiang-B32616 <B32616@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>, Timur Tabi <timur@tabi.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
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

On Fri, 2013-06-07 at 11:48 +0100, David Laight wrote:
> > For those interested, this is the Quake3 sqrt from Carmack ...
> there's
> > plenty of literature about it one or two google clicks away :-)
> 
> I guess that is a rough enough approximation for graphics.
> 
> However it will be miscompiled unless i and y are put in a union.

It won't in the kernel disables strict aliasing :-)

Anyway, that was just a hack and plenty enough to get anaconda going,
the bloody thing only uses fsqrt because it's python crappola does
something like exp(1.0) / sqrt(2.0) as part of its random number stuff.

Honestly I could have made it just return 1.0 and it would probably have
worked :-)

However, my point remains, it would be very much worthwhile for the
kernel to have some reasonable emulation of those missing instructions
(afaik only a handful) like we have for isel, popcnt* etc... especially
since distros seem to be keen on enabling the use of them in their
toolchain.

I don't personally have the bandwidth to do a clean implementation (that
handles FP exceptions, NaNs, FPSCR, etc...) but I believe it would be
valuable if somebody else did (hint hint hint :-) since without this,
Fedora ppc64 is basically going to be a non-started on those chips.

BTW. Did you guys (ie. FSL) finally add fsqrt to e6500 or it's still
out ? 

Cheers,
Ben.

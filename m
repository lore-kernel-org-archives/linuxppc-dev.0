Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5F4BF2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2013 22:09:28 +1000 (EST)
Message-ID: <1370606960.3766.381.camel@pasglop>
Subject: Re: FSL 64-bit DMA window question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-R61911 <r61911@freescale.com>
Date: Fri, 07 Jun 2013 22:09:20 +1000
In-Reply-To: <3E027F8168735B46AC006B1D0C7BB0020B213BF7@039-SN2MPN1-012.039d.mgd.msft.net>
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
 <1370588727.3766.355.camel@pasglop>
 <3E027F8168735B46AC006B1D0C7BB0020B213AA9@039-SN2MPN1-012.039d.mgd.msft.net>
 <1370595309.3766.361.camel@pasglop>
 <3E027F8168735B46AC006B1D0C7BB0020B213BF7@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Liu Qiang-B32616 <B32616@freescale.com>, Timur Tabi <timur@tabi.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-06-07 at 09:44 +0000, Zang Roy-R61911 wrote:
> 
> > -----Original Message-----
> > From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> > 
> > On Fri, 2013-06-07 at 07:58 +0000, Zang Roy-R61911 wrote:
> > >
> > > > -----Original Message-----
> > > > From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> > > >
> > > > Hi Folks !
> > > >
> > > > Is there any specific reason why you chose 1T (40 bit) as the
> > location of
> > > > the 64-bit DMA window ?
> > > >
> > > > It happens that most current radeon adapters cannot DMA there, they
> > have
> > > > a 40-bit DMA limit. I seem to be getting things to work fine using a
> > 39-
> > > > bit window, but I suppose that might collide with something else ?
> > > T4240 has 40bit physical address ability.
> > > "
> > > This chip's 40-bit, physical address map consists of local space and
> > external address
> > > space. For the local address map, 32 local access windows (LAWs) define
> > mapping
> > > within the local 40-bit (1 TB) address space. Inbound and outbound
> > translation windows
> > > can map the chip into a larger system address space such as the RapidIO
> > or PCIe 64-bit
> > > address environment. This functionality is included in the address
> > translation and
> > > mapping units (ATMUs).
> > >
> > > "
> > > That should be the reason to set the DMA window to 40-bit.
> > I see. However if the top half of that space isn't used by default with
> > whatever is our current setup, it makes sense to move down the 64-bit
> > DMA window to allow those adapters to function don't you think ?
> Good to me.
> 40 bit DMA will prevent your radeon video card from working. Right?
> Your P5020 DS system only support 36 bit physical address.

We should probably put the "64-bit DMA" address in the device-tree,
that way if somebody wish to do differently they can.
> > 
> > I'm trying to turn those FSL boxes into nice ppc64 dev. workstations :-)
> That is good. I'd like to see how long it will build a kernel ...

I'll tell you when you send me a 24 cores e6500 :-)

In the meantime I'll build them on my 16-cores (64 threads) P7+ :-)

I'm more thinking about how to seed general community developers with
machines they can use to ensure things work fine on ppc64 without having
to get them a rack in their basement...

Cheers,
Ben.

> thanks.
> Roy

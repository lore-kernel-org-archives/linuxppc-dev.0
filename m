Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 327EA2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 06:47:59 +1000 (EST)
Message-ID: <1375476455.15999.13.camel@pasglop>
Subject: Re: therm_pm72 units, interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Sat, 03 Aug 2013 06:47:35 +1000
In-Reply-To: <1375454871.3852.27.camel@thor.local>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066616.11751.2.camel@pasglop>
 <alpine.LNX.2.01.1301142240140.30171@nerf07.vanv.qr>
 <1358465885.2782.24.camel@pasglop>
 <20130719174300.GL14385@blackmetal.musicnaut.iki.fi>
 <1374275809.19894.562.camel@pasglop>
 <20130720203346.GM14385@blackmetal.musicnaut.iki.fi>
 <1375437816.3852.12.camel@thor.local> <1375447861.15999.1.camel@pasglop>
 <1375454871.3852.27.camel@thor.local>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Ben Hutchings <ben@decadent.org.uk>, Jan Engelhardt <jengelh@inai.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-02 at 16:47 +0200, Michel Dänzer wrote:
> On Fre, 2013-08-02 at 22:51 +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2013-08-02 at 12:03 +0200, Michel Dänzer wrote:
> > > Could a similar change fix the same problem on desktop G5s? The same
> > > values for slots_param in windfarm_pm112.c don't help, unfortunately.
> > 
> > You have a 11,2 and a noisy fan ? Odd, mine(s) don't.... I can dbl check
> > the values vs. what Darwin uses tomorrow...
> 
> Yes, see /proc/cpuinfo below.
> 
> With older kernels (currently still using Debian's 3.2.0-4-powerpc64
> because of this problem), the fans go basically silent as soon as the
> windfarm modules are loaded. With current kernels, the fans stay at the
> level OF sets them to, until after a while they go into 'airplane mode'.
> 
> One thing I notice now is that the lines like
> 
> [    9.539173] windfarm: CPUs control loops started.
> [   16.209962] windfarm: Backside control loop started.
> [   16.262274] windfarm: Slots control loop started.
> [   16.371642] windfarm: Drive bay control loop started.
> 
> no longer appear in dmesg with current kernels. Should they?

Yes. Do you have all the windfarm modules loaded ? What about
i2c-powermac ? (It's typical that the latter is missed, I think it
doesn't auto-load, which we never fixed, we used to request distros to
just built it in)

Ben.

> 
> processor	: 0
> cpu		: PPC970MP, altivec supported
> clock		: 2500.000000MHz
> revision	: 1.1 (pvr 0044 0101)
> 
> processor	: 1
> cpu		: PPC970MP, altivec supported
> clock		: 2500.000000MHz
> revision	: 1.1 (pvr 0044 0101)
> 
> processor	: 2
> cpu		: PPC970MP, altivec supported
> clock		: 2500.000000MHz
> revision	: 1.1 (pvr 0044 0101)
> 
> processor	: 3
> cpu		: PPC970MP, altivec supported
> clock		: 2500.000000MHz
> revision	: 1.1 (pvr 0044 0101)
> 
> timebase	: 33333333
> platform	: PowerMac
> model		: PowerMac11,2
> machine		: PowerMac11,2
> motherboard	: PowerMac11,2 MacRISC4 Power Macintosh 
> detected as	: 337 (PowerMac G5 Dual Core)
> pmac flags	: 00000000
> L2 cache	: 1024K unified
> pmac-generation	: NewWorld
> 
> 

Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 5E06D2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 00:48:09 +1000 (EST)
Message-ID: <1375454871.3852.27.camel@thor.local>
Subject: Re: therm_pm72 units, interface
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 02 Aug 2013 16:47:51 +0200
In-Reply-To: <1375447861.15999.1.camel@pasglop>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066616.11751.2.camel@pasglop>
 <alpine.LNX.2.01.1301142240140.30171@nerf07.vanv.qr>
 <1358465885.2782.24.camel@pasglop>
 <20130719174300.GL14385@blackmetal.musicnaut.iki.fi>
 <1374275809.19894.562.camel@pasglop>
 <20130720203346.GM14385@blackmetal.musicnaut.iki.fi>
 <1375437816.3852.12.camel@thor.local> <1375447861.15999.1.camel@pasglop>
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

On Fre, 2013-08-02 at 22:51 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2013-08-02 at 12:03 +0200, Michel D=C3=A4nzer wrote:
> > Could a similar change fix the same problem on desktop G5s? The same
> > values for slots_param in windfarm_pm112.c don't help, unfortunately.
>=20
> You have a 11,2 and a noisy fan ? Odd, mine(s) don't.... I can dbl check
> the values vs. what Darwin uses tomorrow...

Yes, see /proc/cpuinfo below.

With older kernels (currently still using Debian's 3.2.0-4-powerpc64
because of this problem), the fans go basically silent as soon as the
windfarm modules are loaded. With current kernels, the fans stay at the
level OF sets them to, until after a while they go into 'airplane mode'.

One thing I notice now is that the lines like

[    9.539173] windfarm: CPUs control loops started.
[   16.209962] windfarm: Backside control loop started.
[   16.262274] windfarm: Slots control loop started.
[   16.371642] windfarm: Drive bay control loop started.

no longer appear in dmesg with current kernels. Should they?


processor	: 0
cpu		: PPC970MP, altivec supported
clock		: 2500.000000MHz
revision	: 1.1 (pvr 0044 0101)

processor	: 1
cpu		: PPC970MP, altivec supported
clock		: 2500.000000MHz
revision	: 1.1 (pvr 0044 0101)

processor	: 2
cpu		: PPC970MP, altivec supported
clock		: 2500.000000MHz
revision	: 1.1 (pvr 0044 0101)

processor	: 3
cpu		: PPC970MP, altivec supported
clock		: 2500.000000MHz
revision	: 1.1 (pvr 0044 0101)

timebase	: 33333333
platform	: PowerMac
model		: PowerMac11,2
machine		: PowerMac11,2
motherboard	: PowerMac11,2 MacRISC4 Power Macintosh=20
detected as	: 337 (PowerMac G5 Dual Core)
pmac flags	: 00000000
L2 cache	: 1024K unified
pmac-generation	: NewWorld


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer

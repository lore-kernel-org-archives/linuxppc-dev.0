Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 51B2F2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 02:52:44 +1000 (EST)
Message-ID: <1375462346.3852.42.camel@thor.local>
Subject: Re: therm_pm72 units, interface
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Fri, 02 Aug 2013 18:52:26 +0200
In-Reply-To: <20130802155818.GB29933@blackmetal.musicnaut.iki.fi>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066616.11751.2.camel@pasglop>
 <alpine.LNX.2.01.1301142240140.30171@nerf07.vanv.qr>
 <1358465885.2782.24.camel@pasglop>
 <20130719174300.GL14385@blackmetal.musicnaut.iki.fi>
 <1374275809.19894.562.camel@pasglop>
 <20130720203346.GM14385@blackmetal.musicnaut.iki.fi>
 <1375437816.3852.12.camel@thor.local> <1375447861.15999.1.camel@pasglop>
 <1375454871.3852.27.camel@thor.local>
 <20130802155818.GB29933@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jan Engelhardt <jengelh@inai.de>, Ben Hutchings <ben@decadent.org.uk>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fre, 2013-08-02 at 18:58 +0300, Aaro Koskinen wrote:
> On Fri, Aug 02, 2013 at 04:47:51PM +0200, Michel D=C3=A4nzer wrote:
> > On Fre, 2013-08-02 at 22:51 +1000, Benjamin Herrenschmidt wrote:
> > > On Fri, 2013-08-02 at 12:03 +0200, Michel D=C3=A4nzer wrote:
> > > > Could a similar change fix the same problem on desktop G5s? The sam=
e
> > > > values for slots_param in windfarm_pm112.c don't help, unfortunatel=
y.
> > >=20
> > > You have a 11,2 and a noisy fan ? Odd, mine(s) don't.... I can dbl ch=
eck
> > > the values vs. what Darwin uses tomorrow...
> >=20
> > Yes, see /proc/cpuinfo below.
> >=20
> > With older kernels (currently still using Debian's 3.2.0-4-powerpc64
> > because of this problem), the fans go basically silent as soon as the
> > windfarm modules are loaded. With current kernels, the fans stay at the
> > level OF sets them to, until after a while they go into 'airplane mode'=
.
> >=20
> > One thing I notice now is that the lines like
> >=20
> > [    9.539173] windfarm: CPUs control loops started.
> > [   16.209962] windfarm: Backside control loop started.
> > [   16.262274] windfarm: Slots control loop started.
> > [   16.371642] windfarm: Drive bay control loop started.
> >=20
> > no longer appear in dmesg with current kernels. Should they?
>=20
> Yes. They are printed once all the sensor and control modules are
> loaded and registered. If the loops are not started, it's basically
> doing nothing. Maybe something goes wrong in module loading? What lsmod
> is showing?

Thanks for the suggestion. The same windfarm modules were loaded in both
cases, but i2c_powermac wasn't loaded with the newer kernels. Loading it
manually fixes the problem.

How is i2c_powermac supposed to get loaded with current kernels?


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer

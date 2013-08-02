Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri5.pp.htv.fi (filtteri5.pp.htv.fi [213.243.153.188])
 by ozlabs.org (Postfix) with ESMTP id A735E2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 01:58:30 +1000 (EST)
Date: Fri, 2 Aug 2013 18:58:19 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: therm_pm72 units, interface
Message-ID: <20130802155818.GB29933@blackmetal.musicnaut.iki.fi>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066616.11751.2.camel@pasglop>
 <alpine.LNX.2.01.1301142240140.30171@nerf07.vanv.qr>
 <1358465885.2782.24.camel@pasglop>
 <20130719174300.GL14385@blackmetal.musicnaut.iki.fi>
 <1374275809.19894.562.camel@pasglop>
 <20130720203346.GM14385@blackmetal.musicnaut.iki.fi>
 <1375437816.3852.12.camel@thor.local>
 <1375447861.15999.1.camel@pasglop>
 <1375454871.3852.27.camel@thor.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1375454871.3852.27.camel@thor.local>
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

On Fri, Aug 02, 2013 at 04:47:51PM +0200, Michel Dänzer wrote:
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

Yes. They are printed once all the sensor and control modules are
loaded and registered. If the loops are not started, it's basically
doing nothing. Maybe something goes wrong in module loading? What lsmod
is showing?

A.

Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: michael@ellerman.id.au
Subject: Re: [RFC/PATCH] powerpc: Dynamically allocate pacas
In-reply-to: <1264561612.14310.15.camel@concordia>
References: <39fb8f1aeab9940b86c940b9a5f8e6bd41ec316c.1263368253.git.michael@ellerman.id.au>
	<31712.1264130388@neuling.org>
	<1264561612.14310.15.camel@concordia>
Date: Wed, 27 Jan 2010 13:40:44 +1030
Message-ID: <16692.1264561844@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Fri, 2010-01-22 at 16:19 +1300, Michael Neuling wrote:
> >=20
> > In message <39fb8f1aeab9940b86c940b9a5f8e6bd41ec316c.1263368253.git.micha=
> el@ell
> > erman.id.au> you wrote:
> > > On 64-bit kernels we currently have a 512 byte struct paca_struct for
> > > each cpu (usually just called "the paca"). Currently they are staticall=
> y
> > > allocated, which means a kernel built for a large number of cpus will
> > > waste a lot of space if it's booted on a machine with few cpus.
> > >=20
> > > We can avoid that by only allocating the number of pacas we need at
> > > boot. However this is complicated by the fact that we need to access
> > > the paca before we know how many cpus there are in the system.
> > >=20
> > > The solution is to dynamically allocate enough space for NR_CPUS pacas,
> > > but then later in boot when we know how many cpus we have, we free any
> > > unused pacas.
> > >=20
> > > Lightly booted on Legacy iSeries & pSeries LPAR.
> >=20
> > This is broken on 32bit CPUs.  Dies at compile time with
> > mpc86xx_defconfig.  No paca on 32bit :-(
> 
> Bah, who really uses 32-bit anyway ..

Hehe, that's coming from the guy who tested it on iSeries... :-P

Mikey

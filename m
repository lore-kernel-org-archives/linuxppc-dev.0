Return-Path: <lorenzo.pieralisi@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id BAC5D2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 19:50:33 +1000 (EST)
Date: Thu, 29 Aug 2013 10:50:23 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Grant Likely <grant.likely@linaro.org>
Subject: Re: [RFC PATCH v2 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
Message-ID: <20130829095023.GB2878@e102568-lin.cambridge.arm.com>
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <2032060.4bgTKOdEX2@flatron> <1376777376.25016.11.camel@pasglop>
 <20130819101922.GI3719@e106331-lin.cambridge.arm.com>
 <5212177C.8000709@gmail.com> <521223FA.5050903@arm.com>
 <20130822135930.GC23152@e106331-lin.cambridge.arm.com>
 <20130828194638.AB78E3E0A6F@localhost>
MIME-Version: 1.0
In-Reply-To: <20130828194638.AB78E3E0A6F@localhost>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michal Simek <monstr@monstr.eu>, Jonas Bonn <jonas@southpole.se>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>,
 Tomasz Figa <tomasz.figa@gmail.com>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@sisk.pl>, Rob Herring <robherring2@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 28, 2013 at 08:46:38PM +0100, Grant Likely wrote:
> On Thu, 22 Aug 2013 14:59:30 +0100, Mark Rutland <mark.rutland@arm.com> w=
rote:
> > On Mon, Aug 19, 2013 at 02:56:10PM +0100, Sudeep KarkadaNagesha wrote:
> > > On 19/08/13 14:02, Rob Herring wrote:
> > > > On 08/19/2013 05:19 AM, Mark Rutland wrote:
> > > >> On Sat, Aug 17, 2013 at 11:09:36PM +0100, Benjamin Herrenschmidt w=
rote:
> > > >>> On Sat, 2013-08-17 at 12:50 +0200, Tomasz Figa wrote:
> > > >>>> I wonder how would this handle uniprocessor ARM (pre-v7) cores, =
for
> > > >>>> which=20
> > > >>>> the updated bindings[1] define #address-cells =3D <0> and so no =
reg=20
> > > >>>> property.
> > > >>>>
> > > >>>> [1] - http://thread.gmane.org/gmane.linux.ports.arm.kernel/26079=
5
> > > >>>
> > > >>> Why did you do that in the binding ? That sounds like looking to =
create
> > > >>> problems ...=20
> > > >>>
> > > >>> Traditionally, UP setups just used "0" as the "reg" property on o=
ther
> > > >>> architectures, why do differently ?
> > > >>
> > > >> The decision was taken because we defined our reg property to refe=
r to
> > > >> the MPIDR register's Aff{2,1,0} bitfields, and on UP cores before =
v7
> > > >> there's no MPIDR register at all. Given there can only be a single=
 CPU
> > > >> in that case, describing a register that wasn't present didn't see=
m
> > > >> necessary or helpful.
> > > >=20
> > > > What exactly reg represents is up to the binding definition, but it
> > > > still should be present IMO. I don't see any issue with it being
> > > > different for pre-v7.
> > > >=20
> > > Yes it's better to have 'reg' with value 0 than not having it.
> > > Otherwise this generic of_get_cpu_node implementation would need some
> > > _hack_ to handle that case.
> >=20
> > I'm not sure that having some code to handle a difference in standard
> > between two architectures is a hack. If anything, I'd argue encoding a
> > reg of 0 that corresponds to a nonexistent MPIDR value (given that's
> > what the reg property is defined to map to on ARM) is more of a hack ;)
> >=20
> > I'm not averse to having a reg value of 0 for this case, but given that
> > there are existing devicetrees without it, requiring a reg property wil=
l
> > break compatibility with them.
>=20
> Then special cases those device trees, but you changing existing
> convention really needs to be avoided. The referenced documentation
> change is brand new, so we're not stuck with it.

I have no problem with changing the bindings and forcing:

#address-cells =3D <1>;
reg =3D <0>;

for UP predating v7, my big worry is related to in-kernel dts that we
already patched to follow the #address-cells =3D <0> rule (and we had to
do it since we got asked that question multiple times on the public
lists).

What do you mean by "special case those device trees" ? I have not
planned to patch them again, unless we really consider that a necessary
evil.

Thanks,
Lorenzo

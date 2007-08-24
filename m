Return-Path: <shemminger@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8D416DDF17
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 01:52:45 +1000 (EST)
Date: Fri, 24 Aug 2007 08:52:03 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: RFC: issues concerning the next NAPI interface
Message-ID: <20070824085203.42f4305c@freepuppy.rosehill.hemminger.net>
In-Reply-To: <200708241747.16592.ossthema@de.ibm.com>
References: <200708241559.17055.ossthema@de.ibm.com>
	<20070824153703.GN5592@sgi.com>
	<200708241747.16592.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Klein <tklein@de.ibm.com>, Marcus,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>, akepner@sgi.com,
	Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 24 Aug 2007 17:47:15 +0200
Jan-Bernd Themann <ossthema@de.ibm.com> wrote:

> Hi,
>=20
> On Friday 24 August 2007 17:37, akepner@sgi.com wrote:
> > On Fri, Aug 24, 2007 at 03:59:16PM +0200, Jan-Bernd Themann wrote:
> > > .......
> > > 3) On modern systems the incoming packets are processed very fast. Es=
pecially
> > > =C2=A0 =C2=A0on SMP systems when we use multiple queues we process on=
ly a few packets
> > > =C2=A0 =C2=A0per napi poll cycle. So NAPI does not work very well her=
e and the interrupt=20
> > > =C2=A0 =C2=A0rate is still high. What we need would be some sort of t=
imer polling mode=20
> > > =C2=A0 =C2=A0which will schedule a device after a certain amount of t=
ime for high load=20
> > > =C2=A0 =C2=A0situations. With high precision timers this could work w=
ell. Current
> > > =C2=A0 =C2=A0usual timers are too slow. A finer granularity would be =
needed to keep the
> > >    latency down (and queue length moderate).
> > >=20
> >=20
> > We found the same on ia64-sn systems with tg3 a couple of years=20
> > ago. Using simple interrupt coalescing ("don't interrupt until=20
> > you've received N packets or M usecs have elapsed") worked=20
> > reasonably well in practice. If your h/w supports that (and I'd=20
> > guess it does, since it's such a simple thing), you might try=20
> > it.
> >=20
>=20
> I don't see how this should work. Our latest machines are fast enough tha=
t they
> simply empty the queue during the first poll iteration (in most cases).
> Even if you wait until X packets have been received, it does not help for
> the next poll cycle. The average number of packets we process per poll qu=
eue
> is low. So a timer would be preferable that periodically polls the=20
> queue, without the need of generating a HW interrupt. This would allow us
> to wait until a reasonable amount of packets have been received in the me=
antime
> to keep the poll overhead low. This would also be useful in combination
> with LRO.
>=20

You need hardware support for deferred interrupts. Most devices have it (e1=
000, sky2, tg3)
and it interacts well with NAPI. It is not a generic thing you want done by=
 the stack,
you want the hardware to hold off interrupts until X packets or Y usecs hav=
e expired.

The parameters for controlling it are already in ethtool, the issue is find=
ing a good
default set of values for a wide range of applications and architectures. M=
aybe some
heuristic based on processor speed would be a good starting point. The dyna=
mic irq
moderation stuff is not widely used because it is too hard to get right.

--=20
Stephen Hemminger <shemminger@linux-foundation.org>

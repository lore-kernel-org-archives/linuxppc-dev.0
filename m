Return-Path: <ossthema@de.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0DF65DDEDB
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 01:47:48 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l7OFlh3B169858
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 15:47:43 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7OFlhAX2801680
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 16:47:43 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7OFlXX9015221
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 16:47:33 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: akepner@sgi.com
Subject: Re: RFC: issues concerning the next NAPI interface
Date: Fri, 24 Aug 2007 17:47:15 +0200
References: <200708241559.17055.ossthema@de.ibm.com>
	<20070824153703.GN5592@sgi.com>
In-Reply-To: <20070824153703.GN5592@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708241747.16592.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Friday 24 August 2007 17:37, akepner@sgi.com wrote:
> On Fri, Aug 24, 2007 at 03:59:16PM +0200, Jan-Bernd Themann wrote:
> > .......
> > 3) On modern systems the incoming packets are processed very fast. Espe=
cially
> > =A0 =A0on SMP systems when we use multiple queues we process only a few=
 packets
> > =A0 =A0per napi poll cycle. So NAPI does not work very well here and th=
e interrupt=20
> > =A0 =A0rate is still high. What we need would be some sort of timer pol=
ling mode=20
> > =A0 =A0which will schedule a device after a certain amount of time for =
high load=20
> > =A0 =A0situations. With high precision timers this could work well. Cur=
rent
> > =A0 =A0usual timers are too slow. A finer granularity would be needed t=
o keep the
> >    latency down (and queue length moderate).
> >=20
>=20
> We found the same on ia64-sn systems with tg3 a couple of years=20
> ago. Using simple interrupt coalescing ("don't interrupt until=20
> you've received N packets or M usecs have elapsed") worked=20
> reasonably well in practice. If your h/w supports that (and I'd=20
> guess it does, since it's such a simple thing), you might try=20
> it.
>=20

I don't see how this should work. Our latest machines are fast enough that =
they
simply empty the queue during the first poll iteration (in most cases).
Even if you wait until X packets have been received, it does not help for
the next poll cycle. The average number of packets we process per poll queue
is low. So a timer would be preferable that periodically polls the=20
queue, without the need of generating a HW interrupt. This would allow us
to wait until a reasonable amount of packets have been received in the mean=
time
to keep the poll overhead low. This would also be useful in combination
with LRO.

Regards,
Jan-Bernd

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8F68DDE09
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 09:14:09 +1100 (EST)
Subject: Re: [PATCH] windfarm: add PowerMac 12,1 support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1206214508.9540.89.camel@pmac.infradead.org>
References: <1201348525.6859.1.camel@thilivren>
	<1206214508.9540.89.camel@pmac.infradead.org>
Content-Type: text/plain; charset=utf-8
Date: Sun, 23 Mar 2008 09:13:18 +1100
Message-Id: <1206223998.7197.13.camel@pasglop>
Mime-Version: 1.0
Cc: =?ISO-8859-1?Q?=C9tienne?= Bersac <bersace03@gmail.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-03-22 at 19:35 +0000, David Woodhouse wrote:
> On Sat, 2008-01-26 at 12:55 +0100, Étienne Bersac wrote:
> > From: Étienne Bersac <bersace@gmail.com>
> > 
> > Implement a new driver named windfarm_pm121 which drive fans on PowerMac
> > 12,1 machine : iMac G5 iSight (rev C) 17" and 20". It's based on
> > windfarm_pm81 driver from Benjamin Herrenschmidt.
> 
> Is it just coincidence, or does it only seem to stop the fans when I
> cat /sys/devices/platform/windfarm.0/cpu-temp ? 

Is it actually working ?

If the SMU thinks there is no fan control done by the OS, it will ramp
them up ... but bring them back down when it gets ping.

So if for some reason the control loop isn't starting (because it can't
find something it wants on this machine), the fans will stay up, but
you'll cause such a "ping" when reading the CPU temp.

That may be bogus, just thinking what it could be...

Ben.

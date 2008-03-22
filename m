Return-Path: <SRS0+6740c57f952c672cdc2a+1672+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 01810DDED9
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 10:02:53 +1100 (EST)
Subject: Re: [PATCH] windfarm: add PowerMac 12,1 support
From: David Woodhouse <dwmw2@infradead.org>
To: benh@kernel.crashing.org
In-Reply-To: <1206223998.7197.13.camel@pasglop>
References: <1201348525.6859.1.camel@thilivren>
	<1206214508.9540.89.camel@pmac.infradead.org>
	<1206223998.7197.13.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 22 Mar 2008 23:02:46 +0000
Message-Id: <1206226966.9540.104.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: =?ISO-8859-1?Q?=C9tienne?= Bersac <bersace03@gmail.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-03-23 at 09:13 +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2008-03-22 at 19:35 +0000, David Woodhouse wrote:
> > On Sat, 2008-01-26 at 12:55 +0100, Étienne Bersac wrote:
> > > From: Étienne Bersac <bersace@gmail.com>
> > > 
> > > Implement a new driver named windfarm_pm121 which drive fans on PowerMac
> > > 12,1 machine : iMac G5 iSight (rev C) 17" and 20". It's based on
> > > windfarm_pm81 driver from Benjamin Herrenschmidt.
> > 
> > Is it just coincidence, or does it only seem to stop the fans when I
> > cat /sys/devices/platform/windfarm.0/cpu-temp ? 
> 
> Is it actually working ?
> 
> If the SMU thinks there is no fan control done by the OS, it will ramp
> them up ... but bring them back down when it gets ping.
> 
> So if for some reason the control loop isn't starting (because it can't
> find something it wants on this machine), the fans will stay up, but
> you'll cause such a "ping" when reading the CPU temp.

Yeah, there's weird shit going on with the sensor/control registration.
I think GCC is be miscompiling it -- the sequence of
	all = all && pm121_register_control(foo...);
	all = all && pm121_register_control(bar...);
is bailing out as soon as 'all' gets set to zero. Despite the fact that
pm121_register_control() quite blatantly has side-effects.

-- 
dwmw2

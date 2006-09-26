Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7501367B6A
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 08:02:14 +1000 (EST)
Subject: Re: [PATCH] Add powerpc get/set_rtc_time interface to new generic
	rtc class
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <2FE0EA9E-D0E8-4A6B-8184-454DAAE02FC5@kernel.crashing.org>
References: <20060925215531.3e43be36.kim.phillips@freescale.com>
	<1159240397.5462.11.camel@localhost.localdomain>
	<2FE0EA9E-D0E8-4A6B-8184-454DAAE02FC5@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 08:01:53 +1000
Message-Id: <1159308113.4435.24.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-09-26 at 09:14 -0500, Kumar Gala wrote:
> On Sep 25, 2006, at 10:13 PM, Benjamin Herrenschmidt wrote:
> 
> > On Mon, 2006-09-25 at 21:55 -0500, Kim Phillips wrote:
> >> Add powerpc get/set_rtc_time interface to new generic rtc class. This
> >> abstracts rtc chip specific code from the platform code for rtc- 
> >> over-i2c
> >> platforms.  Specific RTC chip support is now configured under
> >> Device Drivers -> Real Time Clock. Setting time of day from the RTC
> >> on startup is also configurable.
> >>
> >> Currently, the only default config in powerpc arch is the 8349 itx.
> >> Other platforms wanting to consolidate code may also use this.
> >>
> >> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> >
> > I think we should only get that in if we also adapt the various  
> > platform
> > RTC code to be in drivers/rtc ... right now, enabling that option will
> > just break everybody.
> 
> Maybe just drop the init call for now and let people migrate over to  
> using this and moving the drivers over to drivers/rtc which aren't  
> supported there.

Yup. We shouldn't change ppc_md from an initcall that way for something
that may not be supported by a platform. The platform code shall set
ppc_md. (maybe calling some init function for doing it) if the platform
supports the new class mecanism.

Ben.

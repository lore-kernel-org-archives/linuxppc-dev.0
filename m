Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ADC1267A65
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jan 2005 09:27:54 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <93780AB0-696D-11D9-81BE-003065F9B7DC@embeddededge.com>
References: <41EC29A8.1040703@mvista.com>
	<20050118161515.GI28724@smtp.west.cox.net>
	<93780AB0-696D-11D9-81BE-003065F9B7DC@embeddededge.com>
Content-Type: text/plain
Date: Fri, 21 Jan 2005 09:27:01 +1100
Message-Id: <1106260021.5387.11.camel@gaston>
Mime-Version: 1.0
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-01-18 at 11:25 -0500, Dan Malek wrote:
> On Jan 18, 2005, at 11:15 AM, Tom Rini wrote:
> 
> > On Mon, Jan 17, 2005 at 02:10:00PM -0700, Mark A. Greer wrote:
> 
> >> There are 2 reasons to not use the ppc_md.get_rtc_time() et. al. 
> >> interfaces:
> >> 1) They are called before the i2c driver is initialized and even 
> >> loaded
> >> if its a module.
> 
> There are three reasons.  You don't want to use an I2c rtc clock at
> all in these functions because they get can get called from the
> clock interrupt to update the time in the rtc.  If it does happen to 
> work,
> it creates long latencies in the timer interrupt.  If the i2c requires 
> an
> interrupt, they system will crash or hang.

I have the same problem and I think the solution is to fix the clock
interrupt to not do this at interrupt time, but delay to a work queue
instead.

> A system using an I2C RTC should find some way to access the
> clock from application space as a standard I2C device and manage
> time/clock from the application, not from the kernel.

gack ?

Ben.

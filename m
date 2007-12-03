Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B8A91DDE21
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 09:36:59 +1100 (EST)
Subject: Re: [PATCH] Generic RTC class support for ppc_md.[gs]et_rtc_time
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1196715974.13978.176.camel@pmac.infradead.org>
References: <1196701493.13978.163.camel@pmac.infradead.org>
	<1196714722.13230.224.camel@pasglop>
	<1196715974.13978.176.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 09:36:37 +1100
Message-Id: <1196721397.13230.236.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-12-03 at 21:06 +0000, David Woodhouse wrote:
> On Tue, 2007-12-04 at 07:45 +1100, Benjamin Herrenschmidt wrote:
> > On Mon, 2007-12-03 at 17:04 +0000, David Woodhouse wrote:
> > > It would be good to migrate the platform code to register RTC devices
> > > directly, but for now this will make them functional enough for most
> > > purposes...
> > 
> > Wouldn't it be best to do the other way around at some stage ?
> 
> Yes, definitely. We can migrate them one at a time to the RTC class.
> 
> > We need to solve the problem of ppc_md. stuff being called by the core
> > in atomic contexts first though.
> 
> Where from?

Worst one is time_init :-) Way too early to do any i2c babbling. Then
there used to be something with the NTP writeback, dunno if it's
changed.

Ben.

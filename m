Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6CC82DDFC7
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 08:17:29 +1100 (EST)
Subject: Re: [PATCH/RFC] via-pmu: remove mdelays from suspend/resume code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1207336864.19189.74.camel@johannes.berg>
References: <1207237484.3797.2.camel@johannes.berg>
	<20080404172006.GA13980@cynthia.pants.nu>
	<1207336864.19189.74.camel@johannes.berg>
Content-Type: text/plain
Date: Sat, 05 Apr 2008 08:16:45 +1100
Message-Id: <1207343805.10388.411.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-04-04 at 21:21 +0200, Johannes Berg wrote:
> On Fri, 2008-04-04 at 10:20 -0700, Brad Boyer wrote:
> > On Thu, Apr 03, 2008 at 05:44:44PM +0200, Johannes Berg wrote:
> > > I don't see a reason for either of those mdelay()s, is there any? Works
> > > fine for me without them...
> > 
> > Which hardware revisions did you test? I suspect the mdelay calls were
> > added to work around timing issues in one of the older PMU chips. Some
> > of them are very timing sensitive, and sleep in particular is basically
> > a pile of steps that got hacked until they worked on older systems.
> 
> Mine's a 5,6 powerbook with PMU firmware 0x0c. The mdelay(100) seems
> fairly large though for a point where we're out of pmu code already, and
> the other one doesn't really seem too pmu related anyway. In any case,
> just wanted to float that, don't see a particular need for it.

One of those was meant to let devices settle. The reason is that when
waking from sleep, a lot of HW on the mobo is actually powered up (it
was down during sleep). This delay comes from half paranoia / half
experience, and is meant to ensure all those chips got a chance to
settle and complete their power-on reset sequence before we start
banging all over the place.

Cheers,
Ben.

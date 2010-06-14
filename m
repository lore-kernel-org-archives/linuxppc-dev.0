Return-Path: <wmb@firmworks.com>
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CEA40B7D29
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 02:59:31 +1000 (EST)
Message-ID: <4C165FD1.6080505@firmworks.com>
Date: Mon, 14 Jun 2010 06:58:57 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: Request review of device tree documentation
References: <4C13430B.5000907@firmworks.com>
	<1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop>
	<4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>
	<20100614124438.GF9323@yookeroo>
	<alpine.LFD.2.00.1006141044510.13427@xanadu.home>
	<20100614160201.GD9550@shareable.org>
In-Reply-To: <20100614160201.GD9550@shareable.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Nicolas Pitre <nico@fluxnic.net>, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	linux-arm-kernel@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I shall try to clarify this discussion.

There are actually two different things being discussed.  The first is, 
I hope, not too controversial.  The second is so controversial as to be 
a hopeless cause.

First, the primary use case for "keeping OFW alive" is for debugging 
purposes.  OFW remains resident in memory so that, if the OS is set to 
allow it (not the default), a hot-key freezes the OS and enters OFW, 
where a human can inspect the state of devices and OS data structures. A 
high skill level is required, so it's okay if some fiddling is necessary 
to find or establish virtual addresses or do similar magic .  In my 
career of working closely with hardware manufacturers, I and others have 
found this feature to be extremely helpful.  Often it has resulted in 
the resolution of difficult problems that were blocking the ability to 
ship the product - problems that resisted other kernel debugging techniques.

The second topic is the hypothetical use of OFW as a HAL. That will not 
happen for several reasons.  The opposition to the idea is widespread 
and deeply held, and there are good arguments to support that 
opposition.   Furthermore, the economic conditions necessary for the 
creation of such a HAL do not exist in the ARM world, nor indeed in the 
Linux world in general.  (The necessary condition is the ability for one 
company to impose a substantial change by fiat - essentially a monopoly 
position.)

Shall we agree, then, that any further discussion of the HAL issue is 
"just for fun", and that nobody needs to feel threatened that it would 
actually happen?

The potential for "vendors breaking out of the debugging use case and 
turning it into a HAL" is miniscule, because

a) The callback is disabled by default
b) The technical challenges of the callback interface limit its 
applicability to specific "wizard user" scenarios
c) OFW is unlikely to achieve sufficient market penetration for the HAL 
thing to be worth doing

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F83667B62
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 18:56:36 +1000 (EST)
Subject: Re: snd-aoa: g5 tas codec problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1152262148.15068.30.camel@localhost>
References: <1152258426.9862.44.camel@localhost.localdomain>
	<1152262148.15068.30.camel@localhost>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 18:56:25 +1000
Message-Id: <1152262585.9862.61.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-07-07 at 10:49 +0200, Johannes Berg wrote:
> On Fri, 2006-07-07 at 17:47 +1000, Benjamin Herrenschmidt wrote:
> > Also, we should try
> > (if not already the case) to cache our clock/i2s state so that
> > subsequent prepare() don't try to change things that are already ok. 
> 
> I do that, the function reads the dws and sfr registers and exits early
> if they match.

Ok. Be careful that I've removed the initial init of TAS thinking we
always get to clock restart to do it in prepare()... might need to be
put back.

Ben.

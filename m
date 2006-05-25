Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94DD867AC7
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 18:00:24 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1148463777.11734.19.camel@johannes>
References: <1147860564.14395.6.camel@johannes>
	<446B721D.8020203@gentoo.org>  <1148034127.15507.178.camel@johannes>
	<1148169389.13249.44.camel@localhost.localdomain>
	<1148280172.6228.79.camel@johannes.berg>
	<1148422544.13249.96.camel@localhost.localdomain>
	<1148463777.11734.19.camel@johannes>
Content-Type: text/plain
Date: Thu, 25 May 2006 18:00:03 +1000
Message-Id: <1148544004.13249.270.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-24 at 11:42 +0200, Johannes Berg wrote:
> On Wed, 2006-05-24 at 08:15 +1000, Benjamin Herrenschmidt wrote:
> > > Right, that's how snd-powermac does it. It has the nasty side-effect of
> > > polluting the cache a lot though, since dbdma commands are 16 bytes
> > > long. Am I wrong?
> > 
> > You don't have that much DBDMA commands that it would pollute the cache
> > _a lot_ :) 
> 
> Ah, yeah, I guess so. Well I do have 32 dbdma commands, them being
> spaced up in 16-bytes means 16 cachelines, no? I'm not sure how the
> cache is wired up ...

On a 32 bits CPU yes.

> > > Alsa calls this thing the 'pointer' :) The frame counter we currently
> > > use is the frame counter register of the i2s bus controller, and I don't
> > > see why we shouldn't do that instead of reading back all the dbdma
> > > command status fields.
> > 
> > If you manage to have it properly in sync, that may work too.
> 
> Seems to work fine so far, even if bcm43xx kills a few interrupts ;)

So it's bcm's fault ? Did you do a bit of analysis ? that would be
useful...

Ben.

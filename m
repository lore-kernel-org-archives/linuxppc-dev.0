Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F187DDFB8
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 08:54:21 +1000 (EST)
Subject: Re: [patch 4/7] ps3: Storage Driver Probing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0705252143270.2657@pademelon.sonytel.be>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.474400000@sonycom.com>
	<200705251818.03964.arnd@arndb.de>
	<Pine.LNX.4.62.0705252143270.2657@pademelon.sonytel.be>
Content-Type: text/plain
Date: Sat, 26 May 2007 08:54:13 +1000
Message-Id: <1180133653.19517.20.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-25 at 21:48 +0200, Geert Uytterhoeven wrote:
> > > +           msleep_interruptible(ms);
> > > +           if (ms < 60000)
> > > +                   ms <<= 1;
> > 
> > Is this timeout only for the disk spinup, or also for detecting
> media
> > added at run time, like inserting a DVD? One minute timeout for
> > detecting a DVD would sound very long to me.
> 
> It's not for inserting DVDs, only for new devices showing up in the
> repository.
> Apparently new devices may keep on showing up a while after boot up,
> but I
> think this matters only for the kboot kernel, that's why I went with
> the
> exponential back-off with upper limit.

Why not just have a kthread poll at 2 second interval for new devices or
removed ones ?

(And not for request processing)

Ben.

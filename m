Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de
	(static-ip-62-75-166-246.inaddr.intergenia.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C609BDDDF6
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 21:09:39 +1000 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: benh@kernel.crashing.org
Subject: Re: Powerbook shuts down hard when hot, patch found
Date: Sat, 29 Sep 2007 13:06:59 +0200
References: <200709282332.52819.mb@bu3sch.de>
	<1191020653.6158.90.camel@pasglop>
In-Reply-To: <1191020653.6158.90.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200709291306.59627.mb@bu3sch.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 29 September 2007 01:04:13 Benjamin Herrenschmidt wrote:
> 
> On Fri, 2007-09-28 at 23:32 +0200, Michael Buesch wrote:
> > Hi,
> > 
> > some time ago I already mailed you about this problem.
> > I will quickly describe what's going on, again:
> > 
> > My powerbook boots fine when it's cold. You can work with
> > it and you can also run it hot (compile something, etc...).
> > But when you try to boot it while it is hot, it will
> > automatically shutdown hard inside of the boot process.
> > Some part of the hardware is shutting it down.
> > This does not happen when it's getting hot _after_ boot.
> > Only while boot when it's hot.
> > 
> > I bisected the problem and found out that the following patch
> > is responsible for this. Yeah, this sounds a little bit
> > crazy, as this patch does not seem to be related to
> > this at all. But I confirmed it by booting kernel
> > 4f71c5de19c27f2198105d3b26b398494d5c353b
> > That kernel triggered the bug. Then I patch -R the patch below
> > and it booted properly, even when hot. I also rechecked
> > that it really was hot enough to trigger the event by
> > immediately rebooting into a known bad kernel, that immediately
> > shut down the pbook, as expected.
> > So I'm pretty sure it's the patch below causing this weird
> > behaviour. Any idea why?
> 
> This is very strange... Can you try also clearing VGA_DDC_CLK_OUT_EN and
> VGA_DDC_DATA_OUT_EN and the same time and see if that helps ?

It still triggers the bug then.

-- 
Greetings Michael.

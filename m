Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de
	(static-ip-62-75-166-246.inaddr.intergenia.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CFC0FDDE23
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Sep 2007 08:28:58 +1000 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: benh@kernel.crashing.org
Subject: Re: Powerbook shuts down hard when hot, patch found
Date: Sun, 30 Sep 2007 00:26:07 +0200
References: <200709282332.52819.mb@bu3sch.de> <200709292353.06476.mb@bu3sch.de>
	<1191104393.28637.5.camel@pasglop>
In-Reply-To: <1191104393.28637.5.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200709300026.07219.mb@bu3sch.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 30 September 2007 00:19:53 Benjamin Herrenschmidt wrote:
> 
> > 
> > This all smells to me like a silicon bug, so I'd start searching
> > in the silicon erratas. But I'm not sure, of course. It's also strange
> > that it depends on temperature. (That's why I first expected the PMU
> > would cause this).
> > 
> > Thanks for your help.
> 
> Could be that we are creating a short by driving the output low, thus
> causing the silicon to heat up, but that's strange.

Well. The machine needs to be hot in the first place to trigger it.
If it's cold it boots and runs fine even with that patch.
Even if I run it hot after boot it does not shutdown. It only shuts down
on boot when this register is written and when it's hot at this point.

That's why I thought about some silicon bug. Why only when it's hot? :)

> Also, the other change I made you do turns these into inputs, thus the

The _EN bits are already all cleared, as you can see in my printk dump.
So clearing them has no effect, of course.
So the ports are Inputs as default on boot.

> DDL lines should be pulled up, unless ... the board doesn't have
> pullups.

Well, I can't tell you :)

-- 
Greetings Michael.

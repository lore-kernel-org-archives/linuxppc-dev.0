Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	by ozlabs.org (Postfix) with ESMTP id EC2E8B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Dec 2009 07:25:20 +1100 (EST)
From: Rob Landley <rob@landley.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ZILOG serial port broken in 2.6.32
Date: Mon, 7 Dec 2009 14:25:15 -0600
References: <200912060101.22515.rob@landley.net>
	<1260148248.2076.1348.camel@pasglop>
In-Reply-To: <1260148248.2076.1348.camel@pasglop>
MIME-Version: 1.0
Message-Id: <200912071425.16624.rob@landley.net>
Content-Type: Text/Plain;
  charset="utf-8"
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 06 December 2009 19:10:48 Benjamin Herrenschmidt wrote:
> On Sun, 2009-12-06 at 01:01 -0600, Rob Landley wrote:
> > Trying again with a few likely-looking cc's from the MAINTAINERS file:
> >
> > Summary:
> >
> > The PMACZILOG serial driver last worked in 2.6.28.  It was broken by
> > commit f751928e0ddf54ea4fe5546f35e99efc5b5d9938 by Alan Cox making bits
> > of the tty layer dynamically allocated.  The PMACZILOG driver wasn't
> > properly converted, it works with interrupts disabled (for boot
> > messages), but as soon as interrupts are enabled (PID 1 spawns) the next
> > write to the serial console panics the kernel.
>
> Ah looks like I missed that... I'll dig. Thanks for the report.

Ooh, thanks!

I've been digging into it myself this weekend, but I don't understand any of 
this code, so it's going slowly...

Rob
-- 
Latency is more important than throughput. It's that simple. - Linus Torvalds

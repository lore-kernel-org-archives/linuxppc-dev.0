Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 176BF2BDB5
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Nov 2004 21:37:20 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1100854258.21273.273.camel@baythorne.infradead.org>
References: <1100847411.25521.42.camel@gaston>
	<1100854258.21273.273.camel@baythorne.infradead.org>
Content-Type: text/plain
Date: Fri, 19 Nov 2004 21:33:33 +1100
Message-Id: <1100860413.3855.8.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: TEST: Sleep suppport for iBook G4 & Aluminium PowerBooks (ATI
	based)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2004-11-19 at 08:50 +0000, David Woodhouse wrote:
> On Fri, 2004-11-19 at 17:56 +1100, Benjamin Herrenschmidt wrote:
> > (Message cross-posted to several lists, please do _NOT_ reply to all of
> > them).
> 
> I forwarded it to fedora-ppc@lists.infradead.org too.
> 
> Since I started using the previous patch and actually suspending, I've
> been seeing the GNOME panel and window list die frequently, and
> occasionally other X apps. When X apps have died which were started from
> the command line it seemed to be a spurious SIGPIPE, strangely.
> 
> I don't _think_ I've ever seen it immediately after booting; only after
> suspend/resume. But that could be just a coincidence. Likewise the way
> it started when I added the sleep patch _could_ just be a coincidence --
> I was still running Fedora rawhide and updating other packages (and
> there were other kernel changes) at that time, so a lot of other things
> changed too... but has anyone else seen similar behaviour?

Try the new patch. Note that I posted a second one today, right after
the first one, that fixes a engine lockup bug (see my second mail).

The original patch had a bug where some of the CPU "HID" registers
weren't properly restored for 7447A type CPUs. If you had one of these,
it could explain the issue.

Ben.

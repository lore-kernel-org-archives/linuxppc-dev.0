Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B8A668826
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Nov 2005 08:05:52 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <200511242150.23205.rjw@sisk.pl>
References: <1132715288.26560.262.camel@gaston>
	<200511240122.46125.rjw@sisk.pl> <1132795396.26560.382.camel@gaston>
	<200511242150.23205.rjw@sisk.pl>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 08:01:27 +1100
Message-Id: <1132866088.26560.455.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Fix USB suspend/resume crasher
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 
> Well, it's there (actually the problem occurs in vanilla 2.6.15-rc2-mm1 that
> contains the patch).  Do you mean it should go before the
> 
> if (readl(&ehci->regs->configured_flag) != FLAG_CF)
> 		goto restart;
> 
> thing?

Yes.

> > It may be worth following it with a memory barrier actually... just in case
> > (due to the absence of locks in that area).
> 
> wmb()?

Yup.

I wrote that patch against a tree that had different things in that
function, Greg merged it by hand but he got that little bit wrong
unfortunately. I'll send a new patch later today.

Ben.

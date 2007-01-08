Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04578DDE21
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 12:03:01 +1100 (EST)
Subject: Re: [PATCH] SMU LED driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
In-Reply-To: <20070106211939.GB29846@hansmi.ch>
References: <20061224112351.GA27260@hansmi.ch>
	<1167081952.3522.0.camel@localhost.localdomain>
	<20070106211939.GB29846@hansmi.ch>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 12:02:45 +1100
Message-Id: <1168218165.22458.100.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, johannes@sipsolutions.net,
	linux-kernel@killerfox.forkbomb.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-01-06 at 22:19 +0100, Michael Hanselmann wrote:
> On Tue, Dec 26, 2006 at 08:25:52AM +1100, Benjamin Herrenschmidt wrote:
> > On Sun, 2006-12-24 at 12:23 +0100, Michael Hanselmann wrote:
> > > This patch adds a driver for the front LED in recent PowerMacs which
> > > have an SMU.
> 
> > As for the PMU driver, I'm pretty unhappy that it sycnhronously waits
> > for the completion. The original code I wrote was fully asynchronous.
> 
> Unfortunately, I can't see another way than doing it synchronously when
> one shouldn't use kmalloc(). The command (struct smu_simple_cmd) is kept
> on the stack. It contains the buffer used for both sending and
> retrieving data to/from the SMU. Making it module-global wouldn't work,
> because one request could conflict with another. struct smu_cmd can't be
> locked, so we can't check or wait for the status like via-pmu-led does.
> So, what should I do?
> 
> On another note, it seems like the PMU LED driver is already
> asynchronous.

Just have 1 request allocated once for all. Then, have a global set to
what status you want the LED at. Once the completion of any request
arrives, if the new status is different from what you want, send a new
one to fix it up :-)

That's the easy way.

The old PMU code did something more subtle because it was based on the
assumption that the LED was used to emit "pulses" based on HD activity.

Ben.

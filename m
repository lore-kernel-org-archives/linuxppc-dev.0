Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B175DDE02
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 08:48:53 +1100 (EST)
Subject: Re: [PATCH] SMU LED driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
In-Reply-To: <20070114133119.GA22354@hansmi.ch>
References: <20061224112351.GA27260@hansmi.ch>
	<1167081952.3522.0.camel@localhost.localdomain>
	<20070106211939.GB29846@hansmi.ch>
	<1168218165.22458.100.camel@localhost.localdomain>
	<20070114133119.GA22354@hansmi.ch>
Content-Type: text/plain
Date: Mon, 15 Jan 2007 08:48:59 +1100
Message-Id: <1168811339.4803.23.camel@localhost.localdomain>
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

On Sun, 2007-01-14 at 14:31 +0100, Michael Hanselmann wrote:
> On Mon, Jan 08, 2007 at 12:02:45PM +1100, Benjamin Herrenschmidt wrote:
> > Just have 1 request allocated once for all. Then, have a global set to
> > what status you want the LED at. Once the completion of any request
> > arrives, if the new status is different from what you want, send a new
> > one to fix it up :-)
> 
> Implemented that. See below.
> 
> There's a race condition between setting the LED value and unloading the
> module. smu_led_exit can't return an error. Is it possible to prevent
> unloading the module while an SMU request is still running, and if yes,
> how?

No, you have to deal with it in the unload. You can for example wait for
the SMU request to complete after setting wanted to -1, that sort of
thing.

Also, use spin_lock_irqsave/restore or you'll deadlock if the SMU
completion interrupt happens to interrupt your request function.

Ben.

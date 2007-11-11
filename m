Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A1048DDF10
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Nov 2007 08:00:09 +1100 (EST)
Subject: Re: [RFC] powermac: proper sleep management
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1194523729.6294.18.camel@johannes.berg>
References: <1194523729.6294.18.camel@johannes.berg>
Content-Type: text/plain
Date: Mon, 12 Nov 2007 07:59:33 +1100
Message-Id: <1194814773.6510.23.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-pm <linux-pm@lists.linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Just thought I'd send out the patch again, it has changed quite a bit
> since last time because I cleaned up the code, made it depend on
> CONFIG_SUSPEND, made the ioctl backward compatibility optional and some
> other bits.
> 
> The feared freezer vs. fuse sync deadlock is no longer present in 2.6.24
> because the sync is done before the freezer so maybe the patch stands a
> chance now.
> 
> Scott: FYI, here's the use case for the ppc_md irq suspend/resume hooks.

Looks good to me, +/- a couple of things:

 - We _REALLY_ want the freezer to be optional and not enabled by
default on PowerPC. Maybe make it a compile option ?

 - Don't remove the pmu_polled_request() debug code. It's very useful
for debugging and I don't want to have to re-invent it.

Plus I also need to test it on some exotic hardware :-)

Cheers,
Ben.

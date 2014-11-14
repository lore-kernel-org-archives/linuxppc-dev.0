Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [150.101.137.129])
 by lists.ozlabs.org (Postfix) with ESMTP id A836A1A0B48
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 14:01:53 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Support OPAL requested heartbeat
Date: Fri, 14 Nov 2014 14:01:50 +1100
Message-ID: <40458133.nYBXtuXJmS@mexican>
In-Reply-To: <1415772194.5124.37.camel@kernel.crashing.org>
References: <1415772194.5124.37.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On Wed, 12 Nov 2014 17:03:14 Benjamin Herrenschmidt wrote:

<snip>

> +
> +static int kopald(void *unused)
> +{
> +	set_freezable();
> +	do {
> +		try_to_freeze();
> +		opal_poll_events(NULL);

Do we need to check for outstanding events (and call opal_do_notifier)? The 
Linux OPAL-IPMI interface signals an event which the interrupt handler 
(opal_interrupt) checks for, but if interrupts aren't functional no event will 
be signalled and hence the Linux IPMI layer won't get a response.

It's probably only an issue for lab bring up though as I would expect 
interrupts to generally be working...

> +		msleep_interruptible(opal_heartbeat);
> +	} while (!kthread_should_stop());
> +
> +	return 0;
> +}
> +

Regards,

Alistair

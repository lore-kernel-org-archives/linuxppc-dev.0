Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE513DE02C
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 12:33:09 +1000 (EST)
Subject: Re: [patch v2] LMB: Add basic spin locking to lmb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080519.192215.193701293.davem@davemloft.net>
References: <20080515.000203.225783838.davem@davemloft.net>
	<48321DF9.6060807@am.sony.com> <48322191.6060909@am.sony.com>
	<20080519.192215.193701293.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 19 May 2008 22:32:58 -0400
Message-Id: <1211250778.8297.159.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-05-19 at 19:22 -0700, David Miller wrote:
> From: Geoff Levand <geoffrey.levand@am.sony.com>
> Date: Mon, 19 May 2008 17:55:45 -0700
> 
> > Add a spinlock to struct lmb to enforce concurrency in
> > lmb_add(), lmb_remove(), lmb_analyze(), lmb_find(), and
> > lmb_dump_all().
> > 
> > This locking is needed for SMP systems that access the lmb structure
> > during hot memory add and remove operations after secondary cpus
> > have been started.
> > 
> > Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> > ---
> > 
> > v2: o Add locking to lmb_find().
> 
> I'm not against this patch, but I'm pretty sure it's not
> necessary.  Isn't memory hotplug already synchronized at
> a higher level?
> 
> If not, it should be.

I think the core memory hotplug is... However, we used to not change the
LMB when doing so (afaik, I'm travelling and not looking at the code
right now). However, things like PS3 memory hotplug tries to keep LMB is
sync for the sake of /dev/mem or similar and that happens before the
memory is added to the core.

Ben.

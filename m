Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C16AFDE04A
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 12:34:45 +1000 (EST)
Date: Mon, 19 May 2008 19:34:39 -0700 (PDT)
Message-Id: <20080519.193439.31663045.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [patch v2] LMB: Add basic spin locking to lmb
From: David Miller <davem@davemloft.net>
In-Reply-To: <1211250778.8297.159.camel@pasglop>
References: <48322191.6060909@am.sony.com>
	<20080519.192215.193701293.davem@davemloft.net>
	<1211250778.8297.159.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 19 May 2008 22:32:58 -0400

> I think the core memory hotplug is... However, we used to not change the
> LMB when doing so (afaik, I'm travelling and not looking at the code
> right now). However, things like PS3 memory hotplug tries to keep LMB is
> sync for the sake of /dev/mem or similar and that happens before the
> memory is added to the core.

But if the memory hotplug is synchronized, so are changes to the LMB
tables.

And if there are LMB read side access concernes outside of the hotplug
event, ideally we should use the synchronization mechanism that
hotplug uses instead of adding a new one.

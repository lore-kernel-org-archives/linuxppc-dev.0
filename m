Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) by ozlabs.org (Postfix) with ESMTP id 15F6F67BBC
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 09:56:16 +1000 (EST)
Date: Mon, 21 Aug 2006 16:56:16 -0700 (PDT)
Message-Id: <20060821.165616.107936004.davem@davemloft.net>
To: linas@austin.ibm.com
Subject: Re: [RFC] HOWTO use NAPI to reduce TX interrupts
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060821235244.GJ5427@austin.ibm.com>
References: <44E7BB7F.7030204@osdl.org> <200608191325.19557.arnd@arndb.de>
	<20060821235244.GJ5427@austin.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: akpm@osdl.org, arnd@arndb.de, netdev@vger.kernel.org, jklewis@us.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Jens.Osterkamp@de.ibm.com, jgarzik@pobox.com, shemminger@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: linas@austin.ibm.com (Linas Vepstas)
Date: Mon, 21 Aug 2006 18:52:44 -0500

> Under what circumstance does one turn TX interrupts back on?
> I couldn't quite figure that out.

Don't touch interrupts until both RX and TX queue work is
fullydepleted.  You seem to have this notion that RX and TX interrupts
are seperate.  They aren't, even if your device can generate those
events individually.  Whatever interrupt you get, you shut down all
interrupt sources and schedule the ->poll().  Then ->poll() does
something like:

	all_tx_completion_work();
	ret = as_much_rx_work_as_budget_and_quota_allows();
	if (!ret)
		reenable_interrupts_and_complet_napi_poll();

You always run the TX completion work fully, then you do the RX work
within the quota/budget.

See the tg3 driver for details, really...

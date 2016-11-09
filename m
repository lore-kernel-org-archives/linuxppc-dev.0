Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tDXw23CnQzDvTZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 04:18:57 +1100 (AEDT)
Date: Wed, 09 Nov 2016 12:18:44 -0500 (EST)
Message-Id: <20161109.121844.1246735222647356131.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, oss@buserror.net, ppc@mindchasers.com,
 joe@perches.com, pebolle@tiscali.nl, joakim.tjernlund@transmode.se
Subject: Re: [PATCH net-next v6 02/10] dpaa_eth: add support for DPAA Ethernet
From: David Miller <davem@davemloft.net>
In-Reply-To: <AM4PR04MB160440B1F671B4C86B238C2DECB90@AM4PR04MB1604.eurprd04.prod.outlook.com>
References: <1478117854-8952-3-git-send-email-madalin.bucur@nxp.com>
 <20161103.155816.642712588084106823.davem@davemloft.net>
 <AM4PR04MB160440B1F671B4C86B238C2DECB90@AM4PR04MB1604.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Madalin-Cristian Bucur <madalin.bucur@nxp.com>
Date: Wed, 9 Nov 2016 17:16:12 +0000

>> From: Madalin-Cristian Bucur
>> Sent: Monday, November 07, 2016 5:43 PM
>> 
>> > From: David Miller [mailto:davem@davemloft.net]
>> > Sent: Thursday, November 03, 2016 9:58 PM
>> >
>> > From: Madalin Bucur <madalin.bucur@nxp.com>
>> > Date: Wed, 2 Nov 2016 22:17:26 +0200
>> >
>> > > This introduces the Freescale Data Path Acceleration Architecture
> <snip>
> 
>> > > +	int numstats = sizeof(struct rtnl_link_stats64) / sizeof(u64);
>> >  ...
>> > > +		cpustats = (u64 *)&percpu_priv->stats;
>> > > +
>> > > +		for (j = 0; j < numstats; j++)
>> > > +			netstats[j] += cpustats[j];
>> >
>> > This is a memcpy() on well-typed datastructures which requires no
>> > casting or special handling whatsoever, so use memcpy instead of
>> > needlessly open coding the operation.
>> 
>> Will fix.
> 
> Took a second look at this, it's not copying but adding the percpu
> statistics into consolidated results.

Ok, then it looks fine, thanks for clarifying.

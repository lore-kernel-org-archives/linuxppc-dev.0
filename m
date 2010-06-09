Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 7099FB7D69
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 09:27:15 +1000 (EST)
Date: Wed, 09 Jun 2010 16:27:25 -0700 (PDT)
Message-Id: <20100609.162725.189714554.davem@davemloft.net>
To: avorontsov@mvista.com
Subject: Re: [PATCH] gianfar: Revive the driver for eTSEC devices (disable
	timestamping)
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100609193219.GA8629@oksana.dev.rtsoft.ru>
References: <20100609193219.GA8629@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, Manfred.Rudigier@omicron.at,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@mvista.com>
Date: Wed, 9 Jun 2010 23:32:19 +0400

> Since commit cc772ab7cdcaa24d1fae332d92a1602788644f7a ("gianfar: Add
> hardware RX timestamping support"), the driver no longer works on
> at least MPC8313ERDB and MPC8568EMDS boards (and possibly much more
> boards as well).
> 
> That's how MPC8313 Reference Manual describes RCTRL_TS_ENABLE bit:
> 
>   Timestamp incoming packets as padding bytes. PAL field is set
>   to 8 if the PAL field is programmed to less than 8. Must be set
>   to zero if TMR_CTRL[TE]=0.
> 
> I see that the commit above sets this bit, but it doesn't handle
> TMR_CTRL. Manfred probably had this bit set by the firmware for
> his boards. But obviously this isn't true for all boards in the
> wild.
> 
> Also, I recall that Freescale BSPs were explicitly disabling the
> timestamping because of a performance drop.
> 
> For now, the best way to deal with this is just disable the
> timestamping, and later we can discuss proper device tree bindings
> and implement enabling this feature via some property.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>

Agreed, applied, thanks Anton.

Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 0F76FB71F2
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jul 2010 04:37:07 +1000 (EST)
Date: Wed, 30 Jun 2010 11:37:19 -0700 (PDT)
Message-Id: <20100630.113719.128591285.davem@davemloft.net>
To: avorontsov@mvista.com
Subject: Re: [PATCH v2 2/3] gianfar: Implement workaround for eTSEC76 erratum
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100630163913.GB23337@oksana.dev.rtsoft.ru>
References: <20100630163804.GA636@oksana.dev.rtsoft.ru>
	<20100630163913.GB23337@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com,
	Sandeep.Kumar@freescale.com, manfred.rudigier@omicron.at,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@mvista.com>
Date: Wed, 30 Jun 2010 20:39:13 +0400

> MPC8313ECE says:
> 
> "For TOE=1 huge or jumbo frames, the data required to generate the
>  checksum may exceed the 2500-byte threshold beyond which the controller
>  constrains itself to one memory fetch every 256 eTSEC system clocks.
> 
>  This throttling threshold is supposed to trigger only when the
>  controller has sufficient data to keep transmit active for the duration
>  of the memory fetches. The state machine handling this threshold,
>  however, fails to take large TOE frames into account. As a result,
>  TOE=1 frames larger than 2500 bytes often see excess delays before start
>  of transmission."
> 
> This patch implements the workaround as suggested by the errata
> document, i.e.:
> 
> "Limit TOE=1 frames to less than 2500 bytes to avoid excess delays due to
>  memory throttling.
>  When using packets larger than 2700 bytes, it is recommended to turn TOE
>  off."
> 
> To be sure, we limit the TOE frames to 2500 bytes, and do software
> checksumming instead.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>

Applied.

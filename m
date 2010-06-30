Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D39A81007E9
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jul 2010 04:37:00 +1000 (EST)
Date: Wed, 30 Jun 2010 11:37:13 -0700 (PDT)
Message-Id: <20100630.113713.180406828.davem@davemloft.net>
To: avorontsov@mvista.com
Subject: Re: [PATCH v2 1/3] gianfar: Implement workaround for eTSEC74 erratum
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100630163912.GA23337@oksana.dev.rtsoft.ru>
References: <20100630163804.GA636@oksana.dev.rtsoft.ru>
	<20100630163912.GA23337@oksana.dev.rtsoft.ru>
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
Date: Wed, 30 Jun 2010 20:39:12 +0400

> MPC8313ECE says:
> 
> "If MACCFG2[Huge Frame]=0 and the Ethernet controller receives frames
>  which are larger than MAXFRM, the controller truncates the frames to
>  length MAXFRM and marks RxBD[TR]=1 to indicate the error. The controller
>  also erroneously marks RxBD[TR]=1 if the received frame length is MAXFRM
>  or MAXFRM-1, even though those frames are not truncated.
>  No truncation or truncation error occurs if MACCFG2[Huge Frame]=1."
> 
> There are two options to workaround the issue:
> 
> "1. Set MACCFG2[Huge Frame]=1, so no truncation occurs for invalid large
>  frames. Software can determine if a frame is larger than MAXFRM by
>  reading RxBD[LG] or RxBD[Data Length].
> 
>  2. Set MAXFRM to 1538 (0x602) instead of the default 1536 (0x600), so
>  normal-length frames are not marked as truncated. Software can examine
>  RxBD[Data Length] to determine if the frame was larger than MAXFRM-2."
> 
> This patch implements the first workaround option by setting HUGEFRAME
> bit, and gfar_clean_rx_ring() already checks the RxBD[Data Length].
> 
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>

Applied.

Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 3B12BB7D29
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Apr 2010 09:20:37 +1000 (EST)
Date: Fri, 23 Apr 2010 16:20:41 -0700 (PDT)
Message-Id: <20100423.162041.158531826.davem@davemloft.net>
To: avorontsov@mvista.com
Subject: Re: [PATCH 1/2] fsl_pq_mdio: Fix kernel oops during OF address
	translation
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100423171235.GA2140@oksana.dev.rtsoft.ru>
References: <20100423171235.GA2140@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, Sandeep.Kumar@freescale.com,
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
Date: Fri, 23 Apr 2010 21:12:35 +0400

> Old P1020RDB device trees were not specifing tbipa address for
> MDIO nodes, which is now causing this kernel oops:
> 
>  ...
>  eth2: TX BD ring size for Q[6]: 256
>  eth2: TX BD ring size for Q[7]: 256
>  Unable to handle kernel paging request for data at address 0x00000000
>  Faulting instruction address: 0xc0015504
>  Oops: Kernel access of bad area, sig: 11 [#1]
>  ...
>  NIP [c0015504] memcpy+0x3c/0x9c
>  LR [c000a9f8] __of_translate_address+0xfc/0x21c
>  Call Trace:
>  [df839e00] [c000a94c] __of_translate_address+0x50/0x21c (unreliable)
>  [df839e50] [c01a33e8] get_gfar_tbipa+0xb0/0xe0
>  ...
> 
> The old device trees are buggy, though having a dead ethernet is
> better than a dead kernel, so fix the issue by using of_iomap().
> 
> Also, a somewhat similar issue exist in the probe() routine, though
> there the oops is only a possibility. Nonetheless, fix it too.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>

Seems reasonable, applied to net-2.6 thanks!

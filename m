Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A001DB7B9B
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 01:39:19 +1100 (EST)
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH RFC] gianfar: Make polling safe with IRQs disabled 
In-reply-to: <20091104225711.GA30844@oksana.dev.rtsoft.ru> 
References: <20091104225711.GA30844@oksana.dev.rtsoft.ru>
Date: Thu, 05 Nov 2009 08:01:10 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1N62ti-0003iS-K2@jdl.com>
Cc: linuxppc-dev@ozlabs.org, Jason Wessel <jason.wessel@windriver.com>,
	Andy Fleming <afleming@freescale.com>,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> When using KGDBoE, gianfar driver spits 'Interrupt problem' messages,
> which appears to be a legitimate warning, i.e. we may end up calling
> netif_receive_skb() or vlan_hwaccel_receive_skb() with IRQs disabled.
> 
> This patch reworks the RX path so that if netpoll is enabled (the
> only case when the driver don't know from what context the polling
> may be called), we check whether IRQs are disabled, and if so we
> fall back to safe variants of skb receiving functions.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> 
> I'm not sure if this is suitable for mainline since it doesn't
> have KGDBoE support. Jason, if the patch is OK, would you like
> to merge it into KGDB tree?

It's a legitimate problem with or without KGDBoE.  I see it
occasionally when conn_track is enabled as well, for example.

jdl

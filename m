Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C36A6B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 04:04:20 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5A00CDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 04:04:19 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8AI45kL012893
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 11:04:06 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n8AI5lwY003579
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 13:05:47 -0500 (CDT)
Message-ID: <4AA93FB0.5060802@freescale.com>
Date: Thu, 10 Sep 2009 13:04:32 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v2 3/3] ucc_geth: Fix hangs after switching from full
	to	half duplex
References: <20090910020145.GC31083@oksana.dev.rtsoft.ru>
	<20090910175852.GA18948@oksana.dev.rtsoft.ru>
In-Reply-To: <20090910175852.GA18948@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Andy Fleming <afleming@freescale.com>, David Miller <davem@davemloft.net>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> MPC8360 QE UCC ethernet controllers hang when changing link duplex
> under a load (a bit of NFS activity is enough).
> 
>   PHY: mdio@e0102120:00 - Link is Up - 1000/Full
>   sh-3.00# ethtool -s eth0 speed 100 duplex half autoneg off
>   PHY: mdio@e0102120:00 - Link is Down
>   PHY: mdio@e0102120:00 - Link is Up - 100/Half
>   NETDEV WATCHDOG: eth0 (ucc_geth): transmit queue 0 timed out
>   ------------[ cut here ]------------
>   Badness at c01fcbd0 [verbose debug info unavailable]
>   NIP: c01fcbd0 LR: c01fcbd0 CTR: c0194e44
>   ...
> 
> The cure is to disable the controller before changing speed/duplex
> and enable it afterwards.
> 
> Since ugeth_graceful_stop_{tx,rx} now may be called from an atomic
> context, switch the two functions from msleep() to mdelay().

Ouch.  Can we put this in a workqueue or something?

-Scott

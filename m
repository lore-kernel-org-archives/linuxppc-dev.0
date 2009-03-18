Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C6E3CDDDA1
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 07:05:58 +1100 (EST)
Message-ID: <49C1541F.8040803@freescale.com>
Date: Wed, 18 Mar 2009 15:05:51 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v3 3/4] powerpc/85xx: Move gianfar mdio nodes under the
	ethernet nodes
References: <20090318195911.GA31525@oksana.dev.rtsoft.ru>
	<20090318200039.GC8182@oksana.dev.rtsoft.ru>
In-Reply-To: <20090318200039.GC8182@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> Currently it doesn't matter where the mdio nodes are placed, but with
> power management support (i.e. when sleep = <> properties will take
> effect), mdio nodes placement will become important: mdio controller
> is a part of the ethernet block, so the mdio nodes should be placed
> correctly. Otherwise we may wrongly assume that MDIO controllers are
> available during sleep.
> 
> NOTE: mpc8572ds_camp_core1.dts now fully specifies ethernet@24000
> layout. ethernet@24000 node is disabled via status = "disabled on
> core1" property.

Hmm, would that imply that the mdio underneath it is disabled as well?

And are we just ignoring the possibility of races between multiple 
partitions accessing the shared mdio block?

-Scott

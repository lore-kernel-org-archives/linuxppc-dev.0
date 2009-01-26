Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 41767DE0AB
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 08:07:43 +1100 (EST)
Message-Id: <324701F1-4A84-41A6-BC2D-4A61A8E135D9@freescale.com>
From: Andy Fleming <afleming@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090126205043.GA15581@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] gianfar: Revive VLAN support
Date: Mon, 26 Jan 2009 15:07:37 -0600
References: <20090126205043.GA15581@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 26, 2009, at 2:50 PM, Anton Vorontsov wrote:

> commit 77ecaf2d5a8bfd548eed3f05c1c2e6573d5de4ba ("gianfar: Fix VLAN
> HW feature related frame/buffer size calculation") wrongly removed
> priv->vlgrp assignment, and now priv->vlgrp is always NULL.
>
> This patch fixes the issue, plus fixes following sparse warning
> introduced by the same commit:
> gianfar.c:1406:13: warning: context imbalance in  
> 'gfar_vlan_rx_register' - wrong count at exit
>
> gfar_vlan_rx_register() checks for "if (old_grp == grp)" and tries
> to return w/o dropping the lock.
>
> According to net/8021q/vlan.c VLAN core issues rx_register() callback:
> 1. In register_vlan_dev() only on a newly created group;
> 2. In unregister_vlan_dev() only if the group becomes empty.
>
> Thus the check in the gianfar driver isn't needed.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Andy Fleming <afleming@freescale.com>

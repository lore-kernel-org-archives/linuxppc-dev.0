Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7B872B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 16:28:07 +1000 (EST)
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2648CDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 16:28:06 +1000 (EST)
Date: Tue, 18 Aug 2009 23:28:15 -0700 (PDT)
Message-Id: <20090818.232815.73515404.davem@davemloft.net>
To: john.linn@xilinx.com
Subject: Re: [PATCH] net: add Xilinx emac lite device driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090818153047.48E42ED8051@mail66-dub.bigfish.com>
References: <20090818153047.48E42ED8051@mail66-dub.bigfish.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: michal.simek@petalogix.com, netdev@vger.kernel.org, sadanan@xilinx.com,
	linuxppc-dev@ozlabs.org, jgarzik@pobox.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: John Linn <john.linn@xilinx.com>
Date: Tue, 18 Aug 2009 09:30:41 -0600

> @@ -1926,6 +1926,11 @@ config ATL2
>  	  To compile this driver as a module, choose M here.  The module
>  	  will be called atl2.
>  
> +config XILINX_EMACLITE
> +	tristate "Xilinx 10/100 Ethernet Lite support"
> +	help
> +	  This driver supports the 10/100 Ethernet Lite from Xilinx.
> +
>  source "drivers/net/fs_enet/Kconfig"
>  
>  endif # NET_ETHERNET

You can't unconditionally enable this driver everywhere.
It depends upon things like openfirmware support, etc.
so the driver will fail to link if the architecture doesn't
have those support routines.

Please fix this up, thanks.

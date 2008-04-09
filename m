Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6398DDE048
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 07:42:39 +1000 (EST)
Message-ID: <47FD383A.7040604@pobox.com>
Date: Wed, 09 Apr 2008 17:42:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch] PS3: Fix gelic net module dependency
References: <47FD2EC1.8030600@am.sony.com>
In-Reply-To: <47FD2EC1.8030600@am.sony.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand wrote:
> The PS3 gelic network driver depends on the wake-on-lan support
> provided by the PS3 sys manager driver.  Add that dependency
> to the GELIC_NET Kconfig option.
> 
> Prevents these build errors:
> 
>   ps3_gelic_net.c:1277: undefined reference to `.ps3_sys_manager_get_wol'
>   ps3_gelic_net.c:1337: undefined reference to `.ps3_sys_manager_set_wol'
> 
> CC: Masakazu Mokuno <mokuno@sm.sony.co.jp>
> CC: Jeff Garzik <jgarzik@pobox.com>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
> Hi Paul,
> 
> This fixes an error introduced in my 2.6.26 WOL patches now
> queued in your powerpc tree.  Please apply.
> 
> -Geoff
> 
>  drivers/net/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -2358,6 +2358,7 @@ config TSI108_ETH
>  config GELIC_NET
>  	tristate "PS3 Gigabit Ethernet driver"
>  	depends on PPC_PS3
> +	select PS3_SYS_MANAGER
>  	help
>  	  This driver supports the network device on the PS3 game
>  	  console.  This driver has built-in support for Ethernet.

looks sane to me, but I do not have enough knowledge to ACK.  Thanks for 
the CC :)

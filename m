Date: Sun, 18 May 2003 00:39:01 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Mark Rakes <mrakes@vivato.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: e1000 patch for linuxppc_2_4_devel
Message-ID: <20030518043901.GA11221@nevyn.them.org>
References: <3048EFC8-87FB-11D7-B0B0-000393DB7C12@vivato.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3048EFC8-87FB-11D7-B0B0-000393DB7C12@vivato.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, May 16, 2003 at 05:04:54PM -0700, Mark Rakes wrote:
>
> this patch fixes e1000 vlan hardware acceleration on ppc.
>
> vlan tags weren't swapped.
>
> thanks!
> -Mark Rakes
>
>
> diff -Nru a/drivers/net/e1000/e1000_main.c
> b/drivers/net/e1000/e1000_main.c
> --- a/drivers/net/e1000/e1000_main.c	Fri May 16 17:00:24 2003
> +++ b/drivers/net/e1000/e1000_main.c	Fri May 16 17:00:24 2003
> @@ -2062,7 +2062,8 @@
>  		skb->protocol = eth_type_trans(skb, netdev);
>  		if(adapter->vlgrp && (rx_desc->status & E1000_RXD_STAT_VP)) {
>  			vlan_hwaccel_rx(skb, adapter->vlgrp,
> -				le16_to_cpu(rx_desc->special &
> E1000_RXD_SPC_VLAN_MASK));
> +				le16_to_cpu(rx_desc->special &
> +					    E1000_RXD_SPC_VLAN_MASK));
>  		} else {
>  			netif_rx(skb);
>  		}

That patch doesn't do anything but move a line break.  Is that really
what you meant to do?

--
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 20 May 2003 12:07:10 -0700
Subject: Re: e1000 patch for linuxppc_2_4_devel
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
From: Mark Rakes <mrakes@mac.com>
To: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3048EFC8-87FB-11D7-B0B0-000393DB7C12@vivato.net>
Message-Id: <41CF51CA-8AF6-11D7-B2B9-000393DB7C12@mac.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK.  final version of the patch. this one even works for large tag
values.

Sorry for all the confusion.
-mark

diff -Nru a/drivers/net/e1000/e1000_main.c
b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c	Fri May 16 17:00:24 2003
+++ b/drivers/net/e1000/e1000_main.c	Fri May 16 17:00:24 2003
@@ -2062,7 +2062,8 @@
  		skb->protocol = eth_type_trans(skb, netdev);
  		if(adapter->vlgrp && (rx_desc->status & E1000_RXD_STAT_VP)) {
  			vlan_hwaccel_rx(skb, adapter->vlgrp,
-				le16_to_cpu(rx_desc->special & E1000_RXD_SPC_VLAN_MASK));
+				(le16_to_cpu(rx_desc->special) &
+					    E1000_RXD_SPC_VLAN_MASK));
  		} else {
  			netif_rx(skb);
  		}



On Friday, May 16, 2003, at 05:04  PM, Mark Rakes wrote:

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
> -				le16_to_cpu(rx_desc->special & E1000_RXD_SPC_VLAN_MASK));
> +				le16_to_cpu(rx_desc->special &
> +					    E1000_RXD_SPC_VLAN_MASK));
>  		} else {
>  			netif_rx(skb);
>  		}
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

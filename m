Date: Mon, 19 May 2003 09:25:37 -0700
Subject: Re: e1000 patch for linuxppc_2_4_devel
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppc-dev@lists.linuxppc.org
To: Daniel Jacobowitz <drow@false.org>
From: Mark Rakes <mrakes@vivato.net>
In-Reply-To: <20030518043901.GA11221@nevyn.them.org>
Message-Id: <86252EA3-8A16-11D7-B7C7-000393DB7C12@vivato.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


whoops. the le16_to_cpu() isn't there at all in the code.
trying to learn bk and keep the width under 80 was a bad combo.

real patch should look like:

diff -Nru a/drivers/net/e1000/e1000_main.c
b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c	Mon May 19 09:24:11 2003
+++ b/drivers/net/e1000/e1000_main.c	Mon May 19 09:24:11 2003
@@ -2062,7 +2062,8 @@
  		skb->protocol = eth_type_trans(skb, netdev);
  		if(adapter->vlgrp && (rx_desc->status & E1000_RXD_STAT_VP)) {
  			vlan_hwaccel_rx(skb, adapter->vlgrp,
-				(rx_desc->special & E1000_RXD_SPC_VLAN_MASK));
+				le16_to_cpu(rx_desc->special &
+					    E1000_RXD_SPC_VLAN_MASK));
  		} else {
  			netif_rx(skb);
  		}




On Saturday, May 17, 2003, at 09:39  PM, Daniel Jacobowitz wrote:

> On Fri, May 16, 2003 at 05:04:54PM -0700, Mark Rakes wrote:
>>
>> this patch fixes e1000 vlan hardware acceleration on ppc.
>>
>> vlan tags weren't swapped.
>>
>> thanks!
>> -Mark Rakes
>>
>>
>> diff -Nru a/drivers/net/e1000/e1000_main.c
>> b/drivers/net/e1000/e1000_main.c
>> --- a/drivers/net/e1000/e1000_main.c	Fri May 16 17:00:24 2003
>> +++ b/drivers/net/e1000/e1000_main.c	Fri May 16 17:00:24 2003
>> @@ -2062,7 +2062,8 @@
>>  		skb->protocol = eth_type_trans(skb, netdev);
>>  		if(adapter->vlgrp && (rx_desc->status & E1000_RXD_STAT_VP)) {
>>  			vlan_hwaccel_rx(skb, adapter->vlgrp,
>> -				le16_to_cpu(rx_desc->special &
>> E1000_RXD_SPC_VLAN_MASK));
>> +				le16_to_cpu(rx_desc->special &
>> +					    E1000_RXD_SPC_VLAN_MASK));
>>  		} else {
>>  			netif_rx(skb);
>>  		}
>
> That patch doesn't do anything but move a line break.  Is that really
> what you meant to do?
>
> --
> Daniel Jacobowitz
> MontaVista Software                         Debian GNU/Linux Developer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

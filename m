Return-Path: <rsushko@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5F19C688C3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Dec 2005 04:14:10 +1100 (EST)
Message-ID: <439869CD.2040002@ru.mvista.com>
Date: Thu, 08 Dec 2005 20:13:49 +0300
From: "Ruslan V. Sushko" <rsushko@ru.mvista.com>
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
References: <1134045255.28438.4.camel@mephisto.spb.rtsoft.ru>
	<20051208145714.GA16049@tuxdriver.com>
In-Reply-To: <20051208145714.GA16049@tuxdriver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Netpoll controller support for PPC EMAC driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Please see my answers bellow.
John W. Linville wrote:
> On Thu, Dec 08, 2005 at 03:34:15PM +0300, Ruslan V. Sushko wrote:
>   
>> This patch adds netpoll controller support for PPC EMAC driver
>>
>> Signed-off-by: Ruslan V. Sushko <rsushko@ru.mvista.com>
>>     
>
> Patches in-line are easier to review... :-)
>
>   
>> @@ -1071,8 +1071,16 @@ static int emac_start_xmit(struct sk_buf
>>  	struct ocp_enet_private *dev = ndev->priv;
>>  	unsigned int len = skb->len;
>>  	int slot;
>> +	u16 ctrl;
>>  
>> -	u16 ctrl = EMAC_TX_CTRL_GFCS | EMAC_TX_CTRL_GP | MAL_TX_CTRL_READY |
>> +#ifdef CONFIG_NET_POLL_CONTROLLER
>> +	if (unlikely(dev->tx_cnt == NUM_TX_BUFF)) {
>> +		netif_stop_queue(ndev);
>> +		return -EBUSY;
>> +	}
>> +#endif
>>     
>
> Why is this necessary?
>   
When netpoll controller is enabled and packets are trapped bay netpoll 
controller the netif_stop_queue function does nothing. As result the 
packets which are queued for send may be overwritten/corrupted, because 
CPU insert packets significantly faster then netdev send them.
>   
>> +
>> +	ctrl = EMAC_TX_CTRL_GFCS | EMAC_TX_CTRL_GP | MAL_TX_CTRL_READY |
>>  	    MAL_TX_CTRL_LAST | emac_tx_csum(dev, skb);
>>  
>>  	slot = dev->tx_slot++;
>> @@ -1938,6 +1946,33 @@ static int emac_ioctl(struct net_device 
>>  		return -EOPNOTSUPP;
>>  	}
>>  }
>> +#ifdef CONFIG_NET_POLL_CONTROLLER
>> +void
>> +poll_ctrl(struct net_device *dev)
>> +{
>> +	int budget = 16;
>> +	struct ibm_ocp_mal *mal = ((struct ocp_enet_private*)(dev->priv))->mal;
>> +	struct net_device *poll_dev = &(mal->poll_dev);
>> +
>> +	/* disable  MAL interrupts */
>> +	mal_disable_eob_irq(mal);
>> +	netif_poll_disable(poll_dev);
>>     
>
> Is the call to netif_poll_disable necessary?  Aren't NAPI and netpoll
> aware of each other?
>   
In this case the device instance passed to netpoll controller 
functionality is not the same which used by NAPI. As result conflict 
will occurred if netpoll controller invokes polling in the time of NAPI 
poll working. Please see my comments below.
>   
>> +
>> +	emac_poll_rx(dev->priv, budget);
>> +	emac_poll_tx(dev->priv);
>> +
>> +	netif_poll_enable(poll_dev);
>> +	/* Enable mal interrupts */
>> +	mal_enable_eob_irq(mal);
>> +}
>> +
>> +int
>> +poll_fake(struct net_device *dev, int *budget)
>> +{
>> +	/* It will be never invoked */
>> +	return 0;
>> +}
>> +#endif
>>     
>
> If it's never invoked, then why define it?
>   
Please see my comments bellow.
>   
>>  
>>  static int __init emac_probe(struct ocp_device *ocpdev)
>>  {
>> @@ -2188,6 +2223,11 @@ static int __init emac_probe(struct ocp_
>>  	netif_carrier_off(ndev);
>>  	netif_stop_queue(ndev);
>>  
>> +#ifdef CONFIG_NET_POLL_CONTROLLER
>> +	ndev->poll_controller = poll_ctrl;
>> +	ndev->poll = poll_fake;
>> +#endif
>> +
>>     
>
> ->poll is not related to ->poll_controller.  It is for NAPI, not
> netpoll.
>   
The main idea is devices passed to netpoll controller are not the same 
which is used for NAPI. This driver has three net_device instances. One 
is virtual device which is used only for NAPI (for this device real NAPI 
poll function is defined) and two others are usual devices without NAPI. 
For each of these two devices poll handlers functions are defined 
(emac_poll_rx and emac_poll_tx) which are invoked from NAPI device poll 
handler. Function emac_poll_rx uses netif_receive_skb function to pass 
skbs to high level. To pass skb to netpoll controller via 
netif_receive_skb function the poll field must be defined:
-------------------- cut from netif_receive_skb (net/dev.c) ----------
if (skb->dev->poll && netpoll_rx(skb))
return NET_RX_DROP;
--------------------------------------------------------------------------------
So the poll_fake function and poll field are defined and initialized 
only to cheat netif_receive_skb function. In same time the poll_fake 
will be never invoked because devices for whom this function is defined 
are not NAPI devices.

Thank you,
Ruslan

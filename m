Return-Path: <sshtylyov@ru.mvista.com>
Message-ID: <48D76D6E.2020002@ru.mvista.com>
Date: Mon, 22 Sep 2008 14:03:26 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: solution to printk() blocking interrupts?
References: <9e4733910809211353k1f06fb5bi219c124d0c44b47a@mail.gmail.com>	
	<9e4733910809211443l5638887aw856377d39fcca85c@mail.gmail.com>	
	<48D6C8F0.4060808@ru.mvista.com>
	<9e4733910809211634u5b37e297pe8503f08de4f19a8@mail.gmail.com>
In-Reply-To: <9e4733910809211634u5b37e297pe8503f08de4f19a8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Jon Smirl wrote:

>>  Implementing the poll_controller() method in the network driver is usually
>> staightforward.
>>     
>
> Good tip, the simple implementation worked.
>
> What controls this? "carrier detect appears untrustworthy, waiting 4 seconds"
>   

   IIRC, it happens if netpoll code sees the carrier OK right ast the 
first time it checks it. Look for this message in net/core/netpoll.c...

> Get that fixed and this patch could be useful,
>   

    How that hinders using netconsole?

> root@phyCORE-MPC5200B-tiny:~ dmesg | grep netconsole
> Kernel command line: console=ttyPSC0,115200 rw debug root=/dev/nfs
> ip=dhcp nfsroot=192.168.1.4:/home/OSELAS.BSP-Phytec-phyCORE-MPC5200B-tiny-6/root,v3,tcp
> netconsole=6666@192.168.1.11/eth0,514@192.168.1.4/00:19:d1:e4:0f:8d
> netconsole: local port 6666
> netconsole: local IP 192.168.1.11
> netconsole: interface eth0
> netconsole: remote port 514
> netconsole: remote IP 192.168.1.4
> netconsole: remote ethernet address 00:19:d1:e4:0f:8d
> netconsole: device eth0 not up yet, forcing it
> netconsole: carrier detect appears untrustworthy, waiting 4 seconds
> netconsole: network logging started
> root@phyCORE-MPC5200B-tiny:~
>
>
>
> diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
> index 4e4f683..72541b5 100644
> --- a/drivers/net/fec_mpc52xx.c
> +++ b/drivers/net/fec_mpc52xx.c
> @@ -401,6 +401,16 @@ static int mpc52xx_fec_hard_start_xmit(struct
> sk_buff *skb, struct net_device *d
>         return 0;
>  }
>
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +static void mpc52xx_fec_poll_controller(struct net_device *dev)
> +{
> +        disable_irq(dev->irq);
> +        mpc52xx_fec_tx_interrupt(dev->irq, dev);
>   

   The interrupt nu,ber seems wrong, although the handler doesn't care 
anyway...

> +        enable_irq(dev->irq);
> +}
> +#endif
>   

   Hey, how about the Rx interrupt? And I'm seeing 
mcp52xx_fec_interrupt() on separate IRQ too -- looks like for for this 
driver this is not as straightforward as it usually is.
You need to call all the handlers -- netconsole is not the only user of 
the netpoll API, so not only Tx should be handled.

WBR, Sergei

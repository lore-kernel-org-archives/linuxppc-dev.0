Return-Path: <sshtylyov@ru.mvista.com>
Message-ID: <48D77B00.2050606@ru.mvista.com>
Date: Mon, 22 Sep 2008 15:01:20 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: solution to printk() blocking interrupts?
References: <9e4733910809211353k1f06fb5bi219c124d0c44b47a@mail.gmail.com>	
	<9e4733910809211443l5638887aw856377d39fcca85c@mail.gmail.com>	
	<48D6C8F0.4060808@ru.mvista.com>
	<9e4733910809211634u5b37e297pe8503f08de4f19a8@mail.gmail.com>
	<48D76D6E.2020002@ru.mvista.com>
In-Reply-To: <48D76D6E.2020002@ru.mvista.com>
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

Hello, I wrote:

>> diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
>> index 4e4f683..72541b5 100644
>> --- a/drivers/net/fec_mpc52xx.c
>> +++ b/drivers/net/fec_mpc52xx.c
>> @@ -401,6 +401,16 @@ static int mpc52xx_fec_hard_start_xmit(struct
>> sk_buff *skb, struct net_device *d
>>         return 0;
>>  }
>>
>> +#ifdef CONFIG_NET_POLL_CONTROLLER
>> +static void mpc52xx_fec_poll_controller(struct net_device *dev)
>> +{
>> +        disable_irq(dev->irq);
>> +        mpc52xx_fec_tx_interrupt(dev->irq, dev);
>>   
>
>   The interrupt nu,ber seems wrong, although the handler doesn't care 
> anyway...
>
>> +        enable_irq(dev->irq);

   Ah, you're also dis/enabling the wrong IRQ -- it should be 
priv->t_irq. No, this patch won't do.

WBR, Sergei

Return-Path: <sshtylyov@ru.mvista.com>
Message-ID: <48D77D44.80304@ru.mvista.com>
Date: Mon, 22 Sep 2008 15:11:00 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: solution to printk() blocking interrupts?
References: <9e4733910809211353k1f06fb5bi219c124d0c44b47a@mail.gmail.com>	
	<9e4733910809211443l5638887aw856377d39fcca85c@mail.gmail.com>	
	<48D6C8F0.4060808@ru.mvista.com>	
	<9e4733910809211634u5b37e297pe8503f08de4f19a8@mail.gmail.com>
	<1222060635.12085.11.camel@pasglop>
	<48D77BB1.3090103@ru.mvista.com>
In-Reply-To: <48D77BB1.3090103@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: shemminger@linux-foundation.org, linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I wrote:

>>> What controls this? "carrier detect appears untrustworthy, waiting 4 
>>> seconds"
>>> Get that fixed and this patch could be useful,
>>>     
>>
>> Does the driver properly uses netif_carrier_on/off to signal the
>> system when the link is up/down ?
>>   
>  Implementing the poll_controller() method in the network driver is 
> usually
>
>   Looks like the answer is "no"...

   Hm... it uses phylib, so probably it does that. That message and a 4 
s pause appears if the carrier is seen in <10 ms after opening the 
device. Maybe this threshold needs to be changed?

WBR, Sergei

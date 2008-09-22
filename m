Return-Path: <sshtylyov@ru.mvista.com>
Message-ID: <48D7B2B4.6020900@ru.mvista.com>
Date: Mon, 22 Sep 2008 18:59:00 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: solution to printk() blocking interrupts?
References: <9e4733910809211353k1f06fb5bi219c124d0c44b47a@mail.gmail.com>	
	<9e4733910809211443l5638887aw856377d39fcca85c@mail.gmail.com>	
	<48D6C8F0.4060808@ru.mvista.com>	
	<9e4733910809211634u5b37e297pe8503f08de4f19a8@mail.gmail.com>	
	<1222060635.12085.11.camel@pasglop>
	<48D77BB1.3090103@ru.mvista.com>	
	<48D77D44.80304@ru.mvista.com> <48D7AE19.1020309@ru.mvista.com>
	<9e4733910809220745i59a10185rffe1fdcda1916eb0@mail.gmail.com>
In-Reply-To: <9e4733910809220745i59a10185rffe1fdcda1916eb0@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: mpm@selenic.com, shemminger@linux-foundation.org,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

>> Not sure if Stephen was the right person to CC, including Matt now...

>>>>>>What controls this? "carrier detect appears untrustworthy, waiting 4
>>>>>>seconds"
>>>>>>Get that fixed and this patch could be useful,

>>>>>Does the driver properly uses netif_carrier_on/off to signal the
>>>>>system when the link is up/down ?

>>>> Implementing the poll_controller() method in the network driver is
>>>>usually

>>>> Looks like the answer is "no"...

>>> Hm... it uses phylib, so probably it does that. That message and a 4 s
>>>pause appears if the carrier is seen in <10 ms after opening the device.

>>  Oops, not 10 -- 100 ms (HZ / 10).

>>>Maybe this threshold needs to be changed?

>>  Seems like too much indeed.

> The link is coming up, but it appears that netconsole has already
> decided to wait 4s.
> mpc52xx MII bus: probed
> net eth0: Using PHY at MDIO address 0
> netconsole: local port 6666
> netconsole: local IP 192.168.1.11
> netconsole: interface eth0
> netconsole: remote port 514
> netconsole: remote IP 192.168.1.4
> netconsole: remote ethernet address 00:19:d1:e4:0f:8d
> netconsole: device eth0 not up yet, forcing it
> net eth0: attached phy 0 to driver Generic PHY
> netconsole: carrier detect appears untrustworthy, waiting 4 seconds

    Netpoll code decides to wait 4 secs after seeing that carrier is OK before 
100 ms passed...

> PHY: f0003000:00 - Link is Up - 100/Full

    ...but it's only reported to be OK later. So indeed, the carrier reported 
by the driver appears untrustworthy. ;-)

WBR, Sergei

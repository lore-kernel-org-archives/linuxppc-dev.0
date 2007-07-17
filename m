Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA74FDDE4A
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 02:31:40 +1000 (EST)
In-Reply-To: <1184679661.18501.41.camel@mark>
References: <469B3401.9030602@windriver.com> <200707170327.41648.arnd@arndb.de>
	<1184655499.18501.17.camel@mark> <200707171419.05061.arnd@arndb.de>
	<1184679661.18501.41.camel@mark>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AF0E1BD2-BBC1-4179-B901-55275047A36B@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/3] 82xx: SBCPQ2 board platform support
Date: Tue, 17 Jul 2007 18:30:56 +0200
To: Mark Zhan <rongkai.zhan@windriver.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> +	np = of_find_compatible_node(NULL, "cpm-pic", "CPM2");
>>>>> +	if (np == NULL) {
>>>>> +		printk(KERN_ERR "PIC init: can not find cpm-pic node\n");
>>>>> +		return;
>>>>> +	}
>>>>
>>>> This looks like your device tree is wrong. Shouldn't the interrupt
>>>> controller have device_type="interrupt-controller" and a specific
>>>> compatible property instead of having the name in the device_type?

So, I looked it up :-)

The device_type should specify the specific interrupt
controller programming model, because a real OF typically
needs to know the meaning of the interrupt specifiers;
also, when the interrupt binding recommended practice
isn't used, it is needed to know the #interrupt-cells
(which is implicit from the device_type in that case).

If there is no defined binding for your interrupt
controller, just don't put a device_type in your tree at
all, for flat device trees.

>>> Here, I just copy the codes from mpc82xx_ads, is there anything  
>>> wrong?
>>
>> I just checked the Recommended Practice document for interrupt  
>> mapping
>> and it seems that it's ok. The interrupt controller needs to have
>> an property named "interrupt-controller", but does not need a  
>> specific
>> device_type. So it appears to be correct here.

Please also look at the base specifications, not just
the imap thing.  But you reached the correct conclusion.


Segher

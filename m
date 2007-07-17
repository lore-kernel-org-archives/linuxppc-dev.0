Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 05A85DDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 01:08:30 +1000 (EST)
In-Reply-To: <200707171406.03455.arnd@arndb.de>
References: <469B33F9.2080604@windriver.com> <200707170302.07469.arnd@arndb.de>
	<1184647742.10499.34.camel@mark> <200707171406.03455.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3D0E2A2D-9ADE-4931-9C73-8E65550C728F@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] 82xx: Parse SMC serial device node in DTS
Date: Tue, 17 Jul 2007 17:08:18 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> +               if (strstr(model, "SMC")) {
>>>> +                       cpm_uart_dev =  
>>>> platform_device_register_simple("fsl-cpm-smc:uart",
>>>> +                                                       i, &r 
>>>> [0], 3);
>>>> +               } else if (strstr(model, "SCC")) {

>>> You should probably use of_device_is_compatible() to check
>>> if a given device can be used by a particular driver.
>>
>> I think, the function of_find_compatible_node(), which is called  
>> in the
>> for loop, has already done that. So definitely, no need to call
>> of_device_is_compatible() any more.
>
> It's a little more complicated than that. The "compatible" property  
> should
> indicate the exact interface of that device, so the "model" does  
> not really
> matter here.

"model" is meant to be an exact manufacturer model number.
This can be used for workaround code or such if the "compatible"
entry isn't specific enough.  You should try to make sure your
"compatible" entries are, though.

Oh, and strstr() is asking for trouble.  Just do a full
compare.

> I don't know the difference between smc and scc, but if you
> need to register them as different pplatform devices, they should
> normally also have different names in "compatible", possibly in  
> addition
> to the existing one.

Either that, or if they are identical device, just used in
different ways / connected differently, show that via some
other properties or such.

> If the compatible property contains "fsl,cpm-smc\0cpm_uart", you  
> can scan for
> either of them. The loop will iterate over all cpm_uart compatible  
> devices,
> while the later test will look for an fsl,cpm-smc compatible device.

Well, "fsl,cpm-uart" (note the two differences), but yes.


Segher

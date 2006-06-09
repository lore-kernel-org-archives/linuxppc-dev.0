Return-Path: <x.xiao@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id B303E67B1B
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jun 2006 03:15:50 +1000 (EST)
Message-ID: <4489ACE1.1010803@freescale.com>
Date: Fri, 09 Jun 2006 12:16:17 -0500
From: Xianghua Xiao <x.xiao@freescale.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 5/10 v2] Add 8641 CPU and i8259 Setup
References: <1149803956.23938.284.camel@cashmere.sps.mot.com>	<1149826989.12687.50.camel@localhost.localdomain>
	<E1FojUI-0004N5-E7@jdl.com>
In-Reply-To: <E1FojUI-0004N5-E7@jdl.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Reply-To: x.xiao@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Jon Loeliger wrote:

>So, like, the other day Benjamin Herrenschmidt mumbled:
>  
>
>>[A bunch of SMP issues.]
>>
>>The above is wrong, it prevents using the same kernel image on another
>>platform.
>>    
>>
>
>  
>
>>Same comment above... #ifdef is bad. You are entering from 0x100 with
>>address translation not disabled ?
>>    
>>
>
>  
>
>>>+	bl	clear_bats
>>> 	bl	load_up_mmu
>>>      
>>>
>>Why do you need to call clear_bats here ? load_up_mmu should load BATs.
>>If it doesn't handle the high BATs, then fix it :) 
>>    
>>
>
>  
>
I will fix this...

>>>+#ifdef CONFIG_I8259_LEVEL_TRIGGER
>>>+	outb(0xfa, 0x4d0); /* level triggered */
>>>+	outb(0xde, 0x4d1);
>>>+#endif
>>>      
>>>
>>Another change that breaks multiplatform... Can you explain precisely
>>what you are trying to acheive here ? If necessary, we can add an
>>argument to i8259_init. Or you could do the above in your platform
>>code ... though I agree it would be a bit ugly :) 
>>    
>>
>
>  
>
The above code is a must-have on our 8641D HPCN board to get PCI-Express 
ULI1575 southbridge going. The 8259(which is residing inside the 
southbridge) is collecting all PCI devices' interrupts( from both inside 
the ULI1575 and at its external PCI slots) before it reports to MPIC. 
PCI interrupts are level-triggered and shared thus we have to configure 
8259 to be level-triggered on this particular board.

>OK.  I don't have direct answers in hand for some of
>these questions and issues.  I'll get with original
>authors and see what we can do clean this up!
>
>Thanks!
>
>jdl
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-dev
>  
>

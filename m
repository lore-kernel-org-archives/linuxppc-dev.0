Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 9960767F9A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 00:33:25 +1000 (EST)
In-Reply-To: <200508091615.53736.g.jaeger@sysgo.com>
References: <200508091615.53736.g.jaeger@sysgo.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B13EBB66-D911-4008-90D6-69B9EA0BCED5@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 9 Aug 2005 09:33:25 -0500
To: Gerhard Jaeger <g.jaeger@sysgo.com>
Cc: Eric Kampman <erickampman@yahoo.com>, linuxppc-embedded@ozlabs.org
Subject: Re: MPC8555CDS & CCSRBAR
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 9, 2005, at 9:15 AM, Gerhard Jaeger wrote:

> On Tuesday 09 August 2005 16:04, Eric Kampman wrote:
>
>> Trying to port an SEC driver to Linux/PPC8555. Reading
>> the default CCSRBAR @ 0xFF700000 I read 0xFFFFFFFF
>> which is wrong. Looking at Metrowerks init files and
>> uboot code (1.1.2) I see it's likely been moved to
>> 0xE0000000, but I get a seg fault when I try to read
>> there.
>>
>> So, what am I doing wrong, and even better, how do I
>> at runtime find out where CCSRBAR is? Thanks in
>> advance, and please forgive the likely ignorance,
>>
>> Eric
>>
>>
>
> use the get_ccsrbar() function to get the address, then ioremap()
> will be your friend ;)

Depending on the kernel version you might want to use the driver  
model instead.  There is an entry for the security engine which will  
give you the physical address to ioremap and the interrupt number to  
use.  Doing this will be more portable.  However, this is only in  
newer 2.6 kernels.

- kumar

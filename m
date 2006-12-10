Return-Path: <info@schihei.de>
Received: from schihei.org (schihei.net [81.169.184.117])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 360BD679A6
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 06:32:19 +1100 (EST)
In-Reply-To: <200612091244.05862.arnd@arndb.de>
References: <20061207172259.64168f8c@localhost>
	<200612090100.09380.arnd@arndb.de> <4579FE4F.8000206@acm.org>
	<200612091244.05862.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <89216897-DF66-4C4E-9436-BD7816424139@schihei.de>
From: Heiko J Schick <info@schihei.de>
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
Date: Sun, 10 Dec 2006 19:42:17 +0100
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

On 09.12.2006, at 12:44, Arnd Bergmann wrote:

> On Saturday 09 December 2006 01:07, Corey Minyard wrote:
>>> I think the current representation is perfect. AFAICS, there are  
>>> always
>>> two registers, but depending on the HW implementation, they may be
>>> between 1 and 4 bytes wide, and can have a different spacing.
>>>
>> The BT and SMIC interfaces have three registers.  Does that break  
>> things?
>>
> It should still work, but I have to admit that at this point it  
> gets ugly.
>
> How about defining the properties just like the driver expects them:
>
> reg <size> <len>:	the area spanning all registers (2 or three)
> reg-spacing <number>:	offset of the start of each register (default 1)
> reg-size <number>:	length of each register (1, 2, or 4, default 1)
> reg-shift <number>:	bit-position of the data inside the register
> 			(default 0).

We have to include the IPMI information in a way which can be used  
for controllers which are accessed via memory mapped or legacy I/O.  
Furthermore, we have to include the register information that it will  
work not only for KCS interfaces. It should be possible to include BT  
and SMIC interfaces, too.

We have two options how we wanna present IPMI in the OFDT.

(1)

name = ipmi
device_type = ipmi
compatible = ipmi-kcs, ipmi-1.5, ...

regs = <addr> <len> <addr> <len> (for KCS interfaces)
	or
regs = <addr> <len> <addr> <len> <addr> <len> (for BT and SMIC  
interfaces)

(2)
name = ipmi
device_type
regs = <addr> <len>
reg-spacing = <number>
reg-size = <number>
reg-shift = <number>

The main difference between (1) and (2) is that (2) will represent  
the whole register region within the reg property. Because of that  
you have to include additional properties.

In (1) you will include every register (e.g. Cmd / Status, Data_In /  
Data_Out, etc.) within the reg property. The values for reg-spacing  
are calculated by subtracting addr2 - addr1. The reg-size are the  
len's within the reg property.

Personally I prefer (1), because I a the moment I don't see a big  
benefit in (2). For both options of have to implement source code  
which checks the compatible node to get the used interface type.  
According to the emitted interface type you have to read in (1) two  
or three registers from the reg property.

In (2) you have to calculate two or three addresses (with the help of  
reg and the additional reg-spacing, etc. properties).

Regards,
	Heiko

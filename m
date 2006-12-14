Return-Path: <jimix@watson.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A99B067C48
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 02:13:59 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBEFDrQM018077
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 10:13:53 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBEFDrR4210234
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 10:13:53 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBEFDrVw031837
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 10:13:53 -0500
In-Reply-To: <198592450612131708h1f5b59ffhdebd1b23d56d628f@mail.gmail.com>
References: <198592450612121611o7f7271cbnb1404c7f7f9fda71@mail.gmail.com>
	<1165982456.10549.1.camel@diesel>
	<198592450612131708h1f5b59ffhdebd1b23d56d628f@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3DC7CE26-7902-4FB7-B42C-F391314A7862@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: kgdb on mpc834x
Date: Thu, 14 Dec 2006 10:13:51 -0500
To: "Reeve Yang" <yang.reeve@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 13, 2006, at 8:08 PM, Reeve Yang wrote:

> I set "debug serial 1" in gdb, now I'm seeing message like this
>

I think you really want to use "set debug remote" to debug the protocol

there are also several "set remote*" gdb command that can help you

> (gdb) target remote /dev/ttyS0
> Remote debugging using /dev/ttyS0
> [
> r <Timeout: 2 seconds>][<Timeout: 2 seconds>][<Timeout: 2
> seconds>][<Timeout: 2 seconds>][<Timeout: 2 seconds>][<Timeout: 2
> seconds>][<Timeout: 2 seconds>]Ignoring packet error, continuing...
> [<Timeout: 2 seconds>][<Timeout: 2 seconds>][<Timeout: 2
> seconds>][<Timeout: 2 seconds>][<Timeout: 2 seconds>][<Timeout: 2
> seconds>][<Timeout: 2 seconds>]Ignoring packet error, continuing...
> [<Timeout: 2 seconds>][<Timeout: 2 seconds>][<Timeout: 2
> seconds>][<Timeout: 2 seconds>][<Timeout: 2 seconds>][<Timeout: 2
> seconds>][<Timeout: 2 seconds>]Ignoring packet error, continuing...
> Malformed response to offset query, timeout
>
> Does it tell any information?

you may also want to play with:
(gdb) set remotetimeout 0
0 == infinit, or use some really large value like 20

>
> On 12/13/06, Hollis Blanchard <hollis@penguinppc.org> wrote:
>> On Wed, 2006-12-13 at 00:11 +0000, Reeve Yang wrote:
>>> I applied kgdb patch for 2.6.13 to kernel 2.6.14 (since there is no
>>> patch for 2.6.14), but gdb client cannot connec to it. I turn on all
>>> necessary kernel hacking options. Our board is customized with
>>> MPC834x, can someoen who used kgdb to debug kernel on MPC834x  
>>> help me
>>> out? Following are the message from linux boot and gdb client.
>>>
>>> ## Booting image at ff300000 ...
>>>
>>> loaded at:     FF300000 FFB71124
>>> relocated to:  00800000 01071124
>>> board data at: 007FFF70 007FFFF8
>>> relocated to:  00805114 0080519C
>>> zimage at:     00805915 00926A5E
>>> initrd at:     00927000 0106E242
>>> avail ram:     01072000 01472000
>>>
>>> Linux/PPC load: mem=248M
>>> Uncompressing Linux...done.
>>> Now booting the kernel
>>> mpc834x_sys_init(): exit
>>> id mach(): done
>>> MMU:enter
>>> MMU:hw init
>>> MMU:mapin
>>> MMU:setio
>>> MMU:exit
>>> setup_arch: enter
>>> setup_arch: bootmem
>>>
>>> (gdb) target remote /dev/ttyS0
>>> Remote debugging using /dev/ttyS0
>>> Ignoring packet error, continuing...
>>> Ignoring packet error, continuing...
>>> Ignoring packet error, continuing...
>>> Malformed response to offset query, timeout
>>
>> Try 'set debug serial 1' in GDB; it will show you the actual data  
>> GDB is
>> receiving.
>>
>> -Hollis
>>
>>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

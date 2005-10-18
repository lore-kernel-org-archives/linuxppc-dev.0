Return-Path: <dhlii@dlasys.net>
Received: from xm.dlasys.net (unknown [24.152.213.223])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D2917685C4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Oct 2005 05:36:26 +1000 (EST)
Received: from [206.223.20.140] (port=2115 helo=[206.223.20.140])
	by xm.dlasys.net with esmtp (Exim 4.52 #1 (Debian))
	id 1ERwx3-0002IX-2k
	for <linuxppc-embedded@ozlabs.org>; Tue, 18 Oct 2005 15:16:45 -0400
Message-ID: <435549C2.1000106@dlasys.net>
Date: Tue, 18 Oct 2005 15:15:14 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <4354AC78.5080206@comcast.net> <4354B707.6060002@iki.fi>
In-Reply-To: <4354B707.6060002@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: Need help Understanding initial memory conditions.
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kalle Pokki wrote:

> David H. Lynch Jr wrote:
>
>>    What exactly is the minimal startup system state the Linux 2.6.13 
>> Kernel expects ?
>
>
> It's pretty hard to describe the system state fully, as there are so 
> many registers it may depend on. However, I can point out a few things 
> from your setup:
>
> 1. Put RAM to 0x0000000 and flash to some location it mirrors to your 
> boot vector. Linux always expects your physical memory to be at zero. 
> It is then mapped to virtual address 0xC0000000.

    In both this list and elsewhere I have seen several references to 
the difficulty setting up Linux with a physical RAM base other than 0x0. 
I was hoping that I could bypass that by re-arranging physical memory 
using the BAT's or MMU.
I am gathering that while this is possible, that it not sufficient. That 
if memory is re-arranged after power-on it has to be done by something 
Linux is not aware of.

>
> 2. You don't need to have MMU enabled.

    There is a god. I am a compitent developer with lots of low level 
experience, but I have thus far completely missed out on both PPC 
assembler and memory management.

>
> 3. Make sure your boot arguments are passed properly to the kernel. 
> This includes the settings in registers r3 ... r7 and the bd_info 
> structure . There are many variants of that structure, make sure you 
> use the same ones in the boot loader and in Linux.

    That I should have no problem with.


>
>

Thank You very much

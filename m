Return-Path: <jrocnuck@hotmail.com>
Received: from bay0-omc2-s36.bay0.hotmail.com (bay0-omc2-s36.bay0.hotmail.com
	[65.54.246.172]) by ozlabs.org (Postfix) with ESMTP id 6823067B8B
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 22 Oct 2006 03:49:00 +1000 (EST)
Message-ID: <BAY117-F26E839E935D9A3C03E365EC8020@phx.gbl>
In-Reply-To: <BAY110-F2BA131ED0055064C26658B2020@phx.gbl>
From: "Eric Nuckols" <jrocnuck@hotmail.com>
To: eemingliu@hotmail.com, urwithsudheer@gmail.com
Subject: Re: how to reserve memory in linux?
Date: Sat, 21 Oct 2006 13:48:57 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Have you tried the function

alloc_bootmem_low() early in the boot process in main.c ?



----Original Message Follows----
From: "Ming Liu" <eemingliu@hotmail.com>
To: urwithsudheer@gmail.com
CC: linuxppc-embedded@ozlabs.org
Subject: Re: how to reserve memory in linux?
Date: Sat, 21 Oct 2006 14:22:25 +0000

Dear sudheer,
About the "mem=xx" argument, I checked it from the website and got such a 
explanation:

This argument has several purposes: The original purpose was to specify the 
amount of installed memory (or a value less than that if you wanted to limit 
the amount of memory available to linux).

>From the argument above, it says "mem=xx" is to specify the amount of memory 
available to Linux. I am not sure if I am right, but I think if I use such 
an argument, that reserved part (that 5MB you mentioned), is not available 
any more for Linux to access it.

My original meaning is: specify a fixed physical address for a mount of 
memory for reserved use. The point is to make this part of memory fixed in 
the memory of physical address, and then another I/O peripheral could use 
DMA to access such a fixed physical address memory. However if I don't 
reserve such a part, I must let Linux to allocate such a memory part. And 
then Linux will not put it in a fixed physical address and then the 
peripheral will not know where is this part.

Am I right? Thanks for your idea.

Also other ideas are appreciated.

Regards
Ming

>Considering your setup as normal desktop, I hope this can be done by giving
>"mem= xxm"  as the boot arguments.  Say the dmesg in your system shows   "
>495MB LOWMEM available."  .  In the boot arguments you can give mem=490m
>saying the linux to use only 490MB . The rest 5MB can be used later as you
>wish.

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com



_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_________________________________________________________________
Get FREE company branded e-mail accounts and business Web site from 
Microsoft Office Live 
http://clk.atdmt.com/MRT/go/mcrssaub0050001411mrt/direct/01/

Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 648DDDDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Apr 2007 23:51:18 +1000 (EST)
Message-ID: <4613AE3B.2010803@ru.mvista.com>
Date: Wed, 04 Apr 2007 17:55:07 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Peter Mendham <petermendham@computing.dundee.ac.uk>
Subject: Re: Using Linux 2.6.19 with Xilinx ML405
References: <46125216.2080903@computing.dundee.ac.uk>
	<46128E70.50503@ru.mvista.com>
	<46139148.1080308@computing.dundee.ac.uk>
In-Reply-To: <46139148.1080308@computing.dundee.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi Peter,

Peter Mendham wrote:
> Hi Andrei,
> 
> Thanks for your reply
>> CONFIG_PPC_OCP and ppc_sys_platform_devices related problems are due 
>> to the kernel.org tree stopped using the OCP infrastructure in favor 
>> of ppc_sys stuff (originally created for Freescale 8xx/8xxx SOCs).
> Excellent - thanks for explaining this.  I had wondered whether this was 
> the case but didn't want to do anything drastic without understanding 
> what was going on.
>> What BSP vesion have you selected in the xps? As far as I can tell, 
>> linux_2_6_v1_00_a uses the approach similar to 2.6 kernel based 
>> MontaVista LSP: "manual" registration of all the devices in 
>> arch/ppc/platforms/4xx/virtex.c, static int __init 
>> xilinx_platform_init(void). The only exception are 16x50 compatible 
>> UARTs, that rely on struct ocp_def core_ocp[] etc.
> I had selected linux_2_6_v1_00_a also, I just wasn't sure how "current" 
> some of the generated code was.
>> At the moment I am doing some rework of our code (includes rebasing 
>> the patches against a more-or-less recent kernel.org tree). My plan is 
>> to drop both PPC_OCP and ppc_sys, and register all the devices inside 
>> xilinx_platform_init(). For Xilinx'es using ppc_sys adds no value but 
>> some unneeded complexity. And it seems ppc_sys is no longer 
>> used/supported after Freescale 8xx/8xxx SOCs moved to arc/powerpc? 
>> Having all the device registration (and references to xparameters.h as 
>> well!) in one place IMHO would make it easier to move Xilinx based 
>> boards to arc/powerpc (someday).
> OK, that is also good to know.  I buy your argument, so I'd like to use 
> the "manual" approach.  However, when I tried compiling there was some 
> code that expected a ppc_sys_platform_devices (and a ppc_sys_specs).  Am 
> I right in thinking that your patch sorts this out?

Yes, my patch makes the Xilinx board not to use ppc_sys[whatever]

>> Attached is the patch to get rid of both XILINX_OCP and ppc_sys for 
>> the Xilinx boards. With this patch applied it should be not so 
>> difficult to add the relevant entries to 
>> arch/ppc/platforms/4xx/virtex.c by copying them from the EDK generated 
>> linux_2_6_v1_00_a BSP. The patch is against 2.6.21-rc4 if it matters.
> Brilliant!  Thanks.  The code your patch produces expects there to be an 
> 8250 compatible UART around.

The code supports 8250 compatible UART, but not having 8250 is OK as well.
As long as you have some alternative console device ;)

> What happens if I only have a UARTlite?  
> What do I need to fill in to a platform_device structure for a 
> UARTlite?

It depends on the UARTlite driver you use...

> I have just moved to 2.6.20 kernel in the hope of using the 
> mainline uartlite driver - was this a stupid thing to do?  Do you know 
> if I can use it for early serial in the same way as an 8250?

At the moment there is no uartlite driver accepted into the mainline
(or whatever community) tree.
There were several postings to this list. Can't recall if the final patch
has been attached to any of them. But at least people were saying
they have the driver almost ready to go to the community.
MontaVista has UARTlite driver in Pro 4.0 release, but it is
not platform device (yet), and I'd prefer not to publish it
until it becomes a platform device. And it probably should not
use generic_serial.c any more (the current one does).

As for early serial, it should work.

> Many thanks for your help,
> 
> -- Peter

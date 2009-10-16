Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 20DA0B7B90
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 18:46:02 +1100 (EST)
Date: Fri, 16 Oct 2009 09:25:15 +0200
From: Gabriel Paubert <paubert@iram.es>
To: "wilbur.chan" <wilbur512@gmail.com>
Subject: Re: Problem when disabled interrupt in system call (ppc8270)
Message-ID: <20091016072515.GA30367@iram.es>
References: <e997b7420910151812m3de16f67hdb756bcd1f40ddc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e997b7420910151812m3de16f67hdb756bcd1f40ddc@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 16, 2009 at 09:12:34AM +0800, wilbur.chan wrote:
> ppc 8270, kernel 2.6.21.7
> 
> I took the following steps:
> 
> 
> In a system call function , say , sys_reboot, interrupt was disabled
> by local_irq_disable.
> 
> Then ,  value at the address of 0xc000050  was set to a value , say ,
> 0x1234.  Code was like this :
> 
> sys_reboot()
> {
> local_irq_disable();
> *(volatile unsigned long * )0xc1000050 = 0x1234;
>  while(1)
>    {
>     ;
>    }
> }
> 
> Finally, I reset the board (with power still on)  into uboot,using
> 'md 0x1000050' to display the content at physical address 0x1000050,
> and found that , it was not 0x1234.
> 
> 
> However, if I delete the local_irq_disable() in sys_reboot, everything
> went well---After I reset the board, 'md 0x1000050' return the value
> 0x1234.
> 
> 
> So, this really puzzled me , could someone explain why this happed?  Thank you.

The 0x1234 stays in the data cache and is not written to memory. The hard reset
invalidates the caches and you read the previous value from memory.

If you don't disable interrupts, the cache line is ultimately written
back to memory and you see it after reset.

Just try inserting a dcbst (or dcbf) instruction for the address
of the 0x1234 value just after.

Something like asm volatile("dcbst 0,%0": : "r" (address) : "memory");

(Not even tried to compile it, but you get the idea).

	Gabriel

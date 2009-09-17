Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 19520B7B75
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 16:49:02 +1000 (EST)
Subject: Re: FPGA access over PCI-E on MPC8536
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4AB1B84F.8080606@embedded-sol.com>
Date: Thu, 17 Sep 2009 01:48:53 -0500
Message-Id: <C13B4529-4766-48C9-8004-A45B4A6EAE69@kernel.crashing.org>
References: <4AB1B84F.8080606@embedded-sol.com>
To: Felix Radensky <felix@embedded-sol.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 16, 2009, at 11:17 PM, Felix Radensky wrote:

> Hi,
>
> On my custom MPC8536 based board running 2.6.31 kernel
> FPGA is connected via x2 PCI-E lane. FPGA is identified
> during PCI scan and is visible via lspci.
>
> 0000:01:00.0 Class ff00: Altera Corporation Unknown device 0004 (rev  
> 01)
>        Subsystem: Altera Corporation Unknown device 0004
>        Flags: fast devsel, IRQ 16
>        Memory at 98000000 (32-bit, non-prefetchable) [disabled]  
> [size=1M]
>        Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+  
> Queue=0/5 Enable-
>        Capabilities: [78] Power Management version 3
>        Capabilities: [80] Express Endpoint IRQ 0
>        Capabilities: [100] Virtual Channel
>
>
> However when I attempt to access FPGA memory my mmapping it in  
> userspace the read hangs. The same happens in kernel space. Does it  
> happen because FPGA memory is marked as disabled, or because FPGA  
> code is doing something wrong ?

Can you access the device in u-boot?  That would possible tell you if  
the HW is functioning or not.

> Another question is what can cause PCI device memory be marked as
> disabled.

Good question, no idea how lspci decided to print [disabled].  Take a  
look at lspci source and see :)

- k

Return-Path: <eddie@embeddedarm.com>
Received: from oz.embeddedARM.com (oz.embeddedarm.com [67.40.67.44])
	by ozlabs.org (Postfix) with ESMTP id 0A36BB7B6F
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 05:03:27 +1000 (EST)
Message-ID: <4AB13550.1070506@embeddedarm.com>
Date: Wed, 16 Sep 2009 11:58:24 -0700
From: Eddie Dawydiuk <eddie@embeddedarm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PPC PCI bus registers
References: <4A9F0377.1070606@embeddedarm.com>
	<1251972032.15089.30.camel@pasglop>
In-Reply-To: <1251972032.15089.30.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin,

> Also, if you're going to access a PCI device directly, beware of other
> issues such as ordering. PPC is an out of order architecture, you need
> to ensure you add the appropriate memory barriers if you want to ensure
> you accesses are done in the order you write them in your program.
> 
> For "standard" stuff that doesn't involve DMA or locks, an eieio after
> both MMIO loads and stores should do the trick.

I'm not sure I understand. To clarify I have an FPGA connected via the PCI bus 
which implements several peripherals, I've implemented device drivers for. 
Currently I am calling ioremap() to get a virtual address corresponding to the 
PCI devices. Then I use ___raw_writeN / ___raw_readN for reading/writing data 
via the PCI bus to the FPGA registers. From looking at io.h I believe this 
method is safe with regard to out of order execution.

"* ioremap is the standard one and provides non-cacheable guarded mappings
*   and can be hooked by the platform via ppc_md "

Can you verify if my understanding is correct, or let me know if I need to add 
memory barriers?

-- 
Best Regards,
________________________________________________________________
  Eddie Dawydiuk, Technologic Systems | voice:  (480) 837-5200
  16525 East Laser Drive              | fax:    (480) 837-5300
  Fountain Hills, AZ 85268            | web: www.embeddedARM.com

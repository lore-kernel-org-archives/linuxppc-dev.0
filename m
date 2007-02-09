Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A88A8DDE49
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 10:44:43 +1100 (EST)
In-Reply-To: <45CD04B5.1020304@freescale.com>
References: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
	<1170969965.2620.345.camel@localhost.localdomain>
	<0640B069-F05E-4A08-A8EB-C277BEF1466E@embeddedalley.com>
	<1171058780.6578.4.camel@localhost.localdomain>
	<1EFFAE36-7396-45B5-B8F2-DD7348FBE385@kernel.crashing.org>
	<45CCFAD6.5070807@freescale.com>
	<7B89E9E3-620C-4DF5-96E7-AF05287D89DC@kernel.crashing.org>
	<45CCFF4B.7000102@freescale.com>
	<969E3C07-96EE-4AF9-BF57-B10F049684EE@kernel.crashing.org>
	<45CD04B5.1020304@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2C4DF8F6-BA54-4D5C-9670-1893E2625EFC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Discussion about iopa()
Date: Fri, 9 Feb 2007 17:43:49 -0600
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 9, 2007, at 5:33 PM, Timur Tabi wrote:

> Kumar Gala wrote:
>
>> We should fix it so the driver just has to do dma_alloc_coherent,  
>> dma_free_coherent, and dma_map_*/dma_unmap_*
>
> Ok, I'm getting confused now.  The driver currently uses ioremap 
> ().  You're saying that it should use the dma_xxx functions  
> instead, but not until those functions support MURAM?  When that  
> happens, won't that make ioremap() obsolete?

ioremap() is for IO space not normal memory or things that behave  
like normal memory (MURAM, on chip SRAM, etc).  ioremap will always  
be needed to ensure proper non-cachable/guarded access to registers  
on devices, etc...  The problem is that we don't have a mechanism  
between kmalloc/vmalloc (for system memory) and ioremap (for devices)  
to handle other memories in the system.  So we end up with a  
specialized allocator (rheap + muram wrappers) to deal with it.

So, I'd rather mapping also be specialized for MURAM.  I don't see  
any benefit in making mapping behave the same while not addressing  
the other functionality (allocation, deallocation, etc.)

- k

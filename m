Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BCC20DDEDE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 04:03:33 +1100 (EST)
Message-ID: <474C4DA9.6000205@freescale.com>
Date: Tue, 27 Nov 2007 11:02:33 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: vijay baskar <cn.vijaibaskar@gdatech.co.in>
Subject: Re: The question about the high memory support on MPC8360?
References: <396049508.10992@tsinghua.org.cn>
	<474A639A.3090006@gdatech.co.in>	<20071126165751.GA4415@loki.buserror.net>
	<474B9CC0.2000803@gdatech.co.in>
In-Reply-To: <474B9CC0.2000803@gdatech.co.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: =?UTF-8?B?6YOt5Yqy?= <guojin02@tsinghua.org.cn>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

vijay baskar wrote:
> The kernel maps the last 1 GB of the virtual address space one to one
> to the physical memory.

No, it maps 768MB of RAM in this manner.

> This is called the kernel space. After the one
> to one mapping is done for the available physical memory, the
> remaining virtual addresses are used for vmalloc and ioremap.

And highmem mappings.

> The kernel also allows hardcoded mapping
> of IO regions into its virtual address space through the
> io_block_mapping interface.

Not in current arch/powerpc kernels.

> Many boards use the block IO mapping to
> map the CCSRBAR/IMMR into the kernel address space, such that the
> physical address and the virutal address is the same. Virtual
> addresses beyond these hardcoded mappings cannot be used by
> vmalloc/ioremap.

And this is why.

> Now as more and more memory is added to the system the addresses
> available for vmalloc and ioremap gets reduced, and memory allocations
> start to fail, due to the lack of availability of virtual addresses.

How so?  The size of lowmem is constant once you reach the threshold, as 
is the size of the highmem mapping area.

What *does* start to fail eventually, if you have a *lot* of highmem, is 
that you run out of lowmem for pagetables and such.

-Scott

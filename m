Return-Path: <cn.vijaibaskar@gdatech.co.in>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 0B6D3DDD0D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 14:58:05 +1100 (EST)
Received: from [172.29.36.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id ED17A8780BB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 19:57:54 -0800 (PST)
Received: from mail.gdatech.co.in (unknown [172.29.36.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id ABD568780A9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 19:57:54 -0800 (PST)
Message-ID: <474CE85A.1020902@gdatech.co.in>
Date: Wed, 28 Nov 2007 09:32:34 +0530
From: vijay baskar <cn.vijaibaskar@gdatech.co.in>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: The question about the high memory support on MPC8360?
References: <396049508.10992@tsinghua.org.cn>	<474A639A.3090006@gdatech.co.in>	<20071126165751.GA4415@loki.buserror.net>	<474B9CC0.2000803@gdatech.co.in>
	<474C4DA9.6000205@freescale.com>
In-Reply-To: <474C4DA9.6000205@freescale.com>
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

Hi,
"The kernel also allows hardcoded mapping
of IO regions into its virtual address space through the
io_block_mapping interface."

Can u tell me how this is in current arch/powerpc. Also does it mean 
that whatever be the size of the ram > 768 MB there is not going to be 
much improvement in performance in kernel space irrespective of invoking 
CONFIG_HIGHMEM or not?

Also do you think this low mem be enough if i have lots of kernel space 
processes each invoking lots of kmallocs. Will there be bottle necks?? 
Also what alternative do we have if  low mem of 768 MB is not enough??

Scott Wood wrote:

> vijay baskar wrote:
>
>> The kernel maps the last 1 GB of the virtual address space one to one
>> to the physical memory.
>
>
> No, it maps 768MB of RAM in this manner.
>
>> This is called the kernel space. After the one
>> to one mapping is done for the available physical memory, the
>> remaining virtual addresses are used for vmalloc and ioremap.
>
>
> And highmem mappings.
>
>> The kernel also allows hardcoded mapping
>> of IO regions into its virtual address space through the
>> io_block_mapping interface.
>
>
> Not in current arch/powerpc kernels.
>
>> Many boards use the block IO mapping to
>> map the CCSRBAR/IMMR into the kernel address space, such that the
>> physical address and the virutal address is the same. Virtual
>> addresses beyond these hardcoded mappings cannot be used by
>> vmalloc/ioremap.
>
>
> And this is why.
>
>> Now as more and more memory is added to the system the addresses
>> available for vmalloc and ioremap gets reduced, and memory allocations
>> start to fail, due to the lack of availability of virtual addresses.
>
>
> How so?  The size of lowmem is constant once you reach the threshold, 
> as is the size of the highmem mapping area.
>
> What *does* start to fail eventually, if you have a *lot* of highmem, 
> is that you run out of lowmem for pagetables and such.
>
> -Scott
>
>

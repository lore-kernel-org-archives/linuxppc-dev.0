Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 07002DDF67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 03:58:05 +1100 (EST)
Message-ID: <474D9E02.5050302@freescale.com>
Date: Wed, 28 Nov 2007 10:57:38 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: vijay baskar <cn.vijaibaskar@gdatech.co.in>
Subject: Re: The question about the high memory support on MPC8360?
References: <396049508.10992@tsinghua.org.cn>	<474A639A.3090006@gdatech.co.in>	<20071126165751.GA4415@loki.buserror.net>	<474B9CC0.2000803@gdatech.co.in>	<474C4DA9.6000205@freescale.com>
	<474CE85A.1020902@gdatech.co.in>
In-Reply-To: <474CE85A.1020902@gdatech.co.in>
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
> Hi, "The kernel also allows hardcoded mapping of IO regions into its 
> virtual address space through the io_block_mapping interface."
> 
> Can u tell me how this is in current arch/powerpc.

Everything is explicitly ioremapped.

> Also does it mean that whatever be the size of the ram > 768 MB there
>  is not going to be much improvement in performance in kernel space 
> irrespective of invoking CONFIG_HIGHMEM or not?

Well, the kernel can use highmem for cache...  I'm not sure what you
mean by "in kernel space".

> Also do you think this low mem be enough if i have lots of kernel 
> space processes each invoking lots of kmallocs.

That depends on what you mean by "lots". :-)

You'll have 768MB of lowmem, and kmallocs can only use lowmem.

> Will there be bottle necks?? Also what alternative do we have if  low
> mem of 768 MB is not enough??

You'll need to change the user/kernel split, and deal with anything that 
breaks in the process.

Or get a 64-bit chip. :-)

-Scott

Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 64E1CDDE2A
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 01:54:40 +1100 (EST)
In-Reply-To: <1173970133624-git-send-email-timur@freescale.com>
References: <1173970133624-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CB8634B4-7150-4D0D-942C-76BC55C43749@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix invalid pointer usage in ucc_slow_init()
Date: Thu, 15 Mar 2007 09:53:44 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 15, 2007, at 9:48 AM, Timur Tabi wrote:

> In two places, ucc_slow_init() passes a physical address instead of  
> the
> virtual address to functions that were expecting the latter,  
> causing a kernel
> panic.  us_info->regs contains the physical address of the UCC  
> register set.
> The registers are ioremap'd to kernel space, and the virtual  
> pointers are
> stored in us_regs.  The code was using us_info->regs when it should  
> have been
> using us_regs.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---

It's my understanding that there aren't any in kernel users of  
ucc_slow at the moment, is that true?

- k

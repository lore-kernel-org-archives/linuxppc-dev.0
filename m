Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4464FDE0BB
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 00:27:23 +1000 (EST)
Message-Id: <26A28837-B944-4CA6-83B5-5466CF1EDBF3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080801141306.GA29127@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [RFC][PATCH 0/8] kexec/kdump support for ppc32
Date: Fri, 1 Aug 2008 09:21:02 -0500
References: <20080801141306.GA29127@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 1, 2008, at 9:13 AM, Anton Vorontsov wrote:

> Hi all,
>
> I refreshed some Dale Farnsworth's kexec/kdump patches[1] against
> the latest kernel, and here they are.
>
> There is a difference though. Dale's patches were using
> kmap_atomic_pfn() to map oldmem memory, while for this patches
> I took PPC64 approach to use ioremap(). This is done to be able
> to support kdump on !HIGHMEM kernels.
>
> Also, please take a special look into 8/8 patch, there is a hunk
> marked with "XXX:", which I don't quite understand for PPC64 case
> (this hunk also persist in the original Dale's patch, and w/o it
> the capturing kernel doesn't boot on ppc32).
>
> I'll try to refresh BookE support as soon as I'll find some BookE
> board.
>
> The patchset includes:
>
> - Kexec support
>
>  [PATCH 1/8] powerpc: set up OF properties for ppc32 kexec
>  [PATCH 2/8] powerpc: make default kexec/crash_kernel ops implicit
>  [PATCH 3/8] powerpc: remove default kexec/crash_kernel ops  
> assignments
>
>  2/8 and 3/8 patches are used to avoid adding lots of default ops
>  to the board files.
>
> - Kdump support
>
>  [PATCH 4/8] powerpc: add the ability for a classic ppc kernel to be  
> loaded at 32M
>  [PATCH 5/8] powerpc: allow to ioremap RAM addresses for kdump  
> kernel on ppc32
>  [PATCH 6/8] powerpc: set up OF properties for ppc32 kdump
>  [PATCH 7/8] powerpc: implement crash_setup_regs for ppc32
>  [PATCH 8/8] powerpc: last bits to support kdump on ppc32
>
> [1] http://ozlabs.org/pipermail/linuxppc-dev/2007-November/046739.html

What's the state of the kexec tools for ppc32?

- k

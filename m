Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 846D3474C1
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 03:19:53 +1100 (EST)
In-Reply-To: <491851D3.3050904@in.ibm.com>
References: <kexec-kern-2@bga.com> <4900952A.3090605@in.ibm.com>
	<b6c6e115495e149f24d2de5cb82a92ab@bga.com>
	<491851D3.3050904@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f2538c5a645ccd8ed03ff44dc450f652@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 3/3] powerpc/ppc64/kdump: better flag for running
	relocatable
Date: Tue, 11 Nov 2008 10:06:16 -0600
To: Mohan Kumar M <mohan@in.ibm.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@ozlabs.org,
	Simon Horman <horms@verge.net.au>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Nov 10, 2008, at 9:22 AM, Mohan Kumar M wrote:
> Yes, elf_ret_symbol sets the copy in purgatory. But the following code 
> in purgatory (to be introduced)
>
>  	LOADADDR(6,run_at_load)
>  	ld	18,0(6)
>  	cmpd	18,1
>  	bne	skip
>  	li	7,1
>  	stw	7,92(4)		# mark __run_at_load flag at kernel
>
> will set the __run_at_load in the kernel image (ie where ever kernel 
> is loaded + 0x5c(92). Or am I missing some thing?

That would work, but I prefer to keep the change in the userspace side. 
  Partly because I don't want to link setting the relocatable flag to 
purgatory starting a dump kernel, and partly because I think 
kexec-tools should be verifying that the loaded kernel will run where 
it expects, either by it finding the relcatable flag, inspecting the 
elf header for the linked address, or some other method (like elf type 
is dynamic for some platforms).  Oh, and its more readable in C.

If someone adds mmap instead of read files to the common code, then we 
will just have to make sure they use MMAP_PRIVATE instead of 
MMAP_SHARED.  Today its not an issue.

milton

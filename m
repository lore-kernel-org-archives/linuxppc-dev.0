Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A55F7B70DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 06:18:20 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1EB1DDD0C
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Jun 2009 06:18:19 +1000 (EST)
Subject: Re: [OOPS] hugetlbfs tests with 2.6.30-rc8-git1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4A290195.3080807@in.ibm.com>
References: <4A290195.3080807@in.ibm.com>
Content-Type: text/plain
Date: Sat, 06 Jun 2009 06:17:42 +1000
Message-Id: <1244233062.31984.6.camel@pasglop>
Mime-Version: 1.0
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-06-05 at 16:59 +0530, Sachin Sant wrote:
> While executing Hugetlbfs tests against 2.6.30-rc8-git1 on a
> Power 6 box observed the following OOPS message.

> NIP [c000000000038240] .hpte_need_flush+0x1bc/0x2d8
> LR [c0000000000380f0] .hpte_need_flush+0x6c/0x2d8

Weird. I don't really see what happened there.

> Call Trace:
> [c0000000fa8ff710] [c000000000038264] .hpte_need_flush+0x1e0/0x2d8 (unreliable)
> [c0000000fa8ff7d0] [c000000000039fa4] .huge_ptep_get_and_clear+0x40/0x5c
> [c0000000fa8ff850] [c00000000012d46c] .__unmap_hugepage_range+0x178/0x2b8
> [c0000000fa8ff940] [c00000000012d600] .unmap_hugepage_range+0x54/0x88
> [c0000000fa8ff9e0] [c0000000001173a0] .unmap_vmas+0x178/0x8f4
> [c0000000fa8ffb30] [c00000000011cab8] .unmap_region+0xfc/0x1e4
> [c0000000fa8ffc00] [c00000000011e248] .do_munmap+0x2f4/0x38c
> [c0000000fa8ffcc0] [c0000000002f6d74] .SyS_shmdt+0xc0/0x188
> [c0000000fa8ffd70] [c00000000000c430] .sys_ipc+0x274/0x2fc
> [c0000000fa8ffe30] [c000000000008534] syscall_exit+0x0/0x40
> Instruction dump:
> 78090220 2fbd0000 409e0010 7929e0e4 7be00120 4800000c 792945c6 7be00600 
> 7d3f0378 7c1cb82e 3d360001 2f800000 <eb898000> 409e0028 7fe3fb78 7f24cb78 

The call trace looks rather ordinary. In fact, the DAR address doesn't
even look that bad, depends how much RAM you have in this partition I
suppose.

> I first noticed this with 2.6.30-rc7-git3 on a power6 machine,
> but could not recreate again on the same machine. Now the problem
> has resurfaced again with 2.6.30-rc8 (and with git1 as well) on
> another Power6 box.
> 
> I had seen similar failures(although the back trace was different,
> crash point was same) with older kernels and Mel submitted a patch
> to fix that issue. Here is the link to that patch.
> 
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-May/071395.html
> 
> I have attached the .config.

No, Mel's patch is for a different problem and has been fixed upstream
already. This is more concerning... I'm not sure what's up but would
you be able to send a disassembly of the hpte_need_flush() function in
your kernel binary for me to see what access precisely caused the
fault ?

Cheers,
Ben.

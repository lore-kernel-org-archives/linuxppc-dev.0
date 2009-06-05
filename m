Return-Path: <mel@csn.ul.ie>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 06460B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 01:04:40 +1000 (EST)
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 479D3DDD01
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Jun 2009 01:04:36 +1000 (EST)
Date: Fri, 5 Jun 2009 16:04:29 +0100
From: Mel Gorman <mel@csn.ul.ie>
To: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [OOPS] hugetlbfs tests with 2.6.30-rc8-git1
Message-ID: <20090605150429.GA29614@csn.ul.ie>
References: <4A290195.3080807@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <4A290195.3080807@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 05, 2009 at 04:59:25PM +0530, Sachin Sant wrote:
> While executing Hugetlbfs tests against 2.6.30-rc8-git1 on a
> Power 6 box observed the following OOPS message.
>
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=1024 DEBUG_PAGEALLOC NUMA pSeries
> Modules linked in: ipv6 fuse loop dm_mod sg sd_mod crc_t10dif ibmvscsic
> scsi_transport_srp scsi_tgt scsi_mod
> NIP: c000000000038240 LR: c0000000000380f0 CTR: c00000000025d050
> REGS: c0000000fa8ff490 TRAP: 0300   Not tainted  (2.6.30-rc8-git1-autotest)
> MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 44022422  XER: 00000001
> DAR: c000000084340480, DSISR: 0000000040000000
> TASK = c0000000facf40a0[10514] 'shm-fork' THREAD: c0000000fa8fc000 CPU: 2
> GPR00: 0000000000000000 c0000000fa8ff710 c000000000a9d900 
> 0000000000000004 GPR04: 000003fff0000000 c000000084338480 
> 0000168008000393 0000000000000001 GPR08: 0000000000000004 
> c000000084348480 000000000003fff0 0000000000000350 GPR12: 
> 0000000044022422 c000000000b72800 00000000ffffffff ffffffffffffffff  
> GPR16: 000000004c8d6470 0000000000000000 ffffffffffff9010 
> 0000000000000000 GPR20: 0000000000000000 0000040000000000 
> c000000084338480 0000000000760000 GPR24: 0000000000000000 
> 0000168008000393 c000000084379700 0000000000000004 GPR28: 
> c000000000890430 0000000000000001 c000000000ff0430 f9c3d6fff0000000 NIP 
> [c000000000038240] .hpte_need_flush+0x1bc/0x2d8
> LR [c0000000000380f0] .hpte_need_flush+0x6c/0x2d8
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
> 
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

That patch fixes a different problem. The assertion shouldn't have been
made for hugetlbfs regions. I can only assume we are not triggering the
same problem.  According to your .config, DEBUG_VM is not even set so
this is some other problem.

Do you know what line triggered the problem? Eric Munson is currently
investigating this as I'm chasing down another bug but my understanding is that
right now he can't reproduce the problem. How reproducible is this for you?

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab

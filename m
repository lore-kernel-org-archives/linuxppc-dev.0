Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpJ4m01KszDqL9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 19:25:11 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5F9Nn56101021
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 05:25:10 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b3qepratk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 05:25:09 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Thu, 15 Jun 2017 19:25:02 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5F9P0Pa2228550
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 19:25:00 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5F9OxS3018284
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 19:25:00 +1000
Subject: Re: [Oops][next-20170614][] powerpc boot fails with WARNING: CPU:
 12 PID: 0 at mm/memblock.c
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Frank Rowand <frank.rowand@sony.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, linux-next
 <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, mpe <mpe@ellerman.id.au>
Date: Thu, 15 Jun 2017 14:54:56 +0530
In-Reply-To: <1497506437.15415.60.camel@abdul.in.ibm.com>
References: <1497506437.15415.60.camel@abdul.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1497518696.15415.68.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-15 at 11:30 +0530, Abdul Haleem wrote:
> Hi,
> 
> linux-next fails to boot on powerpc Bare-metal with these warnings.
> 
> machine booted fine on next-20170613

Thanks Michael, Yes it is (75fe04e59 of: remove *phandle properties from
expanded device tree)

Frank, would you please take a look at the trace.

Thanks
> 
> Test: Boot
> Machine type: Power8 Bare-metal
> Kernel : 4.12.0-rc5-next-20170614
> config: attached 
> 
> 
> Trace logs:
> -----------
>  numa:   NODE_DATA [mem 0x3fff50a300-0x3fff513fff]
>  numa:     NODE_DATA(0) on node 256
>  Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead
>  ------------[ cut here ]------------
>  WARNING: CPU: 30 PID: 0 at mm/memblock.c:1289
> memblock_virt_alloc_internal+0x94/0x204
>  Modules linked in:
>  CPU: 30 PID: 0 Comm: swapper Not tainted
> 4.12.0-rc5-next-20170614-autotest #1
>  task: c000000000f20d00 task.stack: c000000001068000
>  NIP: c000000000c47614 LR: c000000000c47610 CTR: 0000000030036a88
>  REGS: c00000000106b8e0 TRAP: 0700   Not tainted
> (4.12.0-rc5-next-20170614-autotest)
>  MSR: 9000000000021033 <SF,HV,ME,IR,DR,RI,LE>
>    CR: 24042222  XER: 20000000
>  CFAR: c00000000024e028 SOFTE: 0
>  GPR00: c000000000c47610 c00000000106bb60 c00000000106d700
> 000000000000003d
>  GPR04: 0000000000000000 c00000000008edc4 9000000000001033
> 0000000000000000
>  GPR08: 0000000000000000 c000000000f597f8 c000000000f597f8
> 9000000000001003
>  GPR12: 0000000000002200 c00000000fad3b00 0000000000000001
> 0000000002a50600
>  GPR16: 000000002ffe0000 000000000000002e 0000000000000000
> 0000000000000000
>  GPR20: 0000000000000000 0000000000000008 0000000000000100
> 0000004000000000
>  GPR24: c000000001223f68 c000003ffb460000 0000000000000000
> 0000000000000100
>  GPR28: 0000000000000000 0000004000000000 0000000000000080
> 0000003fff000000
>  NIP [c000000000c47614] memblock_virt_alloc_internal+0x94/0x204
>  LR [c000000000c47610] memblock_virt_alloc_internal+0x90/0x204
>  Call Trace:
>  [c00000000106bb60] [c000000000c47610] memblock_virt_alloc_internal
> +0x90/0x204 (unreliable)
>  [c00000000106bc10] [c000000000c49574] sparse_early_usemaps_alloc_node
> +0xc4/0x248
>  [c00000000106bcd0] [c000000000c49a9c] sparse_init+0x1c0/0x480
>  [c00000000106bd90] [c000000000c23b38] initmem_init+0x938/0xc08
>  [c00000000106be90] [c000000000c1a0e0] setup_arch+0x2c8/0x344
>  [c00000000106bf00] [c000000000c13c8c] start_kernel+0x88/0x544
>  [c00000000106bf90] [c00000000000a97c] start_here_common+0x1c/0x520
>  Instruction dump:
>  2f9b0100 40fe0034 3d42fff3 892a719c 2f890000 40fe0020 39200001 3c62ffae
>  3863b388 992a719c 4b6069dd 60000000 <0fe00000> 3b60ffff 4b648bbd
> 60000000
>  random: print_oops_end_marker+0x6c/0xa0 get_random_bytes called with
> crng_init=0
>  ---[ end trace 0000000000000000 ]---
>  Initializing IODA2 PHB (/pciex@3fffe40000000)
>  PCI host bridge /pciex@3fffe40000000 (primary) ranges:
>   MEM 0x0000200000000000..0x000020ffffffffff -> 0x0000200000000000 (M64
> #0..15)
>   Using M64 #15 as default window
>    256 (255) PE's M32: 0x10001 [segment=0x100]
>                   M64: 0x10000000000 [segment=0x100000000]
>    Allocated bitmap for 2040 MSIs (base IRQ 0x800)
>  Initializing IODA2 PHB (/pciex@3fffe40100000)
>  PCI host bridge /pciex@3fffe40100000  ranges:
>  OPAL: Reboot request...
>  MEM 0x0000210000000000..0x000021ffffffffff -> 0x0000210000000000 (M64
> #0..15)
>  Using M64 #15 as default window
>   256 (255) PE's M32: 0x10001 [segment=0x100]
>                  M64: 0x10000000000 [segment=0x100000000]
>   Allocated bitmap for 2040 MSIs (base IRQ 0x1000)
> Initializing IODA2 PHB (/pciex@3fffe40200000)
> PCI host bridge /pciex@3fffe40200000  ranges:
>  MEM 0x0000220000000000..0x000022ffffffffff -> 0x0000220000000000 (M64
> #0..15)
>  Using M64 #15 as default window
>   256 (255) PE's M32: 0x10001 [segment=0x100]
>                  M64: 0x10000000000 [segment=0x100000000]
>   Allocated bitmap for 2040 MSIs (base IRQ 0x1800)
> OPAL nvram setup, 589824 bytes
> Zone ranges:
>   DMA      [mem 0x0000000000000000-0x0000000fffffffff]
>   DMA32    empty 
>   Normal   empty 
> Movable zone start for each node
> Early memory node ranges
>   node 256: [mem 0x0000000000000000-0x0000000fffffffff]
> Could not find start_pfn for node 0
> Initmem setup node 0 [mem 0x0000000000000000-0x0000000000000000]
> Could not find start_pfn for node 1
> Initmem setup node 1 [mem 0x0000000000000000-0x0000000000000000]
> percpu: Embedded 3 pages/cpu @c000000ffe700000 s159000 r0 d37608
> u262144 
> Unable to handle kernel paging request for data at address 0x00000040
> Faulting instruction address: 0xc00000000022b4ac
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=2048 
> NUMA 
> PowerNV
> 
> CPU: 12 PID: 0 Comm: swapper Tainted: G        W
> 4.12.0-rc5-next-20170614 #1
> task: c000000000f30d00 task.stack: c00000000105c000
> NIP: c00000000022b4ac LR: c00000000022b6d0 CTR: 0000000000000000
> REGS: c00000000105fb70 TRAP: 0380   Tainted: G        W
> (4.12.0-rc5-next-20170614)
> MSR: 9000000002001033 <SF,HV,VEC,ME,IR,DR,RI,LE>
>   CR: 44022228  XER: 00000000  
> CFAR: c00000000022b6cc SOFTE: 0 
> GPR00: c00000000022b684 c00000000105fdf0 c00000000105ec00
> c000000fffd2fd00 
> GPR04: 0000000000000000 0000000000000000 c000000ffea21f88
> 4ec4ec4ec4ec4ec5 
> GPR08: 000000000000000c 0000000000000000 0000000000000000
> 0000000000000000 
> GPR12: 0000000000002200 c00000000fd44200 0000000000000001
> 0000000002900600 
> GPR16: 000000002ffc0000 000000000000002c 0000000000000000
> 0000000000000000 
> GPR20: c000000000d51f28 c000000000d51f00 0000000000000000
> c0000000010a1db8 
> GPR24: c0000000012a08a0 c0000000010a20e4 c000000000d51f30
> 0000000000000001 
> GPR28: c00000000109db78 0000000000000060 c000000ffea21f30
> 000000000000000c 
> NIP [c00000000022b4ac] local_memory_node+0x2c/0x70
> LR [c00000000022b6d0] __build_all_zonelists+0x1e0/0x290
> Call Trace:
> [c00000000105fdf0] [c00000000022b684] __build_all_zonelists+0x194/0x290
> (unreliable)
> [c00000000105fe70] [c000000000cafce0] build_all_zonelists_init+0x1c/0x3c
> [c00000000105fe90] [c0000000002d7f0c] build_all_zonelists+0x17c/0x18c
> [c00000000105ff00] [c000000000c83d5c] start_kernel+0x18c/0x53c
> [c00000000105ff90] [c00000000000b17c] start_here_common+0x1c/0x520
> Instruction dump:
> 60420000 3c4c00e3 38423780 3d22001b 392944e8 78631f24 7d29182a 81491a08 
> 38691a00 2b8a0002 41dd0010 e9230000 <e8690042> 4e800020 7c0802a6
> 38800002 
> ---[ end trace f68728a0d3053b52 ]---
> 
> Kernel panic - not syncing: Attempted to kill the idle task! 
> Rebooting in 10 seconds..
> 


-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre

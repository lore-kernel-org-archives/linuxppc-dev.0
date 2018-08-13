Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptdG24f7zDr5t
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:23:14 +1000 (AEST)
In-Reply-To: <153365139399.14256.13555279013971561179.stgit@jupiter.in.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michal Suchanek <msuchanek@suse.com>, Ananth Narayan <ananth@in.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, stable@vger.kernel.org,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [v7,
 3/9] powerpc/pseries: Fix endainness while restoring of r3 in MCE
 handler.
Message-Id: <41ptdD5YkCz9sCf@ozlabs.org>
Date: Mon, 13 Aug 2018 21:23:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-08-07 at 14:16:46 UTC, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> During Machine Check interrupt on pseries platform, register r3 points
> RTAS extended event log passed by hypervisor. Since hypervisor uses r3
> to pass pointer to rtas log, it stores the original r3 value at the
> start of the memory (first 8 bytes) pointed by r3. Since hypervisor
> stores this info and rtas log is in BE format, linux should make
> sure to restore r3 value in correct endian format.
> 
> Without this patch when MCE handler, after recovery, returns to code that
> that caused the MCE may end up with Data SLB access interrupt for invalid
> address followed by kernel panic or hang.
> 
> [   62.878965] Severe Machine check interrupt [Recovered]
> [   62.878968]   NIP [d00000000ca301b8]: init_module+0x1b8/0x338 [bork_kernel]
> [   62.878969]   Initiator: CPU
> [   62.878970]   Error type: SLB [Multihit]
> [   62.878971]     Effective address: d00000000ca70000
> cpu 0xa: Vector: 380 (Data SLB Access) at [c0000000fc7775b0]
>     pc: c0000000009694c0: vsnprintf+0x80/0x480
>     lr: c0000000009698e0: vscnprintf+0x20/0x60
>     sp: c0000000fc777830
>    msr: 8000000002009033
>    dar: a803a30c000000d0
>   current = 0xc00000000bc9ef00
>   paca    = 0xc00000001eca5c00	 softe: 3	 irq_happened: 0x01
>     pid   = 8860, comm = insmod
> [c0000000fc7778b0] c0000000009698e0 vscnprintf+0x20/0x60
> [c0000000fc7778e0] c00000000016b6c4 vprintk_emit+0xb4/0x4b0
> [c0000000fc777960] c00000000016d40c vprintk_func+0x5c/0xd0
> [c0000000fc777980] c00000000016cbb4 printk+0x38/0x4c
> [c0000000fc7779a0] d00000000ca301c0 init_module+0x1c0/0x338 [bork_kernel]
> [c0000000fc777a40] c00000000000d9c4 do_one_initcall+0x54/0x230
> [c0000000fc777b00] c0000000001b3b74 do_init_module+0x8c/0x248
> [c0000000fc777b90] c0000000001b2478 load_module+0x12b8/0x15b0
> [c0000000fc777d30] c0000000001b29e8 sys_finit_module+0xa8/0x110
> [c0000000fc777e30] c00000000000b204 system_call+0x58/0x6c
> --- Exception: c00 (System Call) at 00007fff8bda0644
> SP (7fffdfbfe980) is in userspace
> 
> This patch fixes this issue.
> 
> Fixes: a08a53ea4c97 ("powerpc/le: Enable RTAS events support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cd813e1cd7122f2c261dce5b54d1e0

cheers

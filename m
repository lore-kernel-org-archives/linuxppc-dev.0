Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5BvC4WJMzDqTp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 13:22:31 +1000 (AEST)
Date: Fri, 5 Aug 2016 13:22:20 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Reza Arbab <arbab@linux.vnet.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: mm: Initialise per_cpu_nodestats for all online pgdats at boot
Message-ID: <20160805032220.GA17119@oak.ozlabs.ibm.com>
References: <20160804092404.GI2799@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160804092404.GI2799@techsingularity.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 04, 2016 at 10:24:04AM +0100, Mel Gorman wrote:
> Paul Mackerras and Reza Arbab reported that machines with memoryless nodes
> fails when vmstats are refreshed. Paul reported an oops as follows
> 
> [    1.713998] Unable to handle kernel paging request for data at address 0xff7a10000
> [    1.714164] Faulting instruction address: 0xc000000000270cd0
> [    1.714304] Oops: Kernel access of bad area, sig: 11 [#1]
> [    1.714414] SMP NR_CPUS=2048 NUMA PowerNV
> [    1.714530] Modules linked in:
> [    1.714647] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.7.0-kvm+ #118
> [    1.714786] task: c000000ff0680010 task.stack: c000000ff0704000
> [    1.714926] NIP: c000000000270cd0 LR: c000000000270ce8 CTR: 0000000000000000
> [    1.715093] REGS: c000000ff0707900 TRAP: 0300   Not tainted  (4.7.0-kvm+)
> [    1.715232] MSR: 9000000102009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE,TM[E]>  CR: 846b6824  XER: 20000000
> [    1.715748] CFAR: c000000000008768 DAR: 0000000ff7a10000 DSISR: 42000000 SOFTE: 1
> GPR00: c000000000270d08 c000000ff0707b80 c0000000011fb200 0000000000000000
> GPR04: 0000000000000800 0000000000000000 0000000000000000 0000000000000000
> GPR08: ffffffffffffffff 0000000000000000 0000000ff7a10000 c00000000122aae0
> GPR12: c000000000a1e440 c00000000fb80000 c00000000000c188 0000000000000000
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> GPR20: 0000000000000000 0000000000000000 0000000000000000 c000000000cecad0
> GPR24: c000000000d035b8 c000000000d6cd18 c000000000d6cd18 c000001fffa86300
> GPR28: 0000000000000000 c000001fffa96300 c000000001230034 c00000000122eb18
> [    1.717484] NIP [c000000000270cd0] refresh_zone_stat_thresholds+0x80/0x240
> [    1.717568] LR [c000000000270ce8] refresh_zone_stat_thresholds+0x98/0x240
> [    1.717648] Call Trace:
> [    1.717687] [c000000ff0707b80] [c000000000270d08] refresh_zone_stat_thresholds+0xb8/0x240 (unreliable)
> 
> Both supplied potential fixes but one potentially misses checks and another
> had redundant initialisations. This version initialises per_cpu_nodestats
> on a per-pgdat basis instead of on a per-zone basis.
> 
> Reported-by: Paul Mackerras <paulus@ozlabs.org>
> Reported-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

That works, thanks.

Tested-by: Paul Mackerras <paulus@ozlabs.org>

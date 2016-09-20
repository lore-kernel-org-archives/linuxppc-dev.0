Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdjhw32yCzDsg6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 23:07:28 +1000 (AEST)
In-Reply-To: <1474306293-15390-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm: Update the FORCE_MAX_ZONEORDER range to enable hugetlb
Message-Id: <3sdjhw2Fr5z9sBr@ozlabs.org>
Date: Tue, 20 Sep 2016 23:07:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-19-09 at 17:31:33 UTC, "Aneesh Kumar K.V" wrote:
> For hugetlb to work with 4K page size, we need the MAX_ORDER to be more
> than 13. When switching from a 64K page size to 4K linux page size using
> make nconfig, we endup with a CONFIG_FORCE_MAX_ZONEORDER value of 9.
> This results in 16M hugepage to be considered as a gigantic huge page
> which inturn can result in failure to setup hugepages if gigantic
> hugepage support is not enabled.
> 
> This also results in kernel crash with 4K radix configuration. We
> hit the below BUG_ON on radix
> 
>  kernel BUG at mm/huge_memory.c:364!
>  Oops: Exception in kernel mode, sig: 5 [#1]
>  SMP NR_CPUS=2048 NUMA PowerNV
>  Modules linked in:
>  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.8.0-rc1-00006-gbae9cc6 #1
>  task: c0000000f1af8000 task.stack: c0000000f1aec000
>  NIP: c000000000c5fa0c LR: c000000000c5f9d8 CTR: c000000000c5f9a4
>  REGS: c0000000f1aef920 TRAP: 0700   Not tainted (4.8.0-rc1-00006-gbae9cc6)
>  MSR: 9000000102029033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE,TM[E]>  CR: 24000844  XER: 00000000
>  CFAR: c000000000c5f9e0 SOFTE: 1
> .....
>  NIP [c000000000c5fa0c] hugepage_init+0x68/0x238
>  LR [c000000000c5f9d8] hugepage_init+0x34/0x238
> 
> Fixes: a7ee539584acf ("powerpc/Kconfig: Update config option based on page size")
> 
> Reported-by: Santhosh <santhog4@linux.vnet.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d5a1e42cb4be016a45a787953d

cheers

Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8BEE51A0018
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 22:35:48 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Mon, 8 Feb 2016 04:35:46 -0700
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 3AC563E40030
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 04:35:32 -0700 (MST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u18BZVJB30539794
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2016 11:35:31 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u18BZTOl017434
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2016 06:35:31 -0500
Message-ID: <56B87E32.4050003@linux.vnet.ibm.com>
Date: Mon, 08 Feb 2016 17:08:26 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: tglx@linutronix.de, mingo@kernel.org, linux-mm@kvack.org,
 mpe@ellerman.id.au, hpa@zytor.com, nikunj@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
 vdavydov@parallels.com, gkurz@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, raghavendra.kt@linux.vnet.ibm.com,
 jstancek@redhat.com, benh@kernel.crashing.org, anton@samba.org,
 grant.likely@linaro.org, paulus@samba.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
CC: tip-bot for Raghavendra K T <tipbot@zytor.com>,
 linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/urgent] sched: Fix crash in sched_init_numa()
References: <1452884483-11676-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <tip-9c03ee147193645be4c186d3688232fa438c57c7@git.kernel.org>
In-Reply-To: <tip-9c03ee147193645be4c186d3688232fa438c57c7@git.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/19/2016 07:08 PM, tip-bot for Raghavendra K T wrote:
> Commit-ID:  9c03ee147193645be4c186d3688232fa438c57c7
> Gitweb:     http://git.kernel.org/tip/9c03ee147193645be4c186d3688232fa438c57c7
> Author:     Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> AuthorDate: Sat, 16 Jan 2016 00:31:23 +0530
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue, 19 Jan 2016 08:42:20 +0100
>
> sched: Fix crash in sched_init_numa()
>
> The following PowerPC commit:
>
>    c118baf80256 ("arch/powerpc/mm/numa.c: do not allocate bootmem memory for non existing nodes")
>
> avoids allocating bootmem memory for non existent nodes.
>
> But when DEBUG_PER_CPU_MAPS=y is enabled, my powerNV system failed to boot
> because in sched_init_numa(), cpumask_or() operation was done on
> unallocated nodes.
>
> Fix that by making cpumask_or() operation only on existing nodes.
>
> [ Tested with and w/o DEBUG_PER_CPU_MAPS=y on x86 and PowerPC. ]
>
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Tested-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> Cc: <gkurz@linux.vnet.ibm.com>
> Cc: <grant.likely@linaro.org>
> Cc: <nikunj@linux.vnet.ibm.com>
> Cc: <vdavydov@parallels.com>
> Cc: <linuxppc-dev@lists.ozlabs.org>
> Cc: <linux-mm@kvack.org>
> Cc: <peterz@infradead.org>
> Cc: <benh@kernel.crashing.org>
> Cc: <paulus@samba.org>
> Cc: <mpe@ellerman.id.au>
> Cc: <anton@samba.org>
> Link: http://lkml.kernel.org/r/1452884483-11676-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>   kernel/sched/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 44253ad..474658b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6840,7 +6840,7 @@ static void sched_init_numa(void)
>
>   			sched_domains_numa_masks[i][j] = mask;
>
> -			for (k = 0; k < nr_node_ids; k++) {
> +			for_each_node(k) {
>   				if (node_distance(j, k) > sched_domains_numa_distance[i])
>   					continue;
>
>
>
>

Hello Greg,
Above commit fixes the debug kernel crash in 4.4 kernel [ when
DEBUG_PER_CPU_MAPS=y to be precise]. This is a regression in 4.4 from
4.3 and should be ideally present in 4.4-stable.

Could you please pull in this change.?

Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQ67c0LXHzDrhv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Sep 2016 01:46:51 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u81Fi6LH019700
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 11:46:49 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 256cqcjnbk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Sep 2016 11:46:48 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 1 Sep 2016 12:46:46 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 9AF001DC0051
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 11:46:33 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u81FkhYZ4333646
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 12:46:43 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u81Fkhcw028493
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 12:46:43 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Rui Teng <rui.teng@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 paulus@samba.org
Subject: Re: [PATCH] powerpc: Clean up tm_abort duplication in hash_utils_64.c
Date: Thu, 01 Sep 2016 12:46:40 -0300
In-Reply-To: <1472183410-18522-1-git-send-email-rui.teng@linux.vnet.ibm.com>
References: <1472183410-18522-1-git-send-email-rui.teng@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <17335881.L5K12VaGEe@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Freitag, 26 August 2016, 11:50:10 schrieb Rui Teng:
> The same logic appears twice and should probably be pulled out into a
> function.
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Rui Teng <rui.teng@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hash_utils_64.c | 45
> +++++++++++++++++------------------------ 1 file changed, 19
> insertions(+), 26 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c
> b/arch/powerpc/mm/hash_utils_64.c index 0821556..69ef702 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -1460,6 +1460,23 @@ out_exit:
>  	local_irq_restore(flags);
>  }
> 
> +/*
> + * Transactions are not aborted by tlbiel, only tlbie.
> + * Without, syncing a page back to a block device w/ PIO could pick up
> + * transactional data (bad!) so we force an abort here.  Before the
> + * sync the page will be made read-only, which will flush_hash_page.
> + * BIG ISSUE here: if the kernel uses a page from userspace without
> + * unmapping it first, it may see the speculated version.
> + */
> +void local_tm_abort(int local)
> +{
> +	if (local && cpu_has_feature(CPU_FTR_TM) && current->thread.regs &&
> +		MSR_TM_ACTIVE(current->thread.regs->msr)) {
> +		tm_enable();
> +		tm_abort(TM_CAUSE_TLBI);
> +	}
> +}
> +

Since local_tm_abort is only used in this file, it should be static.

Also, since both places calling it are guarded by 
CONFIG_PPC_TRANSACTIONAL_MEM, wouldn't it be cleaner if the #ifdef was here 
instead and the #else block defined an empty static inline function? Then 
the call sites wouldn't need to be guarded.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center

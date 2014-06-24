Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB5131A000D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 22:12:48 +1000 (EST)
Message-ID: <53A96B3B.7070601@suse.de>
Date: Tue, 24 Jun 2014 14:12:43 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v4] KVM: PPC: e500mc: Enhance tlb invalidation condition
 on vcpu schedule
References: <1403075722-11151-1-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1403075722-11151-1-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 18.06.14 09:15, Mihai Caraman wrote:
> On vcpu schedule, the condition checked for tlb pollution is too loose.
> The tlb entries of a vcpu become polluted (vs stale) only when a different
> vcpu within the same logical partition runs in-between. Optimize the tlb
> invalidation condition keeping last_vcpu per logical partition id.
>
> With the new invalidation condition, a guest shows 4% performance improvement
> on P5020DS while running a memory stress application with the cpu oversubscribed,
> the other guest running a cpu intensive workload.
>
> Guest - old invalidation condition
>    real 3.89
>    user 3.87
>    sys 0.01
>
> Guest - enhanced invalidation condition
>    real 3.75
>    user 3.73
>    sys 0.01
>
> Host
>    real 3.70
>    user 1.85
>    sys 0.00
>
> The memory stress application accesses 4KB pages backed by 75% of available
> TLB0 entries:
>
> char foo[ENTRIES][4096] __attribute__ ((aligned (4096)));
>
> int main()
> {
> 	char bar;
> 	int i, j;
>
> 	for (i = 0; i < ITERATIONS; i++)
>          	for (j = 0; j < ENTRIES; j++)
>              		bar = foo[j][0];
>
> 	return 0;
> }
>
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> Cc: Scott Wood <scottwood@freescale.com>

Thanks, applied to kvm-ppc-queue.


Alex

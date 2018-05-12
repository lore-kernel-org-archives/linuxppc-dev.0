Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com
 [IPv6:2607:f8b0:400c:c08::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40jSfY6ycczF32K
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2018 10:35:17 +1000 (AEST)
Received: by mail-ua0-x244.google.com with SMTP id a3-v6so4715223uad.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 17:35:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1526046222-17842-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1526046222-17842-1-git-send-email-anju@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Sat, 12 May 2018 10:35:13 +1000
Message-ID: <CAKTCnzn1QmirDJNOJ5hVB0wKE-wpVLePivZocZ8g0e+sA4O7Wg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/perf: Fix memory allocation for core-imc based on
 num_possible_cpus()
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, ppaidipe@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 11, 2018 at 11:43 PM, Anju T Sudhakar
<anju@linux.vnet.ibm.com> wrote:
> Currently memory is allocated for core-imc based on cpu_present_mask, which has
> bit 'cpu' set iff cpu is populated. We use  (cpu number / threads per core)
> as as array index to access the memory.
> So in a system with guarded cores, since allocation happens based on
> cpu_present_mask, (cpu number / threads per core) bounds the index and leads
> to memory overflow.
>
> The issue is exposed in a guard test.
> The guard test will make some CPU's as un-available to the system during boot
> time as well as at runtime. So when the cpu is unavailable to the system during
> boot time, the memory allocation happens depending on the number of available
> cpus. And when we access the memory using (cpu number / threads per core) as the
> index the system crashes due to memory overflow.
>
> Allocating memory for core-imc based on cpu_possible_mask, which has
> bit 'cpu' set iff cpu is populatable, will fix this issue.
>
> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/imc-pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

The changelog does not clearly call out the confusion between present
and possible.
Guarded CPUs are possible but not present, so it blows a hole when we assume the
max length of our allocation is driven by our max present cpus, where
as one of the cpus
might be online and be beyond the max present cpus, due to the hole..

Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh.

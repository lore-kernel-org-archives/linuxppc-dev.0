Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x243.google.com (mail-vk0-x243.google.com
 [IPv6:2607:f8b0:400c:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvqRf66pRzDrf5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 17:16:30 +1100 (AEDT)
Received: by mail-vk0-x243.google.com with SMTP id k187so9073916vke.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Mar 2018 22:16:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1520164518-19097-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1520164518-19097-1-git-send-email-maddy@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 5 Mar 2018 17:16:26 +1100
Message-ID: <CAKTCnzmY3-n3ZxdUJb_yE_K4sY93j+DfaDVEPBKaGUo_dgbaQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/perf: Fix kernel address leak to userspace
 via BHRB buffer
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 4, 2018 at 10:55 PM, Madhavan Srinivasan
<maddy@linux.vnet.ibm.com> wrote:
> The current Branch History Rolling Buffer (BHRB) code does
> not check for any privilege levels before updating the data
> from BHRB. This leaks kernel addresses to userspace even when
> profiling only with userspace privileges. Add proper checks
> to prevent it.
>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/core-book3s.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index f89bbd54ecec..337db5831749 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -457,6 +457,10 @@ static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
>                                 /* invalid entry */
>                                 continue;
>
> +                       if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN) &&
> +                               is_kernel_addr(addr))
> +                               continue;
> +


Looks good to me. The scope of the leaks concern is KASLR related or
something else (figuring out what's in the cache?)

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh.

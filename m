Return-Path: <bsingharora@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTsZS1XGrzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 11:35:12 +1100 (AEDT)
Received: by mail-wr0-x241.google.com with SMTP id g10so344605wrg.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 16:35:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170223105443.22029-1-svaidy@linux.vnet.ibm.com>
References: <20170223105443.22029-1-svaidy@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 24 Feb 2017 11:35:08 +1100
Message-ID: <CAKTCnz=DiF+CAWTtsYwjUN1HGD7=qNMDXbPiNi0__DY31kqNLQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/xics: Adjust interrupt receive priority for
 offline cpus
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 23, 2017 at 9:54 PM, Vaidyanathan Srinivasan
<svaidy@linux.vnet.ibm.com> wrote:
> Offline CPUs need to receive IPIs through XIVE when they are
> in stop state and wakeup from that state.
>
> Reduce interrupt receive priority in order to receive XIVE
> wakeup interrupts when in offline state.
>
> LOWEST_PRIORITY would allow all interrupts to be delivered
> as wakeup events.
>
> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/sysdev/xics/xics-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
> index 69d858e..c674a9d 100644
> --- a/arch/powerpc/sysdev/xics/xics-common.c
> +++ b/arch/powerpc/sysdev/xics/xics-common.c
> @@ -199,7 +199,7 @@ void xics_migrate_irqs_away(void)
>         xics_set_cpu_giq(xics_default_distrib_server, 0);
>
>         /* Allow IPIs again... */
> -       icp_ops->set_priority(DEFAULT_PRIORITY);
> +       icp_ops->set_priority(LOWEST_PRIORITY);
>

Aren't IPI's at higher priority than DEFAULT_PRIORITY? Like Mikey said
I am not sure what
is broken with the current implementation? Is this true for all
icp_ops? I presume you are using
icp_opal. I suspect you'll need to look at

1. XIVE to see if EMULATION_PRIO is the issue
2. Check if only icp_opal is impacted

Balbir Singh.

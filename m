Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x242.google.com (mail-ua0-x242.google.com
 [IPv6:2607:f8b0:400c:c08::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zfvn45F8XzF0lC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 16:46:45 +1100 (AEDT)
Received: by mail-ua0-x242.google.com with SMTP id d4so4222238uak.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 21:46:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b3202827b5f22e9a7e8f145f83140698911641f7.1518394650.git.sam.bobroff@au1.ibm.com>
References: <b3202827b5f22e9a7e8f145f83140698911641f7.1518394650.git.sam.bobroff@au1.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 12 Feb 2018 16:46:41 +1100
Message-ID: <CAKTCnzkzJmi5Yxnz+YhcOf1VaROvkGBp_-D_DM+43+8E361D8Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] powerpc/pseries: Enable RAS hotplug events late
To: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Balbir Singh <bsingharora@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 12, 2018 at 11:19 AM, Sam Bobroff <sam.bobroff@au1.ibm.com> wrote:
> Currently if the kernel receives a memory hot-unplug event early
> enough, it may get stuck in an infinite loop in
> dissolve_free_huge_pages(). This appears as a stall just after:
>
> pseries-hotplug-mem: Attempting to hot-remove XX LMB(s) at YYYYYYYY
>
> It appears to be caused by "minimum_order" being uninitialized, due to
> init_ras_IRQ() executing before hugetlb_init().
>
> To correct this, extract the part of init_ras_IRQ() that enables
> hotplug event processing and place it in the machine_late_initcall
> phase, which is guaranteed to be after hugetlb_init() is called.
>
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/ras.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index 81d8614e7379..ba284949af06 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -66,6 +66,26 @@ static int __init init_ras_IRQ(void)
>                 of_node_put(np);
>         }
>
> +       /* EPOW Events */
> +       np = of_find_node_by_path("/event-sources/epow-events");
> +       if (np != NULL) {
> +               request_event_sources_irqs(np, ras_epow_interrupt, "RAS_EPOW");
> +               of_node_put(np);
> +       }
> +
> +       return 0;
> +}
> +machine_subsys_initcall(pseries, init_ras_IRQ);
> +
> +/*
> + * Enable the hotplug interrupt late because processing them may touch other
> + * devices or systems (e.g. hugepages) that have not been initialized at the
> + * subsys stage.
> + */
> +int __init init_ras_hotplug_IRQ(void)
> +{
> +       struct device_node *np;
> +
>         /* Hotplug Events */
>         np = of_find_node_by_path("/event-sources/hot-plug-events");
>         if (np != NULL) {
> @@ -75,16 +95,9 @@ static int __init init_ras_IRQ(void)
>                 of_node_put(np);
>         }
>
> -       /* EPOW Events */
> -       np = of_find_node_by_path("/event-sources/epow-events");
> -       if (np != NULL) {
> -               request_event_sources_irqs(np, ras_epow_interrupt, "RAS_EPOW");
> -               of_node_put(np);
> -       }
> -
>         return 0;
>  }
> -machine_subsys_initcall(pseries, init_ras_IRQ);
> +machine_late_initcall(pseries, init_ras_hotplug_IRQ);
>

Seems reasonable to me, the other RAS events internal error and epow
seem like they are in the right place.

Acked-by: Balbir Singh <bsingharora@gmail.com>

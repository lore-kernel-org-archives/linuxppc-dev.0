Return-Path: <robherring2@gmail.com>
Received: from mail-wg0-x22f.google.com (mail-wg0-x22f.google.com
 [IPv6:2a00:1450:400c:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 083401A01CB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 23:22:50 +1000 (AEST)
Received: by wgsk9 with SMTP id k9so80587403wgs.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 06:22:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150408165920.25007.6869.stgit@buzz>
References: <20150408165920.25007.6869.stgit@buzz>
From: Rob Herring <robherring2@gmail.com>
Date: Mon, 13 Apr 2015 08:22:26 -0500
Message-ID: <CAL_JsqKQPtNPfTAiqsKnFuU6e-qozzPgujM=8MHseG75R9cbSA@mail.gmail.com>
Subject: Re: [PATCH] of: return NUMA_NO_NODE from fallback of_node_to_nid()
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 sparclinux@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 8, 2015 at 11:59 AM, Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
> Node 0 might be offline as well as any other numa node,
> in this case kernel cannot handle memory allocation and crashes.
>
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: 0c3f061c195c ("of: implement of_node_to_nid as a weak function")
> ---
>  drivers/of/base.c  |    2 +-
>  include/linux/of.h |    5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 8f165b112e03..51f4bd16e613 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -89,7 +89,7 @@ EXPORT_SYMBOL(of_n_size_cells);
>  #ifdef CONFIG_NUMA
>  int __weak of_node_to_nid(struct device_node *np)
>  {
> -       return numa_node_id();
> +       return NUMA_NO_NODE;

This is going to break any NUMA machine that enables OF and expects
the weak function to work.

Rob

>  }
>  #endif
>
> diff --git a/include/linux/of.h b/include/linux/of.h
> index dfde07e77a63..78a04ee85a9c 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -623,7 +623,10 @@ static inline const char *of_prop_next_string(struct property *prop,
>  #if defined(CONFIG_OF) && defined(CONFIG_NUMA)
>  extern int of_node_to_nid(struct device_node *np);
>  #else
> -static inline int of_node_to_nid(struct device_node *device) { return 0; }
> +static inline int of_node_to_nid(struct device_node *device)
> +{
> +       return NUMA_NO_NODE;
> +}
>  #endif
>
>  static inline struct device_node *of_find_matching_node(
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

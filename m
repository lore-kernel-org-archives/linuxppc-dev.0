Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0126.outbound.protection.outlook.com [65.55.169.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39A821A0B37
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 14:11:37 +1100 (AEDT)
Message-ID: <1445569881.701.143.camel@freescale.com>
Subject: Re: [PATCH v12 5/6] QE: use subsys_initcall to init qe
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <qiang.zhao@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <lauraa@codeaurora.org>, <X.xie@freescale.com>, <benh@kernel.crashing.org>,
 <leoli@freescale.com>, <paulus@samba.org>
Date: Thu, 22 Oct 2015 22:11:21 -0500
In-Reply-To: <1444806968-4627-5-git-send-email-qiang.zhao@freescale.com>
References: <1444806968-4627-1-git-send-email-qiang.zhao@freescale.com>
 <1444806968-4627-5-git-send-email-qiang.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-10-14 at 15:16 +0800, Zhao Qiang wrote:
> diff --git a/arch/powerpc/sysdev/qe_lib/qe.c > b/arch/powerpc/sysdev/qe_lib/qe.c
> index c2518cd..3f9f596 100644
> --- a/arch/powerpc/sysdev/qe_lib/qe.c
> +++ b/arch/powerpc/sysdev/qe_lib/qe.c
> @@ -671,6 +671,21 @@ unsigned int qe_get_num_of_snums(void)
>  }
>  EXPORT_SYMBOL(qe_get_num_of_snums);
>  
> +static int __init qe_init(void)
> +{
> +     struct device_node *np;
> +
> +     np = of_find_compatible_node(NULL, NULL, "fsl,qe");
> +     if (!np) {
> +             pr_err("%s: Could not find Quicc Engine node\n", __func__);
> +             return -ENODEV;
> +     }
> +     qe_reset();
> +     of_node_put(np);
> +     return 0;
> +}
> +subsys_initcall(qe_init);

Do not print an error, just because QE is not present.

-Scott

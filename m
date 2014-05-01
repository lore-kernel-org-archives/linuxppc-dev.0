Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] PPC: BOOK3S: Disable/Enable TM looking at the ibm,
 pa-features device tree entry
In-reply-to: <1398845480-9945-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1398845480-9945-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 01 May 2014 15:01:40 +1000
Message-ID: <20060.1398920500@ale.ozlabs.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Runtime disable transactional memory feature looking at pa-features
> device tree entry. This provides a mechanism to disable TM on P8
> systems.

What are we actually achieving with this?

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/prom.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 668aa4791fd7..537bd7e7db0b 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -161,6 +161,11 @@ static struct ibm_pa_feature {
>  	{CPU_FTR_NODSISRALIGN, 0, 0,	1, 1, 1},
>  	{0, MMU_FTR_CI_LARGE_PAGE, 0,	1, 2, 0},
>  	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 5, 0, 0},
> +	/*
> +	 * We should use CPU_FTR_TM_COMP so that if we disable TM, it won't get
> +	 * enabled via device tree
> +	 */
> +	{CPU_FTR_TM_COMP, 0, 0,		22, 0, 0},

What does this do to guests?  Will it turn TM unavailable into an
illegal instruction?

Mikey



>  };
>  
>  static void __init scan_features(unsigned long node, unsigned char *ftrs,
> -- 
> 1.9.1
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

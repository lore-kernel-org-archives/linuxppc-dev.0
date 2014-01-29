Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2CCFB2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 04:37:22 +1100 (EST)
Message-ID: <52E93C4D.8050609@suse.de>
Date: Wed, 29 Jan 2014 18:37:17 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 10/10] PPC: BOOK3S: Disable/Enable TM looking at the
 ibm,pa-features device tree entry
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390927455-3312-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1390927455-3312-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/28/2014 05:44 PM, Aneesh Kumar K.V wrote:
> Runtime disable transactional memory feature looking at pa-features
> device tree entry. We need to do this so that we can run a kernel
> built with TM config in PR mode. For PR guest we provide a device
> tree entry with TM feature disabled in pa-features
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

We need to be able to run kernels without this patch, so better fix TM 
for good - worst case by always aborting transactions.


Alex

> ---
>   arch/powerpc/kernel/prom.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index fa0ad8aafbcc..de8c2caf1024 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -160,6 +160,11 @@ static struct ibm_pa_feature {
>   	{CPU_FTR_NODSISRALIGN, 0, 0,	1, 1, 1},
>   	{0, MMU_FTR_CI_LARGE_PAGE, 0,	1, 2, 0},
>   	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 5, 0, 0},
> +	/*
> +	 * We should use CPU_FTR_TM_COMP so that if we disable TM, it won't get
> +	 * enabled via device tree
> +	 */
> +	{CPU_FTR_TM_COMP, 0, 0,		22, 0, 0},
>   };
>   
>   static void __init scan_features(unsigned long node, unsigned char *ftrs,

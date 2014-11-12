Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 73A121A0179
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 11:44:06 +1100 (AEDT)
Message-ID: <1415753046.5175.22.camel@neuling.org>
Subject: Re: [PATCH V2] powerpc/TM: Disable/Enable TM looking at the ibm,
 pa-features device tree entry
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 12 Nov 2014 11:44:06 +1100
In-Reply-To: <1414938762-20126-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1414938762-20126-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-11-02 at 20:02 +0530, Aneesh Kumar K.V wrote:
> Runtime disable transactional memory feature looking at pa-features
> device tree entry. We need to do this so that we can run a kernel
> built with TM config in PR mode.=20

I'm happy to turn this off but why do we need to do this in PR mode?
Can you explain this in the commit message.

> For PR guest we provide a device
> tree entry with TM feature disabled in pa-features

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
> Changes from V1:
> * rebase to latest linus
>=20
>  arch/powerpc/kernel/prom.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 099f27e6d1b0..3e22930f15d1 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -160,6 +160,11 @@ static struct ibm_pa_feature {
>  	{CPU_FTR_NODSISRALIGN, 0, 0,	1, 1, 1},
>  	{0, MMU_FTR_CI_LARGE_PAGE, 0,	1, 2, 0},
>  	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 5, 0, 0},
> +	/*
> +	 * We should use CPU_FTR_TM_COMP so that if we disable TM, it won't get
> +	 * enabled via device tree
> +	 */
> +	{CPU_FTR_TM_COMP, 0, 0,		22, 0, 0},
>  };
> =20
>  static void __init scan_features(unsigned long node, const unsigned char=
 *ftrs,

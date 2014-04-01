Return-Path: <benh@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3EED9140099
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2014 20:47:02 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 1 Apr 2014 19:46:59 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CF488357803F
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2014 20:46:56 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s319kgEn10748348
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Apr 2014 20:46:42 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s319ktXb009897
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Apr 2014 20:46:56 +1100
Message-ID: <1396345609.28055.7.camel@pasglop>
Subject: Re: [PATCH REPOST v5 1/3] powernv, cpufreq: Select CPUFreq related
 Kconfig options for powernv
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Date: Tue, 01 Apr 2014 20:46:49 +1100
In-Reply-To: <1396336408-20954-3-git-send-email-ego@linux.vnet.ibm.com>
References: <CAKohpo=jvswNPmUPEbS79bSp9ZWC1e3DjaEUX=O4CWMXfufHrw@mail.gmail.com>
 <1396336408-20954-1-git-send-email-ego@linux.vnet.ibm.com>
 <1396336408-20954-3-git-send-email-ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Linux PM list <linux-pm@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@samba.org>, srivatsa.bhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-04-01 at 12:43 +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Enable CPUFreq for PowerNV. Select "performance", "powersave",
> "userspace" and "ondemand" governors. Choose "ondemand" to be the
> default governor.

Rafael, are you going to take these or should I send them to Linus ?

(I'd rather you take them :-)

Cheers,
Ben.

> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
>  arch/powerpc/configs/pseries_defconfig    | 1 +
>  arch/powerpc/configs/pseries_le_defconfig | 1 +
>  arch/powerpc/platforms/powernv/Kconfig    | 6 ++++++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
> index 9ea8342b..a905063 100644
> --- a/arch/powerpc/configs/pseries_defconfig
> +++ b/arch/powerpc/configs/pseries_defconfig
> @@ -306,3 +306,4 @@ CONFIG_KVM_BOOK3S_64=m
>  CONFIG_KVM_BOOK3S_64_HV=y
>  CONFIG_TRANSPARENT_HUGEPAGE=y
>  CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
> +CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> diff --git a/arch/powerpc/configs/pseries_le_defconfig b/arch/powerpc/configs/pseries_le_defconfig
> index 3c84f9d..58e3dbf 100644
> --- a/arch/powerpc/configs/pseries_le_defconfig
> +++ b/arch/powerpc/configs/pseries_le_defconfig
> @@ -301,3 +301,4 @@ CONFIG_CRYPTO_LZO=m
>  # CONFIG_CRYPTO_ANSI_CPRNG is not set
>  CONFIG_CRYPTO_DEV_NX=y
>  CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
> +CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
> index 895e8a2..c252ee9 100644
> --- a/arch/powerpc/platforms/powernv/Kconfig
> +++ b/arch/powerpc/platforms/powernv/Kconfig
> @@ -11,6 +11,12 @@ config PPC_POWERNV
>  	select PPC_UDBG_16550
>  	select PPC_SCOM
>  	select ARCH_RANDOM
> +	select CPU_FREQ
> +	select CPU_FREQ_GOV_PERFORMANCE
> +	select CPU_FREQ_GOV_POWERSAVE
> +	select CPU_FREQ_GOV_USERSPACE
> +	select CPU_FREQ_GOV_ONDEMAND
> +	select CPU_FREQ_GOV_CONSERVATIVE
>  	default y
>  
>  config PPC_POWERNV_RTAS

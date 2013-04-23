Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E562E2C010E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 09:53:28 +1000 (EST)
Date: Tue, 23 Apr 2013 18:53:20 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 02/15] powerpc/85xx: add sleep and deep sleep support
To: Zhao Chenhui <chenhui.zhao@freescale.com>
In-Reply-To: <1366368468-29143-2-git-send-email-chenhui.zhao@freescale.com>
 (from chenhui.zhao@freescale.com on Fri Apr 19 05:47:35 2013)
Message-ID: <1366761200.5825.18@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/19/2013 05:47:35 AM, Zhao Chenhui wrote:
>  static int pmc_suspend_enter(suspend_state_t state)
>  {
> -	int ret;
> +	int ret =3D 0;
> +
> +	switch (state) {
> +#ifdef CONFIG_PPC_85xx
> +	case PM_SUSPEND_MEM:
> +#ifdef CONFIG_SPE
> +		enable_kernel_spe();
> +#endif
> +		enable_kernel_fp();

Why does enable_kernel_spe() need an ifdef but enable_kernel_fp() =20
doesn't?

> +	case PM_SUSPEND_STANDBY:
> +#ifdef CONFIG_FSL_SOC_BOOKE
> +		flush_dcache_L1();
> +#endif
> +		setbits32(&pmc_regs->powmgtcsr, POWMGTCSR_SLP);

Only L1, even on e500mc?

-Scott=

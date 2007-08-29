Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 69CF8DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 09:05:41 +1000 (EST)
In-Reply-To: <46D40510.3060805@scram.de>
References: <46D40510.3060805@scram.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <611B8BA7-89B3-4DA0-A248-0FB57E4654ED@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ppc32/8xx: Fix r3 trashing due to 8MB TLB page
	instantiation
Date: Wed, 29 Aug 2007 18:08:00 -0500
To: Jochen Friedrich <jochen@scram.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 28, 2007, at 6:20 AM, Jochen Friedrich wrote:

> Instantiation of 8MB pages on the TLB cache for the kernel static
> mapping trashes r3 register on !CONFIG_8xx_CPU6 configurations.
> This ensures r3 gets saved and restored.
>
> This has been posted to linuxppc-embedded by Marcelo Tosatti
> <marcelo@kvack.org>, but only an incomplete version of the patch
> has been applied in c51e078f82096a7d35ac8ec2416272e843a0e1c4.
> This patch adds the rest of the fix.
>
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
>  arch/ppc/kernel/head_8xx.S |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> This can be pulled from git://git.bocc.de/dbox2.git ppc-fixes
> diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
> index 944c35c..eb8d26f 100644
> --- a/arch/ppc/kernel/head_8xx.S
> +++ b/arch/ppc/kernel/head_8xx.S
> @@ -495,9 +495,7 @@ LoadLargeDTLB:
>  	lwz	r11, 4(r0)
>
>  	lwz	r12, 16(r0)
> -#ifdef CONFIG_8xx_CPU6
>  	lwz	r3, 8(r0)
> -#endif
>  	rfi
>
>  /* This is the data TLB error on the MPC8xx.  This could be due to

do we need this in arch/powerpc as well?

- k

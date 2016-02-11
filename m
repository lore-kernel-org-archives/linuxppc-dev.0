Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0E1A1A0019
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 14:22:45 +1100 (AEDT)
Message-ID: <1455160957.2463.14.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>, Kumar Gala
 <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 10 Feb 2016 21:22:37 -0600
In-Reply-To: <1455096160-5868-1-git-send-email-alessio.bogani@elettra.eu>
References: <1455096160-5868-1-git-send-email-alessio.bogani@elettra.eu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: powerpc/86xx: Use config fragments approach
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-02-10 at 10:22 +0100, Alessio Igor Bogani wrote:
> Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
> ---
>  arch/powerpc/Makefile                            |  10 +
>  arch/powerpc/configs/86xx-32bit.config           |   4 +
>  arch/powerpc/configs/86xx-hw.config              | 106 +++++++++
>  arch/powerpc/configs/86xx-smp.config             |   2 +
>  arch/powerpc/configs/86xx/gef_ppc9a_defconfig    | 216 ------------------
>  arch/powerpc/configs/86xx/gef_sbc310_defconfig   | 214 ------------------
>  arch/powerpc/configs/86xx/gef_sbc610_defconfig   | 273 --------------------
> ---
>  arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig | 110 ---------
>  arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig | 156 -------------
>  arch/powerpc/configs/86xx/sbc8641d_defconfig     | 246 --------------------
>  arch/powerpc/configs/mpc86xx_basic_defconfig     |   6 +
>  arch/powerpc/configs/mpc86xx_defconfig           | 162 --------------
>  12 files changed, 128 insertions(+), 1377 deletions(-)
>  create mode 100644 arch/powerpc/configs/86xx-32bit.config
>  create mode 100644 arch/powerpc/configs/86xx-hw.config
>  create mode 100644 arch/powerpc/configs/86xx-smp.config
>  delete mode 100644 arch/powerpc/configs/86xx/gef_ppc9a_defconfig
>  delete mode 100644 arch/powerpc/configs/86xx/gef_sbc310_defconfig
>  delete mode 100644 arch/powerpc/configs/86xx/gef_sbc610_defconfig
>  delete mode 100644 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig
>  delete mode 100644 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig
>  delete mode 100644 arch/powerpc/configs/86xx/sbc8641d_defconfig
>  create mode 100644 arch/powerpc/configs/mpc86xx_basic_defconfig
>  delete mode 100644 arch/powerpc/configs/mpc86xx_defconfig

Why do your patches not start with [PATCH]?

How does the resulting config compare to the individual previous configs?  Are
there any options that were dropped from the union of the old configs? 
 Mutually exclusive options that had to be resolved one way or another? 
 Changes in non-hw options?

It would be nice to do what I did with 85xx in commit 7e2ad2ef851, and start
with a patch that makes the defconfigs conform to what the new approach will
give (to more easily see what is changing), and then have the next patch
switch to fragments.

> diff --git a/arch/powerpc/configs/86xx-32bit.config
> b/arch/powerpc/configs/86xx-32bit.config
> new file mode 100644
> index 0000000..8a2c6ff
> --- /dev/null
> +++ b/arch/powerpc/configs/86xx-32bit.config
> @@ -0,0 +1,4 @@
> +CONFIG_HIGHMEM=y
> +CONFIG_KEXEC=y
> +CONFIG_PPC_86xx=y
> +CONFIG_PROC_KCORE=y

Why is this not in mpc86xx_basic_defconfig?  There is no 64-bit 86xx.

-Scott

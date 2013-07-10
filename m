Return-Path: <R65777@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 98B9A2C029E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 15:21:25 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [v3][PATCH 7/8] book3e/kexec/kdump: redefine VIRT_PHYS_OFFSET
Date: Wed, 10 Jul 2013 05:20:24 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D070AE138@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1373357007-30785-1-git-send-email-tiejun.chen@windriver.com>
 <1373357007-30785-8-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1373357007-30785-8-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Tie=
jun Chen
> Sent: Tuesday, July 09, 2013 1:33 PM
> To: benh@kernel.crashing.org
> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
> Subject: [v3][PATCH 7/8] book3e/kexec/kdump: redefine VIRT_PHYS_OFFSET
>=20
> Book3e is always aligned 1GB to create TLB so we should
> use (KERNELBASE - MEMORY_START) as VIRT_PHYS_OFFSET to
> get __pa/__va properly while boot kdump.
>=20
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/include/asm/page.h |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/p=
age.h
> index 988c812..5b00081 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -112,6 +112,8 @@ extern long long virt_phys_offset;
>  /* See Description below for VIRT_PHYS_OFFSET */
>  #ifdef CONFIG_RELOCATABLE_PPC32
>  #define VIRT_PHYS_OFFSET virt_phys_offset
> +#elif defined(CONFIG_PPC_BOOK3E_64)
> +#define VIRT_PHYS_OFFSET (KERNELBASE - MEMORY_START)

Can you please explain this code a bit more. I am not understanding this pa=
rt:)

-Bharat

>  #else
>  #define VIRT_PHYS_OFFSET (KERNELBASE - PHYSICAL_START)
>  #endif
> --
> 1.7.9.5
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

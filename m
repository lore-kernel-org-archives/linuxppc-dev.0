Return-Path: <york.sun@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnSLM2B0DzDrKj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 01:34:17 +1000 (AEST)
From: York Sun <york.sun@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
CC: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>, "linuxppc-dev
 linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] fsl_pci: Correct fsl_pci_mcheck_exception
Date: Wed, 6 Sep 2017 15:34:11 +0000
Message-ID: <VI1PR04MB20787FDC28E53BF15DF8E3949A970@VI1PR04MB2078.eurprd04.prod.outlook.com>
References: <20170905115943.19919-1-joakim.tjernlund@infinera.com>
Reply-To: York Sun <york.sun@nxp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/05/2017 04:59 AM, Joakim Tjernlund wrote:=0A=
> get_user() had it args reversed causing NIP to be NULL:ed instead=0A=
> of fixing up the PCI access.=0A=
> =0A=
> Note: This still hangs my P1020 Freescale CPU hard, but at least=0A=
> I get a NIP now.=0A=
> =0A=
> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>=0A=
> ---=0A=
>   arch/powerpc/sysdev/fsl_pci.c | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.=
c=0A=
> index 7c8b779c329a..9e64c12dff6a 100644=0A=
> --- a/arch/powerpc/sysdev/fsl_pci.c=0A=
> +++ b/arch/powerpc/sysdev/fsl_pci.c=0A=
> @@ -996,7 +996,7 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)=0A=
>   	if (is_in_pci_mem_space(addr)) {=0A=
>   		if (user_mode(regs)) {=0A=
>   			pagefault_disable();=0A=
> -			ret =3D get_user(regs->nip, &inst);=0A=
> +			ret =3D get_user(inst, (__u32 __user *)regs->nip);=0A=
>   			pagefault_enable();=0A=
>   		} else {=0A=
>   			ret =3D probe_kernel_address(regs->nip, inst);=0A=
> =0A=
=0A=
Leo,=0A=
=0A=
Can you take a look, or assign it to someone who is familiar with this code=
?=0A=
=0A=
York=0A=

Return-Path: <bharat.bhushan@nxp.com>
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70040.outbound.protection.outlook.com [40.107.7.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414ZNT5bGxzF43B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 12:59:18 +1000 (AEST)
From: Bharat Bhushan <bharat.bhushan@nxp.com>
To: Diana Madalina Craciun <diana.craciun@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "oss@buserror.net"
 <oss@buserror.net>, Leo Li <leoyang.li@nxp.com>, Diana Madalina Craciun
 <diana.craciun@nxp.com>
Subject: RE: [PATCH v2 3/3] powerpc/fsl: Implement cpu_show_spectre_v1/v2 for
 NXP PowerPC Book3E
Date: Tue, 12 Jun 2018 02:59:11 +0000
Message-ID: <AM5PR0401MB2545BC30FB194E4D4E42ADA89A7F0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1528721608-15443-1-git-send-email-diana.craciun@nxp.com>
 <1528721608-15443-4-git-send-email-diana.craciun@nxp.com>
In-Reply-To: <1528721608-15443-4-git-send-email-diana.craciun@nxp.com>
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

Hi Diana,

> -----Original Message-----
> From: Diana Craciun [mailto:diana.craciun@nxp.com]
> Sent: Monday, June 11, 2018 6:23 PM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: mpe@ellerman.id.au; oss@buserror.net; Leo Li <leoyang.li@nxp.com>;
> Bharat Bhushan <bharat.bhushan@nxp.com>; Diana Madalina Craciun
> <diana.craciun@nxp.com>
> Subject: [PATCH v2 3/3] powerpc/fsl: Implement cpu_show_spectre_v1/v2 for
> NXP PowerPC Book3E

Please add some description

>=20
> Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
> ---
>  arch/powerpc/Kconfig           |  2 +-
>  arch/powerpc/kernel/security.c | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig index
> 940c955..a781d60 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -170,7 +170,7 @@ config PPC
>  	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
>  	select GENERIC_CMOS_UPDATE
>  	select GENERIC_CPU_AUTOPROBE
> -	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64
> +	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64 ||
> PPC_FSL_BOOK3E
>  	select GENERIC_IRQ_SHOW
>  	select GENERIC_IRQ_SHOW_LEVEL
>  	select GENERIC_SMP_IDLE_THREAD
> diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/securit=
y.c
> index 797c975..aceaadc 100644
> --- a/arch/powerpc/kernel/security.c
> +++ b/arch/powerpc/kernel/security.c
> @@ -183,3 +183,18 @@ ssize_t cpu_show_spectre_v2(struct device *dev,
> struct device_attribute *attr, c  }  #endif /* CONFIG_PPC_BOOK3S_64 */
>=20
> +#ifdef CONFIG_PPC_FSL_BOOK3E
> +ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute
> +*attr, char *buf) {
> +	if (barrier_nospec_enabled)
> +		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
> +
> +	return sprintf(buf, "Vulnerable\n");
> +}
> +
> +ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute
> +*attr, char *buf) {
> +	return sprintf(buf, "Vulnerable\n");
> +}
> +#endif /* CONFIG_PPC_FSL_BOOK3E */
> +
> --
> 2.5.5

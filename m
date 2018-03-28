Return-Path: <srs0=q3o0=gs=nxp.com=diana.craciun@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B2KN1b0JzF2J7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 20:15:20 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40B2KM2qXDz8wMB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 20:15:19 +1100 (AEDT)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30058.outbound.protection.outlook.com [40.107.3.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40B2KK1rMmz9s08
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2018 20:15:15 +1100 (AEDT)
From: Diana Madalina Craciun <diana.craciun@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>
CC: "mauricfo@linux.vnet.ibm.com" <mauricfo@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 10/10] powerpc/64s: Wire up cpu_show_spectre_v2()
Date: Wed, 28 Mar 2018 09:15:10 +0000
Message-ID: <HE1PR0401MB263432C57661741B3C4DE153FFA30@HE1PR0401MB2634.eurprd04.prod.outlook.com>
References: <20180327120153.31612-1-mpe@ellerman.id.au>
 <20180327120153.31612-10-mpe@ellerman.id.au>
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

Why is the speculation barrier specific to Spectre v2? Can't the barrier=0A=
be used as a mitigation for Spectre v1 as well?=0A=
=0A=
Regards,=0A=
Diana=0A=
=0A=
On 3/27/2018 3:32 PM, Michael Ellerman wrote:=0A=
> Add a definition for cpu_show_spectre_v2() to override the generic=0A=
> version. This has several permuations, though in practice some may not=0A=
> occur we cater for any combination.=0A=
>=0A=
> The most verbose is:=0A=
>=0A=
>   Mitigation: Indirect branch serialisation (kernel only), Indirect=0A=
>   branch cache disabled, ori31 speculation barrier enabled=0A=
>=0A=
> We don't treat the ori31 speculation barrier as a mitigation on its=0A=
> own, because it has to be *used* by code in order to be a mitigation=0A=
> and we don't know if userspace is doing that. So if that's all we see=0A=
> we say:=0A=
>=0A=
>   Vulnerable, ori31 speculation barrier enabled=0A=
>=0A=
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>=0A=
> ---=0A=
>  arch/powerpc/kernel/security.c | 33 +++++++++++++++++++++++++++++++++=0A=
>  1 file changed, 33 insertions(+)=0A=
>=0A=
> diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/securit=
y.c=0A=
> index 0eace3cac818..2cee3dcd231b 100644=0A=
> --- a/arch/powerpc/kernel/security.c=0A=
> +++ b/arch/powerpc/kernel/security.c=0A=
> @@ -58,3 +58,36 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct=
 device_attribute *attr, c=0A=
>  =0A=
>  	return sprintf(buf, "Vulnerable\n");=0A=
>  }=0A=
> +=0A=
> +ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute =
*attr, char *buf)=0A=
> +{=0A=
> +	bool bcs, ccd, ori;=0A=
> +	struct seq_buf s;=0A=
> +=0A=
> +	seq_buf_init(&s, buf, PAGE_SIZE - 1);=0A=
> +=0A=
> +	bcs =3D security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED);=0A=
> +	ccd =3D security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED);=0A=
> +	ori =3D security_ftr_enabled(SEC_FTR_SPEC_BAR_ORI31);=0A=
> +=0A=
> +	if (bcs || ccd) {=0A=
> +		seq_buf_printf(&s, "Mitigation: ");=0A=
> +=0A=
> +		if (bcs)=0A=
> +			seq_buf_printf(&s, "Indirect branch serialisation (kernel only)");=0A=
> +=0A=
> +		if (bcs && ccd)=0A=
> +			seq_buf_printf(&s, ", ");=0A=
> +=0A=
> +		if (ccd)=0A=
> +			seq_buf_printf(&s, "Indirect branch cache disabled");=0A=
> +	} else=0A=
> +		seq_buf_printf(&s, "Vulnerable");=0A=
> +=0A=
> +	if (ori)=0A=
> +		seq_buf_printf(&s, ", ori31 speculation barrier enabled");=0A=
> +=0A=
> +	seq_buf_printf(&s, "\n");=0A=
> +=0A=
> +	return s.len;=0A=
> +}=0A=
=0A=
=0A=

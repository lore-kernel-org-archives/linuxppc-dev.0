Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0C9EC2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 03:55:50 +1000 (EST)
Received: from mail78-ch1 (localhost [127.0.0.1])	by mail78-ch1-R.bigfish.com
 (Postfix) with ESMTP id 839A3C00D7	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jul 2013 17:55:45 +0000 (UTC)
Received: from CH1EHSMHS036.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.238])	by mail78-ch1.bigfish.com (Postfix) with ESMTP id
 A6D2940006F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 17:55:42 +0000 (UTC)
Date: Tue, 2 Jul 2013 12:55:40 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH][v2] powerpc/85xx: Move ePAPR paravirt initialization
 earlier
To: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
References: <1372769189-17864-1-git-send-email-Laurentiu.Tudor@freescale.com>
In-Reply-To: <1372769189-17864-1-git-send-email-Laurentiu.Tudor@freescale.com> (from
 Laurentiu.Tudor@freescale.com on Tue Jul  2 07:46:29 2013)
Message-ID: <1372787740.8183.113@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/2013 07:46:29 AM, Laurentiu Tudor wrote:
> diff --git a/arch/powerpc/kernel/epapr_paravirt.c =20
> b/arch/powerpc/kernel/epapr_paravirt.c
> index d44a571..d05f9da 100644
> --- a/arch/powerpc/kernel/epapr_paravirt.c
> +++ b/arch/powerpc/kernel/epapr_paravirt.c
> @@ -30,38 +30,45 @@ extern u32 epapr_ev_idle_start[];
>=20
>  bool epapr_paravirt_enabled;
>=20
> -static int __init epapr_paravirt_init(void)
> +static int __init early_init_dt_scan_epapr(unsigned long node,
> +					   const char *uname,
> +					   int depth, void *data)
>  {
> -	struct device_node *hyper_node;
> -	const u32 *insts;
> -	int len, i;
> +	const u32 *instrs;
> +	unsigned long len;
> +	int i;
>=20
> -	hyper_node =3D of_find_node_by_path("/hypervisor");
> -	if (!hyper_node)
> -		return -ENODEV;
> +	if (!of_flat_dt_is_compatible(node, "epapr,hypervisor-1"))
> +		return 0;

QEMU doesn't set "epapr,hypervisor-1" but it still uses the same hcall =20
mechanism.  The compatible that QEMU sets is "linux,kvm".  Perhaps QEMU =20
should change, but we'd still like to be compatible with older QEMUs.

How is this change related to moving initialization earlier?

> -	insts =3D of_get_property(hyper_node, "hcall-instructions", &len);
> -	if (!insts)
> -		return -ENODEV;
> +#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
> +	if (of_get_flat_dt_prop(node, "has-idle", NULL))
> +		ppc_md.power_save =3D epapr_ev_idle;
> +#endif

Why are you doing this before processing hcall-instructions?

-Scott=

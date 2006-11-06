Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id F1C8367C2D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Nov 2006 04:56:02 +1100 (EST)
Date: Mon, 6 Nov 2006 20:55:43 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kalle Pokki <kalle.pokki@iki.fi>
Subject: Re: [PATCH] CPM_UART: Fixed SMC handling for CPM2 processors
Message-ID: <20061106205543.43b2aacb@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0611061523360.12023@host32.eke.fi>
References: <Pine.LNX.4.64.0611061523360.12023@host32.eke.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_joSueqHRa=+4FzutCCFcZqR";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Sig_joSueqHRa=+4FzutCCFcZqR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Nov 2006 15:29:47 +0200 (EET)
Kalle Pokki wrote:

> SMC handling is broken in two places when using then platform device
> approach with CPM2 devices.
>=20
> 1. The resources in pq2_devices are not named "regs" and "pram", thus
> they are not found in cpm_uart_drv_get_platform_data().
>=20
> 2. The code in cpm_uart_drv_get_platform_data() assumes the parameter
> RAM is at "pram". With SMCs of CPM2 devices, "pram" is just a pointer
> to the actual parameter RAM, which the code should reserve somewhere
> in DPRAM.
>=20
Right, since I had nothing to probe with pq2/smc, that part of code remain =
intact since creation.
Nice to see this stuff tuned finally :)

> This patch renames these the two existing resources, and introduces a
> new one, "pram_base", which is a pointer to the parameter RAM. The
> parameter RAM for SMC1 and SMC2 is put in the first 128 bytes of the
> DPRAM. This memory was already reserved from the DPRAM memory
> allocator for this purpose.
>=20
Well just one objection. pram_base should not be a device unless it applies=
 to all the stuff of=20
SoC family which is not the case.

For this aim, I'd put what you need into the platform_data, or follow the s=
ame approach 8xx stuff having.

Thanks, Vitaly

> Signed-off-by: Kalle Pokki <kalle.pokki@iki.fi>
> ---
>   arch/ppc/syslib/pq2_devices.c           |   24
> ++++++++++++++++++------ drivers/serial/cpm_uart/cpm_uart_core.c |
> 8 +++++++- 2 files changed, 25 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/ppc/syslib/pq2_devices.c
> b/arch/ppc/syslib/pq2_devices.c index fefbc21..e8f7ba2 100644
> --- a/arch/ppc/syslib/pq2_devices.c
> +++ b/arch/ppc/syslib/pq2_devices.c
> @@ -286,16 +286,22 @@ struct platform_device ppc_sys_platform_
>   	[MPC82xx_CPM_SMC1] =3D {
>   		.name =3D "fsl-cpm-smc",
>   		.id	=3D 1,
> -		.num_resources	 =3D 3,
> +		.num_resources	 =3D 4,
>   		.resource =3D (struct resource[]) {
>   			{
> -				.name	=3D "smc_mem",
> +				.name	=3D "regs",
>   				.start	=3D 0x11A80,
>   				.end	=3D 0x11A8F,
>   				.flags	=3D IORESOURCE_MEM,
>   			},
>   			{
> -				.name	=3D "smc_pram",
> +				.name	=3D "pram",
> +				.start	=3D PROFF_SMC1,
> +				.end	=3D PROFF_SMC1 + 63,
> +				.flags	=3D IORESOURCE_MEM,
> +			},
> +			{
> +				.name	=3D "pram_base",
>   				.start	=3D 0x87fc,
>   				.end	=3D 0x87fd,
>   				.flags	=3D IORESOURCE_MEM,
> @@ -310,16 +316,22 @@ struct platform_device ppc_sys_platform_
>   	[MPC82xx_CPM_SMC2] =3D {
>   		.name =3D "fsl-cpm-smc",
>   		.id	=3D 2,
> -		.num_resources	 =3D 3,
> +		.num_resources	 =3D 4,
>   		.resource =3D (struct resource[]) {
>   			{
> -				.name	=3D "smc_mem",
> +				.name	=3D "regs",
>   				.start	=3D 0x11A90,
>   				.end	=3D 0x11A9F,
>   				.flags	=3D IORESOURCE_MEM,
>   			},
>   			{
> -				.name	=3D "smc_pram",
> +				.name	=3D "pram",
> +				.start	=3D PROFF_SMC2,
> +				.end	=3D PROFF_SMC2 + 63,
> +				.flags	=3D IORESOURCE_MEM,
> +			},
> +			{
> +				.name	=3D "pram_base",
>   				.start	=3D 0x88fc,
>   				.end	=3D 0x88fd,
>   				.flags	=3D IORESOURCE_MEM,
> diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c
> b/drivers/serial/cpm_uart/cpm_uart_core.c index 4047530..55419b1
> 100644 --- a/drivers/serial/cpm_uart/cpm_uart_core.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_core.c
> @@ -1024,7 +1024,7 @@ int cpm_uart_drv_get_platform_data(struc
>   	int idx =3D pdata->fs_no;	/* It is UART_SMCx or
> UART_SCCx index */ struct uart_cpm_port *pinfo;
>   	int line;
> -	u32 mem, pram;
> +	u32 mem, pram, pram_base;
>=20
>   	line =3D cpm_uart_id2nr(idx);
>   	if(line < 0) {
> @@ -1049,6 +1049,12 @@ int cpm_uart_drv_get_platform_data(struc
>   		return -EINVAL;
>   	pram =3D r->start;
>=20
> +	r =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "pram_base");
> +	if (r) {
> +		pram_base =3D r->start;
> +		out_be16((u16 *)pram_base, pram & 0xffff);
> +	}
> +
>   	if(idx > fsid_smc2_uart) {
>   		pinfo->sccp =3D (scc_t *)mem;
>   		pinfo->sccup =3D (scc_uart_t *)pram;

--Sig_joSueqHRa=+4FzutCCFcZqR
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFT3cfuOg9JvQhSEsRAskTAJ99riOLRt83yzLOZOuHjtpq+q9HUQCfZvo6
oXI6Ci2Q/HA9Tu9U2pxR/w8=
=ODGt
-----END PGP SIGNATURE-----

--Sig_joSueqHRa=+4FzutCCFcZqR--

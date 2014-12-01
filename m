Return-Path: <mpa@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E4D81A09BF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Dec 2014 18:10:03 +1100 (AEDT)
Date: Mon, 1 Dec 2014 07:50:46 +0100
From: Markus Pargmann <mpa@pengutronix.de>
To: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: free irq before irq_dispose_mapping()
Message-ID: <20141201065046.GB27289@pengutronix.de>
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
In-Reply-To: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 Li.Xiubo@freescale.com, timur@tabi.org, perex@perex.cz, nicoleotsuka@gmail.com,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 01, 2014 at 11:50:51AM +0900, Jiada Wang wrote:
> irq_dispose_mapping() in turns calls unregister_irq_proc(),
> which will remove irq proc entry, if IRQ is not freed
> before calling of irq_dispose_mapping(), then it will cause
> kernel warning.
>=20
> By free IRQ before irq_dispose_mapping(), this patch fix
> the following kernel warning found when remove of fsl_ssi driver:
>=20
> [   31.515336] ------------[ cut here ]------------
> [   31.520091] WARNING: CPU: 2 PID: 434 at fs/proc/generic.c:521 remove_p=
roc_entry+0x14c/0x16c()
> [   31.528708] remove_proc_entry: removing non-empty directory 'irq/79', =
leaking at least '202c000.ss'
> [   31.537911] Modules linked in: snd_soc_wm8962 snd_soc_imx_wm8962 snd_s=
oc_fsl_ssi(-) evbug
> [   31.546249] CPU: 2 PID: 434 Comm: rmmod Not tainted 3.18.0-rc6-00028-g=
3314bf6-dirty #1
> [   31.554235] Backtrace:
> [   31.556816] [<80011ea8>] (dump_backtrace) from [<80012044>] (show_stac=
k+0x18/0x1c)
> [   31.564416]  r6:80142c88 r5:00000000 r4:00000000 r3:00000000
> [   31.570267] [<8001202c>] (show_stack) from [<806980ec>] (dump_stack+0x=
88/0xa4)
> [   31.577588] [<80698064>] (dump_stack) from [<80029d78>] (warn_slowpath=
_common+0x70/0x94)
> [   31.585711]  r5:00000009 r4:bb61fd90
> [   31.589423] [<80029d08>] (warn_slowpath_common) from [<80029e40>] (war=
n_slowpath_fmt+0x38/0x40)
> [   31.598187]  r8:bb61fdfe r7:be05d76d r6:be05d9a8 r5:00000002 r4:be05d7=
00
> [   31.605054] [<80029e0c>] (warn_slowpath_fmt) from [<80142c88>] (remove=
_proc_entry+0x14c/0x16c)
> [   31.613709]  r3:806a79c0 r2:808229a0
> [   31.617371] [<80142b3c>] (remove_proc_entry) from [<80070380>] (unregi=
ster_irq_proc+0x94/0xb8)
> [   31.625989]  r10:00000000 r8:8000ede4 r7:80955f2c r6:0000004f r5:8118e=
738 r4:be00af00
> [   31.633952] [<800702ec>] (unregister_irq_proc) from [<80069dac>] (free=
_desc+0x2c/0x64)
> [   31.641898]  r6:0000004f r5:80955f38 r4:be00af00
> [   31.646604] [<80069d80>] (free_desc) from [<80069e68>] (irq_free_descs=
+0x4c/0x8c)
> [   31.654092]  r7:00000081 r6:00000001 r5:0000004f r4:00000001
> [   31.659863] [<80069e1c>] (irq_free_descs) from [<8006fc3c>] (irq_dispo=
se_mapping+0x40/0x5c)
> [   31.668247]  r6:be17b844 r5:be17b800 r4:0000004f r3:802c5ec0
> [   31.673998] [<8006fbfc>] (irq_dispose_mapping) from [<7f004ea4>] (fsl_=
ssi_remove+0x58/0x70 [snd_so)
> [   31.683948]  r4:bb5bba10 r3:00000001
> [   31.687618] [<7f004e4c>] (fsl_ssi_remove [snd_soc_fsl_ssi]) from [<803=
720a0>] (platform_drv_remove)
> [   31.697564]  r5:7f0064f8 r4:be17b810
> [   31.701195] [<80372080>] (platform_drv_remove) from [<80370494>] (__de=
vice_release_driver+0x78/0xc)
> [   31.710361]  r5:7f0064f8 r4:be17b810
> [   31.713987] [<8037041c>] (__device_release_driver) from [<80370d20>] (=
driver_detach+0xbc/0xc0)
> [   31.722631]  r5:7f0064f8 r4:be17b810
> [   31.726259] [<80370c64>] (driver_detach) from [<80370304>] (bus_remove=
_driver+0x54/0x98)
> [   31.734382]  r6:00000800 r5:00000000 r4:7f0064f8 r3:bb67f500
> [   31.740149] [<803702b0>] (bus_remove_driver) from [<80371398>] (driver=
_unregister+0x30/0x50)
> [   31.748617]  r4:7f0064f8 r3:bd9f7080
> [   31.752245] [<80371368>] (driver_unregister) from [<80371f3c>] (platfo=
rm_driver_unregister+0x14/0x)
> [   31.761498]  r4:7f00655c r3:7f005a70
> [   31.765130] [<80371f28>] (platform_driver_unregister) from [<7f005a84>=
] (fsl_ssi_driver_exit+0x14/)
> [   31.776147] [<7f005a70>] (fsl_ssi_driver_exit [snd_soc_fsl_ssi]) from =
[<8008ed80>] (SyS_delete_mod)
> [   31.786553] [<8008ec64>] (SyS_delete_module) from [<8000ec20>] (ret_fa=
st_syscall+0x0/0x48)
> [   31.794824]  r6:00c46d18 r5:00000800 r4:00c46d18
> [   31.799530] ---[ end trace 954e8a3a15379e52 ]---
>=20
> Moreover replace devm_request_irq() with request_irq() since there is
> no need to use it as now driver always frees IRQ manually.

devm_request_irq() is used by other drivers too, this should not be a
problem. Looking at the code it seems that irq_dispose_mapping may not
be necessary with devm_request_irq(). So I think it would be better to
remove irq_dispose_mapping() instead.

Best Regards,

Markus Pargmann

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUfA/GAAoJEEpcgKtcEGQQRKcP/RsPlz4tOriNjE4I5Zto1Hp3
w1aymMN1g+k8VEpOT/ihLsfQ5F9AfTGulgnJUu5pcbvAzEiSBAejfS9T5H7gMhaX
I+PkdqMQzdVayM0jYKCTr25oPjKlSMN1iLuD3IiO37H7QdJI7kcVCJciatGT2fq2
bFMd0AY3iobX5BK51YGWVCXutLnosJZ9uI3EbcFr44ncJU2576bdCkINTUgYqTAl
EFLAwlVB0CsAZVF6Gv+EjtR6OLJLMwUffr1ragl+oC5FTsVsMgaYNY4rxSiitxh3
1pUihmVp7ruNRWktVTPfPKTe2vNTFxiIa4sygYvzx0GkYbwos016/DCDAcJ6h1An
3Pd4srtsdXDX8YUTDex4ZQqMq+Aq3Xsa0PN0Dth6cxCgQQWjadIG1sBz0qpeOpKa
48cIyVoRb8L4YCzSUzn1VyI51ET+hDvmnoUUnVu01lOfn06oxZiqvrtsXefBTex0
zX4ShYDGZAzxezRotCibYtBms/s6TINFT6ErCnedeNZGRLRtAQPVIo68CK1NdE5K
Bj3QEU0Q/2aZmoWwlkR+tu0UypsB91uY657Z7/VkZuDIRrpI7agwpuj0gKDJ/YTe
i4VqCo2jKn9pAmxmq73EeHh2CkOCIaRWjgzoLk7Ny4xWRdhyRgXXwv+LmJwZQH94
5onip2QeDXCJ0NH81MYS
=4KXQ
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--

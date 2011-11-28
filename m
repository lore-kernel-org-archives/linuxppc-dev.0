Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
 [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E8A69B6F82
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 10:42:31 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 2/6] powerpc/85xx: consolidate of_platform_bus_probe calls
Date: Mon, 28 Nov 2011 23:42:24 +0000
Message-ID: <CAOZdJXXZG38v-tgA2Ty7-uxJ3AxoFCmNxMO3dKJnJYQtJFb9DA@mail.gmail.com>
References: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
 <1321552581-29773-2-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1321552581-29773-2-git-send-email-dbaryshkov@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2011 at 11:56 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platfo=
rms/85xx/p1022_ds.c
> index 00d93a4..cacb4d4 100644
> --- a/arch/powerpc/platforms/85xx/p1022_ds.c
> +++ b/arch/powerpc/platforms/85xx/p1022_ds.c
> @@ -330,10 +330,6 @@ static void __init p1022_ds_setup_arch(void)
> =A0}
>
> =A0static struct of_device_id __initdata p1022_ds_ids[] =3D {
> - =A0 =A0 =A0 { .type =3D "soc", },
> - =A0 =A0 =A0 { .compatible =3D "soc", },
> - =A0 =A0 =A0 { .compatible =3D "simple-bus", },
> - =A0 =A0 =A0 { .compatible =3D "gianfar", },
> =A0 =A0 =A0 =A0/* So that the DMA channel nodes can be probed individuall=
y: */
> =A0 =A0 =A0 =A0{ .compatible =3D "fsl,eloplus-dma", },
> =A0 =A0 =A0 =A0{},
> @@ -343,6 +339,7 @@ static int __init p1022_ds_publish_devices(void)
> =A0{
> =A0 =A0 =A0 =A0return of_platform_bus_probe(NULL, p1022_ds_ids, NULL);
> =A0}
> +machine_device_initcall(p1022_ds, mpc85xx_common_publish_devices);
> =A0machine_device_initcall(p1022_ds, p1022_ds_publish_devices);

I don't think this is working. =A0I need to investigate some more to be
sure, but it looks like this is not picking up "fsl,eloplus-dma".
None of the DMA channels are being probed in the audio driver
(sound/soc/fsl_dma.c).

--
Timur Tabi
Linux kernel developer at Freescale=

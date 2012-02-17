Return-Path: <pku.leo@gmail.com>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 004E2B6FCB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 17:56:40 +1100 (EST)
Received: by eekd49 with SMTP id d49so1151465eek.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2012 22:56:36 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1329458236-4619-1-git-send-email-Jiafei.Pan@freescale.com>
References: <1329458236-4619-1-git-send-email-Jiafei.Pan@freescale.com>
Date: Fri, 17 Feb 2012 14:56:35 +0800
Message-ID: <CADRPPNTtAuQCjB5_NgBbJj7YT1cBxAVXAwQbm9r+8tdGxuyeog@mail.gmail.com>
Subject: Re: [PATCH] USB: ehci-fsl: Turn on cache snooping on MPC8xxx
From: Li Yang <leoli@freescale.com>
To: Pan Jiafei <Jiafei.Pan@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 17, 2012 at 1:57 PM, Pan Jiafei <Jiafei.Pan@freescale.com> wrot=
e:
> If a MPC8xxx was being used, 'have_sysif_regs' should be set and
> it should setup cache snooping for all the 4GB space on both PPC32
> and PPC64.
>
> Signed-off-by: Pan Jiafei <Jiafei.Pan@freescale.com>

Hi Jiafei,

You should have sent this patch upstream earlier.  I remember you
asked about it a few months ago. :)

Acked-by: Li Yang <leoli@freescale.com>

> ---
> =C2=A0drivers/usb/host/ehci-fsl.c | =C2=A0 23 ++++++++++-------------
> =C2=A01 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index c26a82e..8327d3e 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -252,21 +252,18 @@ static int ehci_fsl_usb_setup(struct ehci_hcd *ehci=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pdata->have_sysif_regs) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D in_be32(n=
on_ehci + FSL_SOC_USB_CTRL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out_be32(non_ehci =
+ FSL_SOC_USB_CTRL, temp | 0x00000004);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(non_ehci + FS=
L_SOC_USB_SNOOP1, 0x0000001b);
> - =C2=A0 =C2=A0 =C2=A0 }
>
> -#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
> - =C2=A0 =C2=A0 =C2=A0 /*
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* Turn on cache snooping hardware, since som=
e PowerPC platforms
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* wholly rely on hardware to deal with cache=
 coherent
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Turn on cache snoopi=
ng hardware, since some PowerPC platforms
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * wholly rely on hardw=
are to deal with cache coherent
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>
> - =C2=A0 =C2=A0 =C2=A0 /* Setup Snooping for all the 4GB space */
> - =C2=A0 =C2=A0 =C2=A0 /* SNOOP1 starts from 0x0, size 2G */
> - =C2=A0 =C2=A0 =C2=A0 out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0 | SNOO=
P_SIZE_2GB);
> - =C2=A0 =C2=A0 =C2=A0 /* SNOOP2 starts from 0x80000000, size 2G */
> - =C2=A0 =C2=A0 =C2=A0 out_be32(non_ehci + FSL_SOC_USB_SNOOP2, 0x80000000=
 | SNOOP_SIZE_2GB);
> -#endif
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Setup Snooping for =
all the 4GB space */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* SNOOP1 starts from =
0x0, size 2G */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(non_ehci + FS=
L_SOC_USB_SNOOP1, 0x0 | SNOOP_SIZE_2GB);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* SNOOP2 starts from =
0x80000000, size 2G */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(non_ehci + FS=
L_SOC_USB_SNOOP2, 0x80000000 | SNOOP_SIZE_2GB);
> + =C2=A0 =C2=A0 =C2=A0 }
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((pdata->operating_mode =3D=3D FSL_USB2_DR_=
HOST) ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(pdata->operating_mode =3D=3D FSL_USB2_DR_OTG))
> --
> 1.7.5.1

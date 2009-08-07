Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 51410B7B64
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 04:49:57 +1000 (EST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20090807184147.4932.18130.stgit@terra>
References: <20090807184147.4932.18130.stgit@terra>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 7 Aug 2009 12:49:34 -0600
Message-ID: <fa686aa40908071149k6db83aeew2c8c7a03f9072520@mail.gmail.com>
Subject: Re: [PATCH] Use clock freqency from the device tree to calculate
	correct MPC5200 PSC clock.
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 7, 2009 at 12:41 PM, Jon Smirl<jonsmirl@gmail.com> wrote:
> Use clock freqency from the device tree to calculate correct MPC5200 PSC =
clock.
> Previous code had errors or used a constant. This versions computes
> the right clock based on the xtal and register settings.

Looks good to me; one comment below:

> ---
> =A0arch/powerpc/include/asm/mpc52xx.h =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0arch/powerpc/platforms/52xx/mpc52xx_common.c | =A0 26 ++++++++++++++++=
++++++++--
> =A0drivers/spi/mpc52xx_psc_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
8 +-------
> =A0sound/soc/fsl/mpc5200_psc_i2s.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +-=
---------
> =A04 files changed, 27 insertions(+), 20 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/as=
m/mpc52xx.h
> index cadd398..1ca8a0e 100644
> --- a/arch/powerpc/include/asm/mpc52xx.h
> +++ b/arch/powerpc/include/asm/mpc52xx.h
> @@ -285,7 +285,7 @@ struct mpc52xx_rtc {
> =A0extern void mpc5200_setup_xlb_arbiter(void);
> =A0extern void mpc52xx_declare_of_platform_devices(void);
> =A0extern void mpc52xx_map_common_devices(void);
> -extern int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv);
> +extern int mpc52xx_set_psc_clkdiv(int psc_id, int freq);
> =A0extern unsigned int mpc52xx_get_xtal_freq(struct device_node *node);
> =A0extern void mpc52xx_restart(char *cmd);
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/=
platforms/52xx/mpc52xx_common.c
> index a46bad0..f81fb03 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> @@ -110,6 +110,8 @@ static struct of_device_id mpc52xx_cdm_ids[] __initda=
ta =3D {
> =A0 =A0 =A0 =A0{}
> =A0};
>
> +static u32 fsystem; /* fsystem clock on mpc5200 */
> +

To protect against collisions with the global namespace, please name
this mpc5200_fsystem.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

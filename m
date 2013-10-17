Return-Path: <LW@KARO-electronics.de>
Received: from mail.karo-electronics.de (mail.karo-electronics.de
 [81.173.242.67]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 121DD2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 21:18:56 +1100 (EST)
Date: Thu, 17 Oct 2013 12:17:21 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Xiubo Li <Li.Xiubo@freescale.com>
Subject: Re: [PATCHv1 5/8] ASoC: sgtl5000: Revise the bugs about the
 sgt15000 codec.
Message-ID: <20131017121721.43e1b34b@ipc1.ka-ro>
In-Reply-To: <1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org,
 linux-doc@vger.kernel.org, tiwai@suse.de, b18965@freescale.com, timur@tabi.org,
 perex@perex.cz, r65073@freescale.com, linux@arm.linux.org.uk,
 b42378@freescale.com, linux-arm-kernel@lists.infradead.org,
 grant.likely@linaro.org, devicetree@vger.kernel.org, ian.campbell@citrix.com,
 pawel.moll@arm.com, swarren@wwwdotorg.org, rob.herring@calxeda.com,
 broonie@kernel.org, oskar@scara.com, fabio.estevam@freescale.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, rob@landley.net,
 r64188@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Xiubo Li <Li.Xiubo@freescale.com> wrote:
> When the CONFIG_REGULATOR is disabled there will be some warnings
> printed out.
>=20
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  sound/soc/codecs/sgtl5000.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> index 1f4093f..4e2e4c9 100644
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -883,14 +883,19 @@ static int ldo_regulator_register(struct snd_soc_co=
dec *codec,
>  				struct regulator_init_data *init_data,
>  				int voltage)
>  {
> +#ifdef CONFIG_SND_SOC_FSL_SGTL5000
> +	return 0;
> +#else
>  	dev_err(codec->dev, "this setup needs regulator support in the kernel\n=
");
>  	return -EINVAL;
> +#endif
>
This looks wrong to me, as this will disable the error for unsolicited
platforms in a multi arch kernel!

>  static int ldo_regulator_remove(struct snd_soc_codec *codec)
>  {
>  	return 0;
>  }
> +
>  #endif
> =20
Why do you add an extra empty line here?


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________

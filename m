Return-Path: <Li.Xiubo@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0184.outbound.protection.outlook.com [207.46.163.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D5E89140089
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 18:37:08 +1100 (EST)
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>,
 "broonie@kernel.org" <broonie@kernel.org>
Subject: RE: [PATCH] ASoC: fsl_sai: Fix Bit Clock Polarity configurations
Date: Fri, 4 Apr 2014 07:37:00 +0000
Message-ID: <9cb53ac6e0e04c01bc0c6ae6a4d42557@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1396595387-4371-1-git-send-email-Guangyu.Chen@freescale.com>
In-Reply-To: <1396595387-4371-1-git-send-email-Guangyu.Chen@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "timur@tabi.org" <timur@tabi.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Subject: [PATCH] ASoC: fsl_sai: Fix Bit Clock Polarity configurations
>=20
> The BCP bit in TCR4/RCR4 register rules as followings:
>   0 Bit clock is active high with drive outputs on rising edge
>     and sample inputs on falling edge.
>   1 Bit clock is active low with drive outputs on falling edge
>     and sample inputs on rising edge.
>=20
> For all formats currently supported in the fsl_sai driver, they're exactl=
y
> sending data on the falling edge and sampling on the rising edge.
>=20
> However, the driver clears this BCP bit for all of them which results cli=
ck
> noise when working with SGTL5000 and big noise with WM8962.
>=20
> Thus this patch corrects the BCP settings for all the formats here to fix
> the nosie issue.
>=20
> Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> ---

Good catch.

Acked-by: Xiubo Li <Li.Xiubo@freescale.com>

Thanks,
--

BRs,
Xiubo


>  sound/soc/fsl/fsl_sai.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 99051c7..9bbebea 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -180,7 +180,7 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai
> *cpu_dai,
>  		 * that is, together with the last bit of the previous
>  		 * data word.
>  		 */
> -		val_cr2 &=3D ~FSL_SAI_CR2_BCP;
> +		val_cr2 |=3D FSL_SAI_CR2_BCP;
>  		val_cr4 |=3D FSL_SAI_CR4_FSE | FSL_SAI_CR4_FSP;
>  		break;
>  	case SND_SOC_DAIFMT_LEFT_J:
> @@ -188,7 +188,7 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai
> *cpu_dai,
>  		 * Frame high, one word length for frame sync,
>  		 * frame sync asserts with the first bit of the frame.
>  		 */
> -		val_cr2 &=3D ~FSL_SAI_CR2_BCP;
> +		val_cr2 |=3D FSL_SAI_CR2_BCP;
>  		val_cr4 &=3D ~(FSL_SAI_CR4_FSE | FSL_SAI_CR4_FSP);
>  		break;
>  	case SND_SOC_DAIFMT_DSP_A:
> @@ -198,7 +198,7 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai
> *cpu_dai,
>  		 * that is, together with the last bit of the previous
>  		 * data word.
>  		 */
> -		val_cr2 &=3D ~FSL_SAI_CR2_BCP;
> +		val_cr2 |=3D FSL_SAI_CR2_BCP;
>  		val_cr4 &=3D ~FSL_SAI_CR4_FSP;
>  		val_cr4 |=3D FSL_SAI_CR4_FSE;
>  		sai->is_dsp_mode =3D true;
> @@ -208,7 +208,7 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai
> *cpu_dai,
>  		 * Frame high, one bit for frame sync,
>  		 * frame sync asserts with the first bit of the frame.
>  		 */
> -		val_cr2 &=3D ~FSL_SAI_CR2_BCP;
> +		val_cr2 |=3D FSL_SAI_CR2_BCP;
>  		val_cr4 &=3D ~(FSL_SAI_CR4_FSE | FSL_SAI_CR4_FSP);
>  		sai->is_dsp_mode =3D true;
>  		break;
> --
> 1.8.4
>=20

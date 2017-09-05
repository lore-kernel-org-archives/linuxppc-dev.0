Return-Path: <festevam@gmail.com>
Received: from mail-oi0-x231.google.com (mail-oi0-x231.google.com
 [IPv6:2607:f8b0:4003:c06::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xn2lC0MGVzDrHr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 09:20:54 +1000 (AEST)
Received: by mail-oi0-x231.google.com with SMTP id h70so33391796oic.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Sep 2017 16:20:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cfb8f844-87aa-f1f3-bd55-4f2b60f3cf88@denx.de>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
 <20170905052031.GB2774@Asurada-CZ80>
 <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
 <20170905181108.GB23906@Asurada-Nvidia>
 <cfb8f844-87aa-f1f3-bd55-4f2b60f3cf88@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 5 Sep 2017 20:20:51 -0300
Message-ID: <CAOMZO5BpEo2+kSrzkM90xS-h6i5Ozy8Wr2tn0pmhsXnY0x6Lrg@mail.gmail.com>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal
 to system freq
To: =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@denx.de>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 5, 2017 at 6:13 PM, =C5=81ukasz Majewski <lukma@denx.de> wrote:

> &i2c1 {
>         clock-frequency =3D <400000>;
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_i2c1>;
>         status =3D "okay";
>
>         codec: tfa9879@6C {
>                 #sound-dai-cells =3D <0>;
>                 compatible =3D "tfa9879";

This codec seems to miss device tree support. Don't you need something
like this?

--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -312,9 +312,15 @@ static const struct i2c_device_id tfa9879_i2c_id[] =3D=
 {
 };
 MODULE_DEVICE_TABLE(i2c, tfa9879_i2c_id);

+static const struct of_device_id tfa9879_of_match[] =3D {
+       { .compatible =3D "nxp,tfa9879", },
+       { }
+};
+
 static struct i2c_driver tfa9879_i2c_driver =3D {
        .driver =3D {
                .name =3D "tfa9879",
+               .of_match_table =3D tfa9879_of_match,
        },
        .probe =3D tfa9879_i2c_probe,
        .remove =3D tfa9879_i2c_remove,

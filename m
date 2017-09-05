Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xn25x3XGZzDrFq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 08:52:04 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id m1so2266333pfk.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Sep 2017 15:52:04 -0700 (PDT)
Date: Tue, 5 Sep 2017 15:52:26 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@denx.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Timur Tabi <timur@tabi.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal
 to system freq
Message-ID: <20170905225225.GA14132@Asurada-Nvidia>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
 <20170905052031.GB2774@Asurada-CZ80>
 <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
 <20170905181108.GB23906@Asurada-Nvidia>
 <cfb8f844-87aa-f1f3-bd55-4f2b60f3cf88@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <cfb8f844-87aa-f1f3-bd55-4f2b60f3cf88@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 05, 2017 at 11:13:40PM +0200, Łukasz Majewski wrote:

> They key point here is the asoc_simple_card_parse_clk() function
> from simple-card-utils.c
> 
> Please look how the clock is assigned; It first checks for cpu
> clock, then for "system-clock-frequency" DTS node and _finally_
> looks for another "child" clock [1], which is the codec attached to
> I2C.

Here is the routine that I understood from the code:
1) asoc_simple_card_parse_clk_cpu(dev, cpu, dai_link, cpu_dai);
   => asoc_simple_card_parse_clk(dev, cpu,        // cpu node in sound{} [1]
		   		 dai_link->cpu_of_node,     // node ssi2 [2]
				 cpu_dai, dai_link->cpu_dai_name);
   ==> 1.1) devm_get_clk_from_child(dev, node, NULL);                 // [1]
   ==> 1.2) of_property_read_u32(node, "system-clock-frequency", &val)// [1]
   ==> 1.3) devm_get_clk_from_child(dev, dai_of_node, NULL);          // [2]

2) asoc_simple_card_parse_clk_codec(dev, codec, dai_link, codec_dai);
   => asoc_simple_card_parse_clk(dev, codec,    // codec node in sound{} [3]
		   		 dai_link->codec_of_node,// node tfa9879 [4]
				 codec_dai, dai_link->codec_dai_name);
   ==> 2.1) devm_get_clk_from_child(dev, node, NULL);                 // [3]
   ==> 2.2) of_property_read_u32(node, "system-clock-frequency", &val)// [3]
   ==> 2.3) devm_get_clk_from_child(dev, dai_of_node, NULL);          // [4]

For the cpu routine, it first checks for clock property under cpu
node of simple-card, then for "system-clock-frequency" in the cpu
node of simple-card, and finally looks for clock property in ssi2
node.

For codec routine, it first checks for clock property under codec
node of simple-card, then for "system-clock-frequency" in codec
node of simple-card, and finally looks for clock property in the
tfa9879 node.

The cpu and codec are totally separate, aren't they? And I don't
think it's right if not.

> >>which has clock from I2C (66 MHz).
> >
> >You mean I2C scl or I2S sclk?
> 
> I2C scl.

A couple of things here.....
1) I don't think I2C scl can run at 66MHz...The 66MHz is probably
   the ipg clock of I2C controller.
2) Even if the scl does run at 66MHz, there is no point in passing
   the clock of I2C scl into an I2S dai-link.
   
So I feel something must be wrong. I suggest you to add some printk
to check the names of those nodes and x_of_node in the simple card
driver.

> My DTS [1] (it is different than other in-tree supported codecs - at
> least I did not find similar setup in DTSes):
> 
> 	sound {
> 		compatible = "simple-audio-card";
> 		label = "tfa9879-mono";
> 
> 		simple-audio-card,dai-link {
> 			/* DAC */
> 			format = "i2s";
> 			bitclock-master = <&dailink_master>;
> 			frame-master = <&dailink_master>;
> 
> 			dailink_master: cpu {
> 			    sound-dai = <&ssi2>;
> 			};
> 			codec {
> 			    sound-dai = <&codec>;
> 			};
> 		};

I remember there is another style for a single dai-link. Could you
please try that one? There is an example in:
    Documentation/devicetree/bindings/sound/simple-card.txt

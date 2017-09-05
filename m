Return-Path: <lukma@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmzwb13qFzDqYN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 07:13:49 +1000 (AEST)
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal
 to system freq
To: Nicolin Chen <nicoleotsuka@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
 <20170905052031.GB2774@Asurada-CZ80>
 <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
 <20170905181108.GB23906@Asurada-Nvidia>
From: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@denx.de>
Message-ID: <cfb8f844-87aa-f1f3-bd55-4f2b60f3cf88@denx.de>
Date: Tue, 5 Sep 2017 23:13:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170905181108.GB23906@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nicolin,

> On Tue, Sep 05, 2017 at 10:35:34AM +0200, Łukasz Majewski wrote:
> 
>>> And apparently, we shouldn't set bitclk to 66MHz either. Can
>>> you help to find where this 66MHz comes from?
> 
>> 2. int asoc_simple_card_init_dai() @ simple-card-utils.c
> 
> Oh, I just searched in the simple-card.c but missed this file.
> 
>> In this function (point 2.) the
>> simple_dai->sysclk is set and:
>> snd_soc_dai_set_sysclk(dai, 0, simple_dai->sysclk, 0)
>> which sets frequency to 66 MHz [*].
>>
>> The asoc_simple_card_init_dai() is called in
>> asoc_simple_card_dai_init() @ simple-card.c
>> which is assigned to dai_link->init
>> dai_link->init		= asoc_simple_card_dai_init; @ simple_card.c
>>
>> And the sysclk itself is defined at:
>> -------------------------------------
>> dai_props->codec_dai->sysclk, which is used at:a
> 
> Why codec_dai? Why not dai_props->cpu_dai->sysclk since we are talking
> about SSI?

This is how the simple-card (simple-sound-card) is written.

> 
>> asoc_simple_card_startup(), asoc_simple_card_shutdown() and others
>> functions at simple-card.c
>> It is setup at:
>> asoc_simple_card_parse_clk() @ simple-card-utils.c from macro:
>> #define asoc_simple_card_parse_clk_cpu()
>> And the problem is:
>> -------------------
>>
>> At the
>> asoc_simple_card_parse_clk()
>> we finally go to dts node:
>> /soc/aips-bus@02100000/i2c@021a0000/tfa9879@6C
> 
> This tfa9879 should be the CODEC right?

Yes. The tfa9879 is a codec (very simple -> I2S + I2C, mono).

They key point here is the asoc_simple_card_parse_clk() function from 
simple-card-utils.c

Please look how the clock is assigned; It first checks for cpu clock, 
then for "system-clock-frequency" DTS node and _finally_ looks for 
another "child" clock [1], which is the codec attached to I2C.

And from there it takes the 66 MHz CLK:
/soc/aips-bus@02100000/i2c@021a0000/tfa9879@6C



> 
>> which has clock from I2C (66 MHz).
> 
> You mean I2C scl or I2S sclk?

I2C scl.

> 
> -----------------------------------------------------------------
> 
> But anyway, I feel very confused here as you have 66MHz clock rate
> (regardless of it purpose) for a codec dai but it's been passed to
> a cpu dai (SSI).

Please look into asoc_simple_card_parse_clk().


My DTS [1] (it is different than other in-tree supported codecs - at 
least I did not find similar setup in DTSes):

	sound {
		compatible = "simple-audio-card";
		label = "tfa9879-mono";

		simple-audio-card,dai-link {
			/* DAC */
			format = "i2s";
			bitclock-master = <&dailink_master>;
			frame-master = <&dailink_master>;

			dailink_master: cpu {
			    sound-dai = <&ssi2>;
			};
			codec {
			    sound-dai = <&codec>;
			};
		};
	};


&i2c1 {
	clock-frequency = <400000>;
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_i2c1>;
	status = "okay";

	codec: tfa9879@6C {
		#sound-dai-cells = <0>;
		compatible = "tfa9879";
		reg = <0x6C>;
	};
};

&ssi2 {
	fsl,mode = "i2s-master";
	status = "okay";
};

the ssi2 node is defined in imx6qdl.dtsi file (no changes).

The SOC is IMX6Q.

The TFA9879 is a slave for I2S transmission.


> 
>> [*] - I could workaround this problem by setting:
>>
>> system-clock-frequency = <0> in
>>
>> 			dailink_master: cpu {
>> 			    sound-dai = <&ssi2>;
>> 			};
>>
>> but this is IMHO even worse hack.... than this patch.
> 
> I haven't used simple-card for a while so I forgot how to define
> its DT bindings specifically. But you should assign ssi2 as the
> CPU dai and assign tfa9879 as a CODEC dai.
> 


-- 
Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

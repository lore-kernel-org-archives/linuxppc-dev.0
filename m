Return-Path: <lukma@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnJ5w0hF2zDrJZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 19:22:56 +1000 (AEST)
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal
 to system freq
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Timur Tabi <timur@tabi.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
 <20170905052031.GB2774@Asurada-CZ80>
 <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
 <20170905181108.GB23906@Asurada-Nvidia>
 <cfb8f844-87aa-f1f3-bd55-4f2b60f3cf88@denx.de>
 <20170905225225.GA14132@Asurada-Nvidia>
From: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@denx.de>
Message-ID: <ae1d3e2a-d618-05e2-1572-5593caff1ee0@denx.de>
Date: Wed, 6 Sep 2017 11:22:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170905225225.GA14132@Asurada-Nvidia>
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

> On Tue, Sep 05, 2017 at 11:13:40PM +0200, Łukasz Majewski wrote:
> 
>> They key point here is the asoc_simple_card_parse_clk() function
>> from simple-card-utils.c
>>
>> Please look how the clock is assigned; It first checks for cpu
>> clock, then for "system-clock-frequency" DTS node and _finally_
>> looks for another "child" clock [1], which is the codec attached to
>> I2C.
> 
> Here is the routine that I understood from the code:
> 1) asoc_simple_card_parse_clk_cpu(dev, cpu, dai_link, cpu_dai);
>     => asoc_simple_card_parse_clk(dev, cpu,        // cpu node in sound{} [1]
> 		   		 dai_link->cpu_of_node,     // node ssi2 [2]
> 				 cpu_dai, dai_link->cpu_dai_name);
>     ==> 1.1) devm_get_clk_from_child(dev, node, NULL);                 // [1]
>     ==> 1.2) of_property_read_u32(node, "system-clock-frequency", &val)// [1]
>     ==> 1.3) devm_get_clk_from_child(dev, dai_of_node, NULL);          // [2]
> 
> 2) asoc_simple_card_parse_clk_codec(dev, codec, dai_link, codec_dai);
>     => asoc_simple_card_parse_clk(dev, codec,    // codec node in sound{} [3]
> 		   		 dai_link->codec_of_node,// node tfa9879 [4]
> 				 codec_dai, dai_link->codec_dai_name);
>     ==> 2.1) devm_get_clk_from_child(dev, node, NULL);                 // [3]
>     ==> 2.2) of_property_read_u32(node, "system-clock-frequency", &val)// [3]
>     ==> 2.3) devm_get_clk_from_child(dev, dai_of_node, NULL);          // [4]
> 
> For the cpu routine, it first checks for clock property under cpu
> node of simple-card, then for "system-clock-frequency" in the cpu
> node of simple-card, and finally looks for clock property in ssi2
> node.

I've double checked this and the
simple_dai->sysclk is assigned in the

asoc_simple_card_parse_clk()

-----> dev: sound
-----> clk node: /soc/aips-bus@02000000/spba-bus@02000000/ssi@0202c000
-----> Clk asignment

And this clock is taken from this node. It looks like ipg clock for ssi...

> 
> For codec routine, it first checks for clock property under codec
> node of simple-card, then for "system-clock-frequency" in codec
> node of simple-card, and finally looks for clock property in the
> tfa9879 node.
> 
> The cpu and codec are totally separate, aren't they? And I don't
> think it's right if not.

Yes, they should be separated.

> 
>>>> which has clock from I2C (66 MHz).
>>>
>>> You mean I2C scl or I2S sclk?
>>
>> I2C scl.
> 
> A couple of things here.....
> 1) I don't think I2C scl can run at 66MHz...The 66MHz is probably
>     the ipg clock of I2C controller.

I agree. I2C scl runs with 400 kHz (as recommended by I2C high speed spec).

And considering above, the 66 MHz clock seems to be from ssi IP block.

> 2) Even if the scl does run at 66MHz, there is no point in passing
>     the clock of I2C scl into an I2S dai-link.

Yes.

>     
> So I feel something must be wrong. I suggest you to add some printk
> to check the names of those nodes and x_of_node in the simple card
> driver.

The problem is with the "lack" of clock nodes/properties at

  			dailink_master: cpu {
  			    sound-dai = <&ssi2>;
			    clock = <&SSSS>;
			    system-clock-frequency = <XXXX>;
  			};


and as a result we take some "default" clock.

> 
>> My DTS [1] (it is different than other in-tree supported codecs - at
>> least I did not find similar setup in DTSes):
>>
>> 	sound {
>> 		compatible = "simple-audio-card";
>> 		label = "tfa9879-mono";
>>
>> 		simple-audio-card,dai-link {
>> 			/* DAC */
>> 			format = "i2s";
>> 			bitclock-master = <&dailink_master>;
>> 			frame-master = <&dailink_master>;
>>
>> 			dailink_master: cpu {
>> 			    sound-dai = <&ssi2>;
>> 			};
>> 			codec {
>> 			    sound-dai = <&codec>;
>> 			};
>> 		};
> 
> I remember there is another style for a single dai-link. Could you
> please try that one? There is an example in:
>      Documentation/devicetree/bindings/sound/simple-card.txt

Yes, the

simple-audio-card,cpu
simple-audio-card,format,
....

etc.

I've omitted it since in the code it is regarded as "old":
(simple-card.c line 384).


> 


I think that the proper solution would be to add check for:

freq < sysclk/5 in fsl_ssi_set_dai_sysclk() and return -ENOTSUPP to make 
the simple-audo-card driver happy (and not introducing regressions).


-- 
Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

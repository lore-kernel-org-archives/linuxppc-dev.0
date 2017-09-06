Return-Path: <lukma@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnc092w8gzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 07:19:03 +1000 (AEST)
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
References: <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
 <20170905052031.GB2774@Asurada-CZ80>
 <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
 <20170905181108.GB23906@Asurada-Nvidia>
 <cfb8f844-87aa-f1f3-bd55-4f2b60f3cf88@denx.de>
 <20170905225225.GA14132@Asurada-Nvidia>
 <ae1d3e2a-d618-05e2-1572-5593caff1ee0@denx.de>
 <20170906173348.GA28104@Asurada-Nvidia>
 <69352458-2e90-a847-2c2f-bba259a32162@denx.de>
 <20170906194748.GA31334@Asurada-Nvidia>
From: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@denx.de>
Message-ID: <14a174b2-df3b-73f2-a5c2-7bd4ca9b0882@denx.de>
Date: Wed, 6 Sep 2017 23:18:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170906194748.GA31334@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/06/2017 09:47 PM, Nicolin Chen wrote:
> On Wed, Sep 06, 2017 at 08:35:50PM +0200, Łukasz Majewski wrote:
>   
>> 	clocks = <&clks IMX6QDL_CLK_SSI2_IPG>,
>> 		 <&clks IMX6QDL_CLK_SSI2>;
>> 	clock-names = "ipg", "baud";
> 
>>>>   			dailink_master: cpu {
>>>>   			    sound-dai = <&ssi2>;
>>>> 			    clock = <&SSSS>;
>>
>> 	If possible I do prefer a solution, which uses only DTS.
>> Side question - how to refer to baud clock from [1]?
> 
> Just add a property to this cpu node like:
> 	clock = <&clks IMX6QDL_CLK_SSI2>;

Ok.

> 
>>>> 			    system-clock-frequency = <XXXX>;
> 
> This would not be necessary unless you want to specify a clock rate
> so as to override the clock rate configuration in hw_params().

Ok.

> 
>>> This is the right solution based on current simple-card driver. For
>>> SSI (having two clocks), you have to specify the baud clock in the
>>> cpu node like that. I believe this is what the simple-card designer
>>> expected users to do since the cpu node is the first place that the
>>> driver tries to look at.
>>
>> I will give a shoot the option with adding the ipg clock.
> 
> No, not ipg clock. You should use the second clock -- baud clock.

Yes. Correct - the baud clock.

> 


-- 
Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

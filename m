Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnVzt38jvzDrRw
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 03:33:29 +1000 (AEST)
Received: by mail-pf0-x22c.google.com with SMTP id m1so13830272pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Sep 2017 10:33:29 -0700 (PDT)
Date: Wed, 6 Sep 2017 10:33:50 -0700
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
Message-ID: <20170906173348.GA28104@Asurada-Nvidia>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
 <20170905052031.GB2774@Asurada-CZ80>
 <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
 <20170905181108.GB23906@Asurada-Nvidia>
 <cfb8f844-87aa-f1f3-bd55-4f2b60f3cf88@denx.de>
 <20170905225225.GA14132@Asurada-Nvidia>
 <ae1d3e2a-d618-05e2-1572-5593caff1ee0@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <ae1d3e2a-d618-05e2-1572-5593caff1ee0@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 06, 2017 at 11:22:48AM +0200, Łukasz Majewski wrote:

> >Here is the routine that I understood from the code:
> >1) asoc_simple_card_parse_clk_cpu(dev, cpu, dai_link, cpu_dai);
> >    => asoc_simple_card_parse_clk(dev, cpu,        // cpu node in sound{} [1]
> >		   		 dai_link->cpu_of_node,     // node ssi2 [2]
> >				 cpu_dai, dai_link->cpu_dai_name);
> >    ==> 1.1) devm_get_clk_from_child(dev, node, NULL);                 // [1]
> >    ==> 1.2) of_property_read_u32(node, "system-clock-frequency", &val)// [1]
> >    ==> 1.3) devm_get_clk_from_child(dev, dai_of_node, NULL);          // [2]

> >For the cpu routine, it first checks for clock property under cpu
> >node of simple-card, then for "system-clock-frequency" in the cpu
> >node of simple-card, and finally looks for clock property in ssi2
> >node.

> -----> dev: sound
> -----> clk node: /soc/aips-bus@02000000/spba-bus@02000000/ssi@0202c000
> -----> Clk asignment
> 
> And this clock is taken from this node. It looks like ipg clock for ssi...

This makes sense now. The devm_get_clk_from_child() in 1.3) fetched
the first clock of ssi2 -- ipg clock.

> The problem is with the "lack" of clock nodes/properties at
> 
>  			dailink_master: cpu {
>  			    sound-dai = <&ssi2>;
> 			    clock = <&SSSS>;
> 			    system-clock-frequency = <XXXX>;
>  			};

This is the right solution based on current simple-card driver. For
SSI (having two clocks), you have to specify the baud clock in the
cpu node like that. I believe this is what the simple-card designer
expected users to do since the cpu node is the first place that the
driver tries to look at.

> I think that the proper solution would be to add check for:
> 
> freq < sysclk/5 in fsl_ssi_set_dai_sysclk() and return -ENOTSUPP to
> make the simple-audo-card driver happy (and not introducing
> regressions).

As I said in the first place, adding another check in set_sysclk()
is not that essential but seems to be plausible to me. So I am okay
if you really want to have that.

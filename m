Return-Path: <daniel.baluta@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsndm4WPkzDqd1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 21:47:08 +1100 (AEDT)
Received: by mail-it0-x242.google.com with SMTP id y18so2490170itc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 03:47:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170328092103.GQ6986@localhost.localdomain>
References: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
 <1490691532-2086-3-git-send-email-daniel.baluta@nxp.com>
 <20170328092103.GQ6986@localhost.localdomain>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 28 Mar 2017 13:47:04 +0300
Message-ID: <CAEnQRZAx1o9xtbf3u1A_Zun7MSaJjdjunpJm1Q6=ZAA3beoFbA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v3 2/2] ASoC: imx-wm8962: Fix codec_clk
 cleanup
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
 Timur Tabi <timur@tabi.org>, Xiubo.Lee@gmail.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, fabio.estevam@nxp.com,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 28, 2017 at 12:21 PM, Charles Keepax
<ckeepax@opensource.wolfsonmicro.com> wrote:
> On Tue, Mar 28, 2017 at 11:58:52AM +0300, Daniel Baluta wrote:
>> Resource managed devm_clk_get only works with platform's device dev.
>>
>
> I feel like this could use an explaination of why not using devm
> is the correct fix, rather than just using the platform device
> for the call. Its not obvious to me, that using the platform
> device would be an issue.

Hi Charles,

I see where the confusion comes from :) and I thought the explanation
is obvious from the code, see inline comments.

Would an explanation like the one below, work better?

" We cannot use devm_clk_get with &codec_dev->dev device because
the kernel uses pdev->dev to free the managed resources, so we will end
up with a leaking codec_clk reference"

>> @@ -231,7 +231,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
>>               goto fail;
>>       }

pdev->dev from here:

>>
>> -     codec_clk = devm_clk_get(&codec_dev->dev, NULL);
>> +     codec_clk = clk_get(&codec_dev->dev, NULL);

is different from &codec_dev->dev.

>>       if (IS_ERR(codec_clk)) {
>>               ret = PTR_ERR(codec_clk);
>>               dev_err(&codec_dev->dev, "failed to get codec clk: %d\n", ret);
>> @@ -239,6 +239,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
>>       }
>>
>>       data->clk_frequency = clk_get_rate(codec_clk);
>> +     clk_put(codec_clk);
>>
>>       data->dai.name = "HiFi";
>>       data->dai.stream_name = "HiFi";

thanks,
Daniel.

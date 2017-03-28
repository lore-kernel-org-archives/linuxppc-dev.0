Return-Path: <ckeepax@opensource.wolfsonmicro.com>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsqbd6wLbzDqY6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 23:15:25 +1100 (AEDT)
Date: Tue, 28 Mar 2017 12:53:06 +0100
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
CC: Daniel Baluta <daniel.baluta@nxp.com>, Nicolin Chen
 <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>, <Xiubo.Lee@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 <fabio.estevam@nxp.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [alsa-devel] [PATCH v3 2/2] ASoC: imx-wm8962: Fix codec_clk
 cleanup
Message-ID: <20170328115306.GR6986@localhost.localdomain>
References: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
 <1490691532-2086-3-git-send-email-daniel.baluta@nxp.com>
 <20170328092103.GQ6986@localhost.localdomain>
 <CAEnQRZAx1o9xtbf3u1A_Zun7MSaJjdjunpJm1Q6=ZAA3beoFbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAEnQRZAx1o9xtbf3u1A_Zun7MSaJjdjunpJm1Q6=ZAA3beoFbA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 28, 2017 at 01:47:04PM +0300, Daniel Baluta wrote:
> On Tue, Mar 28, 2017 at 12:21 PM, Charles Keepax
> <ckeepax@opensource.wolfsonmicro.com> wrote:
> > On Tue, Mar 28, 2017 at 11:58:52AM +0300, Daniel Baluta wrote:
> >> Resource managed devm_clk_get only works with platform's device dev.
> >>
> >
> > I feel like this could use an explaination of why not using devm
> > is the correct fix, rather than just using the platform device
> > for the call. Its not obvious to me, that using the platform
> > device would be an issue.
> 
> Hi Charles,
> 
> I see where the confusion comes from :) and I thought the explanation
> is obvious from the code, see inline comments.
> 
> Would an explanation like the one below, work better?
> 
> " We cannot use devm_clk_get with &codec_dev->dev device because
> the kernel uses pdev->dev to free the managed resources, so we will end
> up with a leaking codec_clk reference"
> 
> >> @@ -231,7 +231,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
> >>               goto fail;
> >>       }
> 
> pdev->dev from here:
> 
> >>
> >> -     codec_clk = devm_clk_get(&codec_dev->dev, NULL);
> >> +     codec_clk = clk_get(&codec_dev->dev, NULL);
> 
> is different from &codec_dev->dev.
> 

I get that they are different, I just don't get why changing
from a devm_clk_get to a clk_get is a better fix than changing
&codec->dev to &pdev->dev.

Thanks,
Charles

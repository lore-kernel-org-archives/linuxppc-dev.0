Return-Path: <caleb@crome.org>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0wSM4pNQzDsNS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 09:19:30 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id bd8so5694765plb.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 14:19:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4e69ef31-3aa6-66ea-331b-8a7472a66a15@tabi.org>
References: <1513565530-33957-1-git-send-email-nicoleotsuka@gmail.com>
 <4e69ef31-3aa6-66ea-331b-8a7472a66a15@tabi.org>
From: Caleb Crome <caleb@crome.org>
Date: Mon, 18 Dec 2017 14:19:08 -0800
Message-ID: <CAG5mAdxsWmHfCc=vFkO+Wmi8m0c_9t7B6BTUBGVOmPoGOQrsyg@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] ASoC: fsl_ssi: Clean up - coding style level
To: Timur Tabi <timur@tabi.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, mail@maciej.szmigiero.name,
 Arnaud Mouiche <arnaud.mouiche@invoxia.com>, lukma@denx.de,
 Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 17, 2017 at 7:13 PM, Timur Tabi <timur@tabi.org> wrote:
>
> On 12/17/17 8:51 PM, Nicolin Chen wrote:
>>
>> Nicolin Chen (11):
>>    ASoC: fsl_ssi: Rename fsl_ssi_private to fsl_ssi
>>    ASoC: fsl_ssi: Cache pdev->dev pointer
>>    ASoC: fsl_ssi: Refine all comments
>>    ASoC: fsl_ssi: Rename registers and fields macros
>>    ASoC: fsl_ssi: Refine indentations and wrappings
>>    ASoC: fsl_ssi: Refine printk outputs
>>    ASoC: fsl_ssi: Rename cpu_dai parameter to dai
>>    ASoC: fsl_ssi: Rename scr_val to scr
>>    ASoC: fsl_ssi: Replace fsl_ssi_rxtx_reg_val with fsl_ssi_regvals
>>    ASoC: fsl_ssi: Rename i2smode to i2s_net
>>    ASoC: fsl_ssi: Define ternary macros to simplify code
>
>
> Acked-by: Timur Tabi <timur@tabi.org>


I'm re-setting up my loopback test to try to verify these most recent changes.

I'm starting with the for-next branch at
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git (which
is a 4.15 numbered kernel).

The basic setup is using a wandboard with a TX pin tied directly to an
RX pin do test if what is sent is what is received, using Arnaud's
tester here: https://github.com/amouiche/atest

Unfortunately, it doesn't pass the loopback test, even before these
patches.  I'm not actively developing on this platform at the moment,
and my brain has been out of kernel development for quite a while.

I'm getting channel slips again.

output from atest:

warn:   11a0 11a1 1160 11a3 11a4 11a5 11a6 11a7
warn: Valid frame after 1 invalid frames
warn:   11c0 11c1 11c2 11c3 11c4 11c5 11c6 11c7
warn: first invalid frame while expecting frame 0x00a0
warn:   13e7 1400 1401 1402 1403 1404 1405 1404
warn:   1407 1420 1421 1422 1423 1424 1425 1426
warn:   1427 1440 1441 1442 1443 1444 1445 1484
warn:   1447 1460 1461 1462 1463 1464 1465 1466

Those last 4 lines are the channel slips -- the least significant
nibble should be the channel number:  i.e. should go 0, 1, 2, 3, 4, 5,
6, 7.

Ugh, so it's basically quite broken again -- before these patches.
I guess I need to go backwards in time and see what rev re-broke it.
I don't really have time to dig too deep on this again.

I'd be happy to provide the hardware to anybody that can diagnose and
debug this more quickly than I can.  I'm very inefficient at kernel
drivers I think.   My day job is acoustical and electrical
engineering.

Here's what the hardware looks like for anybody that's interested.
Just a single wire loopback on the wandboard header.

https://ibb.co/d2rfzm

-Caleb

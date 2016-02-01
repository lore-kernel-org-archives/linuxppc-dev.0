Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A79C91A0166
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 23:08:16 +1100 (AEDT)
Message-ID: <56AF4A9F.4060401@maciej.szmigiero.name>
Date: Mon, 01 Feb 2016 13:07:59 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: remove explicit register defaults
References: <569D3800.2040801@maciej.szmigiero.name>
 <CAOMZO5DwQza+jDdkA80v4wkrB56y53tOjkP2-36YNq2WBLodaA@mail.gmail.com>
In-Reply-To: <CAOMZO5DwQza+jDdkA80v4wkrB56y53tOjkP2-36YNq2WBLodaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Fabio,

On 01.02.2016 13:05, Fabio Estevam wrote:
> Hi Maciej,
> 
> On Mon, Jan 18, 2016 at 5:07 PM, Maciej S. Szmigiero
> <mail@maciej.szmigiero.name> wrote:
>> There is no guarantee that on fsl_ssi module load
>> SSI registers will have their power-on-reset values.
>>
>> In fact, if the driver is reloaded the values in
>> registers will be whatever they were set to previously.
>>
>> However, the cache needs to be fully populated at probe
>> time to avoid non-atomic allocations during register
>> access.
>>
>> Special case here is imx21-class SSI, since
>> according to datasheet it don't have SACC{ST,EN,DIS}
>> regs.
>>
>> This fixes hard lockup on fsl_ssi module reload,
>> at least in AC'97 mode.
>>
>> Fixes: 05cf237972fe ("ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast")
>>
>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> 
> I know I have already tested this and it worked fine on a mx6sabresd,
> but running linux-next 20160201 on a mx6sl-evk the ssi driver does not
> probe anymore:
> 
> [    2.216954] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
> [    2.223412] fsl-asoc-card sound: snd_soc_register_card failed (-517)
> [    2.230258] imx-wm8962 sound: ASoC: CPU DAI 202c000.ssi not registered
> [    2.236806] imx-wm8962 sound: snd_soc_register_card failed (-517)
> [    2.244782] snvs_rtc 20cc000.snvs:snvs-rtc-lp: setting system clock
> to 1970-01-01 00:01:14 UTC (74)
> [    2.285864] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
> [    2.292335] fsl-asoc-card sound: snd_soc_register_card failed (-517)
> [    2.299572] imx-wm8962 sound: ASoC: CPU DAI 202c000.ssi not registered
> [    2.306121] imx-wm8962 sound: snd_soc_register_card failed (-517)
> 
> Reverting this patch fixes the problem.
> 
> Wandboard also has the same issue:
> 
> http://arm-soc.lixom.net/bootlogs/next/next-20160201/wandboard-arm-imx_v6_v7_defconfig.html
> 
> Any suggestions?
> 
> Thanks
> 

Is regmap patch from 
http://www.spinics.net/lists/kernel/msg2161934.html
applied to the tested tree?

Best regards,
Maciej

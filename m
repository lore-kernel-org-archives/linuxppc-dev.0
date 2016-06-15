Return-Path: <j.anaszewski@samsung.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTxty0XyMzDqZB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 16:48:57 +1000 (AEST)
Message-id: <5760FA52.7010806@samsung.com>
Date: Wed, 15 Jun 2016 08:48:50 +0200
From: Jacek Anaszewski <j.anaszewski@samsung.com>
MIME-version: 1.0
To: "Andrew F. Davis" <afd@ti.com>
Cc: Russell King <linux@armlinux.org.uk>,
 Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>,
 Wolfram Sang <wsa@the-dreams.de>, Richard Purdie <rpurdie@rpsys.net>,
 Rusty Russell <rusty@rustcorp.com.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Lauro Ramos Venancio <lauro.venancio@openbossa.org>,
 Aloisio Almeida Jr <aloisio.almeida@openbossa.org>,
 Samuel Ortiz <sameo@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 linux-pwm@vger.kernel.org, lguest@lists.ozlabs.org,
 linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 12/12] leds: Only descend into leds directory when
 CONFIG_NEW_LEDS is set
References: <20160613200211.14790-1-afd@ti.com>
 <20160613200211.14790-13-afd@ti.com>
In-reply-to: <20160613200211.14790-13-afd@ti.com>
Content-type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

Thanks for the patch.

Please address the issue [1] raised by test bot and resubmit.

Thanks,
Jacek Anaszewski

[1] https://lkml.org/lkml/2016/6/13/1091

On 06/13/2016 10:02 PM, Andrew F. Davis wrote:
> When CONFIG_NEW_LEDS is not set make will still descend into the leds
> directory but nothing will be built. This produces unneeded build
> artifacts and messages in addition to slowing the build. Fix this here.
>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>   drivers/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 567e32c..fa514d5 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -127,7 +127,7 @@ obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
>   obj-$(CONFIG_CPU_IDLE)		+= cpuidle/
>   obj-$(CONFIG_MMC)		+= mmc/
>   obj-$(CONFIG_MEMSTICK)		+= memstick/
> -obj-y				+= leds/
> +obj-$(CONFIG_NEW_LEDS)		+= leds/
>   obj-$(CONFIG_INFINIBAND)	+= infiniband/
>   obj-$(CONFIG_SGI_SN)		+= sn/
>   obj-y				+= firmware/
>


-- 
Best regards,
Jacek Anaszewski

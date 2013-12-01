Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205]) by ozlabs.org (Postfix) with ESMTP id 886CD2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Dec 2013 06:43:16 +1100 (EST)
Message-ID: <529B9152.9090106@roeck-us.net>
Date: Sun, 01 Dec 2013 11:43:14 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Wim Van Sebroeck <wim@iguana.be>, scottwood@freescale.com
Subject: Re: [PATCH] watchdog: mpc8xxx_wdt: MPC8xx is HW enabled
References: <20131130154540.E83D743E15@localhost.localdomain>
In-Reply-To: <20131130154540.E83D743E15@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/30/2013 07:45 AM, Christophe Leroy wrote:
> MPC8xx watchdog is enabled at startup by HW.
> If the bootloader disables it, it cannot be reenabled.
>

Is that true for all variants of 8xx, especially for 823 ? I am a bit concerned
about breaking compatibility with some chips ... assuming there was a reason
for not setting this flag originally.

Thanks,
Guenter

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>
> diff -ur a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> --- a/drivers/watchdog/mpc8xxx_wdt.c	2013-05-11 22:57:46.000000000 +0200
> +++ b/drivers/watchdog/mpc8xxx_wdt.c	2013-08-08 02:12:15.000000000 +0200
> @@ -273,6 +310,7 @@
>   		.compatible = "fsl,mpc823-wdt",
>   		.data = &(struct mpc8xxx_wdt_type) {
>   			.prescaler = 0x800,
> +			.hw_enabled = true,
>   		},
>   	},
>   	{},
>
> ---
> Ce courrier électronique ne contient aucun virus ou logiciel malveillant parce que la protection avast! Antivirus est active.
> http://www.avast.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

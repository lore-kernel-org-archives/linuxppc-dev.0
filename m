Return-Path: <lee.jones@linaro.org>
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com
 [209.85.223.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3334E1A05B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 19:00:59 +1100 (EST)
Received: by mail-ie0-f180.google.com with SMTP id x19so4905551ier.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Oct 2014 01:00:57 -0700 (PDT)
Date: Tue, 7 Oct 2014 09:00:48 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 12/44] mfd: ab8500-sysctrl: Register with kernel poweroff
 handler
Message-ID: <20141007080048.GB25331@lee--X1>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-13-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1412659726-29957-13-git-send-email-linux@roeck-us.net>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, Linus Walleij <linus.walleij@linaro.org>,
 devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
 lguest@lists.ozlabs.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
 devicetree@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 linux-pm@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net,
 linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
 linux-tegra@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Samuel Ortiz <sameo@linux.intel.com>, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 06 Oct 2014, Guenter Roeck wrote:

> Register with kernel poweroff handler instead of setting pm_power_off
> directly. Register with a low priority value of 64 to reflect that
> the original code only sets pm_power_off if it was not already set.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/mfd/ab8500-sysctrl.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
> index 8e0dae5..677438f 100644
> --- a/drivers/mfd/ab8500-sysctrl.c
> +++ b/drivers/mfd/ab8500-sysctrl.c
> @@ -6,6 +6,7 @@

[...]

> +static int ab8500_power_off(struct notifier_block *this, unsigned long unused1,
> +			    void *unused2)
>  {
>  	sigset_t old;
>  	sigset_t all;
> @@ -34,11 +36,6 @@ static void ab8500_power_off(void)
>  	struct power_supply *psy;
>  	int ret;
>  
> -	if (sysctrl_dev == NULL) {
> -		pr_err("%s: sysctrl not initialized\n", __func__);
> -		return;
> -	}

Can you explain the purpose of this change please?

>  	/*
>  	 * If we have a charger connected and we're powering off,
>  	 * reboot into charge-only mode.
> @@ -83,8 +80,15 @@ shutdown:
>  					 AB8500_STW4500CTRL1_SWRESET4500N);
>  		(void)sigprocmask(SIG_SETMASK, &old, NULL);
>  	}
> +
> +	return NOTIFY_DONE;
>  }

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

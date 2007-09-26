Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 2A165DDDF9
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 22:06:45 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/7] Celleb: Support for Power/Reset buttons
Date: Wed, 26 Sep 2007 13:55:49 +0200
References: <20070926.132556.1723232353.kouish@swc.toshiba.co.jp>
In-Reply-To: <20070926.132556.1723232353.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709261355.50310.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 26 September 2007, Ishizaki Kou wrote:
> This is a patch to support Power/Reset buttons on Beat on Celleb.
> 
> On Beat, we have an event from Beat if Power button or Reset button
> is pressed. This patch catches the event and convert it to a signal
> to INIT process.
> 
> /sbin/inittab have no entry to turn the machine power off so we have
> to detect if power button is pressed or not internally in our driver.
> This idea is taken from PS3's event handling subsystem.
> 
> Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>

Basically looks good. At some point I want to do a similar driver
for the IBM cell blade, but I fear there is not much code we
can share.

> +static irqreturn_t beat_power_event(int virq, void *arg)
> +{
> +	printk(KERN_DEBUG "Beat: power button pressed\n");
> +	beat_pm_poweroff_flag = 1;
> +	if (kill_cad_pid(SIGINT, 1)) {
> +		/* Just in case killing init process failed */
> +		beat_power_off();
> +	}
> +	return IRQ_HANDLED;
> +}

I think this should call ctrl_alt_del() instead of doing 
kill_cad_pid() directly.

Also, I think you should better not call the low-level
beat_power_off() function, but rather a high-level function
that goes through the reboot notifiers first.

kernel_restart() seems appropriate for that.

> +static irqreturn_t beat_reset_event(int virq, void *arg)
> +{
> +	printk(KERN_DEBUG "Beat: reset button pressed\n");
> +	beat_pm_poweroff_flag = 0;
> +	if (kill_cad_pid(SIGINT, 1)) {
> +		/* Just in case killing init process failed */
> +		beat_restart(NULL);
> +	}
> +	return IRQ_HANDLED;
> +}

same here, except calling kernel_halt() in the end.

> +static int __init beat_event_init(void)
> +{
> +	if (!machine_is(celleb) || !firmware_has_feature(FW_FEATURE_BEAT))
> +		return -EINVAL;

Shouldn't one of the two be sufficent? It seems to me that you want to
probe for either celleb or BEAT, but not both, considering that celleb
implies BEAT.

	Arnd <><

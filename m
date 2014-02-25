Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 74A9A2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 09:07:08 +1100 (EST)
Date: Tue, 25 Feb 2014 14:07:05 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] [PATCH] rtc/ds3232: Enable ds3232 to work as wakeup
 source
Message-Id: <20140225140705.fe9f7038bbffbfbde899e0f7@linux-foundation.org>
In-Reply-To: <1390281891-9632-1-git-send-email-dongsheng.wang@freescale.com>
References: <1390281891-9632-1-git-send-email-dongsheng.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: a.zummo@towertech.it, linuxppc-dev@lists.ozlabs.org,
 Dongsheng Wang <dongsheng.wang@freescale.com>, chenhui.zhao@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Jan 2014 13:24:51 +0800 Dongsheng Wang <dongsheng.wang@freescale.com> wrote:

> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Add suspend/resume and device_init_wakeup to enable ds3232 as
> wakeup source, /sys/class/rtc/rtcX/wakealarm for set wakeup alarm.
> 
> ...
> 
> @@ -411,23 +424,21 @@ static int ds3232_probe(struct i2c_client *client,
>  	if (ret)
>  		return ret;
>  
> -	ds3232->rtc = devm_rtc_device_register(&client->dev, client->name,
> -					  &ds3232_rtc_ops, THIS_MODULE);
> -	if (IS_ERR(ds3232->rtc)) {
> -		dev_err(&client->dev, "unable to register the class device\n");
> -		return PTR_ERR(ds3232->rtc);
> -	}
> -
> -	if (client->irq >= 0) {
> +	if (client->irq != NO_IRQ) {

x86_64 allmodconfig:

drivers/rtc/rtc-ds3232.c: In function 'ds3232_probe':
drivers/rtc/rtc-ds3232.c:427: error: 'NO_IRQ' undeclared (first use in this function)
drivers/rtc/rtc-ds3232.c:427: error: (Each undeclared identifier is reported only once
drivers/rtc/rtc-ds3232.c:427: error: for each function it appears in.)

Not all architectures implement NO_IRQ.

I think this should be 

	if (client->irq > 0) {

but I'm not sure - iirc, x86 (at least) treats zero as "not an IRQ". 
But I think some architectures permit IRQ 0.  There was discussion many
years ago but I don't think anything got resolved.


Help!  I think some ppc people will know what to do here?

Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0D31F67A3F
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jul 2006 13:03:38 +1000 (EST)
Date: Mon, 24 Jul 2006 20:03:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: powermac: More powermac backlight fixes
Message-Id: <20060724200315.d3c80ed0.akpm@osdl.org>
In-Reply-To: <20060715130900.GA29287@hansmi.ch>
References: <20060715130900.GA29287@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, johannes@sipsolutions.net, aris@valeta.org,
	linux-kernel@killerfox.forkbomb.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 15 Jul 2006 15:09:00 +0200
Michael Hanselmann <linux-kernel@hansmi.ch> wrote:

> This patch fixes several problems:
> - The legacy backlight value might be set at interrupt time. Introduced
>   a worker to prevent it from directly calling the backlight code.
> - via-pmu allows the backlight to be grabbed, in which case we need to
>   prevent other kernel code from changing the brightness.
> - Don't send PMU requests in via-pmu-backlight when the machine is about
>   to sleep or waking up.
> - More Kconfig fixes.
> 
> ...
>
>  static void pmac_backlight_key_worker(void *data);
> +static void pmac_backlight_set_legacy_worker(void *data);
> +
>  static DECLARE_WORK(pmac_backlight_key_work, pmac_backlight_key_worker, NULL);
> +static DECLARE_WORK(pmac_backlight_set_legacy_work, pmac_backlight_set_legacy_worker, NULL);

I see schedule_work()s in there, but no flush_scheduled_work()s or anything
like that.  Generally, this means there are races against rmmod, close(),
etc.

>  
> +void pmac_backlight_disable()
> +{
> +	atomic_inc(&kernel_backlight_disabled);
> +}
> +
> +void pmac_backlight_enable()
> +{
> +	atomic_dec(&kernel_backlight_disabled);
> +}
> +

So if userspace calls ioctl(PMU_IOC_GRAB_BACKLIGHT) eleven times, eleven
enables are needed?  (Actually, eleven open()/close() sequences, I think).

Methinks you wanted just

	kernel_backlight_disabled = 1;
?

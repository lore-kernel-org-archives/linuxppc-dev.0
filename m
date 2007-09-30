Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 1156ADDE36
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 07:16:58 +1000 (EST)
Date: Sun, 30 Sep 2007 23:17:09 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/7] Celleb: Support for Power/Reset buttons
In-Reply-To: <200709261355.50310.arnd@arndb.de>
Message-ID: <Pine.LNX.4.60.0709302259510.10318@poirot.grange>
References: <20070926.132556.1723232353.kouish@swc.toshiba.co.jp>
	<200709261355.50310.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 26 Sep 2007, Arnd Bergmann wrote:

> On Wednesday 26 September 2007, Ishizaki Kou wrote:
> 
> > +static irqreturn_t beat_power_event(int virq, void *arg)
> > +{
> > +	printk(KERN_DEBUG "Beat: power button pressed\n");
> > +	beat_pm_poweroff_flag = 1;
> > +	if (kill_cad_pid(SIGINT, 1)) {
> > +		/* Just in case killing init process failed */
> > +		beat_power_off();
> > +	}
> > +	return IRQ_HANDLED;
> > +}
> 
> I think this should call ctrl_alt_del() instead of doing 
> kill_cad_pid() directly.

Agree.

> Also, I think you should better not call the low-level
> beat_power_off() function, but rather a high-level function
> that goes through the reboot notifiers first.
> 
> kernel_restart() seems appropriate for that.

Now a comment to this one says:

 *	This is not safe to call in interrupt context.

and AFAIU, this is called from an interrupt. Am I missing anything or 
would this be wrong to call kernel_restart() here?

> > +static irqreturn_t beat_reset_event(int virq, void *arg)
> > +{
> > +	printk(KERN_DEBUG "Beat: reset button pressed\n");
> > +	beat_pm_poweroff_flag = 0;
> > +	if (kill_cad_pid(SIGINT, 1)) {
> > +		/* Just in case killing init process failed */
> > +		beat_restart(NULL);
> > +	}
> > +	return IRQ_HANDLED;
> > +}
> 
> same here, except calling kernel_halt() in the end.

kernel_halt() doesn't have a similar comment, but it does call the 
kernel_shutdown_prepare() too, so, seems like it should not be called from 
an interrupt either?

Now, another question, is it generally good to hard-wire "reset" and 
"power-off" buttons in the kernel? Isn't it better to just register them 
as input event sources and let userspace (power-management daemon) decide 
what to do with them? Like poweroff / reboot / suspend / hibernate / ...

Thanks
Guennadi
---
Guennadi Liakhovetski

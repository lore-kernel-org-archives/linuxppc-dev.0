Return-Path: <jolt@tuxbox.org>
Received: from fiebig.biz (loadbalancer1.core.taytron.net [80.190.249.152])
	by ozlabs.org (Postfix) with ESMTP id 856B96877D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 17:41:42 +1100 (EST)
Message-ID: <43798327.70305@tuxbox.org>
Date: Tue, 15 Nov 2005 07:41:43 +0100
From: Florian Schirmer <jolt@tuxbox.org>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20051114143821.GA28852@logos.cnet>
In-Reply-To: <20051114143821.GA28852@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: obi@saftware.de, carjay@gmx.de,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] m8xx_wdt: software watchdog reset/interrupt select
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

> Note: From my reading of the documentation, even if the SWRI bit is
> unset (interrupt select mode), an NMI at IRQ0 should cause the system to
> jump to exception vector 0x100, resetting the system.
> 
> So I'm wondering if the interrupt mode ever worked?

Never tried the interrupt mode. IMHO doesn't make much sense for a 
watchdog. Why don't you simply set SWRI?


> +static void m8xx_wdt_timer_func(unsigned long data)
> +{
> +	m8xx_wdt_reset();
> +	m8xx_wdt_timer.expires = jiffies + 25;
> +	add_timer(&m8xx_wdt_timer);
> +}
> +
> +void m8xx_wdt_install_timer(volatile immap_t *imap)
> +{
> +	m8xx_wdt_timer.expires = jiffies + 25;
> +	add_timer(&m8xx_wdt_timer);
> +}

m8xx_wdt_install_timer doesn't need imap and you could call it from 
m8xx_wdt_timer_func to re-engange the timer resulting in less duplicated 
code. Just a cosmetic thing though.

Best,
   Florian

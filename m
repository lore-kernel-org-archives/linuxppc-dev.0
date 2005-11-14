Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5791B68755
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 07:55:05 +1100 (EST)
In-Reply-To: <20051114143821.GA28852@logos.cnet>
References: <20051114143821.GA28852@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9E7D3814-47AB-4601-A565-2530C3A4BEE0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Mon, 14 Nov 2005 14:55:24 -0600
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Florian Schirmer <jolt@tuxbox.org>, obi@saftware.de, carjay@gmx.de,
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

Can we put the WDT for 8xx in drivers/char/watchdog/?

- kumar

On Nov 14, 2005, at 8:38 AM, Marcelo Tosatti wrote:

> Hi,
>
> Currently the mpc8xx_wdt driver installs an IRQ handler for
> PIT_INTERRUPT (SIU_LEVEL0, irq 1) to service the WDT until a userspace
> watchdog daemon takes over after boot.
>
> However, if the "software watchdog reset/interrupt select" (SWRI)  
> bit of
> SYPCR register is set, no interrupt is generated. In that  
> configuration
> (the default) HRESET signal is generated if the WDT timeout expires,
> without kernel notification.
>
> The following patch creates a kernel timer to service the WDT and  
> rearm
> itself in case this configuration is detected, making it possible to
> boot the system with the watchdog turned on. The timer is shutdown
> once the userspace daemon open's the device.
>
> Note: From my reading of the documentation, even if the SWRI bit is
> unset (interrupt select mode), an NMI at IRQ0 should cause the  
> system to
> jump to exception vector 0x100, resetting the system.
>
> So I'm wondering if the interrupt mode ever worked?
>
>
> --- ../git/linux-2.6/arch/ppc/syslib/m8xx_wdt.c	2005-11-08  
> 11:38:39.000000000 -0600
> +++ linux-2.6-git-wednov02/arch/ppc/syslib/m8xx_wdt.c	2005-11-14  
> 10:36:53.000000000 -0600
> @@ -45,35 +45,18 @@
>  	return IRQ_HANDLED;
>  }
>
> -void __init m8xx_wdt_handler_install(bd_t * binfo)
> +#define SYPCR_SWP 0x1
> +#define SYPCR_SWRI 0x2
> +#define SYPCR_SWE 0x4
> +
> +/* software watchdog reset/interrupt select */
> +int m8xx_wdt_keepalive_mode = 0;
> +
> +void __init m8xx_wdt_install_irq(volatile immap_t *imap, bd_t *binfo)
>  {
> -	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
>  	u32 pitc;
> -	u32 sypcr;
>  	u32 pitrtclk;
>
> -	sypcr = in_be32(&imap->im_siu_conf.sc_sypcr);
> -
> -	if (!(sypcr & 0x04)) {
> -		printk(KERN_NOTICE "m8xx_wdt: wdt disabled (SYPCR: 0x%08X)\n",
> -		       sypcr);
> -		return;
> -	}
> -
> -	m8xx_wdt_reset();
> -
> -	printk(KERN_NOTICE
> -	       "m8xx_wdt: active wdt found (SWTC: 0x%04X, SWP: 0x%01X)\n",
> -	       (sypcr >> 16), sypcr & 0x01);
> -
> -	wdt_timeout = (sypcr >> 16) & 0xFFFF;
> -
> -	if (!wdt_timeout)
> -		wdt_timeout = 0xFFFF;
> -
> -	if (sypcr & 0x01)
> -		wdt_timeout *= 2048;
> -
>  	/*
>  	 * Fire trigger if half of the wdt ticked down
>  	 */
> @@ -98,6 +81,66 @@
>  	printk(KERN_NOTICE
>  	       "m8xx_wdt: keep-alive trigger installed (PITC: 0x%04X)\n",  
> pitc);
>
> +}
> +
> +static void m8xx_wdt_timer_func(unsigned long data);
> +
> +static struct timer_list m8xx_wdt_timer =
> +	TIMER_INITIALIZER(m8xx_wdt_timer_func, 0, 0);
> +
> +void m8xx_wdt_stop_timer(void)
> +{
> +	del_timer(&m8xx_wdt_timer);
> +}
> +
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
> +
> +void __init m8xx_wdt_handler_install(bd_t * binfo)
> +{
> +	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
> +	u32 sypcr;
> +
> +	sypcr = in_be32(&imap->im_siu_conf.sc_sypcr);
> +
> +	printk(KERN_NOTICE "m8xx_wdt SYPCR: 0x%08X)\n", sypcr);
> +
> +	if (!(sypcr & SYPCR_SWE)) {
> +		printk(KERN_NOTICE "m8xx_wdt: wdt disabled (SYPCR: 0x%08X)\n",
> +		       sypcr);
> +		return;
> +	}
> +
> +	m8xx_wdt_reset();
> +
> +	printk(KERN_NOTICE
> +	       "m8xx_wdt: active wdt found (SWTC: 0x%04X, SWP: 0x%01X)\n",
> +	       (sypcr >> 16), sypcr & SYPCR_SWP);
> +
> +	wdt_timeout = (sypcr >> 16) & 0xFFFF;
> +
> +	if (!wdt_timeout)
> +		wdt_timeout = 0xFFFF;
> +
> +	if (sypcr & SYPCR_SWP)
> +		wdt_timeout *= 2048;
> +
> +	m8xx_wdt_keepalive_mode = sypcr & SYPCR_SWRI;
> +	if (m8xx_wdt_keepalive_mode)
> +		m8xx_wdt_install_timer(imap);
> +	else
> +		m8xx_wdt_install_irq(imap, binfo);
> +
>  	wdt_timeout /= binfo->bi_intfreq;
>  }
>
> --- ../git/linux-2.6/arch/ppc/syslib/m8xx_wdt.h	2005-10-10  
> 18:06:12.000000000 -0500
> +++ linux-2.6-git-wednov02/arch/ppc/syslib/m8xx_wdt.h	2005-11-14  
> 10:37:39.000000000 -0600
> @@ -9,8 +9,12 @@
>  #ifndef _PPC_SYSLIB_M8XX_WDT_H
>  #define _PPC_SYSLIB_M8XX_WDT_H
>
> +extern int m8xx_wdt_keepalive_mode;
> +
>  extern void m8xx_wdt_handler_install(bd_t * binfo);
>  extern int m8xx_wdt_get_timeout(void);
>  extern void m8xx_wdt_reset(void);
> +extern void m8xx_wdt_install_timer(volatile immap_t *imap);
> +extern void m8xx_wdt_stop_timer(void);
>
>  #endif				/* _PPC_SYSLIB_M8XX_WDT_H */
> --- ../git/linux-2.6/drivers/char/watchdog/mpc8xx_wdt.c	2005-10-10  
> 18:06:15.000000000 -0500
> +++ linux-2.6-git-wednov02/drivers/char/watchdog/mpc8xx_wdt.c	 
> 2005-11-14 10:37:15.000000000 -0600
> @@ -27,7 +27,10 @@
>  {
>  	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
>
> -	imap->im_sit.sit_piscr &= ~(PISCR_PIE | PISCR_PTE);
> +	if (m8xx_wdt_keepalive_mode)
> +		m8xx_wdt_stop_timer();
> +	else
> +		imap->im_sit.sit_piscr &= ~(PISCR_PIE | PISCR_PTE);
>
>  	printk(KERN_NOTICE "mpc8xx_wdt: keep-alive handler deactivated\n");
>  }
> @@ -36,7 +39,10 @@
>  {
>  	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
>
> -	imap->im_sit.sit_piscr |= PISCR_PIE | PISCR_PTE;
> +	if (m8xx_wdt_keepalive_mode)
> +		m8xx_wdt_install_timer(imap);
> +	else
> +		imap->im_sit.sit_piscr |= PISCR_PIE | PISCR_PTE;
>
>  	printk(KERN_NOTICE "mpc8xx_wdt: keep-alive handler activated\n");
>  }
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

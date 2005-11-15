Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3E90B68748
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 21:52:57 +1100 (EST)
Date: Tue, 15 Nov 2005 03:42:16 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Florian Schirmer <jolt@tuxbox.org>
Message-ID: <20051115054216.GB29963@logos.cnet>
References: <20051114143821.GA28852@logos.cnet> <43798327.70305@tuxbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43798327.70305@tuxbox.org>
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

Hi Florian!

On Tue, Nov 15, 2005 at 07:41:43AM +0100, Florian Schirmer wrote:
> Hi,
> 
> >Note: From my reading of the documentation, even if the SWRI bit is
> >unset (interrupt select mode), an NMI at IRQ0 should cause the system to
> >jump to exception vector 0x100, resetting the system.
> >
> >So I'm wondering if the interrupt mode ever worked?
> 
> Never tried the interrupt mode. IMHO doesn't make much sense for a 
> watchdog. Why don't you simply set SWRI?

The SYPCR register can be set only _once_ at machine startup and the
bootloader in question does not have an option to change the mode. Many
bootloaders probably dont.

> >+static void m8xx_wdt_timer_func(unsigned long data)
> >+{
> >+	m8xx_wdt_reset();
> >+	m8xx_wdt_timer.expires = jiffies + 25;
> >+	add_timer(&m8xx_wdt_timer);
> >+}
> >+
> >+void m8xx_wdt_install_timer(volatile immap_t *imap)
> >+{
> >+	m8xx_wdt_timer.expires = jiffies + 25;
> >+	add_timer(&m8xx_wdt_timer);
> >+}
> 
> m8xx_wdt_install_timer doesn't need imap and you could call it from 
> m8xx_wdt_timer_func to re-engange the timer resulting in less duplicated 
> code. Just a cosmetic thing though.

Indeed. Will update the patch and resend you for review.

Thanks

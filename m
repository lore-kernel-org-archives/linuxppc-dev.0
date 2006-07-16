Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3AE3067B7B
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Jul 2006 05:19:34 +1000 (EST)
Subject: Re: crash in aty128_set_lcd_enable on PowerBook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20060716165004.GA16369@suse.de>
References: <20060716163728.GA16228@suse.de> <20060716165004.GA16369@suse.de>
Content-Type: text/plain
Date: Sun, 16 Jul 2006 15:19:09 -0400
Message-Id: <1153077550.5905.33.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-07-16 at 18:50 +0200, Olaf Hering wrote:
>  On Sun, Jul 16, Olaf Hering wrote:
> 
> > 
> > Current Linus tree crashes in aty128_set_lcd_enable() because par->pdev
> > is NULL. This happens since at least a week. Call trace is:
> > 
> > aty128_set_lcd_enable
> > aty128fb_set_par
> > fbcon_init
> > visual_init
> > take_over_console
> > fbcon_takeover
> > notifier_call_chain
> > blocking_notifier_call_chain
> > register_framebuffer
> > aty128fb_probe
> 
> aty128_init calls register_framebuffer() before it assigns pdev.

Yeah, that looks like some serious bogosity in that code. Care to send a
patch ?

>    2028         if (register_framebuffer(info) < 0)
>    2029                 return 0;
>    2030 
>    2031         par->pm_reg = pci_find_capability(pdev, PCI_CAP_ID_PM);
>    2032         par->pdev = pdev;
>    2033         par->asleep = 0;
>    2034         par->lock_blank = 0;
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

Return-Path: <olh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5DD4167B81
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Jul 2006 02:50:09 +1000 (EST)
Date: Sun, 16 Jul 2006 18:50:04 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: crash in aty128_set_lcd_enable on PowerBook
Message-ID: <20060716165004.GA16369@suse.de>
References: <20060716163728.GA16228@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060716163728.GA16228@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sun, Jul 16, Olaf Hering wrote:

> 
> Current Linus tree crashes in aty128_set_lcd_enable() because par->pdev
> is NULL. This happens since at least a week. Call trace is:
> 
> aty128_set_lcd_enable
> aty128fb_set_par
> fbcon_init
> visual_init
> take_over_console
> fbcon_takeover
> notifier_call_chain
> blocking_notifier_call_chain
> register_framebuffer
> aty128fb_probe

aty128_init calls register_framebuffer() before it assigns pdev.

   2028         if (register_framebuffer(info) < 0)
   2029                 return 0;
   2030 
   2031         par->pm_reg = pci_find_capability(pdev, PCI_CAP_ID_PM);
   2032         par->pdev = pdev;
   2033         par->asleep = 0;
   2034         par->lock_blank = 0;

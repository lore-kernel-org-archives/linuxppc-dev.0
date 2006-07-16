Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 136A067B85
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Jul 2006 02:37:33 +1000 (EST)
Date: Sun, 16 Jul 2006 18:37:28 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: crash in aty128_set_lcd_enable on PowerBook
Message-ID: <20060716163728.GA16228@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Current Linus tree crashes in aty128_set_lcd_enable() because par->pdev
is NULL. This happens since at least a week. Call trace is:

aty128_set_lcd_enable
aty128fb_set_par
fbcon_init
visual_init
take_over_console
fbcon_takeover
notifier_call_chain
blocking_notifier_call_chain
register_framebuffer
aty128fb_probe
pci_device_probe
bus_for_each_dev
driver_attach
bus_add_driver
driver_register
__pci_register_driver
aty128fb_init
init
kernel_thread

This happens on a PowerBook pismo.

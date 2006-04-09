Return-Path: <kernel@andred.net>
Received: from andred.net (sushi.andred.net [217.160.180.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6950C67B2E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Apr 2006 08:39:11 +1000 (EST)
Message-ID: <44398BD4.60904@andred.net>
Date: Mon, 10 Apr 2006 00:33:56 +0200
From: Andre Draszik <kernel@andred.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Slab errors on 4xx (STB04)
Content-Type: text/plain; charset=UTF-8
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

I am trying to use the "ppc-soc-ohci" driver on a redwood5 based board
w/ kernel 2.6.17-rc1. It's not really inspiring confidence, because I
get tons of messages similar to these

[  595.693614] slab error in cache_free_debugcheck(): cache `size-32':
double free, or memory outside object was overwritten
[  595.704278] Call Trace:
[  595.706683] [C056BE10] [C0009DD8] show_stack+0x58/0x194 (unreliable)
[  595.712967] [C056BE40] [C0009F2C] dump_stack+0x18/0x28
[  595.718028] [C056BE50] [C006103C] __slab_error+0x2c/0x3c
[  595.723265] [C056BE60] [C0062FF8] cache_free_debugcheck+0x23c/0x2e0
[  595.729427] [C056BE90] [C0063F64] kfree+0x8c/0x118
[  595.734152] [C056BEC0] [C68F46D0] usb_get_status+0x94/0xac [usbcore]
[  595.740718] [C056BEF0] [C68EEA44] choose_configuration+0x2c/0x1b8
[usbcore]
[  595.747758] [C056BF10] [C68EECCC] usb_new_device+0xfc/0x1bc [usbcore]
[  595.754286] [C056BF30] [C68F0034] hub_port_connect_change+0x24c/0x3dc
[usbcore]
[  595.761669] [C056BF60] [C68F0530] hub_events+0x36c/0x498 [usbcore]
[  595.767955] [C056BF90] [C68F066C] hub_thread+0x10/0xf0 [usbcore]
[  595.774073] [C056BFC0] [C0037CA0] kthread+0xbc/0xc4
[  595.778889] [C056BFF0] [C000525C] kernel_thread+0x44/0x60
[  595.784228] c0dec610: redzone 1:0x5a2cf071, redzone 2:0x170fc2a5.

when accessing devices.

Since it _seems_ to work nevertheless - is CONFIG_DEBUG_SLAB known to be
broken on this platform? (Although such stack traces are only printed
when doing sth with the USB). Or is this caused by some other (memory
initialization?) error?


Greetings,
Andre'

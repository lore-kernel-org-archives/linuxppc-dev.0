Return-Path: <stelian@popies.net>
Received: from sd291.sivit.org (sd291.sivit.org [194.146.225.122])
	by ozlabs.org (Postfix) with ESMTP id 401C468964
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jan 2006 23:06:50 +1100 (EST)
From: Stelian Pop <stelian@popies.net>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
In-Reply-To: <20051231235124.GA18506@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
	<200512252304.32830.dtor_core@ameritech.net>
	<20051231235124.GA18506@hansmi.ch>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 02 Jan 2006 13:06:40 +0100
Message-Id: <1136203601.5803.17.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@killerfox.forkbomb.ch,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Vojtech Pavlik <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple
	PowerBooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Le dimanche 01 janvier 2006 à 00:51 +0100, Michael Hanselmann a écrit :
> On Sun, Dec 25, 2005 at 11:04:30PM -0500, Dmitry Torokhov wrote:
> > Well, we have used 11 out of 32 available bits so there still some
> > reserves. My concern is that your implementation allows only one
> > hook to be installed while with quirks you can have several of them
> > active per device.
> 
> Below you find an implementation using quirks:
> 
> ---
> diff -rNup linux-2.6.15-rc7.orig/drivers/usb/input/hid-core.c linux-2.6.15-rc7/drivers/usb/input/hid-core.c
> --- linux-2.6.15-rc7.orig/drivers/usb/input/hid-core.c	2006-01-01 00:41:15.000000000 +0100
> +++ linux-2.6.15-rc7/drivers/usb/input/hid-core.c	2005-12-31 22:39:53.000000000 +0100
> @@ -1580,6 +1580,10 @@ static struct hid_blacklist {
>  	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
>  	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
>  
> +	{ USB_VENDOR_ID_APPLE, 0x0214, HID_QUIRK_POWERBOOK_HAS_FN },
> +	{ USB_VENDOR_ID_APPLE, 0x0215, HID_QUIRK_POWERBOOK_HAS_FN },
> +	{ USB_VENDOR_ID_APPLE, 0x0216, HID_QUIRK_POWERBOOK_HAS_FN },
> +

Works fine for me on a slightly older (jul '05) Powerbook after adding
the following USB identifiers:

+       { USB_VENDOR_ID_APPLE, 0x020E, HID_QUIRK_POWERBOOK_HAS_FN },
+       { USB_VENDOR_ID_APPLE, 0x020F, HID_QUIRK_POWERBOOK_HAS_FN },
+       { USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_POWERBOOK_HAS_FN },
+       { USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_POWERBOOK_HAS_FN },

Mine is a 020F but the other three ones should be fine too (those are
taken from the appletouch trackpad driver).

Stelian.
-- 
Stelian Pop <stelian@popies.net>

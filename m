Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 52C79DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 02:36:51 +1000 (EST)
Date: Wed, 1 Aug 2007 09:36:04 -0700
From: Greg KH <gregkh@suse.de>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: 2.6.23-rc1-mm2
Message-ID: <20070801163604.GC27879@suse.de>
References: <20070731230932.a9459617.akpm@linux-foundation.org>
	<200708011002.30962.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200708011002.30962.m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulus@samba.org, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 01, 2007 at 10:02:30AM +0200, Mariusz Kozlowski wrote:
> Then reattaching a usb mouse caused this (only once)
> 
> usb 2-1: USB disconnect, address 2
> BUG: atomic counter underflow at:
>  [<c010456a>] show_trace_log_lvl+0x1a/0x30
>  [<c010508d>] show_trace+0x12/0x14
>  [<c01051e0>] dump_stack+0x15/0x17
>  [<c01418cf>] __free_pages+0x50/0x52
>  [<c01418f0>] free_pages+0x1f/0x21
>  [<c010783d>] dma_free_coherent+0x43/0x9c
>  [<c0315067>] hcd_buffer_free+0x43/0x6a
>  [<c030b2b4>] usb_buffer_free+0x23/0x29
>  [<c0346db4>] hid_free_buffers+0x23/0x71
>  [<c0346eb2>] hid_disconnect+0xb0/0xc8
>  [<c0313676>] usb_unbind_interface+0x30/0x72
>  [<c02c6df0>] __device_release_driver+0x6a/0x92
>  [<c02c71c3>] device_release_driver+0x20/0x36
>  [<c02c6736>] bus_remove_device+0x62/0x85
>  [<c02c49f8>] device_del+0x16d/0x27c
>  [<c0310f25>] usb_disable_device+0x7a/0xe2
>  [<c030d0bc>] usb_disconnect+0x94/0xde
>  [<c030e030>] hub_thread+0x2fe/0xc1b
>  [<c0128aee>] kthread+0x36/0x58
>  [<c0104233>] kernel_thread_helper+0x7/0x14
>  =======================
> uhci_hcd 0000:00:0c.0: dma_pool_free buffer-32, 6b6b6b6b/6b6b6b6b (bad dma)
> 
> Every new try shows:
> 
> usb 2-1: new low speed USB device using uhci_hcd and address 3
> usb 2-1: new device found, idVendor=046d, idProduct=c00e
> usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
> usb 2-1: Product: USB-PS/2 Optical Mouse
> usb 2-1: Manufacturer: Logitech
> usb 2-1: configuration #1 chosen from 1 choice
> input: Logitech USB-PS/2 Optical Mouse as /class/input/input9
> input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:0c.0-1
> usb 2-1: USB disconnect, address 3
> uhci_hcd 0000:00:0c.0: dma_pool_free buffer-32, 6b6b6b6b/6b6b6b6b (bad dma)
> 
> But mouse works ok.

Can you see if the patch posted by Jiri fixes this or not?

thanks,

greg k-h

Return-Path: <adaplas@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id 4552B67A3E
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Aug 2006 09:50:53 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id f25so773741pyf
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 16:50:53 -0700 (PDT)
Message-ID: <44CE974B.1090605@gmail.com>
Date: Tue, 01 Aug 2006 07:50:35 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] crash in aty128_set_lcd_enable on PowerBook
References: <20060716163728.GA16228@suse.de> <20060731185024.GA5117@suse.de>
In-Reply-To: <20060731185024.GA5117@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering wrote:
>  On Sun, Jul 16, Olaf Hering wrote:
> 
>> Current Linus tree crashes in aty128_set_lcd_enable() because par->pdev
>> is NULL. This happens since at least a week. Call trace is:
>>
>> aty128_set_lcd_enable
>> aty128fb_set_par
>> fbcon_init
>> visual_init
>> take_over_console
>> fbcon_takeover
>> notifier_call_chain
>> blocking_notifier_call_chain
>> register_framebuffer
>> aty128fb_probe
>> pci_device_probe
>> bus_for_each_dev
>> driver_attach
>> bus_add_driver
>> driver_register
>> __pci_register_driver
>> aty128fb_init
>> init
>> kernel_thread
>>
> 
> 
> - info->fix was assigned twice.
> - par->vram_size is assigned in aty128_probe(), no need to redo it again in aty128_init()
> - register_framebuffer() uses uninitialized struct members,
>   move it past par->pdev assignment and past aty128_bl_init().
> 
> 

Looks good.

> Signed-off-by: Olaf Hering <olh@suse.de>
Acked-by: Antonino Daplas <adaplas@pol.net>

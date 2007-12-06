Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C7619DDE2A
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 17:44:03 +1100 (EST)
Date: Thu, 06 Dec 2007 15:43:55 +0900 (JST)
Message-Id: <20071206.154355.-1300541609.kouish@swc.toshiba.co.jp>
To: arnd@arndb.de
Subject: Re: [PATCH 2/3] celleb: add supporting for native CBE
In-Reply-To: <200712041421.47378.arnd@arndb.de>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 04 December 2007, Ishizaki Kou wrote:
> > This patch adds supporting for native CBE on Celleb. Many codes in
> > platforms/cell/ are used when native CBE environment.
> > 
> > Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>
> 
> Ah, excellent to hear that this is now working!
> 
> I'd suggest doing the initialization in a different way, so that you don't
> need to decide on so many attributes dynamically. The easiest way would
> probably be to have two separate define_machine() calls in the celleb
> definition, like
> 
> define_machine(celleb_beat) {
>         .probe                  = celleb_probe_beat,
>         .setup_arch             = celleb_setup_arch_native,
>         .show_cpuinfo           = celleb_show_cpuinfo,
>         .restart                = beat_restart,
>         .power_off              = beat_power_off,
>         .halt                   = beat_halt,
>         .get_rtc_time           = beat_get_rtc_time,
>         .set_rtc_time           = beat_set_rtc_time,
>         .calibrate_decr         = generic_calibrate_decr,
>         .progress               = celleb_progress,
>         .power_save             = beat_power_save,
>         .nvram_size             = beat_nvram_get_size,
>         .nvram_read             = beat_nvram_read,
>         .nvram_write            = beat_nvram_write,
>         .set_dabr               = beat_set_xdabr,
>         .init_IRQ               = beatic_init_IRQ,
>         .get_irq                = beatic_get_irq,
>         .pci_probe_mode         = celleb_pci_probe_mode,
>         .pci_setup_phb          = celleb_setup_phb,
> 	...
> };
> 
> define_machine(celleb_native) {
>         .probe                  = celleb_probe_native,
>         .setup_arch             = celleb_setup_arch_native,
>         .show_cpuinfo           = celleb_show_cpuinfo,
>         .restart                = rtas_restart,
>         .power_off              = rtas_power_off,
>         .halt                   = rtas_halt,
>         .get_rtc_time           = rtas_get_rtc_time,
>         .set_rtc_time           = rtas_set_rtc_time,
>         .calibrate_decr         = generic_calibrate_decr,
>         .progress               = celleb_progress,
>         .init_IRQ               = celleb_init_IRQ_native,
>         .get_irq                = celleb_get_irq_native,
>         .pci_probe_mode         = celleb_pci_probe_mode,
>         .pci_setup_phb          = celleb_setup_phb,
> 	...
> };
> 
> For this, you can either have the two machine definitions in the
> same celleb/setup.c, or split setup.c into machine specific files,
> depending on how much ends up being shared in the end.

Thanks for your suggestion. I'll try to split into two machine
definitions.


> An interesting question still is how close the native celleb machine
> definition is to the one from platforms/cell/setup.c. Maybe it's best
> to have a common machine definition for these two in the end.

You know celleb-native is between celleb-beat and cell blade. I also
think it's best if we can use a common machine definition and a common
setup code. But there are many differences mainly caused by their
firmwares, and this disturbs the integration. I think celleb-native is
closer to celleb-beat than to cell blade. So I put celleb-native code
in platforms/celleb.


> 	Arnd <><
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

Best regards,
Kou Ishizaki

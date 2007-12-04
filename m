Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 7F067DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 00:21:59 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] celleb: add supporting for native CBE
Date: Tue, 4 Dec 2007 14:21:46 +0100
References: <20071204.173824.-1350527485.kouish@swc.toshiba.co.jp>
In-Reply-To: <20071204.173824.-1350527485.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712041421.47378.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 04 December 2007, Ishizaki Kou wrote:
> This patch adds supporting for native CBE on Celleb. =A0Many codes in
> platforms/cell/ are used when native CBE environment.
>=20
> Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>

Ah, excellent to hear that this is now working!

I'd suggest doing the initialization in a different way, so that you don't
need to decide on so many attributes dynamically. The easiest way would
probably be to have two separate define_machine() calls in the celleb
definition, like

define_machine(celleb_beat) {
        .probe                  =3D celleb_probe_beat,
        .setup_arch             =3D celleb_setup_arch_native,
        .show_cpuinfo           =3D celleb_show_cpuinfo,
        .restart                =3D beat_restart,
        .power_off              =3D beat_power_off,
        .halt                   =3D beat_halt,
        .get_rtc_time           =3D beat_get_rtc_time,
        .set_rtc_time           =3D beat_set_rtc_time,
        .calibrate_decr         =3D generic_calibrate_decr,
        .progress               =3D celleb_progress,
        .power_save             =3D beat_power_save,
        .nvram_size             =3D beat_nvram_get_size,
        .nvram_read             =3D beat_nvram_read,
        .nvram_write            =3D beat_nvram_write,
        .set_dabr               =3D beat_set_xdabr,
        .init_IRQ               =3D beatic_init_IRQ,
        .get_irq                =3D beatic_get_irq,
        .pci_probe_mode         =3D celleb_pci_probe_mode,
        .pci_setup_phb          =3D celleb_setup_phb,
	...
};

define_machine(celleb_native) {
        .probe                  =3D celleb_probe_native,
        .setup_arch             =3D celleb_setup_arch_native,
        .show_cpuinfo           =3D celleb_show_cpuinfo,
        .restart                =3D rtas_restart,
        .power_off              =3D rtas_power_off,
        .halt                   =3D rtas_halt,
        .get_rtc_time           =3D rtas_get_rtc_time,
        .set_rtc_time           =3D rtas_set_rtc_time,
        .calibrate_decr         =3D generic_calibrate_decr,
        .progress               =3D celleb_progress,
        .init_IRQ               =3D celleb_init_IRQ_native,
        .get_irq                =3D celleb_get_irq_native,
        .pci_probe_mode         =3D celleb_pci_probe_mode,
        .pci_setup_phb          =3D celleb_setup_phb,
	...
};

=46or this, you can either have the two machine definitions in the
same celleb/setup.c, or split setup.c into machine specific files,
depending on how much ends up being shared in the end.

An interesting question still is how close the native celleb machine
definition is to the one from platforms/cell/setup.c. Maybe it's best
to have a common machine definition for these two in the end.

	Arnd <><

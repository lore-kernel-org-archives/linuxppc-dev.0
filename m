Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id 2C8F1DDDE5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Feb 2007 19:29:30 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: New driver model in 2.6
Date: Wed, 14 Feb 2007 09:29:26 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E651F70@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Anyone knows how, where, when the match device of spi_bus_type structure
is called? I put a printk in spi_match_device function and registered an
spi device in this way:

static struct spi_board_info spi_board_info[] __initdata =3D {
        {
                .modalias       =3D "m25p80",
                .max_speed_hz   =3D 16000000,
                .bus_num        =3D 0,
                .chip_select    =3D 0,
        },
};

static int board_init_spi(void)
{
        printk("%s\n", __FUNCTION__);
        spi_register_board_info(spi_board_info,
ARRAY_SIZE(spi_board_info));
        return 0;
}

But spi_match_device is not called and consequently the _probe function
of m25p80 driver is never called.

Any help is appreciated,
Antonio.

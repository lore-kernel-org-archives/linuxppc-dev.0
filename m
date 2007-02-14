Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id 1749DDDE00
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Feb 2007 22:39:38 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: New driver model in 2.6
Date: Wed, 14 Feb 2007 12:39:35 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E652034@aquib01a>
In-Reply-To: <200702141032.28005.laurent.pinchart@technotrade.biz>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: "Laurent Pinchart" <laurent.pinchart@technotrade.biz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>spi_register_board_info() will add the board information structure to=20
>board_list in drivers/spi/spi.c. The list is walked from
scan_boardinfo() in=20
>the same file when a SPI master is registered by spi_register_master().
The=20
>first step would be to check if spi_register_master() is called, and if
it=20
>fails before calling scan_boardinfo(). Add a few printk's there.

>If a master is correctly registered, scan_boardinfo() will call=20
>spi_new_device(), which in turn calls device_register(). That's where
the=20
>spi_match_device() function should be called, using the function
pointer=20
>stored in proxy->dev.bus.match.

Thank you for your help, is it possible that calling
spi_register_master() before the spi_register_board_info() and before
the registration for m25p80 spi device causes the problem?=20

Thank you.

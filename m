Return-Path: <laurent.pinchart@technotrade.biz>
Received: from outmx012.isp.belgacom.be (outmx012.isp.belgacom.be
	[195.238.5.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D881DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Feb 2007 20:32:45 +1100 (EST)
Received: from outmx012.isp.belgacom.be (localhost [127.0.0.1])
	by outmx012.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1E9WUqp014421
	for <linuxppc-embedded@ozlabs.org>; Wed, 14 Feb 2007 10:32:30 +0100
	(envelope-from <laurent.pinchart@technotrade.biz>)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: New driver model in 2.6
Date: Wed, 14 Feb 2007 10:32:27 +0100
References: <F1F6EC0C8B75034F9E3A79FC85122E8E651F70@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E651F70@aquib01a>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702141032.28005.laurent.pinchart@technotrade.biz>
Cc: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
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
> Anyone knows how, where, when the match device of spi_bus_type structure
> is called? I put a printk in spi_match_device function and registered an
> spi device in this way:
>
> static struct spi_board_info spi_board_info[] __initdata = {
>         {
>                 .modalias       = "m25p80",
>                 .max_speed_hz   = 16000000,
>                 .bus_num        = 0,
>                 .chip_select    = 0,
>         },
> };
>
> static int board_init_spi(void)
> {
>         printk("%s\n", __FUNCTION__);
>         spi_register_board_info(spi_board_info,
> ARRAY_SIZE(spi_board_info));
>         return 0;
> }
>
> But spi_match_device is not called and consequently the _probe function
> of m25p80 driver is never called.

spi_register_board_info() will add the board information structure to 
board_list in drivers/spi/spi.c. The list is walked from scan_boardinfo() in 
the same file when a SPI master is registered by spi_register_master(). The 
first step would be to check if spi_register_master() is called, and if it 
fails before calling scan_boardinfo(). Add a few printk's there.

If a master is correctly registered, scan_boardinfo() will call 
spi_new_device(), which in turn calls device_register(). That's where the 
spi_match_device() function should be called, using the function pointer 
stored in proxy->dev.bus.match.

Hope this helps.

Best regards,

Laurent Pinchart

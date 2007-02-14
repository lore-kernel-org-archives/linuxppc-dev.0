Return-Path: <laurent.pinchart@technotrade.biz>
Received: from outmx011.isp.belgacom.be (outmx011.isp.belgacom.be
	[195.238.5.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 795E6DDE05
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Feb 2007 22:56:02 +1100 (EST)
Received: from outmx011.isp.belgacom.be (localhost [127.0.0.1])
	by outmx011.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1EBtuNf032603
	for <linuxppc-embedded@ozlabs.org>; Wed, 14 Feb 2007 12:55:56 +0100
	(envelope-from <laurent.pinchart@technotrade.biz>)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
Subject: Re: New driver model in 2.6
Date: Wed, 14 Feb 2007 12:55:47 +0100
References: <F1F6EC0C8B75034F9E3A79FC85122E8E652034@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E652034@aquib01a>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702141255.47603.laurent.pinchart@technotrade.biz>
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

Hi,

> > spi_register_board_info() will add the board information structure to
> > board_list in drivers/spi/spi.c. The list is walked from scan_boardinfo()
> > in the same file when a SPI master is registered by spi_register_master().
> > The first step would be to check if spi_register_master() is called, and
> > if it fails before calling scan_boardinfo(). Add a few printk's there.
> >
> > If a master is correctly registered, scan_boardinfo() will call
> > spi_new_device(), which in turn calls device_register(). That's where
> > the spi_match_device() function should be called, using the function
> > pointer stored in proxy->dev.bus.match.
>
> Thank you for your help, is it possible that calling
> spi_register_master() before the spi_register_board_info() and before
> the registration for m25p80 spi device causes the problem?

I think it might, but I'm not sure. Try registering the master after 
registering board information if you can.

Laurent Pinchart

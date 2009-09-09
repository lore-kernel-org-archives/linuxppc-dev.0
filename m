Return-Path: <michaelbarkowski@ruggedcom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 23BF4B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Sep 2009 23:42:06 +1000 (EST)
Received: from mail.ruggedcom.com (mail.ruggedcom.com [204.50.190.93])
	by ozlabs.org (Postfix) with ESMTP id 8AA5BDDD01
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Sep 2009 23:42:05 +1000 (EST)
Message-ID: <4AA7B0AB.10309@ruggedcom.com>
Date: Wed, 09 Sep 2009 09:42:03 -0400
From: Michael Barkowski <michaelbarkowski@ruggedcom.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Bug in of_mpc8xxx_spi chipselect
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just want to document this bug, since I don't have time to make a patch:

In of_mpc8xxx_spi_get_chipselects():

	pinfo->alow_flags[i] = flags & OF_GPIO_ACTIVE_LOW;

	ret = gpio_direction_output(pinfo->gpios[i],
				    pinfo->alow_flags[i]);


The initial value of the chip should be disabled.  If SPI_CS_HIGH, value of 0 means disabled - ok, but...

If not SPI_CS_HIGH for a given device (which is the case for most devices), that device will be enabled until it is disabled at the end of the first transaction to that device.  If there are transactions to other devices on the same bus in the meantime, this device may be confused and fail the first transaction.

Maybe the chip select should be disabled until the device entry is initialized with full knowledge of its configuration.  Not sure of the right solution.

-- 
Michael Barkowski
905-482-4577

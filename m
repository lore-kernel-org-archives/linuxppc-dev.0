Return-Path: <yuli@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B984667A6D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Mar 2005 07:39:56 +1100 (EST)
From: Yuli Barcohen <yuli@arabellasw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16946.530.358572.465485@astp0002.localdomain>
Date: Fri, 11 Mar 2005 22:39:46 +0200
To: "Vijay Padiyar" <vijay_padiyar@hotmail.com>
In-Reply-To: <BAY1-DAV11E7EFC29304B234EEB9A38B530@phx.gbl>
References: <BAY1-DAV11E7EFC29304B234EEB9A38B530@phx.gbl>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: query regarding I2C controller on MPC8260
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> Vijay Padiyar writes:

    Vijay> Hi there I am using an MPC8260-based target board. My target
    Vijay> is running U-Boot 1.1.2 as the bootloader and Linux-2.6.10 as
    Vijay> the kernel with BusyBox-1.0. I wish to use the I2C controller
    Vijay> on the MPC8260 to access an external EEPROM connected to
    Vijay> it. I need to do this from *user space*.

    Vijay> From what I understand, we can open the I2C device with the
    Vijay> open command from our application as follows:

    Vijay> ret = open ("/dev/i2c-0", O_RDWR);

    Vijay> After this, the device should be accessible using either
    Vijay> standard I2C functions or SMBus functions.

    Vijay> I read that if the I2C controller supports SMBus, it will be
    Vijay> preferable to access the device via the SMBus read/write
    Vijay> functions, as they seem to be more "efficient." What I want
    Vijay> to know is, does the PowerPC I2C controller support the SMBus
    Vijay> protocol? I don't think it does, judging from the MPC8260
    Vijay> manual, but just want to be sure.

It does not support SMBus but since it's a full-featured I2C controller,
it's not a problem. SMBus emulation mode can be used on any I2C
controller.

    Vijay> Also, do we need to create the /dev/i2c-0 device file
    Vijay> manually or will it be created on the fly?

It depends on the /dev filesystem which you use. If it's devfs (or you
use udev), the file will be created on the fly, otherwise you have to
create it manually.

-- 
========================================================================
 Yuli Barcohen       | Phone +972-9-765-1788 |  Software Project Leader
 yuli@arabellasw.com | Fax   +972-9-765-7494 | Arabella Software, Israel
========================================================================

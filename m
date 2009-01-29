Return-Path: <lherrera@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 3A039DE03F
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 07:38:31 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [QUESTION] PPC4xx SPI mode
Date: Thu, 29 Jan 2009 15:38:17 -0500
Message-ID: <6FCCA913376DD7488F4139A4D11B8F488BD2B4@troe2k1.cs.myharris.net>
In-Reply-To: <6FCCA913376DD7488F4139A4D11B8F48146489@troe2k1.cs.myharris.net>
References: <6FCCA913376DD7488F4139A4D11B8F48146489@troe2k1.cs.myharris.net>
From: "Herrera-Bendezu, Luis" <lherrera@harris.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Actually SPI_IOC_WR_MODE changes are not used for file I/O read() and
write(). SPI_IOC_MESSAGE uses modified SPI parameters only when ioctl()
argument struct spio_ioc_transfer fields: speed_hz and bits_per_word are
non-zero.

This mechanism is enforced by spi_bitbang.c function bitbang_work()
that calls setup_transfer function (in my case spi_ppc4xx_setupxfer())
only when the above condition is true.

On the other hand, read() and write() queue their messages with struct
spi_transfer fields speed_hz and bits_per_word set to 0.=20

IMHO all three cases should behave similarly.

Regards,
Luis=20

-----Original Message-----
From: linuxppc-dev-bounces+lherrera=3Dharris.com@ozlabs.org
[mailto:linuxppc-dev-bounces+lherrera=3Dharris.com@ozlabs.org] On Behalf
Of Herrera-Bendezu, Luis
Sent: Wednesday, January 28, 2009 7:08 PM
To: linuxppc-dev@ozlabs.org
Subject: [QUESTION] PPC4xx SPI mode


I am using PPC440EPx SPI driver to access devices with different clock
polarities (SPI_MODE_0 and SPI_MODE_2), but otherwise similar SPI
parameters (max clock frequency, bits per word, etc.) If spidev is
used to modify clock polarity via ioctl SPI_IOC_WR_MODE, it does not
have any effect on the controller.

This list has dicussed a related issue:
http://ozlabs.org/pipermail/linuxppc-dev/2009-January/066749.html

that explains why SPI_IOC_WR_MODE does not work, function
spi_ppc4xx_setupxfer() is called only once by spi_ppc4xx_setup()
function. Any subsequent call just ignores request to change SPI
configuration and does not report any error.

Is this how the driver is supposed to work?
Can the above usage be acommodated into the driver?

Thanks,
Luis


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev

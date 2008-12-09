Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id C918EDDF2B
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 08:48:16 +1100 (EST)
Message-ID: <493EE79C.9000405@harris.com>
Date: Tue, 09 Dec 2008 16:48:12 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v5] spi: Add PPC4xx SPI driver
References: <1227628088-10849-1-git-send-email-sr@denx.de>
In-Reply-To: <1227628088-10849-1-git-send-email-sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> This adds a SPI driver for the SPI controller found in the IBM/AMCC
> 4xx PowerPC's.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
> Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> ---

I have a question as to how to use this driver.  of_num_gpios() starts
testing for gpio's at num = 0, and stops at the first invalid one.
However, gpio numbers are apparently allocated dynamically from 255 down,
meaning that there probably is no gpio-0.

For example, on my Sequoia board I have gpiochip176, gpiochip192,
and gpiochip224.  So, of_num_gpios() returns zero, even though there
are 72 gpio's on my board.

This gets back to an earlier discussion about setting the gpio index
of each controller, which was rejected, IIRC.  If we could set the
base gpio of each chip, we could start at zero and use consecutive
numbers.  Failing that, it seems that Stefan's SPI driver needs to
probe the entire 0-255 gpio space.

How is this intended to work?  An example .dts would be greatly
appreciated.

	Steve

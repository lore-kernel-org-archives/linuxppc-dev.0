Return-Path: <bgat@billgatliff.com>
Received: from mail-iw0-f172.google.com (mail-iw0-f172.google.com
	[209.85.223.172]) by ozlabs.org (Postfix) with ESMTP id DAD6BB7C27
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2010 07:13:42 +1100 (EST)
Received: by iwn2 with SMTP id 2so11740004iwn.16
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2010 12:13:40 -0800 (PST)
Message-ID: <4B4B866B.10207@billgatliff.com>
Date: Mon, 11 Jan 2010 14:13:31 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Sleep-capable GPIO slave-selects on MPC52xx?
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guys:


A platform I have inherited utilizes a GPIO on an I2C expander chip
(MAX7314) as a SPI slave-select.  I'm using the actual MPC52xx SPI
peripheral, not a PSC.

It looks like the current version of the MPC52xx SPI driver won't work
with sleep-capable GPIOs for slave-selects.  In particular, it looks
like mpc52xx_spi_fsmstate_transfer() is an interrupt handler that calls
mpc52xx_spi_chipsel(), which itself calls gpio_set_value().  Or, at
least my kernel thinks so, since I get a barrage of oops-type output
screaming at me whenever I hit the SPI device.  :)

Am I missing something, or is this a known (or at least now-identified)
limitation of the current mpc52xx_spi.c?


Thanks!


b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat@billgatliff.com

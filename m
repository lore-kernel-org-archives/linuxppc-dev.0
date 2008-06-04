Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E40C1DDF6E
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 01:24:25 +1000 (EST)
Message-ID: <4846B39F.3010601@freescale.com>
Date: Wed, 04 Jun 2008 10:24:15 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <200806041706.21557.sr@denx.de>
In-Reply-To: <200806041706.21557.sr@denx.de>
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
> I'm wondering what is currently recommended in the I2C device tree nodes? The 
> current IBM I2C driver (i2c-ibm_iic.c) checks "index" and most FSL dts files 
> use "cell-index". Some 4xx dts files implement "cell-index" some have no 
> index at all.
> 
> So what should be used here. Please advise and I'll prepare a patch for it.

I just posted a patch for the FSL I2C driver to check for cell-index.  I'm under
the impression that cell-index is the standard for enumerating devices in the
device tree.

My vote: any driver that currently checks for index should first check
cell-index, and any device tree that has index should add cell-index.  In time,
we can remove 'index' from the device trees.

-- 
Timur Tabi
Linux kernel developer at Freescale

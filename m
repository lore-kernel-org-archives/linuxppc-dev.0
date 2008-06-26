Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 19A4BE0017
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 01:55:35 +1000 (EST)
Message-ID: <4863BBE2.2060107@freescale.com>
Date: Thu, 26 Jun 2008 10:55:14 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] powerpc: add of_find_next_property and
	of_get_aliased_index
References: <1214424332-18496-1-git-send-email-timur@freescale.com>
	<c293d4d144094e5b0311b703e64893dc@kernel.crashing.org>
	<4863B1C1.1060300@freescale.com> <200806261751.05379.sr@denx.de>
In-Reply-To: <200806261751.05379.sr@denx.de>
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
> On Thursday 26 June 2008, Timur Tabi wrote:
>>> The only thing a platform should ever use aliases for is if it needs
>>> to (for whatever purpose) find a specific device, that it cannot
>>> identify otherwise (via "reg", ...).  And then that platform code
>>> should look up the device by the alias, not look up the alias by the
>>> device -- there is no 1-1 mapping from device to alias!
>> Hmmm, I hadn't through about that.  I guess this patch isn't such a great
>> idea after all.  I rescind it.
> 
> Too bad. So now we're back to where we started with the discussion 
> about "cell-index" vs. "index" vs. no index on I2C device nodes. :-(

Well, there's a lot of disagreement on this subject.  Not only do we not agree
on a method of enumerating devices, a lot of people have a problem with the
concept of enumerating them in the first place!

This whole thing started with a problem I had in ASoC V2: identifying an I2C
device by name and number.  Scott W. pointed out that all I need in my "fabric
driver" is a pointer to the i2c_adapter structure that the I2C driver was using.
 If we create a link from the I2C device node to its matching i2c_adapter
structure, then I won't care what the adapter/bus number is.  Unfortunately, it
appears the current I2C code in fsl_soc.c can't handle that, but of_i2c.c can.

-- 
Timur Tabi
Linux kernel developer at Freescale

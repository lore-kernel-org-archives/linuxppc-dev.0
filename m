Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3CDA6DE606
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 01:35:54 +1000 (EST)
Message-ID: <4848036D.5060004@freescale.com>
Date: Thu, 05 Jun 2008 10:17:01 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <200806041706.21557.sr@denx.de>
	<20080604220555.658ab13e@vader.jdub.homelinux.org>
	<20080604231641.786bb2dd@lappy.seanm.ca>
	<200806050822.00797.sr@denx.de>
In-Reply-To: <200806050822.00797.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Jean Delvare <khali@linux-fr.org>, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:

> So what should we do now? Currently I2C doesn't work at all on 4xx since the 
> driver expects the "index" property and no dts sets this property. Personally 
> I would like to move to using cell-index here, since this seems to be more 
> common. But I could also life with removing the index property and using 
> the "static index" if this is preferred and/or acceptable.

My opinion:

In situations where it doesn't matter which I2C bus is #1 and which one is #2,
then I think the code should just initialize idx based on the order the nodes
are found in the tree.

In situations where it does matter, then we should use cell-index.

The patch I posted ("Update fsl_soc to use cell-index property of I2C nodes")
does both.  If the cell-index property is present, then its value is used in the
call to platform_device_register_simple().  Otherwise, it just keeps count of
each node, and uses that count.

-- 
Timur Tabi
Linux kernel developer at Freescale

Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 11920DDE1D
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 08:50:49 +1000 (EST)
Message-ID: <4818F7C2.2030408@freescale.com>
Date: Wed, 30 Apr 2008 17:50:42 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: cbouatmailru@gmail.com
Subject: Re: [PATCH v2 4/6] [POWERPC] QE: implement support for the GPIO	LIB
	API
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190045.GD21203@polina.dev.rtsoft.ru>
	<20080430193040.GA9239@polina.dev.rtsoft.ru>
	<4818CB8B.9010106@freescale.com> <20080430224726.GA5529@zarina>
In-Reply-To: <20080430224726.GA5529@zarina>
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

Anton Vorontsov wrote:

> Per Grant Likely's comments, "fsl,qe-pario-bank" considered as a made up
> stuff. MPC8323 is the first QE chip, so every next QE chips should be
> compatible.

Ok.

>> Return value should be "u32", not "int".
> 
> gpio.h disagree
> 
> $ cat include/asm-generic/gpio.h  | grep \*get
>         int                     (*get)(struct gpio_chip *chip,
> 

In that case, perhaps you should return this:

	return in_be32(&regs->cpdata) & pin_mask ? 1 : 0;

-- 
Timur Tabi
Linux kernel developer at Freescale

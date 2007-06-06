Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EFD9ADDEF1
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 08:19:35 +1000 (EST)
Message-ID: <466732EE.8080306@freescale.com>
Date: Wed, 06 Jun 2007 17:19:26 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MPC8349ea Random Device Generator driver
References: <BAY122-F18923A7AA6D3A4D96A360085200@phx.gbl>
	<20070606220913.GA27820@lixom.net> <46673009.6000109@freescale.com>
	<200706070011.43347.arnd@arndb.de>
In-Reply-To: <200706070011.43347.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, sl@powerlinux.fr,
	Philippe Lachenal <philippe.lachenal@hotmail.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:

> The only code that is allowed to dereference an __iomem pointer is the
> implementation of readl/writel and similar functions.
> The code you gave as an example gives you a warning when building with
> make C=1 using sparse, and missed barriers.

Well, that's why I said "or something like that".

Anyway, there's a more fundamental problem.  I can't find any 64-bit versions of the 
in_be/out_be/read/write functions.  Because the registers are big-endian, then we have a 
few choices:

1) Create 64-bit versions of these functions.  Can someone tell me why they don't exist 
already?

2) Do something stupid like u32 v = in_be32(((void *) &rng->rngisr) + 4);

3) Change the struct like this:

struct sec_rng {
	__be32	rngmr_hi;
	__be32	rngmr_lo;
	u8 res1[8];
	__be32 rngdsr_hi;
	__be32 rngdsr_lo;
	__be32 rngrcr_hi;
	__be32 rngrcr_lo;
...

Comments?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale

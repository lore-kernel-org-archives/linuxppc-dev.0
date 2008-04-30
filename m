Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19611DDED4
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 09:03:52 +1000 (EST)
Message-ID: <4818FAD1.8020808@freescale.com>
Date: Wed, 30 Apr 2008 18:03:45 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: cbouatmailru@gmail.com
Subject: Re: [PATCH v2 4/6] [POWERPC] QE: implement support for the GPIO LIB
	API
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190045.GD21203@polina.dev.rtsoft.ru>
	<20080430193040.GA9239@polina.dev.rtsoft.ru>
	<4818CB8B.9010106@freescale.com> <20080430224726.GA5529@zarina>
	<4818F7C2.2030408@freescale.com> <20080430225951.GA10361@zarina>
In-Reply-To: <20080430225951.GA10361@zarina>
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

> What is the problem with returning (int)(u32 & u32) value?

Technically, a signed int is smaller than an unsigned int, so a value of
0x80000000 won't fit in an 'int'.

> You've asked to remove "!!" stuff and now purposing exactly the
> same... :-?

The !! stuff was because the function was returning a boolean value, so non-zero
== TRUE.  I don't think the return value from 'get' is a technically a boolean,
so I'm assuming that the spec says the return value should be 0 or 1, to reflect
the value of that GPIO pin.

-- 
Timur Tabi
Linux kernel developer at Freescale

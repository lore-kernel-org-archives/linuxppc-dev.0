Return-Path: <kim.phillips@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0EF41DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 02:44:25 +1100 (EST)
Date: Wed, 29 Oct 2008 10:54:13 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: jhsiao@amcc.com
Subject: Re: [PATCH] AMCC Crypto4xx Device Driver v2]
Message-Id: <20081029105413.895d5cdb.kim.phillips@freescale.com>
In-Reply-To: <1225246700.1850.61.camel@jhsiao-usb>
References: <1225237276.1850.13.camel@jhsiao-usb>
	<20081028205132.255e674d@zod.rchland.ibm.com>
	<1225246700.1850.61.camel@jhsiao-usb>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 28 Oct 2008 19:18:20 -0700
James Hsiao <jhsiao@amcc.com> wrote:

> On Tue, 2008-10-28 at 20:51 -0400, Josh Boyer wrote:
> > - The question on ABLKCIPHER kconfig was ignored
> Is ABLKCIPHER a sub set of BLKCIPHER? So, if BLKCIPHER is selected then
> if ABLKCIPHER is present, it will use ABLKCIPHER otherwise using
> BLKCIPHER algorithm? Correct?

this is my bad, commit 653ebd9c8510a7d647ed23e66e1338f848ebdbab
"blkcipher: Merge ablkcipher and blkcipher into one option/module"
renders CRYPTO_ABLKCIPHER obsolete in favour of CRYPTO_BLKCIPHER.

> > - Marking functions static
> We have more than one file, that is why some of the function are not
> static.

have one file then?

> > - Global lsec_core variable which doesn't allow for more than one
> > device
> We only support single incidence of device.

it's also a matter of unnecessarily polluting global namespace.

> > - Complete lack of locking code, how do you enforce mutually exclusive
> > access to the device?
> 
> The crypto engine have couple bits 'command ready' and 'packet done',
> which servers as semaphore here. So, software don't need extra locking.

know if it's applicable at all, but I imagine it's not SMP safe.

Kim

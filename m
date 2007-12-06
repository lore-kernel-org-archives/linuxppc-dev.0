Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ACDA5DDD01
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 11:05:44 +1100 (EST)
Message-ID: <47573CCE.4000606@freescale.com>
Date: Wed, 05 Dec 2007 18:05:34 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] qe: add ability to upload QE firmware
References: <11968944871776-git-send-email-timur@freescale.com>
	<200712060031.43171.arnd@arndb.de> <4757362F.7040404@freescale.com>
	<200712060056.39368.arnd@arndb.de>
In-Reply-To: <200712060056.39368.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:

> What does the firmware node contain then? The way I read it, you only put
> metadata about the uploaded firmware in there, but not the blob itself, right?

That's correct.  The meta-data is only the information that a device driver 
would need to identify and interact with the microcode.

> Is there a case where you don't need the firmware in order to start the
> kernel, but still want to provide it in flash?

I don't think you'll ever need the firmware to *start* the kernel.

> In that case, I think it
> would really be better to just put the blob into the tree and only
> have the fw loading code in the kernel instead of duplicating it in the boot
> loader.

That would require the firmware to present in RAM for all time, since the device 
tree cannot be unloaded.  Besides, you might need to have the firmware loaded in 
U-Boot anyway.  If your console is connected to the QE, then you'll need the 
UART firmware loaded before you can see anything.  That's why U-Boot needs its 
own version.

> Regarding the question whether the firmware should be a device node or
> a property of another node, I'd prefer a simple property, because the
> firmware itself is not really a device you can access, but I don't care
> much about that.

Technically, the firmware could be considered a device on the QE, because it's 
loaded into I-RAM and it can significantly alter the behavior of the device. 
Having it its own node also lets me compartmentalize it.  If I want to expand 
the node and add more properties, it's cleaner.

-- 
Timur Tabi
Linux kernel developer at Freescale

Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C63F2DE0CE
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:46:13 +1100 (EST)
Message-ID: <4758193B.5080707@freescale.com>
Date: Thu, 06 Dec 2007 09:46:03 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] qe: add ability to upload QE firmware
References: <11968944871776-git-send-email-timur@freescale.com>
	<200712060117.14768.arnd@arndb.de> <47580F43.7020404@freescale.com>
	<200712061631.19485.arnd@arndb.de>
In-Reply-To: <200712061631.19485.arnd@arndb.de>
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

> My point is that you could have some extra code that calls your
> qe_upload_firmware() when the device tree contains the blob but the boot
> loader did not already load it.

The current design of the 'firmware' node is such that if present, that means 
that the firmware has already been uploaded.

We can't use the device tree to tell the kernel which firmware to upload, 
because that is determined exclusively by the user's application.  The drivers 
are ultimately responsible for deciding which firmware to use.

> This helps e.g. for the case where you
> want to be able to install a generic Linux distribution that is not
> able to ship with your firmware blob in the kernel or the root file system.
> Putting the blob in the device tree makes it easier to get to a running
> system then.

But where would the blob come from?  Probably from flash or a TFTP server.  In 
that case, the boot loader can still handle it.

> You can argue that the boot loader can always load the firmware in the
> first place, but then you wouldn't need an implementation of
> qe_upload_firmware in the kernel any more.

You might want to do runtime swapping of firmwares.  One of the drawbacks of the 
QE microcode design is that you can only have one microcode uploaded at a time. 
  If you need to have two different microcodes (e.g. Soft-UART and 
interworking), then you need to merge the source code for those two into a new 
microcode and compile that.

You might need to do full reset of the QE, which would require re-uploading.

You might not know until after the kernel boots which firmware you want.

In reality, having the boot loader load the firmware will usually be the 
preferred approach, because that's simpler.  Having it in both U-Boot and the 
kernel covers all situations, though.  There would be no need for the bootloader 
to pass the firmware to the kernel.

-- 
Timur Tabi
Linux kernel developer at Freescale

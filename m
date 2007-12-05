Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4D330DDE0F
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 10:37:28 +1100 (EST)
Message-ID: <4757362F.7040404@freescale.com>
Date: Wed, 05 Dec 2007 17:37:19 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] qe: add ability to upload QE firmware
References: <11968944871776-git-send-email-timur@freescale.com>
	<200712060031.43171.arnd@arndb.de>
In-Reply-To: <200712060031.43171.arnd@arndb.de>
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

> Of course, that approach does not help you if the blob is not GPL compatible
> and you are relying on the dts file to be linked into the kernel, 

Well, the blobs will never be GPL compatible, which is why I created the 
firmware binary format.  Previously, the firmware was shipped as header files 
with code like this:

#define MPC8323_R1_0_UC_PATCH   \
{   \
	  0xb3ff0006   \
	, 0xffffffff   \
	, 0xb3ff0009   \
	, 0xffffffff   \
	, 0xb3ff000c   \
	, 0xffffffff   \

and so on.

To address the issue of loading the firmware before the kernel boots, I have 
ported qe_upload_firmware() to U-Boot, and provided a command-line command for 
uploading a firmware at an address in flash.  The blob can be placed in flash, 
and then a boot script will load it.  The U-Boot version of qe_upload_firmware() 
will also create the 'firmware' node in the device tree.

-- 
Timur Tabi
Linux kernel developer at Freescale

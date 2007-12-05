Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 73663DDD0A
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 10:32:01 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2] qe: add ability to upload QE firmware
Date: Thu, 6 Dec 2007 00:31:42 +0100
References: <11968944871776-git-send-email-timur@freescale.com>
In-Reply-To: <11968944871776-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200712060031.43171.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 05 December 2007, Timur Tabi wrote:
> Define the layout of a binary blob that contains a QE firmware and instru=
ctions
> on how to upload it. =A0Add function qe_upload_firmware() to parse the bl=
ob
> and perform the actual upload. =A0Fully define 'struct rsp' in immap_qe.h=
 to
> include the actual RISC Special Registers.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>

The code looks entirely fine to me, but after looking at it, it occurred to
me that you may want to think about having support for autoloading
the firmware based on a property in the device tree. For the spidernet
driver on the Cell blade, we first also did an implementation that called
request_firmware to load the microcode into the spider chip, but we later
added a property (24kb long in our case) that simply contained the whole
blob in the the device tree.
This made it _much_ easier to support things like NFS root and distribution
installers and avoided all licensing problems because the blob can now
be shipped with the board instead of as part of the GPL software.

Of course, that approach does not help you if the blob is not GPL compatible
and you are relying on the dts file to be linked into the kernel, but it
may be good if your driver supports it anyway so you can pass it down from
the system boot loader to the kernel. In your driver, it's just a few lines
of extra code and you can of course still leave the request_firmware call
in place for other scenarios.

	Arnd <><

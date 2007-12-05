Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 5D223DDE2A
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 10:56:49 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2] qe: add ability to upload QE firmware
Date: Thu, 6 Dec 2007 00:56:38 +0100
References: <11968944871776-git-send-email-timur@freescale.com>
	<200712060031.43171.arnd@arndb.de> <4757362F.7040404@freescale.com>
In-Reply-To: <4757362F.7040404@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712060056.39368.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 06 December 2007, Timur Tabi wrote:
> Arnd Bergmann wrote:
>=20
> > Of course, that approach does not help you if the blob is not GPL compa=
tible
> > and you are relying on the dts file to be linked into the kernel,=20
>=20
> Well, the blobs will never be GPL compatible, which is why I created the=
=20
> firmware binary format.

Well, you never know if someone might be willing to reverse-engineer
them and provide free replacements ;-). But that wasn't my point.

> To address the issue of loading the firmware before the kernel boots, I h=
ave=20
> ported qe_upload_firmware() to U-Boot, and provided a command-line comman=
d for=20
> uploading a firmware at an address in flash. =A0The blob can be placed in=
 flash,=20
> and then a boot script will load it. =A0The U-Boot version of qe_upload_f=
irmware()=20
> will also create the 'firmware' node in the device tree.

What does the firmware node contain then? The way I read it, you only put
metadata about the uploaded firmware in there, but not the blob itself, rig=
ht?

Is there a case where you don't need the firmware in order to start the
kernel, but still want to provide it in flash? In that case, I think it
would really be better to just put the blob into the tree and only
have the fw loading code in the kernel instead of duplicating it in the boot
loader.

Regarding the question whether the firmware should be a device node or
a property of another node, I'd prefer a simple property, because the
firmware itself is not really a device you can access, but I don't care
much about that.

	Arnd <><

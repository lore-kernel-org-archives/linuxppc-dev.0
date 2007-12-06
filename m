Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 87C27DDF78
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:31:32 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2] qe: add ability to upload QE firmware
Date: Thu, 6 Dec 2007 16:31:18 +0100
References: <11968944871776-git-send-email-timur@freescale.com>
	<200712060117.14768.arnd@arndb.de> <47580F43.7020404@freescale.com>
In-Reply-To: <47580F43.7020404@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712061631.19485.arnd@arndb.de>
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
> > I'm not trying to convince you of this if it's completely pointless for
> > all your systems, just want to make sure you're aware of this option,
> > because spending a few extra code lines on it now may save you some tro=
uble
> > if you need this later.
>=20
> Um, I think I'm a little confused as to what your point is. =A0My code is=
 just a=20
> generic QE firmware uploader.

My point is that you could have some extra code that calls your
qe_upload_firmware() when the device tree contains the blob but the boot
loader did not already load it. This helps e.g. for the case where you
want to be able to install a generic Linux distribution that is not
able to ship with your firmware blob in the kernel or the root file system.
Putting the blob in the device tree makes it easier to get to a running
system then.

You can argue that the boot loader can always load the firmware in the
first place, but then you wouldn't need an implementation of
qe_upload_firmware in the kernel any more.

	Arnd <><

Return-Path: <SHorton@kodiaknetworks.com>
Received: from cowboy.inovate.inovate.com (planomail.kodiaknetworks.com
	[76.203.108.6]) by ozlabs.org (Postfix) with ESMTP id 604A3DE065
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 05:23:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Problem with cuImage Linux entry from old U-boot
Date: Tue, 22 Jul 2008 14:23:39 -0500
Message-ID: <295C5089A56CE143B316E5F67CA99CB001D0637A@cowboy.inovate.inovate.com>
In-Reply-To: <20080722180506.GB13940@loki.buserror.net>
References: <295C5089A56CE143B316E5F67CA99CB001D0626A@cowboy.inovate.inovate.com>
	<20080722180506.GB13940@loki.buserror.net>
From: "Stephen Horton" <SHorton@kodiaknetworks.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks Scott for the tip. I'll redouble my efforts to compare the code
in my older 1.1.2 U-boot source (that the board boots from) with my new
.dts and cuboot source.

-----Original Message-----
From: Scott Wood [mailto:scottwood@freescale.com]=20
Sent: Tuesday, July 22, 2008 1:05 PM
To: Stephen Horton
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Problem with cuImage Linux entry from old U-boot

On Mon, Jul 21, 2008 at 03:39:55PM -0500, Stephen Horton wrote:
> I have made great strides with help from this mailing list and its
> archives. I now have a compiled cuImage ready to boot from my older
> working u-boot 1.1.2. I now seem to be stuck at the kernel entry
point.
> I'm not sure if I'm trying to jump into the kernel at the wrong
address,
> or if I have a serial console issue that prevents me from seeing
anymore
> progress.

Most likely the latter, or some other issue that prevents the kernel
from
booting to the point where the serial console functions.

> Linux/PowerPC load: ip=3Dbootp root=3D/dev/nfs rw =
nfsroot=3D/opt/gentoo
> console=3DttyMM0,9600n8
> Finalizing device tree... flat tree at 0x7423a0
>=20
> =20
>=20
> ------
>=20
> =20
>=20
> If I run 'nm' on my elf image, I expect to find some entry point
address
> that corresponds to 0x7423a0, but this is not the case.=20

Why would you expect that?  It's a dynamically allocated chunk of memory
that holds the device tree that is passed to the kernel.  It's not an
entry
point; the entry point to the kernel is zero.

-Scott

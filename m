Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D4DFADDFD0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 04:13:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Problem with cuImage Linux entry from old U-boot
Date: Tue, 22 Jul 2008 11:13:09 -0700
Message-ID: <161B3BAD77161449A144FF054231C3D60249D825@uss-am-xch-01.am.trimblecorp.net>
In-Reply-To: <20080722180506.GB13940@loki.buserror.net>
References: <295C5089A56CE143B316E5F67CA99CB001D0626A@cowboy.inovate.inovate.com>
	<20080722180506.GB13940@loki.buserror.net>
From: "Mike Timmons" <mike_timmons@trimble.com>
To: "Scott Wood" <scottwood@freescale.com>,
	"Stephen Horton" <SHorton@kodiaknetworks.com>
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

Related question: I'm using a newer U-boot and managing the load of the
kernel and the device tree from separate partitions of my boot media.

Having the two partitions and managing the kernel and the tree
separately is a bit cumbersome, or maybe I'm just lazy. Regardless, can
I just use that "static" file name option when I build the kernel, load
the cuImage, and just invoke=20

bootm <cuImageLoadAddress> ?

Will it work to just leave off the - <device tree Ram address>

I think I had it set-p right yesterday and I gave it a try, but no joy.

Can it be this simple to statically link the device tree with the kernel
build? For my application I don't see a benefit in keeping them separate
(the kernel and the tree).

Thanks,
Mike


-----Original Message-----
From: linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org]
On Behalf Of Scott Wood
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
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 2B033B7002
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 18:34:00 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 17681-02 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 09:33:37 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 7/7] [v5] drivers/virt: introduce Freescale
	hypervisormanagement driver
Date: Fri, 10 Jun 2011 09:32:08 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AD8B@saturn3.aculab.com>
In-Reply-To: <201106092213.13755.arnd@arndb.de>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Arnd Bergmann" <arnd@arndb.de>, "Timur Tabi" <timur@freescale.com>,
	<linuxppc-dev@lists.ozlabs.org>
Cc: konrad.wilk@oracle.com, greg@kroah.com, kumar.gala@freescale.com,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	akpm@kernel.org, linux-console@vger.kernel.org,
	virtualization@lists.linux-foundation.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> > +enum fsl_hv_ioctl_cmd {
> > +       FSL_HV_IOCTL_PARTITION_RESTART =3D _IOWR(0, 1, struct
fsl_hv_ioctl_restart),
...
> > +};
>=20
> Using a #define here is usually preferred because then you=20
> can use #ifdef in a user application to check if a given
> value has been assigned.

It is also possible to add:
#define FSL_HV_IOCTL_PARTITION_RESTART FSL_HV_IOCTL_PARTITION_RESTART
to have much the same effect.
But there are many cases where #defines are better.
I only tend to use enums when the constanst are beting generated
by the expansion of a #define.

> More importantly, the code you have chose (0) conflicts with=20
> existing drivers (frame buffer, scsi and wavefront among others).
> Please chose a free one and
> add it to Documentation/ioctl/ioctl-number.txt in the same patch.

It is rather a PITA that, when 'int' went from 16 to 32 bits, the
BSD people used the high 16 bits for size/flags rather than
using the extra bits to help make ioctl's unique.
Linux seems to have copied BSD here - rather than SYSV.

One problem with clashing ioctl commands is when systems like
NetBSD are running linux binaries and need to translate ioctl
buffers to/from native format. If the ioctl commands are
unique this can be done much more easily.

	David

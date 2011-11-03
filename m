Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 2598AB6F7B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2011 23:17:37 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 27468-09 for <linuxppc-dev@lists.ozlabs.org>;
 Thu,  3 Nov 2011 12:17:33 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc/usb: use unsigned long to type cast an address of
 ioremap
Date: Thu, 3 Nov 2011 12:16:02 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AEA4@saturn3.aculab.com>
In-Reply-To: <4EB283F5.6000202@freescale.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Tabi Timur-B04825" <B04825@freescale.com>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Xie Shaohui-B21989 <B21989@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >> >  usb_sys_regs =3D (void *)dr_regs + USB_DR_SYS_OFFSET;
>=20
> > But that is invalid C.
>=20
> What's invalid about it?  I haven't tried compiling this=20
> specific line of code, but I've done stuff like it in the past many
times.
>=20
> Are you talking about adding an integer to a void pointer? =20
> If so, then that's something that gcc supports and that the kernel
uses=20
> all over the place.

Arithmetic on 'void *' should not be done. I know some versions of
gcc allow it (provided some warning level/option is enabled) but
that doesn't mean it is valid.
My suspicions are that is was allowed due to the way 'void *'
was originally bodged into gcc.

> A char* is incorrect because a char could be more=20
> than one byte, in theory.

It is somewhat difficult to untangle the standard, but
sizeof (char) is defined to be one.

Of course, the C language doesn't actually require that
you can converts between pointers to different types in
any well-defined manner. But most of the low level device
access assumes an adequately linear address space.

	David

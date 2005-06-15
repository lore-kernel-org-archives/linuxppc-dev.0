Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id 3173467B46
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2005 03:50:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 15 Jun 2005 19:47:56 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B36@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: linuxppc-dev@ozlabs.org
Subject: RE : Error while opennig device file
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm sorry but this is a "copy to mail" error. =20
Here is the right code:

ret_val =3D system("mknod -m 777 /dev/test1 c 122 1");
ret_val =3D system("mknod -m 777 /dev/test2 c 122 2");

file_desc1 =3D open("/dev/test1", O_RDWR);
file_desc2 =3D open("/dev/test2", O_RDWR);

Sorry again but I would have liked that it was so easy...lol

-------- Message d'origine--------
De: Eugene Surovegin [mailto:ebs@ebshome.net]
Date: mer. 15/06/2005 19:26
=C0: Garcia J=E9r=E9mie
Cc: linuxppc-dev@ozlabs.org
Objet : Re: Error while opennig device file
=20
On Wed, Jun 15, 2005 at 06:19:43PM +0200, Garcia J?r?mie wrote:
> Hi everybody,
> I'd like to have your opinion on such a stupid question. Indeed, it =
must be very easy to see but
> I can't find out what goes on.
> I'm writing a device driver. In the init_module(), I register it with =
TEST_DEV_MAJOR =3D 122=20
>=20
> ret_val =3D register_chrdev(TEST_DEV_MAJOR, TEST_DEV_PROC_NAME, =
&lcd_fops);
>=20
> In the user space, I have a programm that creates two device files =
using the same major number but with=20
> different minor numbers:
>=20
> ret_val =3D system("mknod -m 777 /dev/Test1 c 122 1");
> ret_val =3D system("mknod -m 777 /dev/Test1 c 122 2");
                                          ^=20
> Then I try to open both files :
> file_desc1 =3D open("/dev/test1", O_RDWR);
> file_desc2 =3D open("/dev/test2", O_RDWR);

You must be kidding.

You create /dev/Test1 twice, and then open /dev/test1 and /dev/test2.

First of all, Linux fs are case sensitive, second, you don't create=20
test2 (even with wrong case).

--=20
Eugene

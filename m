Return-Path: <krafft@de.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36ABDDDE2B
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 03:07:42 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l5PH7bV6219600
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 17:07:37 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l5PH7bU32793636
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 18:07:37 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l5PG6EBt027587
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 17:06:14 +0100
Date: Mon, 25 Jun 2007 19:07:20 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: Michael Buesch <mb@bu3sch.de>
Subject: Re: [patch] powerpc: sysfs fix compiler warning
Message-ID: <20070625190720.56a3e919@localhost>
In-Reply-To: <200706231146.54959.mb@bu3sch.de>
References: <20070622194853.72fb652a@localhost>
	<200706231146.54959.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_j7WjFC3HIocf=.r7RvNz0X1";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_j7WjFC3HIocf=.r7RvNz0X1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 23 Jun 2007 11:46:54 +0200
Michael Buesch <mb@bu3sch.de> wrote:

> On Friday 22 June 2007 19:48:53 Christian Krafft wrote:
> > From: Christian Krafft <krafft@de.ibm.com>
> >=20
> > This patch fixes the following compiler warning:
> > arch/powerpc/kernel/sysfs.c:385: warning: ignoring return value of
> > `sysfs_create_group',
> >=20
> > Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> >=20
> > Index: linux-2.6.22-rc5/arch/powerpc/kernel/sysfs.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.22-rc5.orig/arch/powerpc/kernel/sysfs.c
> > +++ linux-2.6.22-rc5/arch/powerpc/kernel/sysfs.c
> > @@ -380,16 +380,23 @@ int cpu_add_sysdev_attr_group(struct att
> >  {
> >  	int cpu;
> >  	struct sys_device *sysdev;
> > +	int error;

Looks like I introduced a new warning while fixing another.
Have checked the patch with sparse just after sending it ;-)

> > =20
> >  	mutex_lock(&cpu_mutex);
> > =20
> >  	for_each_possible_cpu(cpu) {
> >  		sysdev =3D get_cpu_sysdev(cpu);
> > -		sysfs_create_group(&sysdev->kobj, attrs);
> > +		error |=3D sysfs_create_group(&sysdev->kobj, attrs);
>=20
> That is probably dangerous, if multiple sysfs_create_group fail
> with different error codes. So it will wiggle the error codes
> together.

Yeah, that's right, will fix it to do a break in case of error.

>=20
> >  	}
> > =20
> > +	if(error)
>  {
> > +		for_each_possible_cpu(cpu) {
> > +			sysdev =3D get_cpu_sysdev(cpu);
> > +			sysfs_remove_group(&sysdev->kobj, attrs);
> > +		}
> probably do something like
> 		error =3D -ENOENT;
>  }
> or some other error code here to fix it.
> > +
> >  	mutex_unlock(&cpu_mutex);
> > -	return 0;
> > +	return error;
> >  }
> >  EXPORT_SYMBOL_GPL(cpu_add_sysdev_attr_group);
> > =20
> >=20
> >=20
>=20
>=20
>=20


--=20
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,
Linux Kernel Development
IT Specialist


Vorsitzender des Aufsichtsrats:	Martin Jetter
Geschaeftsfuehrung:		Herbert Kircher
Sitz der Gesellschaft:		Boeblingen
Registriergericht:		Amtsgericht Stuttgart, HRB 243294


--Sig_j7WjFC3HIocf=.r7RvNz0X1
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGf/ZU6rqK4qDx+dcRAgk2AKDnMjvym6Jchy+Lpq9YhW8XvBWleACguUWA
LFLXGx8AxpbIqUKktSfI9s8=
=LTnI
-----END PGP SIGNATURE-----

--Sig_j7WjFC3HIocf=.r7RvNz0X1--

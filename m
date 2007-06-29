Return-Path: <krafft@de.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EC729DDFEC
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 02:10:37 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l5TGAXih209312
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 16:10:33 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l5TGAXCD2318566
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 17:10:33 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l5TGAWjR024807
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 17:10:32 +0100
Date: Fri, 29 Jun 2007 18:10:13 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: Michael Buesch <mb@bu3sch.de>
Subject: Re: [patch] powerpc: sysfs fix compiler warning
Message-ID: <20070629181013.61d13b54@localhost>
In-Reply-To: <200706291657.20942.mb@bu3sch.de>
References: <20070629165010.1ec5f082@localhost>
	<200706291657.20942.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_.vfhK/i0E_1Yx+UccZrzYac";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_.vfhK/i0E_1Yx+UccZrzYac
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Jun 2007 16:57:20 +0200
Michael Buesch <mb@bu3sch.de> wrote:

> On Friday 29 June 2007 16:50:10 Christian Krafft wrote:
> > From: Christian Krafft <krafft@de.ibm.com>
> >=20
> > This patch fixes the following compiler warning:
> > arch/powerpc/kernel/sysfs.c:385: warning: ignoring return value of
> > `sysfs_create_group',
> >=20
> > Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> >=20
> > --- linux-2.6.orig/arch/powerpc/kernel/sysfs.c
> > +++ linux-2.6/arch/powerpc/kernel/sysfs.c
> > @@ -380,16 +380,25 @@ int cpu_add_sysdev_attr_group(struct att
> >  {
> >  	int cpu;
> >  	struct sys_device *sysdev;
> > +	int error =3D 0;
> > =20
> >  	mutex_lock(&cpu_mutex);
> > =20
> >  	for_each_possible_cpu(cpu) {
> >  		sysdev =3D get_cpu_sysdev(cpu);
> > -		sysfs_create_group(&sysdev->kobj, attrs);
> > +		error =3D sysfs_create_group(&sysdev->kobj, attrs);
> > +
> > +		if (error) {
> > +			for_each_possible_cpu(cpu) {
> > +				sysdev =3D get_cpu_sysdev(cpu);
> > +				sysfs_remove_group(&sysdev->kobj, attrs);
>=20
> Is sysfs_remove_group() safe to call on kobjs for which
> we did not call sysfs_create_group()?

I only looked into it a little and haven't seen a problem.
=46rom the interface point of view I would say it would be a bug, if it's not=
 safe.
But I will do a short test on this.


>=20
> > +			}
> > +			break;
> > +		}
> >  	}
> > =20
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


--Sig_.vfhK/i0E_1Yx+UccZrzYac
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGhS7t6rqK4qDx+dcRAm9MAJ9/z2/+ay8jg9VQ0bD+15F2d22DfgCgw90o
FQfMo4zgHg24/NYjIUAo2d4=
=dSvw
-----END PGP SIGNATURE-----

--Sig_.vfhK/i0E_1Yx+UccZrzYac--

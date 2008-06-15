Return-Path: <krafft@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 22B5DDDE17
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jun 2008 00:46:39 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id m5FEkRCF107754
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jun 2008 14:46:27 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m5FEkR1a3309700
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jun 2008 16:46:27 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m5FEkRHb029722
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jun 2008 16:46:27 +0200
Date: Sun, 15 Jun 2008 17:01:51 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC] poweroff via pm_power_off if set
Message-ID: <20080615170151.35446b18@de.ibm.com>
In-Reply-To: <E67AB741-49D3-456D-9559-C040C5CD5ACC@kernel.crashing.org>
References: <20080613173649.5451976e@de.ibm.com>
	<E67AB741-49D3-456D-9559-C040C5CD5ACC@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TDLjb72AlQdvakK3OimrCYP";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev@ozlabs.org, krafft@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_/TDLjb72AlQdvakK3OimrCYP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Jun 2008 11:00:33 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

>=20
> On Jun 13, 2008, at 10:36 AM, Christian Krafft wrote:
>=20
> > This patch is needed to make ipmi_poweroff working on powerpc.
> > It straightens the poweroff procedure to match with other =20
> > architectures.
> > At the moment powerpc plattforms can define their poweroff method =20
> > using
> > ppc_md.power_off. The only way for plattform independent driver =20
> > (ipmi_poweroff)
> > to register it's poweroff function is to use pm_power_off. So =20
> > machine_power_off
> > should check whether pm_power_off has been set and if so it should =20
> > be used.
> > If not, plattform dependent ppc_md.power_off should be called.
>=20
> It seems like this should be the other way around.  Meaning =20
> ppc_md.power_off should be called first than pm_power_off.  If a =20
> platform provides a power off mechanism that should presuming take =20
> precedence over the ipmi_poweroff.
>=20
> - k

I'd see the pm_power_off as an option to override platform specific poweroff
function. If you want to use ppc_md.power_off you simply don't need to load
ipmi_poweroff module. Also it would not be possible to use ipmi_poweroff
on plattforms that provide a ppc_md.power_off.=20


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

--Sig_/TDLjb72AlQdvakK3OimrCYP
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD4DBQFIVS8C6rqK4qDx+dcRApukAJd+Aw1iCL9gA8L8s2QK8l0x0k/1AKCHck05
BjeTgLaCJ9Ok2/IjLAGkNw==
=1s+K
-----END PGP SIGNATURE-----

--Sig_/TDLjb72AlQdvakK3OimrCYP--

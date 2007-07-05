Return-Path: <rrbranco@br.ibm.com>
Received: from igw2.br.ibm.com (igw2.br.ibm.com [32.104.18.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mailgw2.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3C82FDDE9F
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 08:36:29 +1000 (EST)
Received: from mailhub1.br.ibm.com (mailhub1 [9.18.232.109])
	by igw2.br.ibm.com (Postfix) with ESMTP id 4C76C5BDB1
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jul 2007 19:26:37 -0300 (BRT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.18.232.46])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l65MaOpt1667150
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jul 2007 19:36:24 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
	by d24av01.br.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l65MXoEt023453
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jul 2007 19:33:50 -0300
Subject: Re: Executing from readablee, no-exec pages
From: Rodrigo Rubira Branco <rrbranco@br.ibm.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <468D68D4.4050704@freescale.com>
References: <468D68D4.4050704@freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-vJQeCFHj5nrcrqivoOK7"
Date: Thu, 05 Jul 2007 19:38:55 -0300
Message-Id: <1183675135.4862.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: rrbranco@br.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-vJQeCFHj5nrcrqivoOK7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-07-05 at 16:55 -0500, Scott Wood wrote:
> As revealed by the recent "Prevent data exception in kernel space"=20
> patch, versions of glibc prior to 2.4[1] assume that, on powerpc32, they=20
> can execute out of any readable mapping, regardless of whether it is=20
> marked for execution.  This happens in the elf_machine_load_address()=20
> function.
>=20
> To maintain compatibility with these versions, we could change the test=20
> in do_page_fault() to include VM_READ as well as VM_EXEC on targets that=20
> don't have a separate exec-bit in hardware (are there any powerpc mmus=20
> that do?).  However, Segher suggested on IRC that we may want to drop=20
> compatibility with those old versions of glibc, and that I should seek=20
> your input.
>=20
> Personally, I'd rather stick the VM_READ in there, partially for selfish=20
> reasons (our root filesystems are based on older glibcs), and because it=20
> seems a little too soon to deprecate glibc 2.3, but also because in the=20
> absence of hardware support, the VM_EXEC check will be nondeterministic,=20
> kicking in only when the first fault for a page is to execute.
>=20
> -Scott
>=20
> [1] It's possible that there are other instances of this in 2.4 and that=20
> the actual version is newer; I ran into obnoxious cross compilation=20
> issues trying to try it.  However,
>=20
> <rant>
> Glibc already has target-specific code/headers; if you need to know=20
> something that you'd otherwise need a runs-on-the-target autoconf test=20
> for, why not just stick it in such a target-specific header?  In this=20
> case, it was trying to figure out the size of "long double".
> </rant>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

Since may be a security problem (non-exec mappings being executed), I
really believe we don't want to keep the compatibility.


Regards,


Rodrigo (BSDaemon).

--=20
Rodrigo Rubira Branco
Software Engineer=20
Advanced Linux Response Team (ALRT) / Linux on Power Toolchain
IBM Linux Technology Center (IBM/LTC)
rrbranco@br.ibm.com

GPG KeyID: 1FCEDEA1

--=-vJQeCFHj5nrcrqivoOK7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBGjXL/RpuC3B/O3qERAj+fAJ4mdx4HUcdJw1nTalhMa4ud1jWWkgCfY5WN
VjxQatXrECCcH1UmZddhw1o=
=jr+B
-----END PGP SIGNATURE-----

--=-vJQeCFHj5nrcrqivoOK7--

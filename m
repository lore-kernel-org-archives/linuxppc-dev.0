Return-Path: <wangbj@lzu.edu.cn>
Received: from eyou.net (unknown [202.201.0.146])
	by ozlabs.org (Postfix) with SMTP id C259FDDF66
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Oct 2007 03:04:20 +1100 (EST)
Message-ID: <393649804.05275@eyou.net>
From: "Wang, Baojun" <wangbj@lzu.edu.cn>
To: linuxppc-embedded@ozlabs.org,
 "Barisa Kisku" <barisa.kisku@gmail.com>
Subject: Re: Whether kernel page table is loaded in exception handler?
Date: Mon, 29 Oct 2007 00:04:28 +0800
References: <393584094.25173@lzu.edu.cn>
In-Reply-To: <393584094.25173@lzu.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1202101.878DJtlOqr";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200710290004.30586.wangbj@lzu.edu.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart1202101.878DJtlOqr
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 28 October 2007 22:58:29, Barisa Kisku wrote=EF=BC=9A
> Hi,
> Whether kernel page table is loaded during the execution of exception
> handling.I tried to understand that bit code, but could n't find out=20
> during the execution of system call exception handling or  external
> interrupt exception handling.
>
>
> thanks in advance.
>
> Barisa Kisku

the external interrupt / syscall exception is not responsible for loading p=
age=20
tables. Depending on the type of exception, probably no more exception is=20
allowed if the exception have disabled the MSR EE bit. Otherwise it's=20
depending on the powerpc model, normally the kernel will search tlb first, =
if=20
there is a (Data/Insn) miss, the kernel will search the page table=20
entry(PTEs), if the PTE is founded, the kernel will reload tlb, otherwise i=
t=20
will raise a page fault exception, this may ask the kernel to load the page=
=20
on demand, if the kernel could not load the requested the page, then we got=
 a=20
double fault (page fault). I'm not sure this is 100% corrent, but help it=20
will help

Wang

=2D-=20
Wang, Baojun =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Lanzhou University
Distributed & Embedded System Lab =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0http://dslab.lzu.edu.cn
School of Information Science and Engeneering =C2=A0 =C2=A0 =C2=A0 =C2=A0wa=
ngbj@lzu.edu.cn
Tianshui South Road 222. Lanzhou 730000 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .P.R.China
Tel:+86-931-8912025 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Fax:+86-931-8912022

--nextPart1202101.878DJtlOqr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHJLMMIuIOr7tpgg0RAicTAJ40SyGw1bDcPQRIJNz30cR71MGE+QCfW3z9
vaKKlufGmaZb0ru4Exa84DU=
=oDZY
-----END PGP SIGNATURE-----

--nextPart1202101.878DJtlOqr--

Return-Path: <wangbj@lzu.edu.cn>
Received: from eyou.net (unknown [202.201.0.146])
	by ozlabs.org (Postfix) with SMTP id 8DC88DDE44
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 17:42:06 +1000 (EST)
Message-ID: <393101240.29083@eyou.net>
From: "Wang, Baojun" <wangbj@lzu.edu.cn>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org, rtlinuxgpl@upv.es,
	Miguel Masmano <mimastel@doctor.upv.es>
Subject: Re: ppc manual paging question
Date: Mon, 22 Oct 2007 15:42:07 +0800
References: <200710221203.24157.wangbj@lzu.edu.cn>
	<200710221417.43544.wangbj@lzu.edu.cn> <393039004.29574@lzu.edu.cn>
In-Reply-To: <393039004.29574@lzu.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2558864.iKTAYrqDQK";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200710221542.10592.wangbj@lzu.edu.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2558864.iKTAYrqDQK
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 22 October 2007 15:34:24, Benjamin Herrenschmidt wrote=EF=BC=9A
> > Sorry I didn't realized that. I've finished looking pem64b.pdf, but it's
> > almost nothing like in ppc 4xx/44x.
>
> You'll have to get yourself a 44x manual :-)
>
> > > It's a software loaded TLB, you'll have to put translations in the TLB
> > > yourself. You'll need to design your own data structures for that, tho
> > > you can use a page table for tracking, like we do in linux, and then
> > > have your own TLB miss handler to fill the TLB from that.
> >
> > OK, Shall I look for the DataTLBError code in head.S? I realized that
> > I've got DataTLBError sometimes via BDI2000/kgdb (the fault address is
> > within DataTLBError), Shall I should also look for arch/ppc/mm/fault.c?
>
> head_44x.S is where you'll find some guidance
Yup, I've found how does the kernel handle tlbs, I think the most important=
=20
thing is I forgot read/write the SPRN_SPRG3 register as _switch does.
> > > Your initial code probably need to bolt a TLB entry for the kernel
> > > itself.
> >
> > I don't understand this clearly, how can I do this?
>
> Well, you insert a TLB entry manually and avoid replacing it later on
I've add the _PAGE_PRESENT flag to the related PTE
> Ben.

Thanks very much I'm now getting much clearer about my question:)


  Regards,
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

--nextPart2558864.iKTAYrqDQK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHHFRPIuIOr7tpgg0RAmpJAKCb38rtuSuZC/eSdeAml+iRbS2r0QCfc+Qa
46+jrGpJw70Fy1Ph0qOhmoo=
=XD1L
-----END PGP SIGNATURE-----

--nextPart2558864.iKTAYrqDQK--

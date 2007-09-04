Return-Path: <wangbj@lzu.edu.cn>
Received: from eyou.net (gwmail.lzu.edu.cn [202.201.0.146])
	by ozlabs.org (Postfix) with SMTP id 3F2CFDDE17
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Sep 2007 12:49:49 +1000 (EST)
Message-ID: <388935922.07297@eyou.net>
From: "Wang, Baojun" <wangbj@lzu.edu.cn>
To: linuxppc-embedded@ozlabs.org
Subject: disable interrput under ppc?
Date: Tue, 4 Sep 2007 10:44:14 +0800
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10082962.iXU5BefuCo";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200709041044.16525.wangbj@lzu.edu.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart10082962.iXU5BefuCo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi, list

  How can I disable interrput like `cli' in x86? I want the following code=
=20
freeze the box but it doesn't, $MSR is altered however the box is still=20
alive, how can I freeze the box like `cli' in x86? Thanks very much!

static
void cli(void)
{
        unsigned long msr;
        __asm__ __volatile__("": : :"memory");
        msr =3D mfmsr();
        printk("msr: 0x%lx\n", msr);

        __asm__ __volatile__("sync" : : :"memory");
        __asm__ __volatile__("wrteei 0" : : :"memory");

        msr =3D mfmsr();
        printk("msr: 0x%lx\n", msr);
        printk(KERN_EMERG"!!msr: 0x%lx\n", msr);
}

P.S: the box is BOOKE compatible, the printk has shown is altered!

  Regards,
Wang
=2D-=20
Wang, Baojun                                        Lanzhou University
Distributed & Embedded System Lab              http://dslab.lzu.edu.cn
School of Information Science and Engeneering        wangbj@lzu.edu.cn
Tianshui South Road 222. Lanzhou 730000                     .P.R.China
Tel:+86-931-8912025                                Fax:+86-931-8912022

--nextPart10082962.iXU5BefuCo
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBG3MZ+IuIOr7tpgg0RApMYAKCk9jGr4SLpDDlvcLbxM5rHqzZOsACfWht2
kRn+CEHjEOvwNQR3egGJk1E=
=n34f
-----END PGP SIGNATURE-----

--nextPart10082962.iXU5BefuCo--

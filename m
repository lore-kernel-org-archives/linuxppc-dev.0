Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A81E6DDDE4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 19:49:28 +1100 (EST)
Date: Tue, 23 Jan 2007 11:49:17 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: sudheer <urwithsudheer@gmail.com>
Subject: Re: regarding kgdb in ppc
Message-ID: <20070123114917.5668a578@localhost.localdomain>
In-Reply-To: <45B5A499.4060401@gmail.com>
References: <12c9fc1a0611280820h748cd520pd5546e2803dbab82@mail.gmail.com>
	<d16b1c80611301101n5f9ea44died47d2ff1bac4221@mail.gmail.com>
	<12c9fc1a0611302029h36f29943s119f8ad70b95f2c4@mail.gmail.com>
	<12c9fc1a0612010331p2c33c048j1af6006deda14abb@mail.gmail.com>
	<d16b1c80612010540k7600f0e1n92fadd3d539d75bf@mail.gmail.com>
	<12c9fc1a0612040805p64f23a7bj42fd27891294dfc2@mail.gmail.com>
	<458E384A.108@gmail.com>
	<198592450612281634l3e71834i5915139a73e8f5d1@mail.gmail.com>
	<758a2bbf0612281702u3a4f383bi14e418410bd4f912@mail.gmail.com>
	<45964D27.6020708@gmail.com>
	<758a2bbf0612301753q27727b01w92681214a6296434@mail.gmail.com>
	<45B5A499.4060401@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_CW0jOalhLgpXK/P=v94TAVf";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: kernelnewbies@nl.linux.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Sig_CW0jOalhLgpXK/P=v94TAVf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2007 11:30:57 +0530
sudheer wrote:

> Vijay Sampath wrote:
> > Sorry no idea. The configuration and options for kgdb are different
> > in my architecture. In make menuconfig, under "Kernel Hacking', I
> > enable kgdb and choose its serial port (ttyS0 or ttyS1). After this
> > if I just pass a string with "kgdb" in it in the commandline, it
> > halts early on. Looks like kgdb function is different in your
> > architecture. You will have to read the code that implements your
> > kgdb setup. Clearly it is not happy with the arguments you are
> > passing it, as evident in the output.
> >
> > BTW I am using Linux kernel version 2.6.16 on a IBM405EP board. kgdb
> > breakpoint is setup in setup_arch() in arch/ppc/kernel/setup.c.
> > Note I also enabled CONFIG_WANT_EARLY_SERIAL in the processor
> > configuration. Not sure if this is important.
> >
> In my setup i have one serial port on the target(MPC8540) and one on=20
> host(x86). The document(kgdb_docu_full-2.4.pdf) by default considers=20
> having two serial ports(two on target and two on host).
>=20

To be correct, usually one serial is for serial console, the other-for kgdb=
. Yet you can either disable serial console, or=20
have its output into kgdb. host requires only one serial to be tied on ppc_=
85xx-gdb.
=20
> Can anyone plz guide me how to proceed when i have only one serial
> port . ?
>=20

having one serial is not a comfy case for serial kgdb.

> I want to know the initilization steps for estrablishing the serial=20
> communication between kgdb(in target) and gdb on host. I tried one or=20
> two ways but couldnot succeed.

I'd consider kgdboe - it works pretty well with 8540 gianfar (or at least u=
sed to work for me so tinkering might be trivial).

>=20
> Thanks
> Sudheer
> > Vijay
> >
> > On 12/30/06, sudheer <urwithsudheer@gmail.com> wrote:
> >> Vijay, Thanks  for the reply.
> >> But before trying these options i want to clear one more issue.
> >> While booting the kgdb kernel the kernel claims "kgdb
> >> initialisation failure." I have observed it very lately.
> >>
> >> Memory CAM mapping: CAM0=3D256Mb, CAM1=3D0Mb, CAM2=3D0Mb residual: 0Mb
> >> Linux version 2.6.15.5 (root@Sudheer) (gcc version 3.4.4) #2 Fri
> >> Dec 29 17:58:40 IST
> >> 2006
> >> KGDB cannot initialize I/O yet.
> >> Invalid syntax for option kgdb8250=3D
> >> Malformed early option 'kgdb8250'
> >> Built 1 zonelists
> >> Kernel command line: console=3DttyS0,115200 root=3D/dev/ram rw
> >> kgdbwait kgdb8250=3D0,115200
> >> OpenPIC Version 1.2 (1 CPUs and 60 IRQ sources) at fcfbb000
> >> PID hash table entries: 2048 (order: 11, 32768 bytes)
> >> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> >>
> >>
> >>
> >>
> >> I have changed the kgdb8250 arg to 1,0, but the result is same.
> >> And ......
> >> I have checked the serial cable NULL Mode connecting  x86 systems
> >> serially- with Cat and echo and this is fine.
> >> When i try with Unpatched kernel on target and host(x86) - cat <
> >> /dev/ttyS0 doesnt wait  and returns to prompt.
> >> I tried with 2.6.13 and 2.6.15.5 with resepective kgdb patches,
> >> but the result is same (kgdb Initialization failure). I am not
> >> sure where  am doing the mistake.
> >> Please guide me in right way and also please let me know if any
> >> more details are required.
> >> Happy New Year in Advance.
> >>
> >> Thanks
> >> Sudheer
> >>
> >>
> >>
> >>
>=20
>=20
> >>
> >>
> >
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

--Sig_CW0jOalhLgpXK/P=v94TAVf
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFtcwNuOg9JvQhSEsRAvlEAJ4z0edZaBZcA9C8MWIg2v8InpU5PACeNOjr
ZzTnUA/8C9+RjasfDcIchK8=
=Ltnd
-----END PGP SIGNATURE-----

--Sig_CW0jOalhLgpXK/P=v94TAVf--

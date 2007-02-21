Return-Path: <mh@omnisys.se>
Received: from ch-smtp02.sth.basefarm.net (ch-smtp02.sth.basefarm.net
	[80.76.149.213])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 09F4CDDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 07:24:27 +1100 (EST)
Date: Wed, 21 Feb 2007 22:35:43 +0100
From: Magnus Hjorth <mh@omnisys.se>
To: linuxppc-embedded@ozlabs.org
Subject: Re: mcpu options for AMCC440 with fpu
Message-Id: <20070221223543.64d584d7.mh@omnisys.se>
In-Reply-To: <1172087270.3018.18.camel@localhost.localdomain>
References: <600461.55072.qm@web23412.mail.ird.yahoo.com>
	<1172087270.3018.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Have you tried using the -ffast-math option?

/Magnus


On Wed, 21 Feb 2007 20:47:50 +0100
Patrice Bouchand <pb_fwd_list@yahoo.fr> wrote:

>=20
> FYI, I got the following answer on mplayer mailing list:
>=20
> > Apparently -mcpu=3D440fp is the one. However, it's possible, that GCC
> > "optimizations" actually make the code slower.
>=20
> Can someone confirme this possiblity ?
>=20
> Any answer would be greatly appreciated ;)=20
>=20
>=20
>     Patrice Bouchand
>=20
>=20
> > Hello,
> >=20
> >    I was searching for the best mcpu option for amcc440, compiling and
> > running a small program you can find here:=20
> > http://magnux.free.fr/gcc/mandelbrot.c. My distro is a ppc fedora core
> > 6, and results are obviously the same using DENX4.0.
> >=20
> > --------------------
> > -bash-3.00# gcc -O2 ./mandelbrot.c -o ./mandelbrot &&
> > time ./mandelbrot && rm -f ./mandelbrot
> >=20
> > real    1m15.059s
> > user    1m14.996s
> > sys     0m0.060s
> > -bash-3.00# gcc -O2 -mcpu=3D440 ./mandelbrot.c -o ./mandelbrot &&
> > time ./mandelbrot && rm -f ./mandelbrot
> >=20
> > real    0m39.606s
> > user    0m39.552s
> > sys     0m0.028s
> > -bash-3.00# gcc -O2 -mcpu=3D440fp ./mandelbrot.c -o ./mandelbrot &&
> > time ./mandelbrot && rm -f ./mandelbrot
> >=20
> > real    1m15.016s
> > user    1m14.988s
> > sys     0m0.024s
> > -bash-3.00# gcc -O2 -msoft-float ./mandelbrot.c -o ./mandelbrot &&
> > time ./mandelbrot && rm -f ./mandelbrot
> >=20
> > real    0m39.577s
> > user    0m39.544s
> > sys     0m0.032s
> > --------------------
> >=20
> > * I do not explain why not using FPU gives better results ?
> >=20
> > * I did also a test with bzip2.c
> > ( http://pag.csail.mit.edu/~smcc/projects/single-file-programs/bzip2.c =
).
> >=20
> > ----------------------
> > -bash-3.00# gcc -O2 ./bzip2.c -o ./bzip2 && time ./bzip2 ./oggenc.c
> > && ./bzip2 -d ./oggenc.c.bz2 && rm ./bzip2
> >=20
> > real    0m18.478s
> > user    0m18.216s
> > sys     0m0.152s
> > -bash-3.00# gcc -O2 -mcpu=3D440 ./bzip2.c -o ./bzip2 &&
> > time ./bzip2 ./oggenc.c && ./bzip2 -d ./oggenc.c.bz2 && rm ./bzip2
> >=20
> > real    0m18.786s
> > user    0m18.544s
> > sys     0m0.128s
> > -bash-3.00# gcc -O2 -mcpu=3D440fp ./bzip2.c -o ./bzip2 &&
> > time ./bzip2 ./oggenc.c && ./bzip2 -d ./oggenc.c.bz2 && rm ./bzip2
> >=20
> > real    0m18.811s
> > user    0m18.548s
> > sys     0m0.144s
> > -bash-3.00# gcc -O2 -mcpu=3DG3 ./bzip2.c -o ./bzip2 &&
> > time ./bzip2 ./oggenc.c && ./bzip2 -d ./oggenc.c.bz2 && rm ./bzip2
> >=20
> > real    0m18.871s
> > user    0m18.644s
> > sys     0m0.104s
> > ----------------------
> >=20
> > * mcpu option seems to not have any effect ?
> >=20
> > *  My third test was to compile and run mplayer.
> > - With default options (no mcpu specified), my test mpeg was smooth.
> > - With mcpu=3D440fp, my test mpeg was not smooth.
> >=20
> >  Can anybody bring me some lights about the right gcc mcpu option for
> > amcc440 ?
> >=20
> > Best regards,
> >=20
> >        Patrice Bouchand
> >=20
> >=20
> >=20
> >=20
> > ______________________________________________________________________
> > D=E9couvrez une nouvelle fa=E7on d'obtenir des r=E9ponses =E0 toutes vos
> > questions ! Profitez des connaissances, des opinions et des
> > exp=E9riences des internautes sur Yahoo! Questions/R=E9ponses.
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

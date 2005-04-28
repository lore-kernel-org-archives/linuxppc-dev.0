Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 29F6D67B27
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Apr 2005 09:19:01 +1000 (EST)
In-Reply-To: <61cc712d05042815211d84e870@mail.gmail.com>
References: <61cc712d05042815211d84e870@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <3ab5f12661a4e7a10ac3f6ec1370d106@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 28 Apr 2005 18:18:55 -0500
To: <kylo@kylo.net>
Cc: Chiradeep Vittal <chiradeep@matissenetworks.com>,
	linuxppc-embedded@ozlabs.org
Subject: Re: Linux Kernel Issue: MPC8540 Errata (CPU29)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

All of the suggestions are good ones.. Also, in 2.6 I've recently =20
submitted patches that add emulation of these instructions in the =20
kernel.

Its odd, but I would have expected a GCC configured for e500 not to =20
generate the ld/st string instructions by default, but the -mno-string =20=

is what we do in the kernel to ensure that.

- kumar

On Apr 28, 2005, at 5:21 PM, Kylo Ginsberg wrote:

> Chiradeep,
>
> I have the same issue with gcc3.4.3 and an e500 target.=A0 You can =
give
>  gcc the -mno-string to inhibit generation of those load/store string
>  instructions.=A0 I don't know if gcc can be configured such that its
>  default is not to generate those instructions.
>
> Cheers,
>  Kylo
>
> On 4/28/05, Chiradeep Vittal <chiradeep@matissenetworks.com> wrote:
>  > It turns out to be a compiler issue.
> > We're using gcc 3.4.3 with optimization level -Os. The following =20
> program will generate the illegal instruction with -Os but not with =20=

> -O2
>
> >=A0=A0=A0=A0=A0=A0=A0=A0 int main (int argc, char** argv)
>  >=A0=A0=A0=A0=A0=A0=A0=A0 {
>  >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int seq[] =3D {0, 1, 2};
>  >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>  >=A0=A0=A0=A0=A0=A0=A0=A0 }
>  > The reason is that the compiler generates code with the stswi =20
> instruction which is not supported by the e500. Here's our compiler =20=

> configuration:
>
> > Configured with: =20
> /home/steve/perforce/sw/opt/crosstool/build/powerpc-8540-linux-gnu/=20
> gcc-3.4.3-glibc-2.3.2/gcc-3.4.3/configure =20
> --target=3Dpowerpc-8540-linux-gnu --host=3Di686-host_pc-linux-gnu =20
> --prefix=3D/home/steve/perforce/sw/opt/cross-compile/powerpc-8540-linux-=
=20
> gnu/gcc-3.4.3-glibc-2.3.2 --with-cpu=3D8540 =20
> --enable-cxx-flags=3D-mcpu=3D8540 =20
> --with-headers=3D/home/steve/perforce/sw/opt/cross-compile/powerpc-8540-=
=20
> linux-gnu/gcc-3.4.3-glibc-2.3.2/powerpc-8540-linux-gnu/include =20
> --with-local-prefix=3D/home/steve/perforce/sw/opt/cross-compile/powerpc=20=

> -8540-linux-gnu/gcc-3.4.3-glibc-2.3.2/powerpc-8540-linux-gnu =20
> --disable-nls --enable-threads=3Dposix --enable-symvers=3Dgnu =20
> --enable-__cxa_atexit --enable-languages=3Dc,c++ --enable-shared =20
> --enable-c99 --enable-long-long
>
> >
> > Any recommendations?
> >
> > Thanks
>  > --
>  > Chiradeep
>  >
> > -----Original Message-----
>  > From: Kumar Gala [mailto:kumar.gala@freescale.com]
>  > Sent: Wednesday, April 27, 2005 11:37 AM
>  > To: Chiradeep Vittal
>  > Cc: linuxppc-embedded@ozlabs.org
> > Subject: Re: Linux Kernel Issue: MPC8540 Errata (CPU29)
> >
> > On Apr 27, 2005, at 12:46 PM, Chiradeep Vittal wrote:
>  >
> > > We're running Linux Kernel 2.4.26 on an 8540 ADS derivative. We're
>  > >=A0 seeing an
> > > "illegal instruction" (SIGILL) exception under some circumstances
>  > > (during a pthread_create call). We were wondering if this could =20=

> be a
> > > symptom of
>  > > CPU29 and if there is a patch available for CPU29.
>  > >
>  > > "CPU29 L1 instruction cache gets multiple entries for same line =20=

> after
>  > >=A0 change
>  > > in MSR[IS] bit "
>  > >
>  > > www.freescale.com/files/32bit/doc/errata/MPC8540CE.pdf
> >
> > The way the Linux kernel manages the MMU on e500 it doesn't actually
>  > ever modify MSR[IS] or MSR[DS].=A0 They are always zero so I dont =20=

> believe
>  > you are hitting this errata.
>  >
> > Are you running with math emulation turned on?=A0 Do you know what =
the
>  > instruction is that causes the SIGILL?
>  >
> > - kumar
>  >
> > _______________________________________________
> > Linuxppc-embedded mailing list
>  > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>  >

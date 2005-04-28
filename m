Return-Path: <kylo.ginsberg@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.192])
	by ozlabs.org (Postfix) with ESMTP id E4B4B67B21
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Apr 2005 08:21:31 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id g11so878009rne
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Apr 2005 15:21:30 -0700 (PDT)
Message-ID: <61cc712d05042815211d84e870@mail.gmail.com>
Date: Thu, 28 Apr 2005 15:21:30 -0700
From: Kylo Ginsberg <kylo.ginsberg@gmail.com>
To: Chiradeep Vittal <chiradeep@matissenetworks.com>
In-Reply-To: <F237EFC9919B064C8BF5A44CDA5DA0C212F681@matisse01.matissenetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <F237EFC9919B064C8BF5A44CDA5DA0C212F681@matisse01.matissenetworks.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux Kernel Issue: MPC8540 Errata (CPU29)
Reply-To: kylo@kylo.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Chiradeep,

I have the same issue with gcc3.4.3 and an e500 target.  You can give
gcc the -mno-string to inhibit generation of those load/store string
instructions.  I don't know if gcc can be configured such that its
default is not to generate those instructions.

Cheers,
Kylo

On 4/28/05, Chiradeep Vittal <chiradeep@matissenetworks.com> wrote:
> It turns out to be a compiler issue.
> We're using gcc 3.4.3 with optimization level -Os. The following program =
will generate the illegal instruction with -Os but not with -O2
>         int main (int argc, char** argv)
>         {
>           int seq[] =3D {0, 1, 2};
>           return 0;
>         }
> The reason is that the compiler generates code with the stswi instruction=
 which is not supported by the e500. Here's our compiler configuration:
> Configured with: /home/steve/perforce/sw/opt/crosstool/build/powerpc-8540=
-linux-gnu/gcc-3.4.3-glibc-2.3.2/gcc-3.4.3/configure --target=3Dpowerpc-854=
0-linux-gnu --host=3Di686-host_pc-linux-gnu --prefix=3D/home/steve/perforce=
/sw/opt/cross-compile/powerpc-8540-linux-gnu/gcc-3.4.3-glibc-2.3.2 --with-c=
pu=3D8540 --enable-cxx-flags=3D-mcpu=3D8540 --with-headers=3D/home/steve/pe=
rforce/sw/opt/cross-compile/powerpc-8540-linux-gnu/gcc-3.4.3-glibc-2.3.2/po=
werpc-8540-linux-gnu/include --with-local-prefix=3D/home/steve/perforce/sw/=
opt/cross-compile/powerpc-8540-linux-gnu/gcc-3.4.3-glibc-2.3.2/powerpc-8540=
-linux-gnu --disable-nls --enable-threads=3Dposix --enable-symvers=3Dgnu --=
enable-__cxa_atexit --enable-languages=3Dc,c++ --enable-shared --enable-c99=
 --enable-long-long
>=20
> Any recommendations?
>=20
> Thanks
> --
> Chiradeep
>=20
> -----Original Message-----
> From: Kumar Gala [mailto:kumar.gala@freescale.com]
> Sent: Wednesday, April 27, 2005 11:37 AM
> To: Chiradeep Vittal
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Linux Kernel Issue: MPC8540 Errata (CPU29)
>=20
> On Apr 27, 2005, at 12:46 PM, Chiradeep Vittal wrote:
>=20
> > We're running Linux Kernel 2.4.26 on an 8540 ADS derivative. We're
> >  seeing an
> > "illegal instruction" (SIGILL) exception under some circumstances
> > (during a pthread_create call). We were wondering if this could be a
> > symptom of
> > CPU29 and if there is a patch available for CPU29.
> >
> > "CPU29 L1 instruction cache gets multiple entries for same line after
> >  change
> > in MSR[IS] bit "
> >
> > www.freescale.com/files/32bit/doc/errata/MPC8540CE.pdf
>=20
> The way the Linux kernel manages the MMU on e500 it doesn't actually
> ever modify MSR[IS] or MSR[DS].  They are always zero so I dont believe
> you are hitting this errata.
>=20
> Are you running with math emulation turned on?  Do you know what the
> instruction is that causes the SIGILL?
>=20
> - kumar
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

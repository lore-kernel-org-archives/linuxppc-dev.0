Return-Path: <chiradeep@matissenetworks.com>
Received: from matisse01.matissenetworks.com
	(h-66-166-77-18.snvacaid.covad.net [66.166.77.18])
	by ozlabs.org (Postfix) with ESMTP id 24B4667B33
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Apr 2005 04:32:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 28 Apr 2005 11:31:42 -0700
Message-ID: <F237EFC9919B064C8BF5A44CDA5DA0C212F681@matisse01.matissenetworks.com>
From: "Chiradeep Vittal" <chiradeep@matissenetworks.com>
To: "Kumar Gala" <kumar.gala@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Linux Kernel Issue: MPC8540 Errata (CPU29)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

It turns out to be a compiler issue.
We're using gcc 3.4.3 with optimization level -Os. The following program =
will generate the illegal instruction with -Os but not with -O2
	int main (int argc, char** argv)
	{=09
	  int seq[] =3D {0, 1, 2};
	  return 0;
	}
The reason is that the compiler generates code with the stswi =
instruction which is not supported by the e500. Here's our compiler =
configuration:
Configured with: =
/home/steve/perforce/sw/opt/crosstool/build/powerpc-8540-linux-gnu/gcc-3.=
4.3-glibc-2.3.2/gcc-3.4.3/configure --target=3Dpowerpc-8540-linux-gnu =
--host=3Di686-host_pc-linux-gnu =
--prefix=3D/home/steve/perforce/sw/opt/cross-compile/powerpc-8540-linux-g=
nu/gcc-3.4.3-glibc-2.3.2 --with-cpu=3D8540 =
--enable-cxx-flags=3D-mcpu=3D8540 =
--with-headers=3D/home/steve/perforce/sw/opt/cross-compile/powerpc-8540-l=
inux-gnu/gcc-3.4.3-glibc-2.3.2/powerpc-8540-linux-gnu/include =
--with-local-prefix=3D/home/steve/perforce/sw/opt/cross-compile/powerpc-8=
540-linux-gnu/gcc-3.4.3-glibc-2.3.2/powerpc-8540-linux-gnu --disable-nls =
--enable-threads=3Dposix --enable-symvers=3Dgnu --enable-__cxa_atexit =
--enable-languages=3Dc,c++ --enable-shared --enable-c99 =
--enable-long-long

Any recommendations?

Thanks
--
Chiradeep

-----Original Message-----
From: Kumar Gala [mailto:kumar.gala@freescale.com]=20
Sent: Wednesday, April 27, 2005 11:37 AM
To: Chiradeep Vittal
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux Kernel Issue: MPC8540 Errata (CPU29)

On Apr 27, 2005, at 12:46 PM, Chiradeep Vittal wrote:

> We're running Linux Kernel 2.4.26 on an 8540 ADS derivative. We're
>  seeing an
> "illegal instruction"=A0 (SIGILL) exception under some circumstances
> (during a pthread_create call). We were wondering if this could be a
> symptom of
> CPU29 and if there is a patch available for CPU29.
>
> "CPU29 L1 instruction cache gets multiple entries for same line after
>  change
> in MSR[IS] bit "
>
> www.freescale.com/files/32bit/doc/errata/MPC8540CE.pdf

The way the Linux kernel manages the MMU on e500 it doesn't actually=20
ever modify MSR[IS] or MSR[DS].  They are always zero so I dont believe=20
you are hitting this errata.

Are you running with math emulation turned on?  Do you know what the=20
instruction is that causes the SIGILL?

- kumar

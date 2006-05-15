Return-Path: <agx@sigxcpu.org>
Received: from honk1.physik.uni-konstanz.de (honk1.physik.uni-konstanz.de
	[134.34.140.224])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "honk1.physik.uni-konstanz.de",
	Issuer "Mittelerde" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 29DBF679A6
	for <linuxppc-dev@ozlabs.org>; Tue, 16 May 2006 09:43:54 +1000 (EST)
Date: Mon, 15 May 2006 18:39:35 -0500
From: Guido Guenther <agx@sigxcpu.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch]: pmac nvram driver shouldn't be compileable as a module
Message-ID: <20060515233935.GA9533@bogon.ms20.nix>
References: <20060515230115.GA9172@bogon.ms20.nix>
	<1147734713.13588.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1147734713.13588.0.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 16, 2006 at 09:11:53AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2006-05-15 at 18:01 -0500, Guido Guenther wrote:
> > Hi,
> > currently when selecting CONFIG_NVRAM=3Dm on PPC_PMAC on loading the nv=
ram
> > module one gets:
> >=20
> > nvram: module license 'unspecified' taints kernel.
> > nvram: Unknown symbol of_address_to_resource
> > nvram: Unknown symbol __alloc_bootmem
> > nvram: Unknown symbol pmac_newworld
> >=20
> > instead of exporting all these to modules it'd be nice to make the
> > corresponding CONFIG_NVRAM options bool instead of tristate on PMAC_PPC.
> > I don't think it's intended to be compiled as a module, since it resides
> > under arch/powerpc/platforms/powermac and not drivers/macintosh. Is
> > there an easier way to achive this with the build system than the patch
> > below? If not, please apply.
>=20
> Maybe simply not wrapping it with CONFIG_NVRAM ...=20
=2E..which would make it non selectable at all. That's why I introduced
the PMAC_NVRAM.
 -- Guido
>=20
> Ben.
>=20
> > --- orig/linux-2.6.17-rc4/drivers/char/Kconfig	2006-05-14 21:57:51.0000=
00000 -0500
> > +++ linux-2.6.17-rc4/drivers/char/Kconfig	2006-05-15 17:06:10.000000000=
 -0500
> > @@ -687,7 +687,7 @@
> > =20
> >  config NVRAM
> >  	tristate "/dev/nvram support"
> > -	depends on ATARI || X86 || ARM || GENERIC_NVRAM
> > +	depends on ATARI || X86 || ARM || (GENERIC_NVRAM && !PPC_PMAC)
> >  	---help---
> >  	  If you say Y here and create a character special file /dev/nvram
> >  	  with major number 10 and minor number 144 using mknod ("man mknod"),
> > --- orig/linux-2.6.17-rc4/drivers/macintosh/Kconfig	2006-03-19 23:53:29=
=2E000000000 -0600
> > +++ linux-2.6.17-rc4/drivers/macintosh/Kconfig	2006-05-15 17:14:40.0000=
00000 -0500
> > @@ -200,4 +200,13 @@
> >  	tristate "Support for ANS LCD display"
> >  	depends on ADB_CUDA && PPC_PMAC
> > =20
> > +config PMAC_NVRAM
> > +	bool "/dev/nvram support"
> > +	depends on GENERIC_NVRAM && PPC_PMAC
> > +	---help---
> > +	  If you say Y here and create a character special file /dev/nvram wi=
th
> > +	  major number 10 and minor number 144 using mknod ("man mknod"), you
> > +	  get read and write access to the non-volatile memory of your
> > +	  machine.
> > +
> >  endmenu
> > diff -u -u orig/linux-2.6.17-rc4/arch/powerpc/platforms/powermac/Makefi=
le linux-2.6.17-rc4/arch/powerpc/platforms/powermac/Makefile
> > --- orig/linux-2.6.17-rc4/arch/powerpc/platforms/powermac/Makefile	2006=
-03-19 23:53:29.000000000 -0600
> > +++ linux-2.6.17-rc4/arch/powerpc/platforms/powermac/Makefile	2006-05-1=
5 17:22:43.000000000 -0500
> > @@ -6,7 +6,7 @@
> >  obj-$(CONFIG_PMAC_BACKLIGHT)	+=3D backlight.o
> >  obj-$(CONFIG_CPU_FREQ_PMAC)	+=3D cpufreq_32.o
> >  obj-$(CONFIG_CPU_FREQ_PMAC64)	+=3D cpufreq_64.o
> > -obj-$(CONFIG_NVRAM)		+=3D nvram.o
> > +obj-$(CONFIG_PMAC_NVRAM)	+=3D nvram.o
> >  # ppc64 pmac doesn't define CONFIG_NVRAM but needs nvram stuff
> >  obj-$(CONFIG_PPC64)		+=3D nvram.o
> >  obj-$(CONFIG_PPC32)		+=3D bootx_init.o
> >=20
> > Singed-Off-By: Guido Guenther <agx@sigxcpu.org>
> > Cheers,
> >  -- Guido
>=20

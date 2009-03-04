Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 38583DDE9E
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 11:07:55 +1100 (EST)
Date: Wed, 4 Mar 2009 01:07:55 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
Subject: Re: Linux 2.6.29-rc6 bombs while compiling a kernel for a
	linkstation/kurobox
In-Reply-To: <20090302094303.GA29819@ime.usp.br>
Message-ID: <Pine.LNX.4.64.0903040103440.5059@axis700.grange>
References: <20090302094303.GA29819@ime.usp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2 Mar 2009, Rog=C3=A9rio Brito wrote:

> Hi there.
>=20
> I tried to compile a new kernel for my (powerpc) Kurobox HD (an embedded
> system that has a Freescale processor), but it seems that the
> compilation fails, with both my usual config file and with the shipped
> linkstation_defconfig file.
>=20
> I get the following error during compilation (actually a
> cross-compilation):
>=20
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> arch/powerpc/platforms/built-in.o: In function `linkstation_setup_arch':
> linkstation.c:(.init.text+0x218): undefined reference to `physmap_set_par=
titions'
> drivers/built-in.o:(__ksymtab+0x9f8): undefined reference to `physmap_set=
_partitions'
> make: *** [.tmp_vmlinux1] Error 1
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Yes, linkstation and storcenter have to migrate to the "physmap-flash"=20
platform driver. For now you can define in your .config

CONFIG_MTD_PHYSMAP=3Dy
CONFIG_MTD_PHYSMAP_COMPAT=3Dy
CONFIG_MTD_PHYSMAP_START=3D0xffc00000
CONFIG_MTD_PHYSMAP_LEN=3D0x400000
CONFIG_MTD_PHYSMAP_BANKWIDTH=3D1

(I hope the numbers are correct, just found them in my local tree, don't=20
remember any more what exactly they configure, please, double-check.) And=
=20
yes, it must be fixed in the mainline. I'll see if I find time for this,=20
maybe tomorrow (actually, already today.)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer

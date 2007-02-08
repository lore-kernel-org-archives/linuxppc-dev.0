Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts36-srv.bellnexxia.net (tomts36.bellnexxia.net
	[209.226.175.93]) by ozlabs.org (Postfix) with ESMTP id 1A02EDDE45
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Feb 2007 02:31:53 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.196.179])
	by tomts36-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070208153151.UYKF1862.tomts36-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 Feb 2007 10:31:51 -0500
Date: Thu, 8 Feb 2007 10:31:51 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] PPC : missing request_dma and free_dma on PPC 405
Message-ID: <20070208153151.GA26910@Krystal>
References: <20070207234845.GA26092@Krystal>
	<4CCA1279-2782-4184-AF1D-77A043C18768@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4CCA1279-2782-4184-AF1D-77A043C18768@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

* Kumar Gala (galak@kernel.crashing.org) wrote:
>=20
> On Feb 7, 2007, at 5:48 PM, Mathieu Desnoyers wrote:
>=20
> >PPC : missing request_dma and free_dma on PPC 405
> >
> >The solution I have found to correct this linking error for modules
> >that use DMA is to allow 4xx to select GENERIC_ISA_DMA in arch/ppc/=20
> >Kconfig.
> >It applies on 2.6.20.
> >
> >Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
>=20
> Are you actually using request_dma/free_dma?
>=20
> The reason this was Kconfig'd this way is that ISA_DMA doesn't make =20
> sense on 4xx or the majority of PPC's because of the lack of an ISA bus.
>=20

No, but, in the configuration I tried to build, the following macro :
include/asm-powerpc/vga.h:#define VGA_MAP_MEM(x,s) (x + vgacon_remap_base)
is used by drivers/video/console/vgacon.c which can be compiled as a
module (drivers/video/vga16fb.ko) for PPC 405.

Maybe the right solution would be to make FB_VGA16, VGA_CONSOLE and
MDA_CONSOLE depend on GENERIC_ISA_DMA (or disable them for 4xx and 8xx).

in drivers/video/console/Kconfig
VGA_CONSOLE already uses :
depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC &&
    !M68K && !PARISC && !FRV && !ARCH_VERSATILE && !SUPERH

MDA_CONSOLE
depends on !M68K && !PARISC && ISA (depending on ISA seems to make it
OK)

in drivers/video/Kconfig
FB_VGA16
depends on FB && (X86 || PPC)
here we should probably change it for :
depends on FB && (X86 || PPC64 || (PPC32 && GENERIC_ISA_DMA))

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -488,7 +488,7 @@ config FB_IMSTT
=20
 config FB_VGA16
 	tristate "VGA 16-color graphics support"
-	depends on FB && (X86 || PPC)
+	depends on FB && (X86 || PPC64 || (PPC32 && GENERIC_ISA_DMA))
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
--=20
Mathieu Desnoyers
Computer Engineering Graduate Student, =C9cole Polytechnique de Montr=E9al
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68

Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id B9417DDE42
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 21:23:16 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0CANFsB007500
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 03:23:15 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0CANDPU003248
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 04:23:14 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: [patch][5/5] powerpc: Add the general support for Embedded
	Floating-Point instructions
Date: Fri, 12 Jan 2007 18:23:11 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E816A9D@zch01exm20.fsl.freescale.net>
In-Reply-To: <20070112095213.GA24536@lst.de>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: "Christoph Hellwig" <hch@lst.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]=20
> Sent: 2007=C4=EA1=D4=C212=C8=D5 17:52
> To: Zhu Ebony-r57400
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][5/5] powerpc: Add the general support=20
> for Embedded Floating-Point instructions
>=20
> On Fri, Jan 12, 2007 at 01:31:02PM +0800,=20
> ebony.zhu@freescale.com wrote:
> > +ifeq ($(CONFIG_SPE),y)
> > +ifneq ($(CONFIG_MATH_EMULATION),y)
> > +core-y				+=3D arch/powerpc/math-emu/
> > +endif
> > +endif
> >  core-$(CONFIG_MATH_EMULATION)	+=3D arch/powerpc/math-emu/
>=20
> This statement doesn't make any sense.  I guess you always=20
> want to build arch/powerpc/math-emu if CONFIG_SPE is set,=20
> right?  The proper way to do that is to force=20
> CONFIG_MATH_EMULATION in the Kconfig.
>=20
> Then again we need a really good explanation why CONFIG_SPE=20
> should force the math emulation to be built.
>=20
>=20

Yes, you are. If CONFIG_SPE is set, I want some files in =
arch/powerpc/math-emu be built.
The original kernel will build math emulation only if =
CONFIG_MATH_EMULATION
is set. I don't want to break it.

CONFIG_SPE doesn't force the whole math emulation to be built. If =
CONFIG_SPE is set,
only the new SPFP/DPFP/VSPFP instructions in arch/powerpc/math-emu will =
be built,
while the previous FPU instructions won't. This is controlled by =
Makefile in
arch/powerpc/math-emu

Therefore, what I'm trying to do is to build directory =
arch/powerpc/math-emu if
CONFIG_MATH_EMULATION or CONFIG_SPE is set. Do you have any idea?=20

Thanks.
Ebony

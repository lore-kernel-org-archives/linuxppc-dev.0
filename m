Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B566A1A0A29
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 18:53:36 +1000 (EST)
From: "qiang.zhao@freescale.com" <qiang.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: qe: move qe from arch/powerpc to drivers
Date: Wed, 6 Aug 2014 08:53:28 +0000
Message-ID: <61b449dd79754d25ace3701ccebe10e2@BLUPR03MB341.namprd03.prod.outlook.com>
References: <1403580712-30153-1-git-send-email-B45475@freescale.com>
 <20140730001923.GA4151@home.buserror.net>
In-Reply-To: <20140730001923.GA4151@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Xiaobo
 Xie <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 30, 2014 at 08:19 AM, Wood Scott wrote:


> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Wednesday, July 30, 2014 8:19 AM
> To: Zhao Qiang-B45475
> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Xie Xiaobo-R63061
> Subject: Re: qe: move qe from arch/powerpc to drivers
>=20
> On Tue, Jun 24, 2014 at 11:31:52AM +0800, Zhao Qiang wrote:
> > ls1 has qe and ls1 has arm cpu.
> > move qe from arch/powerpc to drivers.
> >
> > Signed-off-by: Zhao Qiang <B45475@freescale.com>
>=20
> This is a very terse changelog.  Explain more about what QE is, and what
> this patch accomplishes (it doesn't seem to get rid of the PPC dependency=
,
> just moving code at this stage)
>=20
> I don't see a MAINTAINERS update for the new path.  Who is going to
> maintain it?
>=20
> I don't think drivers/qe is the right place for it.  Directories directly
> under drivers/ tend to be for classes of devices, not instances.  In any
> case, LKML should be CCed when creating a new directory directly under
> drivers/ or under a subdirectory of drivers/ that doesn't have its own
> mailing list.

So which directory do you recommend?
Actually qe is a kind of IP block, so in my opinion, it is proper to put it=
 under driver/(just in my opinion).


>=20
> This came up before, without a resolution.  See:
> http://www.spinics.net/lists/kernel/msg1621335.html
>=20
> > diff --git a/arch/powerpc/platforms/83xx/km83xx.c
> > b/arch/powerpc/platforms/83xx/km83xx.c
> > index bf4c447..22c0d6d 100644
> > --- a/arch/powerpc/platforms/83xx/km83xx.c
> > +++ b/arch/powerpc/platforms/83xx/km83xx.c
> > @@ -37,8 +37,8 @@
> >  #include <asm/udbg.h>
> >  #include <sysdev/fsl_soc.h>
> >  #include <sysdev/fsl_pci.h>
> > -#include <asm/qe.h>
> > -#include <asm/qe_ic.h>
> > +#include <linux/qe.h>
> > +#include <linux/qe_ic.h>
>=20
> If you're moving it out of asm/ please give it an fsl prefix.
>=20
> > diff --git a/drivers/qe/Kconfig b/drivers/qe/Kconfig new file mode
> > 100644 index 0000000..dc16e9a
> > --- /dev/null
> > +++ b/drivers/qe/Kconfig
> > @@ -0,0 +1,35 @@
> > +#
> > +# QE Communication options
> > +#
> > +menuconfig QUICC_ENGINE
> > +	bool "Freescale QUICC Engine (QE) Support"
> > +	depends on FSL_SOC && PPC32
> > +	select PPC_LIB_RHEAP
> > +	select CRC32
> > +	help
> > +	  The QUICC Engine (QE) is a new generation of communications
> > +	  coprocessors on Freescale embedded CPUs (akin to CPM in older
> chips).
> > +	  Selecting this option means that you wish to build a kernel
> > +	  for a machine with a QE coprocessor.
> > +
> > +if QUICC_ENGINE
> > +
> > +config UCC_SLOW
> > +	bool
> > +	default y if SERIAL_QE
> > +	help
> > +	  This option provides qe_lib support to UCC slow
> > +	  protocols: UART, BISYNC, QMC
> > +
> > +config UCC_FAST
> > +	bool
> > +	default y if UCC_GETH
> > +	help
> > +	  This option provides qe_lib support to UCC fast
> > +	  protocols: HDLC, Ethernet, ATM, transparent
> > +
> > +config UCC
> > +	bool
> > +	default y if UCC_FAST || UCC_SLOW
> > +
> > +endif
>=20
> These config options could use better namespacing.
>=20
> -Scott


Regards,
Zhao Qiang

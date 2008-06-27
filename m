Return-Path: <oakad@yahoo.com>
Received: from web36701.mail.mud.yahoo.com (web36701.mail.mud.yahoo.com
	[209.191.85.35]) by ozlabs.org (Postfix) with SMTP id 8D555DDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jun 2008 16:36:53 +1000 (EST)
Date: Thu, 26 Jun 2008 23:36:51 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: Rapidio interface in recent kernels
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1CE525D1-51A1-4A12-9059-441B133FA959@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <662733.75233.qm@web36701.mail.mud.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: oakad@yahoo.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>




--- On Thu, 6/26/08, Kumar Gala <galak@kernel.crashing.org> wrote:

> From: Kumar Gala <galak@kernel.crashing.org>
> Subject: Re: Rapidio interface in recent kernels
> To: oakad@yahoo.com
> Cc: linuxppc-embedded@ozlabs.org
> Date: Thursday, June 26, 2008, 6:35 AM
> On Jun 25, 2008, at 11:33 PM, Alex Dubov wrote:
>=20
> > Greetings.
> >
> > I was trying to make use of rapidio on recent (2.6.25)
> kernel (I =20
> > have a 8548
> > cpu). However, it seems that changes to the powerpc
> arch had broken =20
> > it.
> >
> > Therefore, the question: is there an anticipated fix
> or I'm on my =20
> > own here?
>=20
> Is there a compile error?  if so please post it.
>=20
> - k

I'm using 2.6.25.8, but I think it's the same for all 2.6.25 kernels.
I set: ARCH=3Dpowerpc, CROSS_COMPILE=3Dpowerpc-linux-gnuspe-
The cpu is Freescale 8548, so "Processor Type" is Freescale 85xx

First, there's no Kconfig entry for rapidio, as it seems stuck in the
ppc subtree, with bad guarding condition (around line 1097 in
arch/ppc/Kconfig), so I just copied it into arch/powerpc/Kconfig (without
the conditional for now).

And now for the build errors:
Stage 1:
arch/powerpc/kernel/rio.c:17:21: error: asm/rio.h: No such file or=20
directory

Stage 2 (after fixing stage 1):
arch/powerpc/sysdev/fsl_rio.c: In function =E2rio_open_outb_mbox=E2:
arch/powerpc/sysdev/fsl_rio.c:455: error: =E2MPC85xx_IRQ_RIO_TX=E2 undeclar=
ed=20
(first use in this function)
arch/powerpc/sysdev/fsl_rio.c:455: error: (Each undeclared identifier is=20
reported only once
arch/powerpc/sysdev/fsl_rio.c:455: error: for each function it appears in.)
arch/powerpc/sysdev/fsl_rio.c: In function =E2rio_close_outb_mbox=E2:
arch/powerpc/sysdev/fsl_rio.c:510: error: =E2MPC85xx_IRQ_RIO_TX=E2 undeclar=
ed=20
(first use in this function)
arch/powerpc/sysdev/fsl_rio.c: In function =E2rio_open_inb_mbox=E2:
arch/powerpc/sysdev/fsl_rio.c:600: error: =E2MPC85xx_IRQ_RIO_RX=E2 undeclar=
ed=20
(first use in this function)
arch/powerpc/sysdev/fsl_rio.c: In function =E2rio_close_inb_mbox=E2:
arch/powerpc/sysdev/fsl_rio.c:647: error: =E2MPC85xx_IRQ_RIO_RX=E2 undeclar=
ed=20
(first use in this function)
arch/powerpc/sysdev/fsl_rio.c: In function =E2mpc85xx_rio_doorbell_init=E2:
arch/powerpc/sysdev/fsl_rio.c:838: error: =E2MPC85xx_IRQ_RIO_BELL=E2 undecl=
ared (first use in this function)
arch/powerpc/sysdev/fsl_rio.c: In function =E2mpc85xx_rio_setup=E2:
arch/powerpc/sysdev/fsl_rio.c:916: error: =E2CCSRBAR=E2 undeclared (first u=
se=20
in this function)


And the worst thing is - those macros are defined using old style ppc
register defines and I don't have a nearest idea how to fix it on a new=20
style kernel (for one - CCSRBAR is replaced with some runtime thingie).
=0A=0A=0A      

Return-Path: <Emilian.Medve@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] [POWERPC] Add the PC speaker only when requested so
Date: Fri, 23 May 2008 05:59:32 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E2701F48255@az33exm24.fsl.freescale.net>
In-Reply-To: <fa686aa40805221627u4c4580bane16f3c3e23c8e9f5@mail.gmail.com>
References: <1211496016-30311-1-git-send-email-Emilian.Medve@Freescale.com>
	<fa686aa40805221627u4c4580bane16f3c3e23c8e9f5@mail.gmail.com>
From: "Medve Emilian" <Emilian.Medve@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Grant,


You can reproduce this by adding initcall_debug to your kernel
parameters. I'm encountering this situation on an MPC85xx board, but
from looking at the code that seems irrelevant as add_pcspkr() will get
executed anyway. True, "pnpPNP,100" is looked after before the platform
code runs and it will fail if it can't find "pnpPNP,100", but the error
message will show up. As mentioned below, this saves some memory and a
few boot-up CPU cycles...

PCSPKR_PLATFORM is an option in init/Kconfig:

        ...
config PCSPKR_PLATFORM
	bool "Enable PC-Speaker support" if EMBEDDED
	depends on ALPHA || X86 || MIPS || PPC_PREP || PPC_CHRP ||
PPC_PSERIES
	default y
	help
          This option allows to disable the internal PC-Speaker
          support, saving some memory.
        ...


Cheers,
Emil.


> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On=20
> Behalf Of Grant Likely
> Sent: Thursday, May 22, 2008 6:28 PM
> To: Medve Emilian
> Cc: paulus@samba.org; galak@kernel.crashing.org;=20
> linuxppc-dev@ozlabs.org; linuxppc-embedded@ozlabs.org
> Subject: Re: [PATCH] [POWERPC] Add the PC speaker only when=20
> requested so
>=20
> On Thu, May 22, 2008 at 4:40 PM, Emil Medve=20
> <Emilian.Medve@freescale.com> wrote:
> > This will cause this minor boot-time debugging error=20
> message to go away:
> >
> > [    1.316451] calling  add_pcspkr+0x0/0x84
> > [    1.316478] initcall add_pcspkr+0x0/0x84 returned -19=20
> after 0 msecs
>=20
> What situation are you hitting this in?  The code should only run if
> there is a "pnpPNP,100" compatible node in the device tree.
>=20
> Also, where is CONFIG_PCSPKR_PLATFORM defined?  I don't see it
> anywhere in powerpc code and only a reference to it in an x86
> Makefile.  As it stands, it looks like this patch unconditionally
> disables the pcspkr code.
>=20
> Cheers,
> g.
>=20
> >
> > Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> > ---
> >
> >> scripts/checkpatch.pl=20
> 0001--POWERPC-Add-the-PC-speaker-only-when-requested-so.patch
> > total: 0 errors, 0 warnings, 14 lines checked
> >
> >=20
> 0001--POWERPC-Add-the-PC-speaker-only-when-requested-so.patch=20
> has no obvious style problems and is ready for submission.
> >
> >  arch/powerpc/kernel/setup-common.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/setup-common.c=20
> b/arch/powerpc/kernel/setup-common.c
> > index db540ea..61a3f41 100644
> > --- a/arch/powerpc/kernel/setup-common.c
> > +++ b/arch/powerpc/kernel/setup-common.c
> > @@ -500,6 +500,7 @@ void __init smp_setup_cpu_sibling_map(void)
> >  }
> >  #endif /* CONFIG_SMP */
> >
> > +#ifdef CONFIG_PCSPKR_PLATFORM
> >  static __init int add_pcspkr(void)
> >  {
> >        struct device_node *np;
> > @@ -522,6 +523,7 @@ static __init int add_pcspkr(void)
> >        return ret;
> >  }
> >  device_initcall(add_pcspkr);
> > +#endif /* CONFIG_PCSPKR_PLATFORM */
> >
> >  void probe_machine(void)
> >  {
> > --
> > 1.5.5.GIT
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
>=20
>=20
>=20
> --=20
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.

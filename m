Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
 by ozlabs.org (Postfix) with ESMTP id 3B74B1007D5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 23:53:34 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH] powerpc/40x: Add APM8018X SOC support
Date: Fri, 25 Nov 2011 12:53:28 +0000
References: <1322041464-20605-1-git-send-email-tinamdar@apm.com>
 <201111231415.51985.arnd@arndb.de>
 <CACoXjcnfCM8Z5qFfrHtxsXkpf492LVbkDA3X=a9dRv9Lcv7Asw@mail.gmail.com>
In-Reply-To: <CACoXjcnfCM8Z5qFfrHtxsXkpf492LVbkDA3X=a9dRv9Lcv7Asw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201111251253.29528.arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 25 November 2011, Tanmay Inamdar wrote:
> > >
> > > +#if defined(CONFIG_APM8018X)
> > > +/* CPR */
> > > +#define DCRN_CPR0_CONFIG_ADDR        0xa
> > > +#define DCRN_CPR1_CONFIG_DATA        0xb
> > > +/* AHB */
> > > +#define DCRN_SDR1_CONFIG_ADDR        0xc
> > > +#define DCRN_SDR1_CONFIG_DATA        0xd
> > > +#else
> > >  /* CPRs (440GX and 440SP/440SPe) */
> > >  #define DCRN_CPR0_CONFIG_ADDR        0xc
> > >  #define DCRN_CPR0_CONFIG_DATA        0xd
> > > +#endif /* CONFIG_APM8018X */
> >
> > same comment as above.
> >
> 
> Some existing drivers use these macros. If I change the names, I will have
> to update the
> driver code.

Not so many apparently:

$ git grep DCRN_CPR._CONFIG 
arch/powerpc/include/asm/dcr-regs.h:#define DCRN_CPR0_CONFIG_ADDR       0xc
arch/powerpc/include/asm/dcr-regs.h:#define DCRN_CPR0_CONFIG_DATA       0xd
arch/powerpc/kvm/44x_emulate.c:                 case DCRN_CPR0_CONFIG_ADDR:
arch/powerpc/kvm/44x_emulate.c:                 case DCRN_CPR0_CONFIG_DATA:
arch/powerpc/kvm/44x_emulate.c:                         mtdcr(DCRN_CPR0_CONFIG_ADDR,
arch/powerpc/kvm/44x_emulate.c:                                        mfdcr(DCRN_CPR0_CONFIG_DATA));
arch/powerpc/kvm/44x_emulate.c:                 case DCRN_CPR0_CONFIG_ADDR:

Don't worry about out of tree drivers. If you want to be nice to the authors,
rename the macros so that the drivers break in an obvious way rather than
silently.

Note that any drivers relying on these as a constant are already broken
as soon as you try to build a kernel with both APM8018X and 440 enabled,
so you absolutely have to change the device drivers to work with those
kernels.

> > > diff --git a/arch/powerpc/kernel/cputable.c
> > b/arch/powerpc/kernel/cputable.c
> > > index edae5bb..e5c51a6 100644
> > > --- a/arch/powerpc/kernel/cputable.c
> > > +++ b/arch/powerpc/kernel/cputable.c
> > > @@ -1505,6 +1505,58 @@ static struct cpu_spec __initdata cpu_specs[] = {
> > >               .machine_check          = machine_check_4xx,
> > >               .platform               = "ppc405",
> > >       },
> > > +     {       /* APM80186-SK */
> > > +             .pvr_mask               = 0xffffffff,
> > > +             .pvr_value              = 0x7ff11432,
> >
> > If you mask out the lower bits, you only need a single entry instead of
> > four identical ones.
> >
> 
> You are right. But each PVR represent different version of SOC. If I create
> single
> entry, then I will have to give generic cpu_name which I don't want.

Isn't the common name for these always "APM80186"? If you don't need to tell
the difference between them for the purposes of cpu_spec, then don't do
it here.

	Arnd

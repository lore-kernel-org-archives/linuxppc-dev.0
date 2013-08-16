Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1AD462C021F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 13:34:43 +1000 (EST)
Message-ID: <1376624076.4255.132.camel@pasglop>
Subject: Re: [PATCH] powerpc/powernv: Return secondary CPUs to firmware on
 kexec
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
Date: Fri, 16 Aug 2013 13:34:36 +1000
In-Reply-To: <CAEjGV6wdjnoh__eAZ0pFh9o+-=ZpDB-Sg9CBuA2Z+FepgK1-1w@mail.gmail.com>
References: <1376611546.4255.120.camel@pasglop>
 <CAEjGV6wdjnoh__eAZ0pFh9o+-=ZpDB-Sg9CBuA2Z+FepgK1-1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-16 at 11:16 +1000, Michael Neuling wrote:
> 
> > With OPAL v3 we can return secondary CPUs to firmware on kexec. This
> > allows firmware to do various cleanups making things generally more
> > reliable, and will enable the "new" kernel to call OPAL to perform
> > some reconfiguration tasks early on that can only be done while
> > all the CPUs are in firmware.
> 
> Dumb question, but isn't the point of kexec to avoid fw interactions
> like this?

The point of kexec is to avoid rebooting :-)

Sending secondaries back to the OPAL internal spin loop doesn't take a
noticeable amount of time.

We could avoid doing it and solve the problem of needing all CPUs in
firmware for "reconfig" differently however. We could have the "target"
kernel code take them out of kexec into a special path that goes back
into the fw ... I chose the kexec solution because it was simpler and
less code :-)

Cheers,
Ben.

> Mikey
> 
> 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >
> > diff --git a/arch/powerpc/platforms/powernv/setup.c
> b/arch/powerpc/platforms/powernv/setup.c
> > index d4459bf..b59a1da 100644
> > --- a/arch/powerpc/platforms/powernv/setup.c
> > +++ b/arch/powerpc/platforms/powernv/setup.c
> > @@ -31,6 +31,7 @@
> >  #include <asm/xics.h>
> >  #include <asm/rtas.h>
> >  #include <asm/opal.h>
> > +#include <asm/kexec.h>
> >
> >  #include "powernv.h"
> >
> > @@ -143,6 +144,16 @@ static void pnv_shutdown(void)
> >  static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
> >  {
> >         xics_kexec_teardown_cpu(secondary);
> > +
> > +       /* Return secondary CPUs to firmware on OPAL v3 */
> > +       if (firmware_has_feature(FW_FEATURE_OPALv3) && secondary) {
> > +               mb();
> > +               get_paca()->kexec_state = KEXEC_STATE_REAL_MODE;
> > +               mb();
> > +
> > +               /* Return the CPU to OPAL */
> > +               opal_return_cpu();
> > +       }
> >  }
> >  #endif /* CONFIG_KEXEC */
> >
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> >
> 
> 

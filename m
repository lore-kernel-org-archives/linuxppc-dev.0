Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 55D8B1A0835
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 19:38:26 +1000 (EST)
Message-ID: <1401874705.32587.38.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/powernv: Enable POWER8 doorbell IPIs
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 04 Jun 2014 19:38:25 +1000
In-Reply-To: <1401868995.9903.4.camel@concordia>
References: <1401692223-28337-1-git-send-email-mikey@neuling.org>
 <1401692223-28337-2-git-send-email-mikey@neuling.org>
 <1401868995.9903.4.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-06-04 at 18:03 +1000, Michael Ellerman wrote:
> On Mon, 2014-06-02 at 16:57 +1000, Michael Neuling wrote:
> > This patch enables POWER8 doorbell IPIs on powernv.
> >=20
> > Since doorbells can only IPI within a core, we test to see when we can =
use
> > doorbells and if not we fall back to XICS.  This also enables hyperviso=
r
> > doorbells to wakeup us up from nap/sleep via the LPCR PECEDH bit.
> >=20
> > Based on tests by Anton, the best case IPI latency between two threads =
dropped
> > from 894ns to 512ns.
> >=20
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> >  arch/powerpc/kernel/cpu_setup_power.S | 2 ++
> >  arch/powerpc/platforms/powernv/smp.c  | 6 ++++++
> >  arch/powerpc/sysdev/xics/icp-native.c | 9 ++++++++-
> >  3 files changed, 16 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kerne=
l/cpu_setup_power.S
> > index 1557e7c..4673353 100644
> > --- a/arch/powerpc/kernel/cpu_setup_power.S
> > +++ b/arch/powerpc/kernel/cpu_setup_power.S
> > @@ -56,6 +56,7 @@ _GLOBAL(__setup_cpu_power8)
> >  	li	r0,0
> >  	mtspr	SPRN_LPID,r0
> >  	mfspr	r3,SPRN_LPCR
> > +	ori	r3, r3, LPCR_PECEDH
> >  	bl	__init_LPCR
> >  	bl	__init_HFSCR
> >  	bl	__init_tlb_power8
> > @@ -74,6 +75,7 @@ _GLOBAL(__restore_cpu_power8)
> >  	li	r0,0
> >  	mtspr	SPRN_LPID,r0
> >  	mfspr   r3,SPRN_LPCR
> > +	ori	r3, r3, LPCR_PECEDH
> >  	bl	__init_LPCR
> >  	bl	__init_HFSCR
> >  	bl	__init_tlb_power8
> > diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platfo=
rms/powernv/smp.c
> > index 0062a43..5fcfcf4 100644
> > --- a/arch/powerpc/platforms/powernv/smp.c
> > +++ b/arch/powerpc/platforms/powernv/smp.c
> > @@ -32,6 +32,7 @@
> >  #include <asm/opal.h>
> >  #include <asm/runlatch.h>
> >  #include <asm/code-patching.h>
> > +#include <asm/dbell.h>
> > =20
> >  #include "powernv.h"
> > =20
> > @@ -46,6 +47,11 @@ static void pnv_smp_setup_cpu(int cpu)
> >  {
> >  	if (cpu !=3D boot_cpuid)
> >  		xics_setup_cpu();
> > +
> > +#ifdef CONFIG_PPC_DOORBELL
> > +	if (cpu_has_feature(CPU_FTR_DBELL))
> > +		doorbell_setup_this_cpu();
> > +#endif
> >  }
>=20
> Where does CONFIG_PPC_DOORBELL get set?

No where.

> It looks like the only place you can be getting it is from CONFIG_PPC_PSE=
RIES.
> If you build a POWERNV only kernel it will get disabled, which I don't th=
ink is
> what we want.
>=20
> I think we should select it for POWERNV as well as PSERIES. That would me=
an
> it's always enabled for any build of the files you touch, so you shouldn'=
t need
> the #ifdefs.

Ok, I'll add and resend.

Mikey

Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0123.outbound.protection.outlook.com [65.55.169.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DDA91A0AE8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 06:23:38 +1000 (AEST)
Message-ID: <1434572602.2353.99.camel@freescale.com>
Subject: Re: [PATCH v3] powerpc/rcpm: add RCPM driver
From: Scott Wood <scottwood@freescale.com>
To: Bob Cochran <ppc@mindchasers.com>
CC: <Yuantian.Tang@freescale.com>, <b07421@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, Chenhui Zhao <chenhui.zhao@freescale.com>
Date: Wed, 17 Jun 2015 15:23:22 -0500
In-Reply-To: <55806425.7020505@mindchasers.com>
References: <1434446808-31121-1-git-send-email-Yuantian.Tang@freescale.com>
 <55806425.7020505@mindchasers.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-06-16 at 14:00 -0400, Bob Cochran wrote:
> On 06/16/2015 05:26 AM,  Yuantian.Tang@freescale.comwrote:
> > From: Tang Yuantian <Yuantian.Tang@freescale.com>
> > 
> > There is a RCPM (Run Control/Power Management) in Freescale QorIQ
> > series processors. The device performs tasks associated with device
> > run control and power management.
> > 
> > The driver implements some features: mask/unmask irq, enter/exit 
> > low
> > power states, freeze time base, etc.
> > 
> > Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> > Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> > ---
> > v3:
> >     - added static and __init modifier to fsl_rcpm_init
> > v2:
> >     - fix code style issues
> >     - refine compatible string match part
> > 
> >   Documentation/devicetree/bindings/soc/fsl/rcpm.txt |  22 ++
> >   arch/powerpc/include/asm/fsl_guts.h                | 105 +++++++
> >   arch/powerpc/include/asm/fsl_pm.h                  |  48 +++
> >   arch/powerpc/platforms/85xx/Kconfig                |   1 +
> >   arch/powerpc/sysdev/Kconfig                        |   5 +
> >   arch/powerpc/sysdev/Makefile                       |   1 +
> >   arch/powerpc/sysdev/fsl_rcpm.c                     | 338 
> > +++++++++++++++++++++
> >   7 files changed, 520 insertions(+)
> >   create mode 100644 
> > Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> >   create mode 100644 arch/powerpc/include/asm/fsl_pm.h
> >   create mode 100644 arch/powerpc/sysdev/fsl_rcpm.c
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt 
> > b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > new file mode 100644
> > index 0000000..5318999
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > @@ -0,0 +1,22 @@
> > +* Run Control and Power Management
> > +
> > +The RCPM performs all device-level tasks associated with device 
> > run control
> > +and power management.
> > +
> > +Required properites:
> > +  - reg : Offset and length of the register set of RCPM block.
> > +  - compatible : Specifies the compatibility list for the RCPM. 
> > The type
> > +    should be string, such as "fsl,qoriq-rcpm-1.0", "fsl,qoriq-
> > rcpm-2.0".
> 
> 
> I just checked both my T1040 RM and datasheet, and I didn't see 
> mention 
> of the RCPM version that's used ( I assume it's 2.0 ).  Is there a 
> general rule for which SoCs have which version?  If so, perhaps 
> you'll 
> want to include it here along with your examples.

It should be the same as the list in 
Documentation/devicetree/bindings/clock/qoriq-clock.txt, but yes, it'd 
be good to include it here.  FWIW, while T1040 is often labelled as 
having "2.0" blocks, it's not quite the same (e.g. the clock block is 
missing CLKCGnHWACSR) and should probably be labelled something else.

There should also be a sperific-chip compatible (which is shown in the 
t4240 example, but not in the p4080 example or the property 
description).

+
> > +#define E500_PM_PH10       1
> > +#define E500_PM_PH15       2
> > +#define E500_PM_PH20       3
> > +#define E500_PM_PH30       4
> > +#define E500_PM_DOZE       E500_PM_PH10
> > +#define E500_PM_NAP        E500_PM_PH15
> 
> 
> Are you using "E500" in your labels for historical reasons? I can 
> use 
> this driver with E5500 and E6500 cores, right? 

We often use "e500" to refer to the entire family of e500 derivatives.

> However, maybe I'm 
> mistaken since some of your states don't seem to map to my E5500 / 
> T1040 
> (e.g., my RCPM doesn't seem to support PH20 or PH30, but I do have 
> LPM10 
> and LPM35, which I don't think your driver supports).  My RM states 
> that 
> LPM35 is a newer PM state, so maybe this is future work to be done?

PH20 and PH30 were introduced in e6500.

-Scott

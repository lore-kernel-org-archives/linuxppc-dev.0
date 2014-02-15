Return-Path: <cody@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 922102C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Feb 2014 11:25:17 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Fri, 14 Feb 2014 17:25:15 -0700
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2981F38C8047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 19:25:12 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1F0PCN39568722
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Feb 2014 00:25:12 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1F0PANL029836
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 19:25:11 -0500
Date: Fri, 14 Feb 2014 16:25:05 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 10/11] powerpc/perf: add kconfig option for hypervisor
 provided counters
Message-ID: <20140215002505.GA2991@negative>
References: <1392415338-16288-1-git-send-email-cody@linux.vnet.ibm.com>
 <1392415338-16288-11-git-send-email-cody@linux.vnet.ibm.com>
 <1392417133.6733.624.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392417133.6733.624.camel@snotra.buserror.net>
Cc: Paul Bolle <pebolle@tiscali.nl>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>, Michael Ellerman <michael@ellerman.id.au>,
 Tang Yuantian <yuantian.tang@freescale.com>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Priyanka Jain <Priyanka.Jain@freescale.com>,
 Lijun Pan <Lijun.Pan@freescale.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 14, 2014 at 04:32:13PM -0600, Scott Wood wrote:
> On Fri, 2014-02-14 at 14:02 -0800, Cody P Schafer wrote:
> > Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/perf/Makefile             | 2 ++
> >  arch/powerpc/platforms/Kconfig.cputype | 6 ++++++
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
> > index 60d71ee..f9c083a 100644
> > --- a/arch/powerpc/perf/Makefile
> > +++ b/arch/powerpc/perf/Makefile
> > @@ -11,5 +11,7 @@ obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
> >  obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
> >  obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o e6500-pmu.o
> >  
> > +obj-$(CONFIG_HV_PERF_CTRS) += hv-24x7.o hv-gpci.o hv-common.o
> > +
> >  obj-$(CONFIG_PPC64)		+= $(obj64-y)
> >  obj-$(CONFIG_PPC32)		+= $(obj32-y)
> > diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> > index 434fda3..dcc67cd 100644
> > --- a/arch/powerpc/platforms/Kconfig.cputype
> > +++ b/arch/powerpc/platforms/Kconfig.cputype
> > @@ -364,6 +364,12 @@ config PPC_PERF_CTRS
> >         help
> >           This enables the powerpc-specific perf_event back-end.
> >  
> > +config HV_PERF_CTRS
> > +       def_bool y
> > +       depends on PERF_EVENTS && PPC_HAVE_PMU_SUPPORT
> > +       help
> > +         Enable access to perf counters provided by the hypervisor
> 
> Please don't add default-y stuff that is platform-specific, and
> definitely point out that platform dependency in the config description
> -- I have to look elsewhere in the patchset to determine that this is
> for "Power Hypervisor".  PPC_HAVE_PMU_SUPPORT is enabled by all 6xx
> builds, even for hardware like e300 that doesn't have PMU at all (it has
> the FSL embedded perfmon instead), much less this hv interface.
> 
> And yes, PPC_PERF_CTRS has the same problem and should be fixed. :-)

Yep, I just based this one on what PPC_PERF_CTRS was doing.

How about the following:

+config HV_PERF_CTRS
+       bool "Perf Hypervisor supplied counters"
+       default y
+       depends on PERF_EVENTS && PPC_HAVE_PMU_SUPPORT && PPC_PSERIES
+       help
+	  Enable access to hypervisor supplied counters in perf. Currently,
+	  this enables code that uses the hcall GetPerfCounterInfo and 24x7
+	  interfaces to retrieve counters. GPCI exists on Power 6 and later
+	  systems. 24x7 is available on Power 8 systems.
+
+          If unsure, select Y.

And relocated to arch/powerpc/platforms/Kconfig (as this isn't really
strictly "cputype" related).

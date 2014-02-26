Return-Path: <mpe@ellerman.id.au>
Message-ID: <1393386516.29388.6.camel@concordia>
Subject: Re: [PATCH v2 10/11] powerpc/perf: add kconfig option for
 hypervisor provided counters
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Date: Wed, 26 Feb 2014 14:48:36 +1100
In-Reply-To: <530D0BA1.90609@linux.vnet.ibm.com>
References: <20140225033330.54F332C02FB@ozlabs.org>
 <530D0BA1.90609@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Bolle <pebolle@tiscali.nl>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>,
 Tang Yuantian <yuantian.tang@freescale.com>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Priyanka Jain <Priyanka.Jain@freescale.com>,
 Scott Wood <scottwood@freescale.com>, Lijun Pan <Lijun.Pan@freescale.com>,
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

On Tue, 2014-02-25 at 13:31 -0800, Cody P Schafer wrote:
> On 02/24/2014 07:33 PM, Michael Ellerman wrote:
> > On Fri, 2014-14-02 at 22:02:14 UTC, Cody P Schafer wrote:
> >> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
> >> ---
> >>   arch/powerpc/perf/Makefile             | 2 ++
> >>   arch/powerpc/platforms/Kconfig.cputype | 6 ++++++
> >>   2 files changed, 8 insertions(+)
> >>
> >> diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
> >> index 60d71ee..f9c083a 100644
> >> --- a/arch/powerpc/perf/Makefile
> >> +++ b/arch/powerpc/perf/Makefile
> >> @@ -11,5 +11,7 @@ obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
> >>   obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
> >>   obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o e6500-pmu.o
> >>
> >> +obj-$(CONFIG_HV_PERF_CTRS) += hv-24x7.o hv-gpci.o hv-common.o
> >> +
> >>   obj-$(CONFIG_PPC64)		+= $(obj64-y)
> >>   obj-$(CONFIG_PPC32)		+= $(obj32-y)
> >> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> >> index 434fda3..dcc67cd 100644
> >> --- a/arch/powerpc/platforms/Kconfig.cputype
> >> +++ b/arch/powerpc/platforms/Kconfig.cputype
> >> @@ -364,6 +364,12 @@ config PPC_PERF_CTRS
> >>          help
> >>            This enables the powerpc-specific perf_event back-end.
> >>
> >> +config HV_PERF_CTRS
> >> +       def_bool y
> >
> > This was bool, why did you change it?
> 
> No, it wasn't. v1 also had def_bool. https://lkml.org/lkml/2014/1/16/518
> Maybe you're confusing v2.1 and v2 of this patch?

Er yes. Point releases of a patch series confuse me :)

> >> +       depends on PERF_EVENTS && PPC_HAVE_PMU_SUPPORT
> >
> > Should be:
> >
> > 	depends on PERF_EVENTS && PPC_PSERIES
> >
> >> +       help
> >> +         Enable access to perf counters provided by the hypervisor
> >> +
> 
> Yep, the v2.1 patch (which I bungled and labeled as 9/11) already 
> changes both of these.
> It'll end up rolled into v3.

Yes please.

cheers

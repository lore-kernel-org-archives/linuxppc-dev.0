Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F11662C0089
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Feb 2014 09:32:26 +1100 (EST)
Message-ID: <1392417133.6733.624.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 10/11] powerpc/perf: add kconfig option for
 hypervisor provided counters
From: Scott Wood <scottwood@freescale.com>
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Date: Fri, 14 Feb 2014 16:32:13 -0600
In-Reply-To: <1392415338-16288-11-git-send-email-cody@linux.vnet.ibm.com>
References: <1392415338-16288-1-git-send-email-cody@linux.vnet.ibm.com>
 <1392415338-16288-11-git-send-email-cody@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
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

On Fri, 2014-02-14 at 14:02 -0800, Cody P Schafer wrote:
> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/Makefile             | 2 ++
>  arch/powerpc/platforms/Kconfig.cputype | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
> index 60d71ee..f9c083a 100644
> --- a/arch/powerpc/perf/Makefile
> +++ b/arch/powerpc/perf/Makefile
> @@ -11,5 +11,7 @@ obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
>  obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
>  obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o e6500-pmu.o
>  
> +obj-$(CONFIG_HV_PERF_CTRS) += hv-24x7.o hv-gpci.o hv-common.o
> +
>  obj-$(CONFIG_PPC64)		+= $(obj64-y)
>  obj-$(CONFIG_PPC32)		+= $(obj32-y)
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 434fda3..dcc67cd 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -364,6 +364,12 @@ config PPC_PERF_CTRS
>         help
>           This enables the powerpc-specific perf_event back-end.
>  
> +config HV_PERF_CTRS
> +       def_bool y
> +       depends on PERF_EVENTS && PPC_HAVE_PMU_SUPPORT
> +       help
> +         Enable access to perf counters provided by the hypervisor

Please don't add default-y stuff that is platform-specific, and
definitely point out that platform dependency in the config description
-- I have to look elsewhere in the patchset to determine that this is
for "Power Hypervisor".  PPC_HAVE_PMU_SUPPORT is enabled by all 6xx
builds, even for hardware like e300 that doesn't have PMU at all (it has
the FSL embedded perfmon instead), much less this hv interface.

And yes, PPC_PERF_CTRS has the same problem and should be fixed. :-)

-Scott

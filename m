Return-Path: <ego@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 732C3B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 Nov 2009 23:01:47 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id nABC1l6I004018
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2009 23:01:47 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nABBwXJJ831682
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2009 22:58:33 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nABC1jNd024069
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2009 23:01:46 +1100
Date: Wed, 11 Nov 2009 17:31:40 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Nathan Fontenot <nfont@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH v5 0/4] pseries: Add cede support for cpu-offline
Message-ID: <20091111120140.GA11317@in.ibm.com>
References: <20091030052106.25493.42109.stgit@sofia.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091030052106.25493.42109.stgit@sofia.in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Arun R Bharadwaj <arun@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@elte.hu>
Reply-To: ego@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 30, 2009 at 10:52:43AM +0530, Gautham R Shenoy wrote:
> Hi,

Hi Peter,

Did you get a chance to look at this new design ?

> 
> This is version 5 of patch series that provides a framework to choose the
> state a pseries CPU must be put to when it is offlined.
> 
> Previous versions can be found here:
> Version 4: http://lkml.org/lkml/2009/10/9/59
> Version 3: http://lkml.org/lkml/2009/9/15/164
> Version 2: http://lkml.org/lkml/2009/8/28/102
> Version 1: http://lkml.org/lkml/2009/8/6/236
> 
> Changes from the previous version include:
> - Rebased against Nathan Fontenot's latest "pseries kernel handling of dynamic
>   logical paritioning v4" patches found here:
>   http://lkml.org/lkml/2009/10/21/98
> 
> - Added boot-time option to disable putting the offlined vcpus into an
>   extended H_CEDE state.
> 
> - Addressed Ben's comments regarding the if-else sequencing in
>   pseries_mach_cpu_die().
> 
> - Addition of comments for pseries_cpu_die() to distinguish it from
>   pseries_mach_cpu_die()
> 
> Also,
> 
> - This approach addresses Peter Z's objections regarding layering
>   violations. The user simply offlines the cpu and doesn't worry about what
>   state the CPU should be put into. That part is automatically handled by the
>   kernel.
> 
> - It does not add any additional sysfs interface instead uses the existing
>   sysfs interface to offline CPUs.
> 
> - On platforms which do not have support for ceding the vcpu with a
>   latency specifier value, the offlining mechanism defaults to the current
>   method of calling rtas_stop_self().
> 
> The patchset has been tested on the available pseries platforms and it works
> as per the expectations. I believe that the patch set is ready for inclusion.
> ---
> 
> Gautham R Shenoy (4):
>       pseries: Serialize cpu hotplug operations during deactivate Vs deallocate
>       pseries: Add code to online/offline CPUs of a DLPAR node.
>       pSeries: Add hooks to put the CPU into an appropriate offline state
>       pSeries: extended_cede_processor() helper function.
> 
> 
>  Documentation/cpu-hotplug.txt                   |    6 +
>  arch/powerpc/include/asm/lppaca.h               |    9 +
>  arch/powerpc/platforms/pseries/dlpar.c          |  129 ++++++++++++++++
>  arch/powerpc/platforms/pseries/hotplug-cpu.c    |  182 ++++++++++++++++++++++-
>  arch/powerpc/platforms/pseries/offline_states.h |   18 ++
>  arch/powerpc/platforms/pseries/plpar_wrappers.h |   22 +++
>  arch/powerpc/platforms/pseries/smp.c            |   19 ++
>  arch/powerpc/xmon/xmon.c                        |    3 
>  drivers/base/cpu.c                              |    2 
>  include/linux/cpu.h                             |   13 ++
>  10 files changed, 387 insertions(+), 16 deletions(-)
>  create mode 100644 arch/powerpc/platforms/pseries/offline_states.h
> 
> -- 
> Thanks and Regards
> gautham.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Thanks and Regards
gautham

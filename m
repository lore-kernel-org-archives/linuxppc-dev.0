Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxdN73x6bzDqlL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 17:48:55 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5R7mqdD101114
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 03:48:53 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bb2b3yds8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 03:48:53 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 27 Jun 2017 17:48:42 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5R7meK761407416
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 17:48:40 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5R7meaC029392
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 17:48:40 +1000
Subject: Re: [PATCH] powerpc/perf: Add POWER9 alternate PM_RUN_CYC and
 PM_RUN_INST_CMPL events
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, mikey@neuling.org
Cc: linuxppc-dev@lists.ozlabs.org
References: <20170618235128.20472-1-anton@ozlabs.org>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 27 Jun 2017 13:18:37 +0530
MIME-Version: 1.0
In-Reply-To: <20170618235128.20472-1-anton@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <fd388965-53af-2fe1-5606-5d6f5e1c6324@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Monday 19 June 2017 05:21 AM, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
>
> Similar to POWER8, POWER9 can count run cycles and run instructions
> completed on more than one PMU.

Acked-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>


> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>   arch/powerpc/perf/power9-events-list.h | 4 ++++
>   arch/powerpc/perf/power9-pmu.c         | 2 ++
>   2 files changed, 6 insertions(+)
>
> diff --git a/arch/powerpc/perf/power9-events-list.h b/arch/powerpc/perf/power9-events-list.h
> index 71a6bfee5c02..e9e417eefa59 100644
> --- a/arch/powerpc/perf/power9-events-list.h
> +++ b/arch/powerpc/perf/power9-events-list.h
> @@ -51,8 +51,12 @@ EVENT(PM_DTLB_MISS,				0x300fc)
>   EVENT(PM_ITLB_MISS,				0x400fc)
>   /* Run_Instructions */
>   EVENT(PM_RUN_INST_CMPL,				0x500fa)
> +/* Alternate event code for PM_RUN_INST_CMPL */
> +EVENT(PM_RUN_INST_CMPL_ALT,			0x400fa)
>   /* Run_cycles */
>   EVENT(PM_RUN_CYC,				0x600f4)
> +/* Alternate event code for Run_cycles */
> +EVENT(PM_RUN_CYC_ALT,				0x200f4)
>   /* Instruction Dispatched */
>   EVENT(PM_INST_DISP,				0x200f2)
>   EVENT(PM_INST_DISP_ALT,				0x300f2)
> diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
> index 018f8e90ac35..b9168163b2b2 100644
> --- a/arch/powerpc/perf/power9-pmu.c
> +++ b/arch/powerpc/perf/power9-pmu.c
> @@ -107,6 +107,8 @@ extern struct attribute_group isa207_pmu_format_group;
>   /* Table of alternatives, sorted by column 0 */
>   static const unsigned int power9_event_alternatives[][MAX_ALT] = {
>   	{ PM_INST_DISP,			PM_INST_DISP_ALT },
> +	{ PM_RUN_CYC_ALT,		PM_RUN_CYC },
> +	{ PM_RUN_INST_CMPL_ALT,		PM_RUN_INST_CMPL },
>   };
>
>   static int power9_get_alternatives(u64 event, unsigned int flags, u64 alt[])

Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjhdG1JG7zDqZq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 22:34:09 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7VCY60U093576
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 08:34:07 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cpdd6s83w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 08:34:07 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Thu, 31 Aug 2017 22:33:58 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7VCXt3t34275472
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 22:33:55 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7VCXjpX026058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 22:33:46 +1000
Date: Thu, 31 Aug 2017 05:33:53 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org
Subject: Re: [PATCH 4/4] powerpc/smp: Add Power9 scheduler topology
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20170629071256.8159-1-oohall@gmail.com>
 <20170629071256.8159-5-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170629071256.8159-5-oohall@gmail.com>
Message-Id: <20170831123353.GA37619@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +static struct sched_domain_topology_level power9_topology[] = {
> +#ifdef CONFIG_SCHED_SMT
> +	{ cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT) },
> +#endif
> +	{ shared_cache_mask, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE) },
> +	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
> +	{ NULL, },
> +};
> +

Should we name this domain as MC instead of CACHE. Then it would be
compatible with other archs like x86/arm/s390. MC stands for Multi-Core
so it gels with what we have.

Also we could enable CONFIG_SCHED_MC and reuse cpu_core_flags() instead
of adding powerpc_shared_cache_flags.

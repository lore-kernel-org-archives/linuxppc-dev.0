Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDphJ4skDzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 19:40:16 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3S9dQte095402
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 05:40:08 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a432u8gs7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 05:40:07 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 28 Apr 2017 19:40:03 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3S9dq8758327182
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 19:40:00 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3S9dQmF023476
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 19:39:27 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/powernv: Add config option for removal of
 memory
To: Rashmica Gupta <rashmica.g@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, anton@samba.org, npiggin@gmail.com,
 bsingharora@gmail.com, oohall@gmail.com
References: <20170428054227.9176-1-rashmica.g@gmail.com>
Date: Fri, 28 Apr 2017 15:09:09 +0530
MIME-Version: 1.0
In-Reply-To: <20170428054227.9176-1-rashmica.g@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <9618346f-36ef-2943-f5c0-5be1e87b28f9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/28/2017 11:12 AM, Rashmica Gupta wrote:
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>

Please describe a bit about the function/feature you are trying
to add with this new config option. The subject says " Add config
option for removal of memory" but I guess its not related to
memory hotplug but about hardware enabled tracing IIUC. Hence
it should have some amount of description.

> ---
>  arch/powerpc/platforms/powernv/Kconfig  | 4 ++++
>  arch/powerpc/platforms/powernv/Makefile | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
> index 6a6f4ef..1b8b3a8 100644
> --- a/arch/powerpc/platforms/powernv/Kconfig
> +++ b/arch/powerpc/platforms/powernv/Kconfig
> @@ -30,3 +30,7 @@ config OPAL_PRD
>  	help
>  	  This enables the opal-prd driver, a facility to run processor
>  	  recovery diagnostics on OpenPower machines
> +
> +config HARDWARE_TRACING

This is too generic for platform specific feature and also it does
not intend to fit into a generic HW tracing infrastructure. IMHO
it should be named something like "PPC64_HARDWARE_TRACING" or
something similar.

> +	bool 'Enable removal of memory for hardware memory tracing'

If this memory is going to be taken out of memblock like normal
memory hotplug and eventually goes away from kernel control, then
you need to be more specific about its usage.

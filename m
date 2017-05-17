Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSRW26RKSzDqMl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 17:57:34 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4H7nEVR106371
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 03:57:31 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2aggdewqcd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 03:57:30 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 17 May 2017 01:57:30 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org, dja@axtens.net,
 eranian@google.com, hemant@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: Re: [PATCH v8 07/10] powerpc/perf: PMU functions for Core IMC and
 hotplugging
In-Reply-To: <1493907596-11425-8-git-send-email-anju@linux.vnet.ibm.com>
References: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
 <1493907596-11425-8-git-send-email-anju@linux.vnet.ibm.com>
Date: Wed, 17 May 2017 17:57:22 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87wp9fdifx.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
> --- a/arch/powerpc/include/asm/imc-pmu.h
> +++ b/arch/powerpc/include/asm/imc-pmu.h
> @@ -24,6 +24,7 @@
>   */
>  #define IMC_MAX_CHIPS			32
>  #define IMC_MAX_PMUS			32
> +#define IMC_MAX_CORES			32
>
>  /*
>   * This macro is used for memory buffer allocation of
> @@ -38,6 +39,11 @@
>  #define IMC_NEST_MAX_PAGES		64
>
>  /*
> + * IMC Core engine expects 8K bytes of memory for counter collection.
> + */
> +#define IMC_CORE_COUNTER_MEM		8192

Any reason for this not to be in the device tree?

This is the size of memory that Linux needs to give OPAL, so the size of
that should probably come from OPAL rather than Linux.

Otherwise, if in the future, we had a counter with an offset greater
than 8192 in, we'd have no way to detect that and we'd fail silently by
overwriting memory.

-- 
Stewart Smith
OPAL Architect, IBM.

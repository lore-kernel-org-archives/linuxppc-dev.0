Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wPDF00hd2zDqMM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 12:19:15 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4C2JDGl113706
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 22:19:13 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2actxtwe0c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 22:19:13 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 11 May 2017 22:18:35 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org, eranian@google.com,
 hemant@linux.vnet.ibm.com
Subject: Re: [PATCH v8 05/10] powerpc/perf: IMC pmu cpumask and cpuhotplug
 support
In-Reply-To: <0dfc6438-374c-3086-3847-832b5396e7f2@linux.vnet.ibm.com>
References: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
 <1493907596-11425-6-git-send-email-anju@linux.vnet.ibm.com>
 <87shkfqvx6.fsf@possimpible.ozlabs.ibm.com>
 <0dfc6438-374c-3086-3847-832b5396e7f2@linux.vnet.ibm.com>
Date: Fri, 12 May 2017 12:18:29 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a86iizre.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
>>      * in patch 9 should opal_imc_counters_init return something other
>>        than OPAL_SUCCESS in the case on invalid arguments? Maybe
>>        OPAL_PARAMETER? (I think you fix this in a later patch anyway?)
>
> So, init call will return OPAL_PARAMETER for the unsupported
> domains (core and nest are supported). And if the init operation
> fails for any reason, it would return OPAL_HARDWARE. And this is
> documented.

(I'll comment on the skiboot one too), but I think that if the class
exists but init is a no-op, then OPAL_IMC_COUNTERS_INIT should return
OPAL_SUCCESS and just do nothing. This future proofs everything, and the
API is that one *must* call _INIT before start.


-- 
Stewart Smith
OPAL Architect, IBM.

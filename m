Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wPGHk25Q4zDqFr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 13:51:46 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4C3mn73025765
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 23:51:41 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ad2xrp8x1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 23:51:41 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 12 May 2017 13:51:38 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4C3pRmc5374346
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 13:51:35 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4C3ougu009981
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 13:50:57 +1000
Subject: Re: [PATCH v8 05/10] powerpc/perf: IMC pmu cpumask and cpuhotplug
 support
To: Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
References: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
 <1493907596-11425-6-git-send-email-anju@linux.vnet.ibm.com>
 <87shkfqvx6.fsf@possimpible.ozlabs.ibm.com>
 <0dfc6438-374c-3086-3847-832b5396e7f2@linux.vnet.ibm.com>
 <87a86iizre.fsf@linux.vnet.ibm.com> <87o9uybvg3.fsf@concordia.ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org, eranian@google.com,
 hemant@linux.vnet.ibm.com
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Fri, 12 May 2017 09:20:35 +0530
MIME-Version: 1.0
In-Reply-To: <87o9uybvg3.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <6bb74c36-854f-3be7-203f-fbf3ccad6909@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 12 May 2017 09:03 AM, Michael Ellerman wrote:
> Stewart Smith <stewart@linux.vnet.ibm.com> writes:
>
>> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
>>>>       * in patch 9 should opal_imc_counters_init return something other
>>>>         than OPAL_SUCCESS in the case on invalid arguments? Maybe
>>>>         OPAL_PARAMETER? (I think you fix this in a later patch anyway?)
>>> So, init call will return OPAL_PARAMETER for the unsupported
>>> domains (core and nest are supported). And if the init operation
>>> fails for any reason, it would return OPAL_HARDWARE. And this is
>>> documented.
>> (I'll comment on the skiboot one too), but I think that if the class
>> exists but init is a no-op, then OPAL_IMC_COUNTERS_INIT should return
>> OPAL_SUCCESS and just do nothing. This future proofs everything, and the
>> API is that one *must* call _INIT before start.
> Yes, 100%.
>
> That's what I described in my replies to a previous version, if it
> doesn't do that we need to fix it.
Hi mpe,

Yes, as you suggested in the opal v11 patchset, we return OPAL_SUCCESS
from _INIT for type "Nest". Have also added a prerror message logging
for debug, but can get away with it or make it as a prlog.

Maddy
>
> cheers
>

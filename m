Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wPFtk5w72zDqbs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 13:33:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org, eranian@google.com,
 hemant@linux.vnet.ibm.com
Subject: Re: [PATCH v8 05/10] powerpc/perf: IMC pmu cpumask and cpuhotplug
 support
In-Reply-To: <87a86iizre.fsf@linux.vnet.ibm.com>
References: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
 <1493907596-11425-6-git-send-email-anju@linux.vnet.ibm.com>
 <87shkfqvx6.fsf@possimpible.ozlabs.ibm.com>
 <0dfc6438-374c-3086-3847-832b5396e7f2@linux.vnet.ibm.com>
 <87a86iizre.fsf@linux.vnet.ibm.com>
Date: Fri, 12 May 2017 13:33:32 +1000
Message-ID: <87o9uybvg3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stewart Smith <stewart@linux.vnet.ibm.com> writes:

> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
>>>      * in patch 9 should opal_imc_counters_init return something other
>>>        than OPAL_SUCCESS in the case on invalid arguments? Maybe
>>>        OPAL_PARAMETER? (I think you fix this in a later patch anyway?)
>>
>> So, init call will return OPAL_PARAMETER for the unsupported
>> domains (core and nest are supported). And if the init operation
>> fails for any reason, it would return OPAL_HARDWARE. And this is
>> documented.
>
> (I'll comment on the skiboot one too), but I think that if the class
> exists but init is a no-op, then OPAL_IMC_COUNTERS_INIT should return
> OPAL_SUCCESS and just do nothing. This future proofs everything, and the
> API is that one *must* call _INIT before start.

Yes, 100%.

That's what I described in my replies to a previous version, if it
doesn't do that we need to fix it.

cheers

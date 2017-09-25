Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y12WH5tTKzDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 21:52:11 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8PBokT3118198
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 07:52:09 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d70ewknr3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 07:52:09 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 25 Sep 2017 05:52:08 -0600
Subject: Re: [PATCH] powerpc/perf: Fix for core/nest imc call trace on
 cpuhotplug
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com
References: <1505151134-26128-1-git-send-email-anju@linux.vnet.ibm.com>
 <87r2v0d5zi.fsf@concordia.ellerman.id.au>
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Mon, 25 Sep 2017 17:22:01 +0530
MIME-Version: 1.0
In-Reply-To: <87r2v0d5zi.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <28e408f0-d773-6d91-9282-92aa65ef043e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi mpe,


On Thursday 21 September 2017 10:04 AM, Michael Ellerman wrote:
> Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
>
>> Nest/core pmu units are enabled only when it is used. A reference count is
>> maintained for the events which uses the nest/core pmu units. Currently in
>> *_imc_counters_release function a WARN() is used for notification of any
>> underflow of ref count. Replace WARN() with a pr_info since it is an overkill.
> As discussed elsewhere this is not the right solution.
>
> If it's OK for the reference count to be negative, then we shouldn't
> print anything when it is.
>
> But I don't understand how it can be OK for the refcount to be negative.
> That means someone has a negative number of references to something?
>
> cheers
>

Scenario where this happens is in a stress test where perf session is 
started, followed by offlining of all cpus in a given core. And finally 
terminate the perf session.

So, in cpuhotplug offline path(ppc_core_imc_cpu_offline), function set 
the ref->count to zero, if the current cpu which is about to offline is 
the last cpu in a given core and make an OPAL call to disable the engine 
in that core.
And on perf session termination, perf->destory 
(core_imc_counters_release) will first decrement the ref->count for this 
core and based on the ref->count value an opal call is made to disable 
the core-imc engine.

Now, since cpuhotplug path already clears the ref->count for core and 
disabled the engine, perf->destroy() decrementing again at event 
termination make it negative which in turn fires the WARN_ON.

So we do prefer to remove the message as this wont happen in normal 
operation and the core counters are working as expected.
I will send out a patch by removing the message asap.


Thanks,
Anju

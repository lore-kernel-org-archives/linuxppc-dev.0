Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 691E62C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 05:02:01 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 24 Jun 2013 04:59:15 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 670CB3578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 05:01:57 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5NIl98t31916082
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 04:47:10 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5NJ1tv9010608
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 05:01:56 +1000
Message-ID: <51C7455B.904@linux.vnet.ibm.com>
Date: Mon, 24 Jun 2013 00:28:35 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 07/45] CPU hotplug: Expose the new debug config option
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
 <20130623133928.19094.8259.stgit@srivatsabhat.in.ibm.com>
 <51C70F82.4030101@cogentembedded.com>
In-Reply-To: <51C70F82.4030101@cogentembedded.com>
Content-Type: text/plain; charset=UTF-8
Cc: peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, "Paul E. McKenney" <paul.mckenney@linaro.org>,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 Catalin Marinas <catalin.marinas@arm.com>, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 Akinobu Mita <akinobu.mita@gmail.com>, rostedt@goodmis.org,
 namhyung@kernel.org, tglx@linutronix.de, laijs@cn.fujitsu.com,
 zhong@linux.vnet.ibm.com, netdev@vger.kernel.org, oleg@redhat.com, sbw@mit.edu,
 tj@kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/23/2013 08:38 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 23-06-2013 17:39, Srivatsa S. Bhat wrote:
> 
>> Now that we have all the pieces of the CPU hotplug debug infrastructure
>> in place, expose the feature by growing a new Kconfig option,
>> CONFIG_DEBUG_HOTPLUG_CPU.
> 
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: "Paul E. McKenney" <paul.mckenney@linaro.org>
>> Cc: Akinobu Mita <akinobu.mita@gmail.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Michel Lespinasse <walken@google.com>
>> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
>> ---
> 
>>   lib/Kconfig.debug |    9 +++++++++
>>   1 file changed, 9 insertions(+)
> 
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 566cf2b..6be1e72 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -512,6 +512,15 @@ config DEBUG_PREEMPT
>>         if kernel code uses it in a preemption-unsafe way. Also, the
>> kernel
>>         will detect preemption count underflows.
>>
>> +config DEBUG_HOTPLUG_CPU
>> +    bool "Debug CPU hotplug"
>> +    depends on HOTPLUG_CPU
>> +    default n
> 
>     It's the default default, no need to specify it.
> 

Ah, I see. Thanks!

Regards,
Srivatsa S. Bhat

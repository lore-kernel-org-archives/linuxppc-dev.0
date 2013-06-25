Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DCA6C2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 04:53:10 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 04:47:02 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E83F52BB0053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 04:53:05 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PIc71j8323544
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 04:38:07 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PIr3Ss032245
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 04:53:05 +1000
Message-ID: <51C9E647.90306@linux.vnet.ibm.com>
Date: Wed, 26 Jun 2013 00:19:43 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 04/45] CPU hotplug: Add infrastructure to check lacking
 hotplug synchronization
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
 <20130623133841.19094.69631.stgit@srivatsabhat.in.ibm.com>
 <1372116363.18733.189.camel@gandalf.local.home>
In-Reply-To: <1372116363.18733.189.camel@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Cc: peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 Alex Shi <alex.shi@intel.com>, vincent.guittot@linaro.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 xiaoguangrong@linux.vnet.ibm.com,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, wangyun@linux.vnet.ibm.com,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
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

On 06/25/2013 04:56 AM, Steven Rostedt wrote:
> On Sun, 2013-06-23 at 19:08 +0530, Srivatsa S. Bhat wrote:
> 
> 
> Just to make the code a little cleaner, can you add:
> 
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index 860f51a..e90d9d7 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -63,6 +63,72 @@ static struct {
>>  	.refcount = 0,
>>  };
>>  
>> +#ifdef CONFIG_DEBUG_HOTPLUG_CPU
>> +
[..]
> 
> static inline void atomic_reader_refcnt_inc(void)
> {
> 	this_cpu_inc(atomic_reader_refcnt);
> }
> static inline void atomic_reader_refcnt_dec(void)
> {
> 	this_cpu_dec(atomic_reader_refcnt);
> }
> 
> #else
> static inline void atomic_reader_refcnt_inc(void)
> {
> }
> static inline void atomic_reader_refcnt_dec(void)
> {
> }
> #endif
> 
>> +#endif
>> +
>>  void get_online_cpus(void)
>>  {
>>  	might_sleep();
>> @@ -189,13 +255,22 @@ unsigned int get_online_cpus_atomic(void)
>>  	 * from going offline.
>>  	 */
>>  	preempt_disable();
>> +
>> +#ifdef CONFIG_DEBUG_HOTPLUG_CPU
>> +	this_cpu_inc(atomic_reader_refcnt);
>> +#endif
> 
> Replace the #ifdef with just:
> 
> 	atomic_reader_refcnt_inc();
> 
>>  	return smp_processor_id();
>>  }
>>  EXPORT_SYMBOL_GPL(get_online_cpus_atomic);
>>  
>>  void put_online_cpus_atomic(void)
>>  {
>> +
>> +#ifdef CONFIG_DEBUG_HOTPLUG_CPU
>> +	this_cpu_dec(atomic_reader_refcnt);
>> +#endif
> 
> And
> 
> 	atomic_reader_refcnt_dec();
> 

This makes the code look much better. Thank you!
I'll make that change in my v2.

Regards,
Srivatsa S. Bhat

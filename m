Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E74712C0091
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 00:13:04 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 19:38:21 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 0C507E0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 19:42:31 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5QEDHXK24445142
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 19:43:17 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5QECtfO022881
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 00:12:56 +1000
Message-ID: <51CAF624.6060004@linux.vnet.ibm.com>
Date: Wed, 26 Jun 2013 19:39:40 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH v2 15/45] rcu: Use get/put_online_cpus_atomic() to prevent
 CPU offline
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
 <20130625202755.16593.67819.stgit@srivatsabhat.in.ibm.com>
 <20130625220026.GG3828@linux.vnet.ibm.com>
In-Reply-To: <20130625220026.GG3828@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
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

On 06/26/2013 03:30 AM, Paul E. McKenney wrote:
> On Wed, Jun 26, 2013 at 01:57:55AM +0530, Srivatsa S. Bhat wrote:
>> Once stop_machine() is gone from the CPU offline path, we won't be able
>> to depend on disabling preemption to prevent CPUs from going offline
>> from under us.
>>
>> In RCU code, rcu_implicit_dynticks_qs() checks if a CPU is offline,
>> while being protected by a spinlock. Use the get/put_online_cpus_atomic()
>> APIs to prevent CPUs from going offline, while invoking from atomic context.
> 
> I am not completely sure that this is needed.  Here is a (quite possibly
> flawed) argument for its not being needed:
> 
> o	rcu_gp_init() holds off CPU-hotplug operations during
> 	grace-period initialization.  Therefore, RCU will avoid
> 	looking for quiescent states from CPUs that were offline
> 	(and thus in an extended quiescent state) at the beginning
> 	of the grace period.
> 
> o	If force_qs_rnp() is looking for a quiescent state from
> 	a given CPU, and if it senses that CPU as being offline,
> 	then even without synchronization we know that the CPU
> 	was offline some time during the current grace period.
> 
> 	After all, it was online at the beginning of the grace
> 	period (otherwise, we would not be looking at it at all),
> 	and our later sampling of its state must have therefore
> 	happened after the start of the grace period.  Given that
> 	the grace period has not yet ended, it also has to happened
> 	before the end of the grace period.
> 
> o	Therefore, we should be able to sample the offline state
> 	without synchronization.
>

Thanks a lot for explaining the synchronization design in detail, Paul!
I agree that get/put_online_cpus_atomic() is not necessary here.

Regarding the debug checks under CONFIG_DEBUG_HOTPLUG_CPU, to avoid
false-positives, I'm thinking of introducing a few _nocheck() variants,
on a case-by-case basis, like cpu_is_offline_nocheck() (useful here in RCU)
and for_each_online_cpu_nocheck() (useful in percpu-counter code, as
pointed out by Tejun Heo). These fine synchronization details are kinda
hard to encapsulate in that debug logic, so we can use the _nocheck()
variants here to avoid getting splats when running with DEBUG_HOTPLUG_CPU
enabled.

Regards,
Srivatsa S. Bhat

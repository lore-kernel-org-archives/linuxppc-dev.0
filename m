Return-Path: <minchan@kernel.org>
Received: from LGEMRELSE1Q.lge.com (LGEMRELSE1Q.lge.com [156.147.1.111])
 by ozlabs.org (Postfix) with ESMTP id A576B2C0103
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2014 17:55:46 +1100 (EST)
Date: Fri, 14 Mar 2014 15:41:08 +0900
From: Minchan Kim <minchan@kernel.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 36/52] zsmalloc: Fix CPU hotplug callback registration
Message-ID: <20140314064108.GD20556@bbox>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
 <20140310203959.10746.61303.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140310203959.10746.61303.stgit@srivatsabhat.in.ibm.com>
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, akpm@linux-foundation.org, linux-pm@vger.kernel.org,
 peterz@infradead.org, rusty@rustcorp.com.au, rjw@rjwysocki.net,
 oleg@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@ozlabs.org, paulus@samba.org, tj@kernel.org, tglx@linutronix.de,
 paulmck@linux.vnet.ibm.com, mingo@kernel.org, Nitin Gupta <ngupta@vflare.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 11, 2014 at 02:09:59AM +0530, Srivatsa S. Bhat wrote:
> Subsystems that want to register CPU hotplug callbacks, as well as perform
> initialization for the CPUs that are already online, often do it as shown
> below:
> 
> 	get_online_cpus();
> 
> 	for_each_online_cpu(cpu)
> 		init_cpu(cpu);
> 
> 	register_cpu_notifier(&foobar_cpu_notifier);
> 
> 	put_online_cpus();
> 
> This is wrong, since it is prone to ABBA deadlocks involving the
> cpu_add_remove_lock and the cpu_hotplug.lock (when running concurrently
> with CPU hotplug operations).
> 
> Instead, the correct and race-free way of performing the callback
> registration is:
> 
> 	cpu_notifier_register_begin();
> 
> 	for_each_online_cpu(cpu)
> 		init_cpu(cpu);
> 
> 	/* Note the use of the double underscored version of the API */
> 	__register_cpu_notifier(&foobar_cpu_notifier);
> 
> 	cpu_notifier_register_done();
> 
> 
> Fix the zsmalloc code by using this latter form of callback registration.
> 
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Nitin Gupta <ngupta@vflare.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Acked-by: Minchan Kim <minchan@kernel.org>

Thanks.

-- 
Kind regards,
Minchan Kim

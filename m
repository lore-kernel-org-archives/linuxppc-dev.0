Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0034C2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 17:11:55 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Thu, 27 Jun 2013 12:37:11 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 890971258043
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 12:40:53 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5R7BjAQ16908320
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 12:41:45 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5R7BkQf032588
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 07:11:48 GMT
Message-ID: <51CBE4EF.5040302@linux.vnet.ibm.com>
Date: Thu, 27 Jun 2013 12:38:31 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2 38/45] MIPS: Use get/put_online_cpus_atomic() to prevent
 CPU offline
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
 <20130625203257.16593.15358.stgit@srivatsabhat.in.ibm.com>
 <20130626133912.GA4559@linux-mips.org>
In-Reply-To: <20130626133912.GA4559@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>,
 peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, xiaoguangrong@linux.vnet.ibm.com,
 "Steven J. Hill" <sjhill@mips.com>, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 Yong Zhang <yong.zhang0@gmail.com>, namhyung@kernel.org, tglx@linutronix.de,
 Florian Fainelli <florian@openwrt.org>, John Crispin <blogic@openwrt.org>,
 laijs@cn.fujitsu.com, zhong@linux.vnet.ibm.com,
 Sanjay Lal <sanjayl@kymasys.com>, netdev@vger.kernel.org, oleg@redhat.com,
 sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/26/2013 07:09 PM, Ralf Baechle wrote:
> On Wed, Jun 26, 2013 at 02:02:57AM +0530, Srivatsa S. Bhat wrote:
> 
>> Once stop_machine() is gone from the CPU offline path, we won't be able
>> to depend on disabling preemption to prevent CPUs from going offline
>> from under us.
>>
>> Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going
>> offline, while invoking from atomic context.
> 
> I think the same change also needs to be applied to r4k_on_each_cpu() in
> arch/mips/mm/c-r4k.c which currently looks like:
> 
> static inline void r4k_on_each_cpu(void (*func) (void *info), void *info)
> {
>         preempt_disable();
> 
> #if !defined(CONFIG_MIPS_MT_SMP) && !defined(CONFIG_MIPS_MT_SMTC)
>         smp_call_function(func, info, 1);
> #endif
>         func(info);
>         preempt_enable();
> }
> 

Thanks for pointing this out! I'll include changes to this code in my
next version.

Regards,
Srivatsa S. Bhat

> This is a slightly specialized version of on_each_cpu() which only calls
> out to other CPUs in actual multi-core environments and also - unlike
> on_each_cpu() doesn't disable interrupts for the sake of better
> interrupt latencies.
> 
> Which reminds me ...
> 
> Andrew, I was wondering why did 78eef01b0fae087c5fadbd85dd4fe2918c3a015f
> [[PATCH] on_each_cpu(): disable local interrupts] disable interrupts?
> The log is:
> 
> ----- snip -----
>     When on_each_cpu() runs the callback on other CPUs, it runs with local
>     interrupts disabled.  So we should run the function with local interrupts
>     disabled on this CPU, too.
>     
>     And do the same for UP, so the callback is run in the same environment on bo
>     UP and SMP.  (strictly it should do preempt_disable() too, but I think
>     local_irq_disable is sufficiently equivalent).
> [...]
> ----- snip -----
> 
> I'm not entirely convinced the symmetry between UP and SMP environments is
> really worth it.  Would anybody mind removing the local_irq_disable() ...
> local_irq_enable() from on_each_cpu()?
> 

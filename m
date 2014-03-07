Return-Path: <ego@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 399D72C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 17:22:15 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 7 Mar 2014 01:22:12 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 94499C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 01:22:06 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s276M91I9503052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Mar 2014 06:22:09 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s276M7Ml028368
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Mar 2014 01:22:09 -0500
Date: Fri, 7 Mar 2014 11:51:58 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 14/52] powerpc, sysfs: Fix CPU hotplug callback
 registration
Message-ID: <20140307062157.GA2737@in.ibm.com>
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
 <20140214075215.22701.23653.stgit@srivatsabhat.in.ibm.com>
 <1394161051.26321.71.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394161051.26321.71.camel@pasglop>
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, akpm@linux-foundation.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>, peterz@infradead.org,
 rusty@rustcorp.com.au, rjw@rjwysocki.net, oleg@redhat.com,
 linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, paulus@samba.org,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tj@kernel.org,
 tglx@linutronix.de, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 mingo@kernel.org
Reply-To: ego@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Ben,

On Fri, Mar 07, 2014 at 01:57:31PM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2014-02-14 at 13:22 +0530, Srivatsa S. Bhat wrote:
> > Subsystems that want to register CPU hotplug callbacks, as well as perform
> > initialization for the CPUs that are already online, often do it as shown
> > below:
> > 
> > 	get_online_cpus();
> > 
> > 	for_each_online_cpu(cpu)
> > 		init_cpu(cpu);
> > 
> > 	register_cpu_notifier(&foobar_cpu_notifier);
> > 
> > 	put_online_cpus();
> 
> This patch breaks a good half of my test configs with:
> 
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/sysfs.c: In function 'topology_init':
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/sysfs.c:979:2: error: implicit declaration of function 'cpu_notifier_register_begin' [-Werror=implicit-function-declaration]
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/sysfs.c:1004:2: error: implicit declaration of function '__register_cpu_notifier' [-Werror=implicit-function-declaration]
> /home/benh/linux-powerpc-test/arch/powerpc/kernel/sysfs.c:1006:2: error: implicit declaration of function 'cpu_notifier_register_done' [-Werror=implicit-function-declaration]
> cc1: all warnings being treated as errors
> make[2]: *** [arch/powerpc/kernel/sysfs.o] Error 1
> make[2]: *** Waiting for unfinished jobs....

This patch depends on
"[PATCH v2 02/52] CPU hotplug: Provide lockless versions of callback registration functions" 
of the series (Can be found here: https://lkml.org/lkml/2014/2/14/59).
This particular patch defines 'cpu_notifier_register_begin',
'__register_cpu_notifier', and 'cpu_notifier_register_done' in the
cpu-hotplug core. Are you seeing the build breakage with this patch on
?

--
Thanks and Regards
gautham.

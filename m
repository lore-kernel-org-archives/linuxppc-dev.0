Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3AFEA2C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 17:47:24 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 14 Feb 2014 12:17:13 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 38376125805A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 12:19:06 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1E6l1DB3014980
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 12:17:01 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1E6l51r013302
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 12:17:08 +0530
Message-ID: <52FDBBE8.2040709@linux.vnet.ibm.com>
Date: Fri, 14 Feb 2014 12:17:04 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, paulus@samba.org,
 oleg@redhat.com, rusty@rustcorp.com.au, peterz@infradead.org,
 tglx@linutronix.de, akpm@linux-foundation.org
Subject: Re: [PATCH 13/51] powerpc,
 sysfs: Fix CPU hotplug callback registration
References: <20140205220251.19080.92336.stgit@srivatsabhat.in.ibm.com>
 <20140205220654.19080.11341.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140205220654.19080.11341.stgit@srivatsabhat.in.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: ego@linux.vnet.ibm.com, walken@google.com, linux@arm.linux.org.uk,
 linux-kernel@vger.kernel.org, Wang Dongsheng <dongsheng.wang@freescale.com>,
 Olof Johansson <olof@lixom.net>, tj@kernel.org, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 06 February 2014 03:36 AM, Srivatsa S. Bhat wrote:
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
> 	cpu_maps_update_begin();
> 
> 	for_each_online_cpu(cpu)
> 		init_cpu(cpu);
> 
> 	/* Note the use of the double underscored version of the API */
> 	__register_cpu_notifier(&foobar_cpu_notifier);
> 
> 	cpu_maps_update_done();
> 
> 
> Fix the sysfs code in powerpc by using this latter form of callback
> registration.

Acked-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Wang Dongsheng <dongsheng.wang@freescale.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
> 
>  arch/powerpc/kernel/sysfs.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index 97e1dc9..c29ad44 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -975,7 +975,8 @@ static int __init topology_init(void)
>  	int cpu;
> 
>  	register_nodes();
> -	register_cpu_notifier(&sysfs_cpu_nb);
> +
> +	cpu_maps_update_begin();
> 
>  	for_each_possible_cpu(cpu) {
>  		struct cpu *c = &per_cpu(cpu_devices, cpu);
> @@ -999,6 +1000,11 @@ static int __init topology_init(void)
>  		if (cpu_online(cpu))
>  			register_cpu_online(cpu);
>  	}
> +
> +	__register_cpu_notifier(&sysfs_cpu_nb);
> +
> +	cpu_maps_update_done();
> +
>  #ifdef CONFIG_PPC64
>  	sysfs_create_dscr_default();
>  #endif /* CONFIG_PPC64 */
> 

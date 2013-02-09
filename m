Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 214042C0082
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2013 11:29:30 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 8 Feb 2013 17:29:28 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 8E9AD3E40063
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2013 17:16:45 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r190GqOl582402
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2013 17:16:52 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r190GoiY001610
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2013 17:16:52 -0700
Date: Fri, 8 Feb 2013 16:16:49 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 45/45] Documentation/cpu-hotplug: Remove references to
 stop_machine()
Message-ID: <20130209001649.GS2666@linux.vnet.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122074543.13822.44724.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130122074543.13822.44724.stgit@srivatsabhat.in.ibm.com>
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 22, 2013 at 01:15:48PM +0530, Srivatsa S. Bhat wrote:
> Since stop_machine() is no longer used in the CPU offline path, we cannot
> disable CPU hotplug using preempt_disable()/local_irq_disable() etc. We
> need to use the newly introduced get/put_online_cpus_atomic() APIs.
> Reflect this in the documentation.
> 
> Cc: Rob Landley <rob@landley.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
> 
>  Documentation/cpu-hotplug.txt |   17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/cpu-hotplug.txt b/Documentation/cpu-hotplug.txt
> index 9f40135..7f907ec 100644
> --- a/Documentation/cpu-hotplug.txt
> +++ b/Documentation/cpu-hotplug.txt
> @@ -113,13 +113,15 @@ Never use anything other than cpumask_t to represent bitmap of CPUs.
>  	#include <linux/cpu.h>
>  	get_online_cpus() and put_online_cpus():
> 
> -The above calls are used to inhibit cpu hotplug operations. While the
> +The above calls are used to inhibit cpu hotplug operations, when invoked from
> +non-atomic context (because the above functions can sleep). While the
>  cpu_hotplug.refcount is non zero, the cpu_online_mask will not change.
> -If you merely need to avoid cpus going away, you could also use
> -preempt_disable() and preempt_enable() for those sections.
> -Just remember the critical section cannot call any
> -function that can sleep or schedule this process away. The preempt_disable()
> -will work as long as stop_machine_run() is used to take a cpu down.
> +
> +However, if you are executing in atomic context (ie., you can't afford to
> +sleep), and you merely need to avoid cpus going offline, you can use
> +get_online_cpus_atomic() and put_online_cpus_atomic() for those sections.
> +Just remember the critical section cannot call any function that can sleep or
> +schedule this process away.
> 
>  CPU Hotplug - Frequently Asked Questions.
> 
> @@ -360,6 +362,9 @@ A: There are two ways.  If your code can be run in interrupt context, use
>  		return err;
>  	}
> 
> +   If my_func_on_cpu() itself cannot block, use get/put_online_cpus_atomic()
> +   instead of get/put_online_cpus() to prevent CPUs from going offline.
> +
>  Q: How do we determine how many CPUs are available for hotplug.
>  A: There is no clear spec defined way from ACPI that can give us that
>     information today. Based on some input from Natalie of Unisys,
> 

Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5A7532C0085
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2013 11:37:04 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 8 Feb 2013 17:37:01 -0700
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 29B1E1FF0038
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2013 17:14:42 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r190Eh9f170924
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2013 17:14:43 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r190EeaN026573
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2013 17:14:43 -0700
Date: Fri, 8 Feb 2013 16:14:39 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 14/45] rcu, CPU hotplug: Fix comment referring to
 stop_machine()
Message-ID: <20130209001439.GQ2666@linux.vnet.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073630.13822.99359.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130122073630.13822.99359.stgit@srivatsabhat.in.ibm.com>
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

On Tue, Jan 22, 2013 at 01:06:34PM +0530, Srivatsa S. Bhat wrote:
> Don't refer to stop_machine() in the CPU hotplug path, since we are going
> to get rid of it. Also, move the comment referring to callback adoption
> to the CPU_DEAD case, because that's where it happens now.
> 
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Ouch!  That comment is indeed obsolete and must die.

I queued this to -rcu with your Signed-off-by.  However, I omitted
the added comment, as it is imcomplete -- it is easy to look at
rcu_cleanup_dead_cpu() to see what it does.

							Thanx, Paul

> ---
> 
>  kernel/rcutree.c |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcutree.c b/kernel/rcutree.c
> index e441b77..ac94474 100644
> --- a/kernel/rcutree.c
> +++ b/kernel/rcutree.c
> @@ -2827,11 +2827,6 @@ static int __cpuinit rcu_cpu_notify(struct notifier_block *self,
>  		break;
>  	case CPU_DYING:
>  	case CPU_DYING_FROZEN:
> -		/*
> -		 * The whole machine is "stopped" except this CPU, so we can
> -		 * touch any data without introducing corruption. We send the
> -		 * dying CPU's callbacks to an arbitrarily chosen online CPU.
> -		 */
>  		for_each_rcu_flavor(rsp)
>  			rcu_cleanup_dying_cpu(rsp);
>  		rcu_cleanup_after_idle(cpu);
> @@ -2840,6 +2835,10 @@ static int __cpuinit rcu_cpu_notify(struct notifier_block *self,
>  	case CPU_DEAD_FROZEN:
>  	case CPU_UP_CANCELED:
>  	case CPU_UP_CANCELED_FROZEN:
> +		/*
> +		 * We send the dead CPU's callbacks to an arbitrarily chosen
> +		 * online CPU.
> +		 */
>  		for_each_rcu_flavor(rsp)
>  			rcu_cleanup_dead_cpu(cpu, rsp);
>  		break;
> 

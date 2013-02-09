Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8DA532C0087
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2013 11:18:36 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 8 Feb 2013 17:18:34 -0700
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 22A103E4004F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2013 17:15:51 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r190FwZx088510
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2013 17:15:58 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r190FtGn031681
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2013 17:15:58 -0700
Date: Fri, 8 Feb 2013 16:15:54 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 44/45] CPU hotplug, stop_machine: Decouple CPU hotplug
 from stop_machine() in Kconfig
Message-ID: <20130209001554.GR2666@linux.vnet.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122074518.13822.86992.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130122074518.13822.86992.stgit@srivatsabhat.in.ibm.com>
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

On Tue, Jan 22, 2013 at 01:15:22PM +0530, Srivatsa S. Bhat wrote:
> ... and also cleanup a comment that refers to CPU hotplug being dependent on
> stop_machine().
> 
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

(Hey, I thought I owed myself an easy one!)

> ---
> 
>  include/linux/stop_machine.h |    2 +-
>  init/Kconfig                 |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
> index 3b5e910..ce2d3c4 100644
> --- a/include/linux/stop_machine.h
> +++ b/include/linux/stop_machine.h
> @@ -120,7 +120,7 @@ int stop_machine(int (*fn)(void *), void *data, const struct cpumask *cpus);
>   * @cpus: the cpus to run the @fn() on (NULL = any online cpu)
>   *
>   * Description: This is a special version of the above, which assumes cpus
> - * won't come or go while it's being called.  Used by hotplug cpu.
> + * won't come or go while it's being called.
>   */
>  int __stop_machine(int (*fn)(void *), void *data, const struct cpumask *cpus);
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index be8b7f5..048a0c5 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1711,7 +1711,7 @@ config INIT_ALL_POSSIBLE
>  config STOP_MACHINE
>  	bool
>  	default y
> -	depends on (SMP && MODULE_UNLOAD) || HOTPLUG_CPU
> +	depends on (SMP && MODULE_UNLOAD)
>  	help
>  	  Need stop_machine() primitive.
> 
> 

Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EF3AE2C0297
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2013 10:51:34 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 8 Feb 2013 16:51:32 -0700
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id C435E19D803E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2013 16:51:27 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r18NpSa7222252
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2013 16:51:28 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r18NpPKL005084
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2013 16:51:28 -0700
Date: Fri, 8 Feb 2013 15:51:22 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 08/45] CPU hotplug: Convert preprocessor macros to
 static inline functions
Message-ID: <20130208235122.GO2666@linux.vnet.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073500.13822.11469.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130122073500.13822.11469.stgit@srivatsabhat.in.ibm.com>
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

On Tue, Jan 22, 2013 at 01:05:02PM +0530, Srivatsa S. Bhat wrote:
> On 12/05/2012 06:10 AM, Andrew Morton wrote:
> "static inline C functions would be preferred if possible.  Feel free to
> fix up the wrong crufty surrounding code as well ;-)"
> 
> Convert the macros in the CPU hotplug code to static inline C functions.
> 
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
> 
>  include/linux/cpu.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index cf24da1..eb79f47 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -198,10 +198,10 @@ static inline void cpu_hotplug_driver_unlock(void)
> 
>  #else		/* CONFIG_HOTPLUG_CPU */
> 
> -#define get_online_cpus()	do { } while (0)
> -#define put_online_cpus()	do { } while (0)
> -#define get_online_cpus_atomic()	do { } while (0)
> -#define put_online_cpus_atomic()	do { } while (0)
> +static inline void get_online_cpus(void) {}
> +static inline void put_online_cpus(void) {}
> +static inline void get_online_cpus_atomic(void) {}
> +static inline void put_online_cpus_atomic(void) {}
>  #define hotcpu_notifier(fn, pri)	do { (void)(fn); } while (0)
>  /* These aren't inline functions due to a GCC bug. */
>  #define register_hotcpu_notifier(nb)	({ (void)(nb); 0; })
> 

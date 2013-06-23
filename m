Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id A013E2C04E0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 04:17:43 +1000 (EST)
Date: Sun, 23 Jun 2013 11:17:40 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 25/45] staging/octeon: Use get/put_online_cpus_atomic()
 to prevent CPU offline
Message-ID: <20130623181740.GB24256@kroah.com>
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
 <20130623134331.19094.80396.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130623134331.19094.80396.stgit@srivatsabhat.in.ibm.com>
Cc: peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 devel@driverdev.osuosl.org, nikunj@linux.vnet.ibm.com,
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

On Sun, Jun 23, 2013 at 07:13:33PM +0530, Srivatsa S. Bhat wrote:
> Once stop_machine() is gone from the CPU offline path, we won't be able
> to depend on disabling preemption to prevent CPUs from going offline
> from under us.
> 
> Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going
> offline, while invoking from atomic context.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: devel@driverdev.osuosl.org
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
> 
>  drivers/staging/octeon/ethernet-rx.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
> index 34afc16..8588b4d 100644
> --- a/drivers/staging/octeon/ethernet-rx.c
> +++ b/drivers/staging/octeon/ethernet-rx.c
> @@ -36,6 +36,7 @@
>  #include <linux/prefetch.h>
>  #include <linux/ratelimit.h>
>  #include <linux/smp.h>
> +#include <linux/cpu.h>
>  #include <linux/interrupt.h>
>  #include <net/dst.h>
>  #ifdef CONFIG_XFRM
> @@ -97,6 +98,7 @@ static void cvm_oct_enable_one_cpu(void)
>  		return;
>  
>  	/* ... if a CPU is available, Turn on NAPI polling for that CPU.  */
> +	get_online_cpus_atomic();
>  	for_each_online_cpu(cpu) {
>  		if (!cpu_test_and_set(cpu, core_state.cpu_state)) {
>  			v = smp_call_function_single(cpu, cvm_oct_enable_napi,
> @@ -106,6 +108,7 @@ static void cvm_oct_enable_one_cpu(void)
>  			break;
>  		}
>  	}
> +	put_online_cpus_atomic();

Does this driver really need to be doing this in the first place?  If
so, why?  The majority of network drivers don't, why is this one
"special"?

thanks,

greg k-h

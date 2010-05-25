Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 5CEB2B7D30
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 21:39:57 +1000 (EST)
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
From: Millton Miller <miltonm@bga.com>
Subject: [Patch 1/4] Allow arch-specific cleanup before breakpoint
	unregistration
In-Reply-To: <20100525091356.GB29003@in.ibm.com>
References: <20100525083055.342788418@linux.vnet.ibm.com>
	<20100525091356.GB29003@in.ibm.com>
Date: Tue, 25 May 2010 06:39:19 -0500
Message-ID: <1274787559_8162@mail4.comsite.net>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	David Gibson <dwg@au1.ibm.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Alan Stern <stern@rowland.harvard.edu>, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 25 May 2010 at 14:43:56 +0530, K.Prasad wrote:
> Certain architectures (such as PowerPC Book III S) have a need to cleanup
> data-structures before the breakpoint is unregistered. This patch introduces
> an arch-specific hook in release_bp_slot() along with a weak definition in
> the form of a stub funciton.
> 
> Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> ---
>  kernel/hw_breakpoint.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)


My understanding is weak function definitions must appear in a different C
file than their call sites to work on some toolchains.

Andrew, can you confirm the above statement?

> Index: linux-2.6.ppc64_test/kernel/hw_breakpoint.c
> ===================================================================
> --- linux-2.6.ppc64_test.orig/kernel/hw_breakpoint.c
> +++ linux-2.6.ppc64_test/kernel/hw_breakpoint.c
> @@ -242,6 +242,17 @@  toggle_bp_slot(struct perf_event *bp, bo
>  }
>  
>  /*
> + * Function to perform processor-specific cleanup during unregistration
> + */
> +__weak void arch_unregister_hw_breakpoint(struct perf_event *bp)
> +{
> +	/*
> +	 * A weak stub function here for those archs that don't define
> +	 * it inside arch/.../kernel/hw_breakpoint.c
> +	 */
> +}
> +
> +/*
>   * Contraints to check before allowing this new breakpoint counter:
>   *
>   *  == Non-pinned counter == (Considered as pinned for now)
> @@ -339,6 +350,7 @@  void release_bp_slot(struct perf_event *
>  {
>  	mutex_lock(&nr_bp_mutex);
>  
> +	arch_unregister_hw_breakpoint(bp);
>  	__release_bp_slot(bp);
>  
>  	mutex_unlock(&nr_bp_mutex);
> 


Since the weak version is empty, should it just be delcared (in
a header, put the comment there) and not defined?

milton

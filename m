Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40W51P359YzDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 13:15:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: Fix smp_send_stop NMI IPI handling
In-Reply-To: <20180425021753.26275-1-npiggin@gmail.com>
References: <20180425021753.26275-1-npiggin@gmail.com>
Date: Wed, 25 Apr 2018 13:15:34 +1000
Message-ID: <87fu3k563t.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> The NMI IPI handler for a receiving CPU increments nmi_ipi_busy_count
> over the handler function call, which causes later smp_send_nmi_ipi()
> callers to spin until the call is finished.
>
> The smp_send_stop function never returns, so the busy count is never
> decremeted, which can cause the system to hang in some cases. For
> example panic() will call smp_send_stop early on, then later in the
> reboot path, pnv_restart will call smp_send_stop again, which hangs.
>
> Fix this by adding a special case to the smp_send_stop handler to
> decrement the busy count, because it will never return.
>
> Fixes: 6bed3237624e3 ("powerpc: use NMI IPI for smp_send_stop")
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/smp.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index e16ec7b3b427..250fccf04c6e 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -567,10 +567,19 @@ void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
>  
>  #ifdef CONFIG_NMI_IPI
>  static void stop_this_cpu(struct pt_regs *regs)
> +{
> +	/*
> +	 * This is a special case because it never returns, so the NMI IPI
> +	 * handling would never mark it as done, which makes any later
> +	 * smp_send_nmi_ipi() call spin forever. Mark it done now.
> +	 */
> +	nmi_ipi_lock();
> +	nmi_ipi_busy_count--;
> +	nmi_ipi_unlock();
>  #else
>  static void stop_this_cpu(void *dummy)
> -#endif
>  {
> +#endif

I don't love this ifdef/endif business.

Can we do it this way instead?

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e16ec7b3b427..3582f30b60b7 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -565,11 +565,7 @@ void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
 }
 #endif
 
-#ifdef CONFIG_NMI_IPI
-static void stop_this_cpu(struct pt_regs *regs)
-#else
 static void stop_this_cpu(void *dummy)
-#endif
 {
 	/* Remove this CPU */
 	set_cpu_online(smp_processor_id(), false);
@@ -580,10 +576,26 @@ static void stop_this_cpu(void *dummy)
 		spin_cpu_relax();
 }
 
+#ifdef CONFIG_NMI_IPI
+static void nmi_stop_this_cpu(struct pt_regs *regs)
+{
+	/*
+	 * This is a special case because it never returns, so the NMI IPI
+	 * handling would never mark it as done, which makes any later
+	 * smp_send_nmi_ipi() call spin forever. Mark it done now.
+	 */
+	nmi_ipi_lock();
+	nmi_ipi_busy_count--;
+	nmi_ipi_unlock();
+
+	stop_this_cpu(NULL);
+}
+#endif
+
 void smp_send_stop(void)
 {
 #ifdef CONFIG_NMI_IPI
-	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, stop_this_cpu, 1000000);
+	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, nmi_stop_this_cpu, 1000000);
 #else
 	smp_call_function(stop_this_cpu, NULL, 0);
 #endif


cheers

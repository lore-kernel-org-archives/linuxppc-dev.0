Return-Path: <lliubbo@gmail.com>
Received: from mail-vc0-f171.google.com (mail-vc0-f171.google.com
 [209.85.220.171])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 25BF12C008F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2013 20:09:37 +1100 (EST)
Received: by mail-vc0-f171.google.com with SMTP id p1so1730350vcq.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2013 01:09:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130122074123.13822.39102.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122074123.13822.39102.stgit@srivatsabhat.in.ibm.com>
Date: Mon, 28 Jan 2013 17:09:34 +0800
Message-ID: <CAA_GA1fSLNKSDTGSzHoA+j-mur85BvoSRkARq+DMfORuwrrX4Q@mail.gmail.com>
Subject: Re: [PATCH v5 31/45] blackfin/smp: Use get/put_online_cpus_atomic()
 to prevent CPU offline
From: Bob Liu <lliubbo@gmail.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
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

On Tue, Jan 22, 2013 at 3:41 PM, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> Once stop_machine() is gone from the CPU offline path, we won't be able to
> depend on preempt_disable() or local_irq_disable() to prevent CPUs from
> going offline from under us.
>
> Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
> while invoking from atomic context.
>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: Bob Liu <lliubbo@gmail.com>
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: uclinux-dist-devel@blackfin.uclinux.org
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Thanks, will be applied to my blackfin arch tree.

> ---
>
>  arch/blackfin/mach-common/smp.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/blackfin/mach-common/smp.c b/arch/blackfin/mach-common/smp.c
> index bb61ae4..6cc6d7a 100644
> --- a/arch/blackfin/mach-common/smp.c
> +++ b/arch/blackfin/mach-common/smp.c
> @@ -194,6 +194,7 @@ void send_ipi(const struct cpumask *cpumask, enum ipi_message_type msg)
>         struct ipi_data *bfin_ipi_data;
>         unsigned long flags;
>
> +       get_online_cpus_atomic();
>         local_irq_save(flags);
>         smp_mb();
>         for_each_cpu(cpu, cpumask) {
> @@ -205,6 +206,7 @@ void send_ipi(const struct cpumask *cpumask, enum ipi_message_type msg)
>         }
>
>         local_irq_restore(flags);
> +       put_online_cpus_atomic();
>  }
>
>  void arch_send_call_function_single_ipi(int cpu)
> @@ -238,13 +240,13 @@ void smp_send_stop(void)
>  {
>         cpumask_t callmap;
>
> -       preempt_disable();
> +       get_online_cpus_atomic();
>         cpumask_copy(&callmap, cpu_online_mask);
>         cpumask_clear_cpu(smp_processor_id(), &callmap);
>         if (!cpumask_empty(&callmap))
>                 send_ipi(&callmap, BFIN_IPI_CPU_STOP);
>
> -       preempt_enable();
> +       put_online_cpus_atomic();
>
>         return;
>  }
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Regards,
--Bob

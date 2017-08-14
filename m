Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xW6436VlnzDr0G
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 17:02:11 +1000 (AEST)
Message-ID: <1502694131.9844.7.camel@neuling.org>
Subject: Re: [PATCH v6 14/17] powerpc: Add support for setting SPRN_TIDR
From: Michael Neuling <mikey@neuling.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, apopple@au1.ibm.com, oohall@gmail.com
Date: Mon, 14 Aug 2017 17:02:11 +1000
In-Reply-To: <1502233622-9330-15-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1502233622-9330-15-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-08-08 at 16:06 -0700, Sukadev Bhattiprolu wrote:
> We need the SPRN_TIDR to bet set for use with fast thread-wakeup
> (core-to-core wakeup).=C2=A0=C2=A0Each thread in a process needs to have =
a
> unique id within the process but as explained below, for now, we
> assign globally unique thread ids to all threads in the system.
>=20
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
> =C2=A0arch/powerpc/include/asm/processor.h |=C2=A0=C2=A04 ++
> =C2=A0arch/powerpc/kernel/process.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0| 74
> ++++++++++++++++++++++++++++++++++++
> =C2=A02 files changed, 78 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/processor.h
> b/arch/powerpc/include/asm/processor.h
> index fab7ff8..bf6ba63 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -232,6 +232,10 @@ struct debug_reg {
> =C2=A0struct thread_struct {
> =C2=A0	unsigned long	ksp;		/* Kernel stack pointer */
> =C2=A0
> +#ifdef CONFIG_PPC_VAS

I'm tempted to have this always, or a new feature CONFIG_PPC_TID that's PPC=
_VAS
depends on.

> +	unsigned long	tidr;

> +#endif
> +
> =C2=A0#ifdef CONFIG_PPC64
> =C2=A0	unsigned long	ksp_vsid;
> =C2=A0#endif
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index 9f3e2c9..6123859 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1213,6 +1213,16 @@ struct task_struct *__switch_to(struct task_struct
> *prev,
> =C2=A0		hard_irq_disable();
> =C2=A0	}
> =C2=A0
> +#ifdef CONFIG_PPC_VAS
> +	mtspr(SPRN_TIDR, new->thread.tidr);

how much does this hurt our context_switch benchmark in
tools/testing/selftests/powerpc/benchmarks/context_switch.c ?

Also you need an CPU_FTR_ARCH_300 test here (and elsewhere)

> +#endif
> +	/*
> +	=C2=A0* We can't take a PMU exception inside _switch() since there is a
> +	=C2=A0* window where the kernel stack SLB and the kernel stack are out
> +	=C2=A0* of sync. Hard disable here.
> +	=C2=A0*/
> +	hard_irq_disable();
> +

What is this?

> =C2=A0	/*
> =C2=A0	=C2=A0* Call restore_sprs() before calling _switch(). If we move i=
t after
> =C2=A0	=C2=A0* _switch() then we miss out on calling it for new tasks. Th=
e reason
> @@ -1449,9 +1459,70 @@ void flush_thread(void)
> =C2=A0#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> =C2=A0}
> =C2=A0
> +#ifdef CONFIG_PPC_VAS
> +static DEFINE_SPINLOCK(vas_thread_id_lock);
> +static DEFINE_IDA(vas_thread_ida);

This IDA be per process, not global.

> +
> +/*
> + * We need to assign an unique thread id to each thread in a process. Th=
is
> + * thread id is intended to be used with the Fast Thread-wakeup (aka Cor=
e-
> + * to-core wakeup) mechanism being implemented on top of Virtual Acceler=
ator
> + * Switchboard (VAS).
> + *
> + * To get a unique thread-id per process we could simply use task_pid_nr=
()
> + * but the problem is that task_pid_nr() is not yet available for the th=
read
> + * when copy_thread() is called. Fixing that would require changing more
> + * intrusive arch-neutral code in code path in copy_process()?.
> + *
> + * Further, to assign unique thread ids within each process, we need an
> + * atomic field (or an IDR) in task_struct, which again intrudes into th=
e
> + * arch-neutral code.

Really?

> + * So try to assign globally unique thraed ids for now.

Yuck!

> + */
> +static int assign_thread_id(void)
> +{
> +	int index;
> +	int err;
> +
> +again:
> +	if (!ida_pre_get(&vas_thread_ida, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	spin_lock(&vas_thread_id_lock);
> +	err =3D ida_get_new_above(&vas_thread_ida, 1, &index);

We can't use 0 or 1?

> +	spin_unlock(&vas_thread_id_lock);
> +
> +	if (err =3D=3D -EAGAIN)
> +		goto again;
> +	else if (err)
> +		return err;
> +
> +	if (index > MAX_USER_CONTEXT) {
> +		spin_lock(&vas_thread_id_lock);
> +		ida_remove(&vas_thread_ida, index);
> +		spin_unlock(&vas_thread_id_lock);
> +		return -ENOMEM;
> +	}
> +
> +	return index;
> +}
> +
> +static void free_thread_id(int id)
> +{
> +	spin_lock(&vas_thread_id_lock);
> +	ida_remove(&vas_thread_ida, id);
> +	spin_unlock(&vas_thread_id_lock);
> +}
> +#endif /* CONFIG_PPC_VAS */
> +
> +
> =C2=A0void
> =C2=A0release_thread(struct task_struct *t)
> =C2=A0{
> +#ifdef CONFIG_PPC_VAS
> +	free_thread_id(t->thread.tidr);
> +#endif

Can you restructure this to avoid the #ifdef ugliness

> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -1587,6 +1658,9 @@ int copy_thread(unsigned long clone_flags, unsigned=
 long
> usp,
> =C2=A0#endif
> =C2=A0
> =C2=A0	setup_ksp_vsid(p, sp);
> +#ifdef CONFIG_PPC_VAS
> +	p->thread.tidr =3D assign_thread_id();
> +#endif

Same here...=20

> =C2=A0
> =C2=A0#ifdef CONFIG_PPC64=C2=A0
> =C2=A0	if (cpu_has_feature(CPU_FTR_DSCR)) {

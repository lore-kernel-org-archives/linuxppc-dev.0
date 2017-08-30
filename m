Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhxRr416WzDqH0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 17:08:24 +1000 (AEST)
Message-ID: <1504076904.4670.20.camel@neuling.org>
Subject: Re: [PATCH RFC] Interface to set SPRN_TIDR
From: Michael Neuling <mikey@neuling.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, Christophe Lombard
 <clombard@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 17:08:24 +1000
In-Reply-To: <20170830023856.GC26152@us.ibm.com>
References: <20170830023856.GC26152@us.ibm.com>
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

Suka,

Please CC Christophe who as an alternative way of doing this. We ned to get
agreement across all users of TIDR/AS_notify...

His patch is here:
  https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-August/161582.html

Mikey

On Tue, 2017-08-29 at 19:38 -0700, Sukadev Bhattiprolu wrote:
> We need the SPRN_TIDR to be set for use with fast thread-wakeup
> (core-to-core wakeup) in VAS. Each user thread that has a receive
> window setup and expects to be notified when a sender issues a paste
> needs to have a unique SPRN_TIDR value.
>=20
> The SPRN_TIDR value only needs to unique within the process but for
> now we use a globally unique thread id as described below.
>=20
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
> Changelog[v2]
> 	- Michael Ellerman: Use an interface to assign TIDR so it is
> 	=C2=A0=C2=A0assigned to only threads that need it; move assignment to
> 	=C2=A0=C2=A0restore_sprs(). Drop lint from rebase;
>=20
>=20
> =C2=A0arch/powerpc/include/asm/processor.h |=C2=A0=C2=A04 ++
> =C2=A0arch/powerpc/include/asm/switch_to.h |=C2=A0=C2=A03 ++
> =C2=A0arch/powerpc/kernel/process.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0| 97
> ++++++++++++++++++++++++++++++++++++
> =C2=A03 files changed, 104 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/processor.h
> b/arch/powerpc/include/asm/processor.h
> index fab7ff8..bf6ba63 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -232,6 +232,10 @@ struct debug_reg {
> =C2=A0struct thread_struct {
> =C2=A0	unsigned long	ksp;		/* Kernel stack pointer */
>=20
> +#ifdef CONFIG_PPC_VAS
> +	unsigned long	tidr;
> +#endif
> +
> =C2=A0#ifdef CONFIG_PPC64
> =C2=A0	unsigned long	ksp_vsid;
> =C2=A0#endif
> diff --git a/arch/powerpc/include/asm/switch_to.h
> b/arch/powerpc/include/asm/switch_to.h
> index 17c8380..4962455 100644
> --- a/arch/powerpc/include/asm/switch_to.h
> +++ b/arch/powerpc/include/asm/switch_to.h
> @@ -91,4 +91,7 @@ static inline void clear_task_ebb(struct task_struct *t=
)
> =C2=A0#endif
> =C2=A0}
>=20
> +extern void set_thread_tidr(struct task_struct *t);
> +extern void clear_thread_tidr(struct task_struct *t);
> +
> =C2=A0#endif /* _ASM_POWERPC_SWITCH_TO_H */
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index 1f0fd36..13abb22 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1132,6 +1132,10 @@ static inline void restore_sprs(struct thread_stru=
ct
> *old_thread,
> =C2=A0			mtspr(SPRN_TAR, new_thread->tar);
> =C2=A0	}
> =C2=A0#endif
> +#ifdef CONFIG_PPC_VAS
> +	if (old_thread->tidr !=3D new_thread->tidr)
> +		mtspr(SPRN_TIDR, new_thread->tidr);
> +#endif
> =C2=A0}
>=20
> =C2=A0#ifdef CONFIG_PPC_BOOK3S_64
> @@ -1446,9 +1450,97 @@ void flush_thread(void)
> =C2=A0#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> =C2=A0}
>=20
> +#ifdef CONFIG_PPC_VAS
> +static DEFINE_SPINLOCK(vas_thread_id_lock);
> +static DEFINE_IDA(vas_thread_ida);
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
> + *
> + * So try to assign globally unique thraed ids for now.
> + *
> + * NOTE: TIDR 0 indicates that the thread does not need a TIDR value.
> + *=C2=A0	=C2=A0For now, only threads that expect to be notified by the V=
AS
> + *=C2=A0	=C2=A0hardware need a TIDR value and we assign values > 0 for t=
hose.
> + */
> +#define MAX_THREAD_CONTEXT	((1 << 15) - 2)
> +static int assign_thread_tidr(void)
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
> +	spin_unlock(&vas_thread_id_lock);
> +
> +	if (err =3D=3D -EAGAIN)
> +		goto again;
> +	else if (err)
> +		return err;
> +
> +	if (index > MAX_THREAD_CONTEXT) {
> +		spin_lock(&vas_thread_id_lock);
> +		ida_remove(&vas_thread_ida, index);
> +		spin_unlock(&vas_thread_id_lock);
> +		return -ENOMEM;
> +	}
> +
> +	return index;
> +}
> +
> +static void free_thread_tidr(int id)
> +{
> +	spin_lock(&vas_thread_id_lock);
> +	ida_remove(&vas_thread_ida, id);
> +	spin_unlock(&vas_thread_id_lock);
> +}
> +
> +void clear_thread_tidr(struct task_struct *t)
> +{
> +	if (t->thread.tidr) {
> +		free_thread_tidr(t->thread.tidr);
> +		t->thread.tidr =3D 0;
> +		mtspr(SPRN_TIDR, 0);
> +	}
> +}
> +
> +/*
> + * Assign an unique thread id for this thread and set it in the
> + * thread structure. For now, we need this interface only for
> + * the current task.
> + */
> +void set_thread_tidr(struct task_struct *t)
> +{
> +	WARN_ON(t !=3D current);
> +	t->thread.tidr =3D assign_thread_tidr();
> +	mtspr(SPRN_TIDR, t->thread.tidr);
> +}
> +
> +#endif /* CONFIG_PPC_VAS */
> +
> +
> =C2=A0void
> =C2=A0release_thread(struct task_struct *t)
> =C2=A0{
> +#ifdef CONFIG_PPC_VAS
> +	clear_thread_tidr(t);
> +#endif
> =C2=A0}
>=20
> =C2=A0/*
> @@ -1474,6 +1566,8 @@ int arch_dup_task_struct(struct task_struct *dst, s=
truct
> task_struct *src)
>=20
> =C2=A0	clear_task_ebb(dst);
>=20
> +	dst->thread.tidr =3D 0;
> +
> =C2=A0	return 0;
> =C2=A0}
>=20
> @@ -1584,6 +1678,9 @@ int copy_thread(unsigned long clone_flags, unsigned=
 long
> usp,
> =C2=A0#endif
>=20
> =C2=A0	setup_ksp_vsid(p, sp);
> +#ifdef CONFIG_PPC_VAS
> +	p->thread.tidr =3D 0;
> +#endif
>=20
> =C2=A0#ifdef CONFIG_PPC64=C2=A0
> =C2=A0	if (cpu_has_feature(CPU_FTR_DSCR)) {

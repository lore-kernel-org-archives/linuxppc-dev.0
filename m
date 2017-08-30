Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjMH53yglzDqF4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 09:32:17 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7UNSg0m014698
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 19:32:14 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cp0gjw1fm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 19:32:14 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 30 Aug 2017 17:32:13 -0600
Date: Wed, 30 Aug 2017 16:32:08 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC] Interface to set SPRN_TIDR
References: <20170830023856.GC26152@us.ibm.com>
 <1504076904.4670.20.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1504076904.4670.20.camel@neuling.org>
Message-Id: <20170830233208.GC20351@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling [mikey@neuling.org] wrote:
> Suka,
>=20
> Please CC Christophe who as an alternative way of doing this. We ned to g=
et
> agreement across all users of TIDR/AS_notify...

Mikey,

Thanks. There is overlap between the two patches. I will send a patch on
top of Christophe's for the interfaces to assign/clear the TIDR value and
clear the thread->tidr during arch_dup_task_struct(). I will also drop the
CONFIG_VAS check since its not only for VAS.

Christophe, can you let me know of any other comments on this patch?

Suka
>=20
> His patch is here:
>   https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-August/161582.html
>=20
> Mikey
>=20
> On Tue, 2017-08-29 at 19:38 -0700, Sukadev Bhattiprolu wrote:
> > We need the SPRN_TIDR to be set for use with fast thread-wakeup
> > (core-to-core wakeup) in VAS. Each user thread that has a receive
> > window setup and expects to be notified when a sender issues a paste
> > needs to have a unique SPRN_TIDR value.
> >=20
> > The SPRN_TIDR value only needs to unique within the process but for
> > now we use a globally unique thread id as described below.
> >=20
> > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > ---
> > Changelog[v2]
> > 	- Michael Ellerman: Use an interface to assign TIDR so it is
> > 	=A0=A0assigned to only threads that need it; move assignment to
> > 	=A0=A0restore_sprs(). Drop lint from rebase;
> >=20
> >=20
> > =A0arch/powerpc/include/asm/processor.h |=A0=A04 ++
> > =A0arch/powerpc/include/asm/switch_to.h |=A0=A03 ++
> > =A0arch/powerpc/kernel/process.c=A0=A0=A0=A0=A0=A0=A0=A0| 97
> > ++++++++++++++++++++++++++++++++++++
> > =A03 files changed, 104 insertions(+)
> >=20
> > diff --git a/arch/powerpc/include/asm/processor.h
> > b/arch/powerpc/include/asm/processor.h
> > index fab7ff8..bf6ba63 100644
> > --- a/arch/powerpc/include/asm/processor.h
> > +++ b/arch/powerpc/include/asm/processor.h
> > @@ -232,6 +232,10 @@ struct debug_reg {
> > =A0struct thread_struct {
> > =A0	unsigned long	ksp;		/* Kernel stack pointer */
> >=20
> > +#ifdef CONFIG_PPC_VAS
> > +	unsigned long	tidr;
> > +#endif
> > +
> > =A0#ifdef CONFIG_PPC64
> > =A0	unsigned long	ksp_vsid;
> > =A0#endif
> > diff --git a/arch/powerpc/include/asm/switch_to.h
> > b/arch/powerpc/include/asm/switch_to.h
> > index 17c8380..4962455 100644
> > --- a/arch/powerpc/include/asm/switch_to.h
> > +++ b/arch/powerpc/include/asm/switch_to.h
> > @@ -91,4 +91,7 @@ static inline void clear_task_ebb(struct task_struct =
*t)
> > =A0#endif
> > =A0}
> >=20
> > +extern void set_thread_tidr(struct task_struct *t);
> > +extern void clear_thread_tidr(struct task_struct *t);
> > +
> > =A0#endif /* _ASM_POWERPC_SWITCH_TO_H */
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/proces=
s.c
> > index 1f0fd36..13abb22 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -1132,6 +1132,10 @@ static inline void restore_sprs(struct thread_st=
ruct
> > *old_thread,
> > =A0			mtspr(SPRN_TAR, new_thread->tar);
> > =A0	}
> > =A0#endif
> > +#ifdef CONFIG_PPC_VAS
> > +	if (old_thread->tidr !=3D new_thread->tidr)
> > +		mtspr(SPRN_TIDR, new_thread->tidr);
> > +#endif
> > =A0}
> >=20
> > =A0#ifdef CONFIG_PPC_BOOK3S_64
> > @@ -1446,9 +1450,97 @@ void flush_thread(void)
> > =A0#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> > =A0}
> >=20
> > +#ifdef CONFIG_PPC_VAS
> > +static DEFINE_SPINLOCK(vas_thread_id_lock);
> > +static DEFINE_IDA(vas_thread_ida);
> > +
> > +/*
> > + * We need to assign an unique thread id to each thread in a process. =
This
> > + * thread id is intended to be used with the Fast Thread-wakeup (aka C=
ore-
> > + * to-core wakeup) mechanism being implemented on top of Virtual Accel=
erator
> > + * Switchboard (VAS).
> > + *
> > + * To get a unique thread-id per process we could simply use task_pid_=
nr()
> > + * but the problem is that task_pid_nr() is not yet available for the =
thread
> > + * when copy_thread() is called. Fixing that would require changing mo=
re
> > + * intrusive arch-neutral code in code path in copy_process()?.
> > + *
> > + * Further, to assign unique thread ids within each process, we need an
> > + * atomic field (or an IDR) in task_struct, which again intrudes into =
the
> > + * arch-neutral code.
> > + *
> > + * So try to assign globally unique thraed ids for now.
> > + *
> > + * NOTE: TIDR 0 indicates that the thread does not need a TIDR value.
> > + *=A0	=A0For now, only threads that expect to be notified by the VAS
> > + *=A0	=A0hardware need a TIDR value and we assign values > 0 for those.
> > + */
> > +#define MAX_THREAD_CONTEXT	((1 << 15) - 2)
> > +static int assign_thread_tidr(void)
> > +{
> > +	int index;
> > +	int err;
> > +
> > +again:
> > +	if (!ida_pre_get(&vas_thread_ida, GFP_KERNEL))
> > +		return -ENOMEM;
> > +
> > +	spin_lock(&vas_thread_id_lock);
> > +	err =3D ida_get_new_above(&vas_thread_ida, 1, &index);
> > +	spin_unlock(&vas_thread_id_lock);
> > +
> > +	if (err =3D=3D -EAGAIN)
> > +		goto again;
> > +	else if (err)
> > +		return err;
> > +
> > +	if (index > MAX_THREAD_CONTEXT) {
> > +		spin_lock(&vas_thread_id_lock);
> > +		ida_remove(&vas_thread_ida, index);
> > +		spin_unlock(&vas_thread_id_lock);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	return index;
> > +}
> > +
> > +static void free_thread_tidr(int id)
> > +{
> > +	spin_lock(&vas_thread_id_lock);
> > +	ida_remove(&vas_thread_ida, id);
> > +	spin_unlock(&vas_thread_id_lock);
> > +}
> > +
> > +void clear_thread_tidr(struct task_struct *t)
> > +{
> > +	if (t->thread.tidr) {
> > +		free_thread_tidr(t->thread.tidr);
> > +		t->thread.tidr =3D 0;
> > +		mtspr(SPRN_TIDR, 0);
> > +	}
> > +}
> > +
> > +/*
> > + * Assign an unique thread id for this thread and set it in the
> > + * thread structure. For now, we need this interface only for
> > + * the current task.
> > + */
> > +void set_thread_tidr(struct task_struct *t)
> > +{
> > +	WARN_ON(t !=3D current);
> > +	t->thread.tidr =3D assign_thread_tidr();
> > +	mtspr(SPRN_TIDR, t->thread.tidr);
> > +}
> > +
> > +#endif /* CONFIG_PPC_VAS */
> > +
> > +
> > =A0void
> > =A0release_thread(struct task_struct *t)
> > =A0{
> > +#ifdef CONFIG_PPC_VAS
> > +	clear_thread_tidr(t);
> > +#endif
> > =A0}
> >=20
> > =A0/*
> > @@ -1474,6 +1566,8 @@ int arch_dup_task_struct(struct task_struct *dst,=
 struct
> > task_struct *src)
> >=20
> > =A0	clear_task_ebb(dst);
> >=20
> > +	dst->thread.tidr =3D 0;
> > +
> > =A0	return 0;
> > =A0}
> >=20
> > @@ -1584,6 +1678,9 @@ int copy_thread(unsigned long clone_flags, unsign=
ed long
> > usp,
> > =A0#endif
> >=20
> > =A0	setup_ksp_vsid(p, sp);
> > +#ifdef CONFIG_PPC_VAS
> > +	p->thread.tidr =3D 0;
> > +#endif
> >=20
> > =A0#ifdef CONFIG_PPC64=A0
> > =A0	if (cpu_has_feature(CPU_FTR_DSCR)) {

Return-Path: <tfransosi@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DB27EB6F4F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Apr 2011 01:19:59 +1000 (EST)
Received: by iym7 with SMTP id 7so2860526iym.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Apr 2011 08:19:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110429000901.3D66.A69D9226@jp.fujitsu.com>
References: <20110429000901.3D66.A69D9226@jp.fujitsu.com>
Date: Thu, 28 Apr 2011 12:19:56 -0300
Message-ID: <BANLkTi=EvC6E_p+XSpzZUvhu0Q_gStROcQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: convert old cpumask API into new one
From: Thiago Farina <tfransosi@gmail.com>
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 28, 2011 at 12:07 PM, KOSAKI Motohiro
<kosaki.motohiro@jp.fujitsu.com> wrote:
> Adapt new API.
>
> Almost change is trivial. Most important change is the below line
> because we plan to change task->cpus_allowed implementation.
>
> - =C2=A0 =C2=A0 =C2=A0 ctx->cpus_allowed =3D current->cpus_allowed;
>
> Signed-off-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
> =C2=A0arch/powerpc/include/asm/cputhreads.h =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 12 +++++-----
> =C2=A0arch/powerpc/include/asm/kexec.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0arch/powerpc/kernel/crash.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 32 +++++++++++++-------------
> =C2=A0arch/powerpc/kernel/setup-common.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A04 +-
> =C2=A0arch/powerpc/kernel/smp.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A04 +-
> =C2=A0arch/powerpc/kernel/traps.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0arch/powerpc/mm/numa.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0arch/powerpc/platforms/cell/beat_smp.c =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A02 +-
> =C2=A0arch/powerpc/platforms/cell/cbe_regs.c =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 11 +++++----
> =C2=A0arch/powerpc/platforms/cell/smp.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 13 +++++-----
> =C2=A0arch/powerpc/platforms/cell/spufs/sched.c =C2=A0 =C2=A0| =C2=A0 =C2=
=A02 +-
> =C2=A0arch/powerpc/platforms/pseries/hotplug-cpu.c | =C2=A0 =C2=A02 +-
> =C2=A0arch/powerpc/xmon/xmon.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 16 ++++++------
> =C2=A013 files changed, 52 insertions(+), 52 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include=
/asm/cputhreads.h
> index f71bb4c..ce516e5 100644
> --- a/arch/powerpc/include/asm/cputhreads.h
> +++ b/arch/powerpc/include/asm/cputhreads.h
> @@ -37,16 +37,16 @@ extern cpumask_t threads_core_mask;
> =C2=A0* This can typically be used for things like IPI for tlb invalidati=
ons
> =C2=A0* since those need to be done only once per core/TLB
> =C2=A0*/
> -static inline cpumask_t cpu_thread_mask_to_cores(cpumask_t threads)
> +static inline cpumask_t cpu_thread_mask_to_cores(const struct cpumask *t=
hreads)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cpumask_t =C2=A0 =C2=A0 =C2=A0 tmp, res;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
i;
>
> - =C2=A0 =C2=A0 =C2=A0 res =3D CPU_MASK_NONE;
> + =C2=A0 =C2=A0 =C2=A0 cpumask_clear(&res);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < NR_CPUS; i +=3D threads_per_=
core) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpus_shift_left(tmp, t=
hreads_core_mask, i);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpus_intersects(th=
reads, tmp))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpu_set(i, res);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_shift_left(&tm=
p, &threads_core_mask, i);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpumask_intersects=
(threads, &tmp))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpumask_set_cpu(i, &res);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return res;
> =C2=A0}
> @@ -58,7 +58,7 @@ static inline int cpu_nr_cores(void)
>
> =C2=A0static inline cpumask_t cpu_online_cores_map(void)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 return cpu_thread_mask_to_cores(cpu_online_map);
> + =C2=A0 =C2=A0 =C2=A0 return cpu_thread_mask_to_cores(cpu_online_mask);
> =C2=A0}
>
> =C2=A0#ifdef CONFIG_SMP
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/=
kexec.h
> index f54408d..8a33698 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -76,7 +76,7 @@ extern void crash_send_ipi(void (*crash_ipi_callback)(s=
truct pt_regs *));
> =C2=A0extern cpumask_t cpus_in_sr;
> =C2=A0static inline int kexec_sr_activated(int cpu)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 return cpu_isset(cpu,cpus_in_sr);
> + =C2=A0 =C2=A0 =C2=A0 return cpumask_test_cpu(cpu, &cpus_in_sr);
> =C2=A0}
>
> =C2=A0struct kimage;
> diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
> index 3d3d416..88e294f 100644
> --- a/arch/powerpc/kernel/crash.c
> +++ b/arch/powerpc/kernel/crash.c
> @@ -64,9 +64,9 @@ void crash_ipi_callback(struct pt_regs *regs)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hard_irq_disable();
> - =C2=A0 =C2=A0 =C2=A0 if (!cpu_isset(cpu, cpus_in_crash))
> + =C2=A0 =C2=A0 =C2=A0 if (!cpumask_test_cpu(cpu, &cpus_in_crash))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0crash_save_cpu(reg=
s, cpu);
> - =C2=A0 =C2=A0 =C2=A0 cpu_set(cpu, cpus_in_crash);
> + =C2=A0 =C2=A0 =C2=A0 cpumask_set_cpu(cpu, &cpus_in_crash);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Entered via soft-reset - could be the kdump
> @@ -77,8 +77,8 @@ void crash_ipi_callback(struct pt_regs *regs)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Tell the kexec CPU that entered via soft-re=
set and ready
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * to go down.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 if (cpu_isset(cpu, cpus_in_sr)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_clear(cpu, cpus_in=
_sr);
> + =C2=A0 =C2=A0 =C2=A0 if (cpumask_test_cpu(cpu, &cpus_in_sr)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_clear_cpu(cpu,=
 &cpus_in_sr);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atomic_inc(&enter_=
on_soft_reset);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> @@ -87,7 +87,7 @@ void crash_ipi_callback(struct pt_regs *regs)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * This barrier is needed to make sure that al=
l CPUs are stopped.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * If not, soft-reset will be invoked to bring=
 other CPUs.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 while (!cpu_isset(crashing_cpu, cpus_in_crash))
> + =C2=A0 =C2=A0 =C2=A0 while (!cpumask_test_cpu(crashing_cpu, &cpus_in_cr=
ash))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_relax();
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ppc_md.kexec_cpu_down)
> @@ -109,7 +109,7 @@ static void crash_soft_reset_check(int cpu)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int ncpus =3D num_online_cpus() - 1;/=
* Excluding the panic cpu */
>
> - =C2=A0 =C2=A0 =C2=A0 cpu_clear(cpu, cpus_in_sr);
> + =C2=A0 =C2=A0 =C2=A0 cpumask_clear_cpu(cpu, &cpus_in_sr);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while (atomic_read(&enter_on_soft_reset) !=3D =
ncpus)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_relax();
> =C2=A0}
> @@ -132,7 +132,7 @@ static void crash_kexec_prepare_cpus(int cpu)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_EMERG "Sending IPI to other cpus..=
.\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0msecs =3D 10000;
> - =C2=A0 =C2=A0 =C2=A0 while ((cpus_weight(cpus_in_crash) < ncpus) && (--=
msecs > 0)) {
> + =C2=A0 =C2=A0 =C2=A0 while ((cpumask_weight(&cpus_in_crash) < ncpus) &&=
 (--msecs > 0)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_relax();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mdelay(1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -144,20 +144,20 @@ static void crash_kexec_prepare_cpus(int cpu)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * user to do soft reset such that we get all.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Soft-reset will be used until better mechan=
ism is implemented.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 if (cpus_weight(cpus_in_crash) < ncpus) {
> + =C2=A0 =C2=A0 =C2=A0 if (cpumask_weight(&cpus_in_crash) < ncpus) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_EMERG =
"done waiting: %d cpu(s) not responding\n",
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ncpus - cpus_weight(cpus_in_crash));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ncpus - cpumask_weight(&cpus_in_crash));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_EMERG =
"Activate soft-reset to stop other cpu(s)\n");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpus_in_sr =3D CPU_MAS=
K_NONE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_clear(&cpus_in=
_sr);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atomic_set(&enter_=
on_soft_reset, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (cpus_weight(cpu=
s_in_crash) < ncpus)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (cpumask_weight(=
&cpus_in_crash) < ncpus)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cpu_relax();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Make sure all CPUs are entered via soft-res=
et if the kdump is
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * invoked using soft-reset.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 if (cpu_isset(cpu, cpus_in_sr))
> + =C2=A0 =C2=A0 =C2=A0 if (cpumask_test_cpu(cpu, &cpus_in_sr))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0crash_soft_reset_c=
heck(cpu);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Leave the IPI callback set */
> =C2=A0}
> @@ -212,7 +212,7 @@ void crash_kexec_secondary(struct pt_regs *regs)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * exited using 'x'(exit and recover) or
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * kexec_should_crash() failed for all running tasks.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpu_clear(cpu, cpus_in_sr);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cpumask_clear_cpu(cpu, &cpus_in_sr);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0local_irq_restore(flags);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -226,7 +226,7 @@ void crash_kexec_secondary(struct pt_regs *regs)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * then start kexe=
c boot.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0crash_soft_reset_c=
heck(cpu);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_set(crashing_cpu, =
cpus_in_crash);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_set_cpu(crashi=
ng_cpu, &cpus_in_crash);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ppc_md.kexec_c=
pu_down)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ppc_md.kexec_cpu_down(1, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0machine_kexec(kexe=
c_crash_image);
> @@ -253,7 +253,7 @@ static void crash_kexec_prepare_cpus(int cpu)
>
> =C2=A0void crash_kexec_secondary(struct pt_regs *regs)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 cpus_in_sr =3D CPU_MASK_NONE;
> + =C2=A0 =C2=A0 =C2=A0 cpumask_clear(&cpus_in_sr);
> =C2=A0}
> =C2=A0#endif
>
> @@ -345,7 +345,7 @@ void default_machine_crash_shutdown(struct pt_regs *r=
egs)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0crashing_cpu =3D smp_processor_id();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0crash_save_cpu(regs, crashing_cpu);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0crash_kexec_prepare_cpus(crashing_cpu);
> - =C2=A0 =C2=A0 =C2=A0 cpu_set(crashing_cpu, cpus_in_crash);
> + =C2=A0 =C2=A0 =C2=A0 cpumask_set_cpu(crashing_cpu, &cpus_in_crash);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0crash_kexec_wait_realmode(crashing_cpu);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0machine_kexec_mask_interrupts();
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/set=
up-common.c
> index 21f30cb..1475df6 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -381,7 +381,7 @@ static void __init cpu_init_thread_core_maps(int tpc)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0threads_per_core =3D tpc;
> - =C2=A0 =C2=A0 =C2=A0 threads_core_mask =3D CPU_MASK_NONE;
> + =C2=A0 =C2=A0 =C2=A0 cpumask_clear(&threads_core_mask);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* This implementation only supports power of =
2 number of threads
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * for simplicity and performance
> @@ -390,7 +390,7 @@ static void __init cpu_init_thread_core_maps(int tpc)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(tpc !=3D (1 << threads_shift));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < tpc; i++)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_set(i, threads_cor=
e_mask);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_set_cpu(i, &th=
reads_core_mask);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_INFO "CPU maps initialized for %d =
thread%s per core\n",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tpc, tpc > 1 ? "s" : "")=
;
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 9f9c204..da584a9 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -507,7 +507,7 @@ int cpu_first_thread_of_core(int core)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(cpu_first_thread_of_core);
>
> -/* Must be called when no change can occur to cpu_present_map,
> +/* Must be called when no change can occur to cpu_present_mask,
> =C2=A0* i.e. during cpu online or offline.
> =C2=A0*/
> =C2=A0static struct device_node *cpu_to_l2cache(int cpu)
> @@ -608,7 +608,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * se we pin us down to CPU 0 for a short whil=
e
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0alloc_cpumask_var(&old_mask, GFP_NOWAIT);
> - =C2=A0 =C2=A0 =C2=A0 cpumask_copy(old_mask, &current->cpus_allowed);
> + =C2=A0 =C2=A0 =C2=A0 cpumask_copy(old_mask, tsk_cpus_allowed(current));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set_cpus_allowed_ptr(current, cpumask_of(boot_=
cpuid));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (smp_ops && smp_ops->setup_cpu)
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 5ddb801..af1f8f4 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -221,7 +221,7 @@ void system_reset_exception(struct pt_regs *regs)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0#ifdef CONFIG_KEXEC
> - =C2=A0 =C2=A0 =C2=A0 cpu_set(smp_processor_id(), cpus_in_sr);
> + =C2=A0 =C2=A0 =C2=A0 cpumask_set_cpu(smp_processor_id(), &cpus_in_sr);
> =C2=A0#endif
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0die("System Reset", regs, SIGABRT);
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 5ec1dad..d6cc587 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1453,7 +1453,7 @@ int arch_update_cpu_topology(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int associativity[VPHN_ASSOC_BUFSIZE]=
 =3D {0};
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sys_device *sysdev;
>
> - =C2=A0 =C2=A0 =C2=A0 for_each_cpu_mask(cpu, cpu_associativity_changes_m=
ask) {
> + =C2=A0 =C2=A0 =C2=A0 for_each_cpu(cpu,&cpu_associativity_changes_mask) =
{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vphn_get_associati=
vity(cpu, associativity);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nid =3D associativ=
ity_to_nid(associativity);
>
> diff --git a/arch/powerpc/platforms/cell/beat_smp.c b/arch/powerpc/platfo=
rms/cell/beat_smp.c
> index 26efc20..fd3cdb4 100644
> --- a/arch/powerpc/platforms/cell/beat_smp.c
> +++ b/arch/powerpc/platforms/cell/beat_smp.c
> @@ -85,7 +85,7 @@ static void smp_beatic_message_pass(int target, int msg=
)
>
> =C2=A0static int __init smp_beatic_probe(void)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 return cpus_weight(cpu_possible_map);
> + =C2=A0 =C2=A0 =C2=A0 return cpumask_weight(cpu_possible_mask);
> =C2=A0}
>
> =C2=A0static void __devinit smp_beatic_setup_cpu(int cpu)
> diff --git a/arch/powerpc/platforms/cell/cbe_regs.c b/arch/powerpc/platfo=
rms/cell/cbe_regs.c
> index dbc338f..f3917e7 100644
> --- a/arch/powerpc/platforms/cell/cbe_regs.c
> +++ b/arch/powerpc/platforms/cell/cbe_regs.c
> @@ -45,8 +45,8 @@ static struct cbe_thread_map
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int cbe_id;
> =C2=A0} cbe_thread_map[NR_CPUS];
>
> -static cpumask_t cbe_local_mask[MAX_CBE] =3D { [0 ... MAX_CBE-1] =3D CPU=
_MASK_NONE };
> -static cpumask_t cbe_first_online_cpu =3D CPU_MASK_NONE;
> +static cpumask_t cbe_local_mask[MAX_CBE] =3D { [0 ... MAX_CBE-1] =3D {CP=
U_BITS_NONE} };
> +static cpumask_t cbe_first_online_cpu =3D { CPU_BITS_NONE };
>
> =C2=A0static struct cbe_regs_map *cbe_find_map(struct device_node *np)
> =C2=A0{
> @@ -159,7 +159,8 @@ EXPORT_SYMBOL_GPL(cbe_cpu_to_node);
>
> =C2=A0u32 cbe_node_to_cpu(int node)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 return find_first_bit( (unsigned long *) &cbe_loca=
l_mask[node], sizeof(cpumask_t));
> + =C2=A0 =C2=A0 =C2=A0 return cpumask_first(&cbe_local_mask[node]);
> +
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(cbe_node_to_cpu);
>
> @@ -268,9 +269,9 @@ void __init cbe_regs_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0thread->regs =3D map;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0thread->cbe_id =3D cbe_id;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0map->be_node =3D thread->be_node;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_set(i, cbe_local_mask[cbe_id]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_set_cpu(i, &cbe_local_mask[cbe_i=
d]);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if(thread->thread_id =3D=3D 0)
while you are here, could you add a space between if and ( ?

> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_set(i, c=
be_first_online_cpu);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_set_=
cpu(i, &cbe_first_online_cpu);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/c=
ell/smp.c
> index f774530..56e8fa0 100644
> --- a/arch/powerpc/platforms/cell/smp.c
> +++ b/arch/powerpc/platforms/cell/smp.c
> @@ -77,7 +77,7 @@ static inline int __devinit smp_startup_cpu(unsigned in=
t lcpu)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int pcpu;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int start_cpu;
>
> - =C2=A0 =C2=A0 =C2=A0 if (cpu_isset(lcpu, of_spin_map))
> + =C2=A0 =C2=A0 =C2=A0 if (cpumask_test_cpu(lcpu, &of_spin_map))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Already started=
 by OF and sitting in spin loop */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;
>
> @@ -123,7 +123,7 @@ static int __init smp_iic_probe(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iic_request_IPIs();
>
> - =C2=A0 =C2=A0 =C2=A0 return cpus_weight(cpu_possible_map);
> + =C2=A0 =C2=A0 =C2=A0 return cpumask_weight(cpu_possible_mask);
> =C2=A0}
>
> =C2=A0static void __devinit smp_cell_setup_cpu(int cpu)
> @@ -186,13 +186,12 @@ void __init smp_init_cell(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cpu_has_feature(CPU_FTR_SMT)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_present_c=
pu(i) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (cpu_thread_in_core(i) =3D=3D 0)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_set(i, of_spin_map);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_set_cpu(i, &of_spin_map);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 } else {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 of_spin_map =3D cpu_pr=
esent_map;
> - =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 } else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&of_spin_=
map, cpu_present_mask);
>
> - =C2=A0 =C2=A0 =C2=A0 cpu_clear(boot_cpuid, of_spin_map);
> + =C2=A0 =C2=A0 =C2=A0 cpumask_clear_cpu(boot_cpuid, &of_spin_map);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Non-lpar has additional take/give timebase =
*/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rtas_token("freeze-time-base") !=3D RTAS_U=
NKNOWN_SERVICE) {
> diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/pla=
tforms/cell/spufs/sched.c
> index 6520385..32cb4e6 100644
> --- a/arch/powerpc/platforms/cell/spufs/sched.c
> +++ b/arch/powerpc/platforms/cell/spufs/sched.c
> @@ -141,7 +141,7 @@ void __spu_update_sched_info(struct spu_context *ctx)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * runqueue. The context will be rescheduled o=
n the proper node
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * if it is timesliced or preempted.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 ctx->cpus_allowed =3D current->cpus_allowed;
> + =C2=A0 =C2=A0 =C2=A0 cpumask_copy(&ctx->cpus_allowed, tsk_cpus_allowed(=
current));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Save the current cpu id for spu interrupt r=
outing. */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx->last_ran =3D raw_smp_processor_id();
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/=
platforms/pseries/hotplug-cpu.c
> index ef8c454..7be7c20 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -280,7 +280,7 @@ static int pseries_add_processor(struct device_node *=
np)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_cpu(cpu, tmp) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG_ON(cpumask_test_cp=
u(cpu, cpu_present_mask));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG_ON(cpu_present(cpu=
));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_cpu_present(cp=
u, true);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_hard_smp_proce=
ssor_id(cpu, *intserv++);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 33794c1..c160361 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -334,7 +334,7 @@ static void release_output_lock(void)
>
> =C2=A0int cpus_are_in_xmon(void)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 return !cpus_empty(cpus_in_xmon);
> + =C2=A0 =C2=A0 =C2=A0 return !cpumask_empty(&cpus_in_xmon);
> =C2=A0}
> =C2=A0#endif
>
> @@ -373,7 +373,7 @@ static int xmon_core(struct pt_regs *regs, int fromip=
i)
>
> =C2=A0#ifdef CONFIG_SMP
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu =3D smp_processor_id();
> - =C2=A0 =C2=A0 =C2=A0 if (cpu_isset(cpu, cpus_in_xmon)) {
> + =C2=A0 =C2=A0 =C2=A0 if (cpumask_test_cpu(cpu, &cpus_in_xmon)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_output_lock();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0excprint(regs);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf("cpu 0x%x: =
Exception %lx %s in xmon, "
> @@ -396,7 +396,7 @@ static int xmon_core(struct pt_regs *regs, int fromip=
i)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0xmon_fault_jmp[cpu] =3D recurse_jmp;
> - =C2=A0 =C2=A0 =C2=A0 cpu_set(cpu, cpus_in_xmon);
> + =C2=A0 =C2=A0 =C2=A0 cpumask_set_cpu(cpu, &cpus_in_xmon);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bp =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((regs->msr & (MSR_IR|MSR_PR|MSR_SF)) =3D=
=3D (MSR_IR|MSR_SF))
> @@ -440,7 +440,7 @@ static int xmon_core(struct pt_regs *regs, int fromip=
i)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0smp_send_debugger_break(MSG_ALL_BUT_SELF);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* wait for other cpus to come in */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0for (timeout =3D 100000000; timeout !=3D 0; --timeout) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpus_weight(cpus_in_xmon) >=3D ncpus=
)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpumask_weight(&cpus_in_xmon) >=3D n=
cpus)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0barrier();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}
> @@ -484,7 +484,7 @@ static int xmon_core(struct pt_regs *regs, int fromip=
i)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0leave:
> - =C2=A0 =C2=A0 =C2=A0 cpu_clear(cpu, cpus_in_xmon);
> + =C2=A0 =C2=A0 =C2=A0 cpumask_clear_cpu(cpu, &cpus_in_xmon);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0xmon_fault_jmp[cpu] =3D NULL;
> =C2=A0#else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* UP is simple... */
> @@ -630,7 +630,7 @@ static int xmon_iabr_match(struct pt_regs *regs)
> =C2=A0static int xmon_ipi(struct pt_regs *regs)
> =C2=A0{
> =C2=A0#ifdef CONFIG_SMP
> - =C2=A0 =C2=A0 =C2=A0 if (in_xmon && !cpu_isset(smp_processor_id(), cpus=
_in_xmon))
> + =C2=A0 =C2=A0 =C2=A0 if (in_xmon && !cpumask_test_cpu(smp_processor_id(=
), &cpus_in_xmon))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xmon_core(regs, 1)=
;
> =C2=A0#endif
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> @@ -976,7 +976,7 @@ static int cpu_cmd(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf("cpus stopp=
ed:");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0count =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (cpu =3D 0; cp=
u < NR_CPUS; ++cpu) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (cpu_isset(cpu, cpus_in_xmon)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (cpumask_test_cpu(cpu, &cpus_in_xmon)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (count =3D=3D 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(" =
%x", cpu);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0++count;
> @@ -992,7 +992,7 @@ static int cpu_cmd(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* try to switch to cpu specified */
> - =C2=A0 =C2=A0 =C2=A0 if (!cpu_isset(cpu, cpus_in_xmon)) {
> + =C2=A0 =C2=A0 =C2=A0 if (!cpumask_test_cpu(cpu, &cpus_in_xmon)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf("cpu 0x%x i=
sn't in xmon\n", cpu);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> --
> 1.7.3.1
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>

Return-Path: <boqun.feng@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXkRc18JlzDvtg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 12:23:56 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id e9so18027556pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Dec 2016 17:23:56 -0800 (PST)
Date: Tue, 6 Dec 2016 09:23:15 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v8 3/6] powerpc: lib/locks.c: Add cpu yield/wake helper
 function
Message-ID: <20161206012315.GD18164@tardis.cn.ibm.com>
References: <1480951166-44830-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1480951166-44830-4-git-send-email-xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
In-Reply-To: <1480951166-44830-4-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 10:19:23AM -0500, Pan Xinhui wrote:
> Add two corresponding helper functions to support pv-qspinlock.
>=20
> For normal use, __spin_yield_cpu will confer current vcpu slices to the
> target vcpu(say, a lock holder). If target vcpu is not specified or it
> is in running state, such conferging to lpar happens or not depends.
>=20
> Because hcall itself will introduce latency and a little overhead. And we
> do NOT want to suffer any latency on some cases, e.g. in interrupt handle=
r.
> The second parameter *confer* can indicate such case.
>=20
> __spin_wake_cpu is simpiler, it will wake up one vcpu regardless of its
> current vcpu state.
>=20
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/spinlock.h |  4 +++
>  arch/powerpc/lib/locks.c            | 59 +++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 63 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/a=
sm/spinlock.h
> index 954099e..6426bd5 100644
> --- a/arch/powerpc/include/asm/spinlock.h
> +++ b/arch/powerpc/include/asm/spinlock.h
> @@ -64,9 +64,13 @@ static inline bool vcpu_is_preempted(int cpu)
>  /* We only yield to the hypervisor if we are in shared processor mode */
>  #define SHARED_PROCESSOR (lppaca_shared_proc(local_paca->lppaca_ptr))
>  extern void __spin_yield(arch_spinlock_t *lock);
> +extern void __spin_yield_cpu(int cpu, int confer);
> +extern void __spin_wake_cpu(int cpu);
>  extern void __rw_yield(arch_rwlock_t *lock);
>  #else /* SPLPAR */
>  #define __spin_yield(x)        barrier()
> +#define __spin_yield_cpu(x, y) barrier()
> +#define __spin_wake_cpu(x) barrier()
>  #define __rw_yield(x)  barrier()
>  #define SHARED_PROCESSOR       0
>  #endif
> diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
> index 6574626..bd872c9 100644
> --- a/arch/powerpc/lib/locks.c
> +++ b/arch/powerpc/lib/locks.c
> @@ -23,6 +23,65 @@
>  #include <asm/hvcall.h>
>  #include <asm/smp.h>
> =20
> +/*
> + * confer our slices to a specified cpu and return. If it is in running =
state
> + * or cpu is -1, then we will check confer. If confer is NULL, we will r=
eturn
> + * otherwise we confer our slices to lpar.
> + */
> +void __spin_yield_cpu(int cpu, int confer)
> +{
> +	unsigned int holder_cpu =3D cpu, yield_count;

As I said at:

https://marc.info/?l=3Dlinux-kernel&m=3D147455748619343&w=3D2

@holder_cpu is not necessary and doesn't help anything.

> +
> +	if (cpu =3D=3D -1)
> +		goto yield_to_lpar;
> +
> +	BUG_ON(holder_cpu >=3D nr_cpu_ids);
> +	yield_count =3D be32_to_cpu(lppaca_of(holder_cpu).yield_count);
> +
> +	/* if cpu is running, confer slices to lpar conditionally*/
> +	if ((yield_count & 1) =3D=3D 0)
> +		goto yield_to_lpar;
> +
> +	plpar_hcall_norets(H_CONFER,
> +		get_hard_smp_processor_id(holder_cpu), yield_count);
> +	return;
> +
> +yield_to_lpar:
> +	if (confer)
> +		plpar_hcall_norets(H_CONFER, -1, 0);
> +}
> +EXPORT_SYMBOL_GPL(__spin_yield_cpu);
> +
> +void __spin_wake_cpu(int cpu)
> +{
> +	unsigned int holder_cpu =3D cpu;

And it's even wrong to call the parameter of _wake_cpu() a holder_cpu,
because it's not the current lock holder.

Regards,
Boqun

> +
> +	BUG_ON(holder_cpu >=3D nr_cpu_ids);
> +	/*
> +	 * NOTE: we should always do this hcall regardless of
> +	 * the yield_count of the holder_cpu.
> +	 * as thers might be a case like below;
> +	 *	CPU 1			CPU 2
> +	 *				yielded =3D true
> +	 * if (yielded)
> +	 *	__spin_wake_cpu()
> +	 *				__spin_yield_cpu()
> +	 *
> +	 * So we might lose a wake if we check the yield_count and
> +	 * return directly if the holder_cpu is running.
> +	 * IOW. do NOT code like below.
> +	 *	yield_count =3D be32_to_cpu(lppaca_of(holder_cpu).yield_count);
> +	 *	if ((yield_count & 1) =3D=3D 0)
> +	 *		return;
> +	 *
> +	 * a PROD hcall marks the target_cpu proded, which cause the next cede
> +	 * or confer called on the target_cpu invalid.
> +	 */
> +	plpar_hcall_norets(H_PROD,
> +		get_hard_smp_processor_id(holder_cpu));
> +}
> +EXPORT_SYMBOL_GPL(__spin_wake_cpu);
> +
>  #ifndef CONFIG_QUEUED_SPINLOCKS
>  void __spin_yield(arch_spinlock_t *lock)
>  {
> --=20
> 2.4.11
>=20

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYRhL/AAoJEEl56MO1B/q45moH/0tssWctDVQsjVy5WuNi/hvA
L4e/ZuV15whPP7skv2LdFPtYlgTiffVowBZzesZhRxhtgII493XtKBYBn6fANw0h
6SL43kqYjiAqNQOrctyXTUjZyNpkVH8xDqXVMU+t0A3+sjbNfy34KicR8DxBwuPO
UWtdxSFlR8yixVjtYdBCWlsRIMCOU1/iD7/Xa89S6utJYQ49QQN4knQZgJI4aPh5
PoddXsUQPK/0iGUBEaSyVhICmYropOHZnvBjQP+1QWmk9g6lnzri7HbTFtTuTKHR
djgXWL7f0h+z5Cg2ZQPJakXbEwztucINAesRyp8WEofmaHMa6PSEfcWDIvD+p7g=
=PcEx
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--

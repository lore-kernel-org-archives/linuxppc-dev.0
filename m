Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sg0VV6PRGzDsj8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 01:17:54 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id oz2so3803087pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 08:17:54 -0700 (PDT)
Date: Thu, 22 Sep 2016 23:17:16 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v7 4/6] powerpc: lib/locks.c: Add cpu yield/wake helper
 function
Message-ID: <20160922151716.GA22004@tardis.cn.ibm.com>
References: <1474277037-15200-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1474277037-15200-5-git-send-email-xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
In-Reply-To: <1474277037-15200-5-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Xinhui,

On Mon, Sep 19, 2016 at 05:23:55AM -0400, Pan Xinhui wrote:
> Add two corresponding helper functions to support pv-qspinlock.
>=20
> For normal use, __spin_yield_cpu will confer current vcpu slices to the
> target vcpu(say, a lock holder). If target vcpu is not specified or it
> is in running state, such conferging to lpar happens or not depends.
>=20
> Because hcall itself will introduce latency and a little overhead. And
> we do NOT want to suffer any latency on some cases, e.g. in interrupt han=
dler.
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
> index 6aef8dd..abb6b0f 100644
> --- a/arch/powerpc/include/asm/spinlock.h
> +++ b/arch/powerpc/include/asm/spinlock.h
> @@ -56,9 +56,13 @@
>  /* We only yield to the hypervisor if we are in shared processor mode */
>  #define SHARED_PROCESSOR (lppaca_shared_proc(local_paca->lppaca_ptr))
>  extern void __spin_yield(arch_spinlock_t *lock);
> +extern void __spin_yield_cpu(int cpu, int confer);
> +extern void __spin_wake_cpu(int cpu);
>  extern void __rw_yield(arch_rwlock_t *lock);
>  #else /* SPLPAR */
>  #define __spin_yield(x)	barrier()
> +#define __spin_yield_cpu(x,y) barrier()
> +#define __spin_wake_cpu(x) barrier()
>  #define __rw_yield(x)	barrier()
>  #define SHARED_PROCESSOR	0
>  #endif
> diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
> index 6574626..892df7d 100644
> --- a/arch/powerpc/lib/locks.c
> +++ b/arch/powerpc/lib/locks.c
> @@ -23,6 +23,65 @@
>  #include <asm/hvcall.h>
>  #include <asm/smp.h>
> =20
> +/*
> + * confer our slices to a specified cpu and return. If it is already run=
ning or
> + * cpu is -1, then we will check confer. If confer is NULL, we will retu=
rn
> + * otherwise we confer our slices to lpar.
> + */
> +void __spin_yield_cpu(int cpu, int confer)
> +{
> +	unsigned int holder_cpu =3D cpu, yield_count;
> +

You don't need @holder_cpu at all, do you?

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
> +

Ditto.

Regards,
Boqun

> +	BUG_ON(holder_cpu >=3D nr_cpu_ids);
> +	/*
> +	 * NOTE: we should always do this hcall regardless of
> +	 * the yield_count of the holder_cpu.
> +	 * as thers might be a case like below;
> +	 * CPU 	1				2
> +	 *				yielded =3D true
> +	 *	if (yielded)
> +	 * 	__spin_wake_cpu()
> +	 * 				__spin_yield_cpu()
> +	 *
> +	 * So we might lose a wake if we check the yield_count and
> +	 * return directly if the holder_cpu is running.
> +	 * IOW. do NOT code like below.
> +	 *  yield_count =3D be32_to_cpu(lppaca_of(holder_cpu).yield_count);
> +	 *  if ((yield_count & 1) =3D=3D 0)
> +	 *  	return;
> +	 *
> +	 * a PROD hcall marks the target_cpu proded, which cause the next cede =
or confer
> +	 * called on the target_cpu invalid.
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

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX4/X4AAoJEEl56MO1B/q4y6gH/2AGxmEsj0HH4US1mcYUC7Qt
jlvBMes+KDlso1yy+lG5M3U8dmfWVjiN+QHQq/XT7RSU9u69sY0mPzifrRhBt4eF
Jir1MwKnW4VymB5gjbJakNNaCL48OpaGm4wBZFqkl+9y36Cb3v7ZuSIXtVLbQwmj
oJt0baU46hGpGKcgAqhPthPqOkaZW/1z8ifW+tZWI84kR+AvstZXYfNgcWqvun7V
rAddDUiPCoWImT7pzvyrllwp7bMAeezaAALlj5AxfVD6py4mcUfl4itjhT8b6J4v
QbOwzHakp/UmLlMEairtDiLFglZTbCHY2dm+PCb2myqw1bsGKTdRAnGZIo5CV74=
=y/qP
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--

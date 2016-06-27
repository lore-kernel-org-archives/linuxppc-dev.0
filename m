Return-Path: <boqun.feng@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdX6J0mvGzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 00:55:04 +1000 (AEST)
Received: by mail-it0-x244.google.com with SMTP id f6so10477219ith.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 07:55:04 -0700 (PDT)
Date: Mon, 27 Jun 2016 22:58:32 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 paulmck@linux.vnet.ibm.com, peterz@infradead.org, mingo@redhat.com,
 mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org,
 Waiman.Long@hpe.com, will.deacon@arm.com, dave@stgolabs.net
Subject: Re: [PATCH 2/3] powerpc/spinlock: support vcpu preempted check
Message-ID: <20160627145832.GB19108@insomnia>
References: <1467049290-32359-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1467049290-32359-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
In-Reply-To: <1467049290-32359-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Xinhui,

On Mon, Jun 27, 2016 at 01:41:29PM -0400, Pan Xinhui wrote:
> This is to fix some holder preemption issues. Spinning at one
> vcpu which is preempted is meaningless.
>=20
> Kernel need such interfaces, So lets support it.
>=20
> We also should suooprt both the shared and dedicated mode.
> So add lppaca_dedicated_proc macro in lppaca.h
>=20
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/lppaca.h   |  6 ++++++
>  arch/powerpc/include/asm/spinlock.h | 15 +++++++++++++++
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm=
/lppaca.h
> index d0a2a2f..0a263d3 100644
> --- a/arch/powerpc/include/asm/lppaca.h
> +++ b/arch/powerpc/include/asm/lppaca.h
> @@ -111,12 +111,18 @@ extern struct lppaca lppaca[];
>   * we will have to transition to something better.
>   */
>  #define LPPACA_OLD_SHARED_PROC		2
> +#define LPPACA_OLD_DEDICATED_PROC      (1 << 6)
> =20

I think you should describe a little bit about the magic number here,
i.e. what document/specification says this should work, and how this
works.

>  static inline bool lppaca_shared_proc(struct lppaca *l)
>  {
>  	return !!(l->__old_status & LPPACA_OLD_SHARED_PROC);
>  }
> =20
> +static inline bool lppaca_dedicated_proc(struct lppaca *l)
> +{
> +	return !!(l->__old_status & LPPACA_OLD_DEDICATED_PROC);
> +}
> +
>  /*
>   * SLB shadow buffer structure as defined in the PAPR.  The save_area
>   * contains adjacent ESID and VSID pairs for each shadowed SLB.  The
> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/a=
sm/spinlock.h
> index 523673d..ae938ee 100644
> --- a/arch/powerpc/include/asm/spinlock.h
> +++ b/arch/powerpc/include/asm/spinlock.h
> @@ -52,6 +52,21 @@
>  #define SYNC_IO
>  #endif
> =20
> +/* For fixing some spinning issues in a guest.
> + * kernel would check if vcpu is preempted during a spin loop.
> + * we support that.
> + */
> +#define arch_vcpu_is_preempted arch_vcpu_is_preempted
> +static inline bool arch_vcpu_is_preempted(int cpu)

This function should be guarded by #ifdef PPC_PSERIES .. #endif, right?
Because if the kernel is not compiled with guest support,
vcpu_is_preempted() should always be false, right?

> +{
> +	struct lppaca *lp =3D &lppaca_of(cpu);
> +
> +	if (unlikely(!(lppaca_shared_proc(lp) ||
> +			lppaca_dedicated_proc(lp))))

Do you want to detect whether we are running in a guest(ie. pseries
kernel) here? Then I wonder whether "machine_is(pseries)" works here.

Regards,
Boqun

> +		return false;
> +	return !!(be32_to_cpu(lp->yield_count) & 1);
> +}
> +
>  static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>  {
>  	return lock.slock =3D=3D 0;
> --=20
> 2.4.11
>=20

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXcT8NAAoJEEl56MO1B/q4cyEH/0BwiD9WX4WAWHrOYPnQZX3R
yWOklVosPly6PYigYSlnJlX1l+/OatBRFOQXknr1J7hKa6eacAPigvOv7tH8pI8o
MWaThUKZq7DGPiwPxvrJyfIKhk38930xEYYrMFT3mFbO00/FCb8lg71qr+EXsGsU
kelg6U1STVyGkW03sOSFVfMZIxxQibKjUmAb6ypjc19cSCBfv4lxf4K12OW8HiCm
zSzl2h2jVBp/k5TZu4p251DbL0di38i+0I+uA7PETEpQFeZXaCKHllS2nTUa1x60
4zsL+nlJqBsoTCzpr8uOXjI73EwOOt27g3mzTsh8sHRl4OeF1OHZV/ldK6BimFc=
=29fm
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--

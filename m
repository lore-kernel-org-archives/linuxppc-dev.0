Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdVwk0z6jzDqmf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 00:01:42 +1000 (AEST)
Received: by mail-io0-x241.google.com with SMTP id t74so23558152ioi.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 07:01:42 -0700 (PDT)
Date: Mon, 27 Jun 2016 22:05:40 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 paulmck@linux.vnet.ibm.com, peterz@infradead.org, mingo@redhat.com,
 mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org,
 Waiman.Long@hpe.com, will.deacon@arm.com, dave@stgolabs.net
Subject: Re: [PATCH 1/3] kernel/sched: introduce vcpu preempted check interface
Message-ID: <20160627140540.GA19108@insomnia>
References: <1467049290-32359-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1467049290-32359-2-git-send-email-xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
In-Reply-To: <1467049290-32359-2-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 27, 2016 at 01:41:28PM -0400, Pan Xinhui wrote:
> this supports to fix lock holder preempted issue which run as a guest
>=20
> for kernel users, we could use bool vcpu_is_preempted(int cpu) to detech
> if one vcpu is preempted or not.
>=20
> The default implementation is a macrodefined by false. So compiler can
> wrap it out if arch dose not support such vcpu pteempted check.
>=20
> archs can implement it by define arch_vcpu_is_preempted().
>=20
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
>  include/linux/sched.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 6e42ada..dc0a9c3 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -3293,6 +3293,15 @@ static inline void set_task_cpu(struct task_struct=
 *p, unsigned int cpu)
> =20
>  #endif /* CONFIG_SMP */
> =20
> +#ifdef arch_vcpu_is_preempted
> +static inline bool vcpu_is_preempted(int cpu)
> +{
> +	return arch_vcpu_is_preempted(cpu);
> +}
> +#else
> +#define vcpu_is_preempted(cpu)	false
> +#endif
> +

I think you are missing Peter's comment here. We can

#ifndef vcpu_is_preempted
#define vcpu_is_preempted(cpu)	fasle
#endif

And different archs implement their own versions of vcpu_is_preempted(),
IOW, no need for an arch_vcpu_is_preempted().

Regards,
Boqun

>  extern long sched_setaffinity(pid_t pid, const struct cpumask *new_mask);
>  extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
> =20
> --=20
> 2.4.11
>=20

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXcTKeAAoJEEl56MO1B/q4tVcIAKHcKyQ2OQl4rQNL9SRTjkBX
08ZNF9oytmzS4VkgaSPuuM5YJg80pQ6ikFfWODjRj1oqD1Fgh1f1x9QfujCLMWFw
zW64t9FHqajLjKMp/GtwMvTffsYxLj6wN9khrQuOY5ZaeVaEpRHhuqEUQdUZunkM
SrELOSlW1A5hBhDKqWkIiGuwMYO1KKqzCkAgrjy66oAoRjtaZ451R3y2bG188F7K
FbBGGo6ZufD/2KE4lUZfDvpbIDJ52iU71LTcT/E5wCcCK8HzhakMx0gHod/+eUP6
6j5fWbSWAZhfLjRQr76nJgWE8gvO9fmF2a7FjXl6xP5o2GBEeK/QzhXZIM3Ox+4=
=4hgI
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

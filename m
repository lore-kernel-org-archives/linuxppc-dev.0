Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 01/10] irq: move some interrupt arch_* functions into
	struct irq_chip.
From: Michael Ellerman <michael@ellerman.id.au>
To: Yinghai Lu <yinghai@kernel.org>
In-Reply-To: <1269221770-9667-2-git-send-email-yinghai@kernel.org>
References: <1269221770-9667-1-git-send-email-yinghai@kernel.org>
	<1269221770-9667-2-git-send-email-yinghai@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-+d9bi2FcoHj8lqKBYIsB"
Date: Mon, 22 Mar 2010 12:56:02 +1100
Message-ID: <1269222962.3534.12.camel@concordia>
Mime-Version: 1.0
Cc: lguest@ozlabs.org, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-sh@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>, Paul Mackerras <paulus@samba.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ian Campbell <ian.campbell@citrix.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-+d9bi2FcoHj8lqKBYIsB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2010-03-21 at 18:36 -0700, Yinghai Lu wrote:
> From: Ian Campbell <ian.campbell@citrix.com>
...
> To replace the x86 arch_init_chip_data functionality
> irq_to_desc_alloc_node now takes a pointer to a function to allocate
> the chip data. This is necessary to ensure the allocation happens
> under the correct locking at the core level. On PowerPC and SH
> architectures (the other users of irq_to_desc_alloc_node) pass in NULL
> which retains existing chip_data behaviour.
...
>=20
> -v4: yinghai add irq_to_desc_alloc_node_x...
>      so could leave default path not changed...

Apologies for not noticing this sooner, but ..

> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -1088,7 +1088,7 @@ int arch_early_irq_init(void)
>  	return 0;
>  }
> =20
> -int arch_init_chip_data(struct irq_desc *desc, int node)
> +int arch_init_irq_desc(struct irq_desc *desc, int node, init_chip_data_f=
n fn)
>  {
>  	desc->status |=3D IRQ_NOREQUEST;
>  	return 0;

This is a bit feral, that is the init_chip_data_fn.

It seems like it only exists to support the following on x86:

> +int arch_init_irq_desc(struct irq_desc *desc, int node,
> +			 init_chip_data_fn init_chip_data)
> +{
> +	if (!init_chip_data)
> +		return x86_init_chip_data(desc, node);
> +
> +	return init_chip_data(desc, node);
> +}

Which is really just a hack to avoid an if (xen) check isn't it?

It looks to me like this should just be done via a current machine
vector or platform routine, in the same way as powerpc and (I think)
ia64, ie:

> +int arch_init_irq_desc(struct irq_desc *desc, int node)
> +{
> +	return current_machine->init_chip_data(desc, node);
> +}

cheers


--=-+d9bi2FcoHj8lqKBYIsB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkumzjIACgkQdSjSd0sB4dJRaQCgmIelxJ0xbu71jQVjWOd/3Epl
RuwAn2Xk0uH1zUreygWD0l0pGnxudcCh
=Un8c
-----END PGP SIGNATURE-----

--=-+d9bi2FcoHj8lqKBYIsB--

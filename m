Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: fixup lwsync at runtime
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0807010031241.23830@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0807010031241.23830@blarg.am.freescale.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0qr8HO79Kqsye8rMDkPz"
Date: Tue, 01 Jul 2008 16:29:13 +1000
Message-Id: <1214893753.8055.13.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-0qr8HO79Kqsye8rMDkPz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-07-01 at 00:32 -0500, Kumar Gala wrote:
> To allow for a single kernel image on e500 v1/v2/mc we need to fixup lwsy=
nc
> at runtime.  On e500v1/v2 lwsync causes an illop so we need to patch up
> the code.  We default to 'sync' since that is always safe and if the cpu
> is capable we will replace 'sync' with 'lwsync'.
>=20
> We introduce CPU_FTR_LWSYNC as a way to determine at runtime if this is
> needed.  This flag could be moved elsewhere since we dont really use it
> for the normal CPU_FTR purpose.
>=20
> Finally we only store the relative offset in the fixup section to keep it
> as small as possible rather than using a full fixup_entry.

How many entries are we talking? I guess it's not much bother to have a
separate section.

> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_3=
2.c
> index 9e83add..0109e7f 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -101,6 +101,10 @@ unsigned long __init early_init(unsigned long dt_ptr=
)
>  			  PTRRELOC(&__start___ftr_fixup),
>  			  PTRRELOC(&__stop___ftr_fixup));
>=20
> +	do_lwsync_fixups(spec->cpu_features,
> +			 PTRRELOC(&__start___lwsync_fixup),
> +			 PTRRELOC(&__stop___lwsync_fixup));
> +

This could be changed to use cur_cpu_spec->cpu_features, and then all
the call sites would be passing that, which would mean
do_lwsync_fixups() could just check cur_cpu_spec->cpu_features directly.

> diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature=
-fixups.c
> index 48e1ed8..ac5f5a1 100644
> --- a/arch/powerpc/lib/feature-fixups.c
> +++ b/arch/powerpc/lib/feature-fixups.c
> @@ -110,6 +110,22 @@ void do_feature_fixups(unsigned long value, void *fi=
xup_start, void *fixup_end)
>  	}
>  }
>=20
> +void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixu=
p_end)
> +{
> +	unsigned int *start, *end, *dest;
> +
> +	if (!(value & CPU_FTR_LWSYNC))
> +		return ;
> +
> +	start =3D fixup_start;
> +	end =3D fixup_end;
> +
> +	for (; start < end; start++) {
> +		dest =3D (void *)start + *start;
> +		patch_instruction(dest, PPC_LWSYNC_INSTR);
> +	}
> +}
> +
>  #ifdef CONFIG_FTR_FIXUP_SELFTEST

...

No tests? :)

> diff --git a/include/asm-powerpc/synch.h b/include/asm-powerpc/synch.h
> index 42a1ef5..4737c61 100644
> --- a/include/asm-powerpc/synch.h
> +++ b/include/asm-powerpc/synch.h
> @@ -3,20 +3,37 @@
>  #ifdef __KERNEL__
>=20
>  #include <linux/stringify.h>
> +#include <asm/feature-fixups.h>
>=20
> -#if defined(__powerpc64__) || defined(CONFIG_PPC_E500MC)
> -#define __SUBARCH_HAS_LWSYNC
> -#endif
> +#ifndef __ASSEMBLY__
> +extern unsigned int __start___lwsync_fixup, __stop___lwsync_fixup;
> +extern void do_lwsync_fixups(unsigned long value, void *fixup_start,
> +			     void *fixup_end);
> +#endif /* __ASSEMBLY__ */
> +
> +#define START_LWSYNC_SECTION(label)	label##1:
> +#define MAKE_LWSYNC_SECTION_ENTRY(label, sect)		\
> +label##4:						\
> +	.pushsection sect,"a";				\
> +	.align 2;					\
> +label##5:					       	\
> +	.long label##1b-label##5b;			\
> +	.popsection;

I'd rather this was in feature-fixups.h, seeing as I just moved all the
feature-fixup related macros in there :)

It might make more sense to use label##2 and label##3.

>=20
> -#ifdef __SUBARCH_HAS_LWSYNC
> +#if defined(__powerpc64__)
>  #    define LWSYNC	lwsync
> +#elif defined(CONFIG_E500)
> +#    define LWSYNC					\
> +	START_LWSYNC_SECTION(97);			\
> +	sync;						\
> +	MAKE_LWSYNC_SECTION_ENTRY(97, __lwsync_fixup);
>  #else
>  #    define LWSYNC	sync
>  #endif

Using 97 means you can't nest an LWSYNC inside a feature or firmware
feature section, if you use say 96 then nesting should work.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-0qr8HO79Kqsye8rMDkPz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIac65dSjSd0sB4dIRAu5LAJ4nj47Mk19mS+lRITxzvBsB7qOgggCffsu+
vJndtHPcp+0DpVEKI8Bcrjk=
=GMRF
-----END PGP SIGNATURE-----

--=-0qr8HO79Kqsye8rMDkPz--

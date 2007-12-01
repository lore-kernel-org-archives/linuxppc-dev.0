Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [POWERPC] Add machine initcall macros
From: Michael Ellerman <michael@ellerman.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20071201002437.22923.31304.stgit@trillian.secretlab.ca>
References: <20071201002437.22923.31304.stgit@trillian.secretlab.ca>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-XKFvEQDR3gH0MtNa16WF"
Date: Sat, 01 Dec 2007 18:11:07 +1100
Message-Id: <1196493067.17582.7.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, olof@lixom.net
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-XKFvEQDR3gH0MtNa16WF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-11-30 at 17:24 -0700, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>=20
> The machine initcall macros allow initcalls to be registered which
> test machine_is() before executing the initcall.
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>=20
> Ben, is this the sort of thing you're considering?
>=20
> g.
>=20
>  include/asm-powerpc/machdep.h |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
>=20
> diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.=
h
> index 6968f43..f24af06 100644
> --- a/include/asm-powerpc/machdep.h
> +++ b/include/asm-powerpc/machdep.h
> @@ -326,5 +326,24 @@ static inline void log_error(char *buf, unsigned int=
 err_type, int fatal)
>  		ppc_md.log_error(buf, err_type, fatal);
>  }
> =20
> +#define __define_machine_initcall(mach,level,fn,id) \
> +	static int __init __machine_initcall_##mach##_##fn(void) { \
> +		if (machine_is(mach)) return fn(); \
> +		return 0; \
> +	} \
> +	__define_initcall(level,__machine_initcall_##mach##_##fn,id);
> +
> +#define machine_arch_initcall(mach,fn)		__define_machine_initcall(mach,"=
3",fn,3)
> +#define machine_arch_initcall_sync(mach,fn)	__define_machine_initcall(ma=
ch,"3s",fn,3s)
> +#define machine_subsys_initcall(mach,fn)	__define_machine_initcall(mach,=
"4",fn,4)
> +#define machine_subsys_initcall_sync(mach,fn)	__define_machine_initcall(=
mach,"4s",fn,4s)
> +#define machine_fs_initcall(mach,fn)		__define_machine_initcall(mach,"5"=
,fn,5)
> +#define machine_fs_initcall_sync(mach,fn)	__define_machine_initcall(mach=
,"5s",fn,5s)
> +#define machine_rootfs_initcall(mach,fn)	__define_machine_initcall(mach,=
"rootfs",fn,rootfs)
> +#define machine_device_initcall(mach,fn)	__define_machine_initcall(mach,=
"6",fn,6)
> +#define machine_device_initcall_sync(mach,fn)	__define_machine_initcall(=
mach,"6s",fn,6s)
> +#define machine_late_initcall(mach,fn)		__define_machine_initcall(mach,"=
7",fn,7)
> +#define machine_late_initcall_sync(mach,fn)	__define_machine_initcall(ma=
ch,"7s",fn,7s)

I can't think at the moment, it's Saturday, but is there some way we
could just make it a wrapper macro, so we don't need to redefine - and
keep in sync - all the different init call types?

So the usage would look something like:

arch_initcall(machine_initcall(foo, bar));

or=20

machine_initcall(foo, arch_initcall(bar));

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-XKFvEQDR3gH0MtNa16WF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHUQkLdSjSd0sB4dIRAkxKAKCvyKV0+Nckh6QtUhv3RP3PuThr9wCfaUW7
ngun4GJ3Na2Hey+b0ZYBPTQ=
=Hl4A
-----END PGP SIGNATURE-----

--=-XKFvEQDR3gH0MtNa16WF--

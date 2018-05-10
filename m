Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hDLc13VrzF2RP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 10:17:12 +1000 (AEST)
Date: Thu, 10 May 2018 10:17:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the powerpc tree with the powerpc-fixes
 tree
Message-ID: <20180510101703.57ffb774@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/P+vlI.MpA0A+.dhb42QwUz5"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/P+vlI.MpA0A+.dhb42QwUz5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  arch/powerpc/include/asm/ftrace.h

between commit:

  edf6a2dfe388 ("powerpc/trace/syscalls: Update syscall name matching logic=
 to account for ppc_ prefix")

from the powerpc-fixes tree and commit:

  c3e59d778403 ("powerpc64/ftrace: Rearrange #ifdef sections in ftrace.h")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

Michael, I think the version in your merge branch is not quite right ...
--=20
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/include/asm/ftrace.h
index b2dabd06659d,fc3a2203c566..000000000000
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@@ -66,35 -62,39 +62,54 @@@ struct dyn_arch_ftrace=20
  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
  #define ARCH_SUPPORTS_FTRACE_OPS 1
  #endif
- #endif
+ #endif /* CONFIG_FUNCTION_TRACER */
 =20
- #if defined(CONFIG_FTRACE_SYSCALLS) && !defined(__ASSEMBLY__)
+ #ifndef __ASSEMBLY__
 -#if defined(CONFIG_FTRACE_SYSCALLS) && defined(PPC64_ELF_ABI_v1)
++#if defined(CONFIG_FTRACE_SYSCALLS)
 +/*
 + * Some syscall entry functions on powerpc start with "ppc_" (fork and cl=
one,
 + * for instance) or ppc32_/ppc64_. We should also match the sys_ variant =
with
 + * those.
 + */
  #define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
 +#ifdef PPC64_ELF_ABI_v1
  static inline bool arch_syscall_match_sym_name(const char *sym, const cha=
r *name)
  {
 -	/*
 -	 * Compare the symbol name with the system call name. Skip the .sys or .=
SyS
 -	 * prefix from the symbol name and the sys prefix from the system call n=
ame and
 -	 * just match the rest. This is only needed on ppc64 since symbol names =
on
 -	 * 32bit do not start with a period so the generic function will work.
 -	 */
 -	return !strcmp(sym + 4, name + 3);
 +	/* We need to skip past the initial dot, and the __se_sys alias */
 +	return !strcmp(sym + 1, name) ||
 +		(!strncmp(sym, ".__se_sys", 9) && !strcmp(sym + 6, name)) ||
 +		(!strncmp(sym, ".ppc_", 5) && !strcmp(sym + 5, name + 4)) ||
 +		(!strncmp(sym, ".ppc32_", 7) && !strcmp(sym + 7, name + 4)) ||
 +		(!strncmp(sym, ".ppc64_", 7) && !strcmp(sym + 7, name + 4));
  }
 -#endif /* CONFIG_FTRACE_SYSCALLS && PPC64_ELF_ABI_v1 */
 +#else
 +static inline bool arch_syscall_match_sym_name(const char *sym, const cha=
r *name)
 +{
 +	return !strcmp(sym, name) ||
 +		(!strncmp(sym, "__se_sys", 8) && !strcmp(sym + 5, name)) ||
 +		(!strncmp(sym, "ppc_", 4) && !strcmp(sym + 4, name + 4)) ||
 +		(!strncmp(sym, "ppc32_", 6) && !strcmp(sym + 6, name + 4)) ||
 +		(!strncmp(sym, "ppc64_", 6) && !strcmp(sym + 6, name + 4));
 +}
- #endif
- #endif /* CONFIG_FTRACE_SYSCALLS && !__ASSEMBLY__ */
++#endif /* PPC64_ELF_ABI_v1 */
++#endif /* CONFIG_FTRACE_SYSCALLS */
+=20
+ #ifdef CONFIG_PPC64
+ #include <asm/paca.h>
+=20
+ static inline void this_cpu_disable_ftrace(void)
+ {
+ 	get_paca()->ftrace_enabled =3D 0;
+ }
+=20
+ static inline void this_cpu_enable_ftrace(void)
+ {
+ 	get_paca()->ftrace_enabled =3D 1;
+ }
+ #else /* CONFIG_PPC64 */
+ static inline void this_cpu_disable_ftrace(void) { }
+ static inline void this_cpu_enable_ftrace(void) { }
+ #endif /* CONFIG_PPC64 */
+ #endif /* !__ASSEMBLY__ */
 =20
  #endif /* _ASM_POWERPC_FTRACE */

--Sig_/P+vlI.MpA0A+.dhb42QwUz5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrzj38ACgkQAVBC80lX
0GxK/gf+LcQqTZpLp+78Kev/k7kNL5Fsk+clmLo0tLX+jorszBo+IGLtXmz8ravq
D0Dvv5oEwVe2RHAvEtJs446JMUG7CBsPhKdhHhvEnmkCndS5jxICcmbx+Uv7qfFw
29PGLV5Wen+xC9gKyFoCZeOKiKlEGGip5TM6IS1C3MX2HLjJNsQkeA6V46Z60vpD
N4ujC7kfYI+SYQJXjyDFUMrI3YiVfuyHc0hBaYQefKa0tUEwT2Qnz7Y25dnMUgVc
y8Q82aJQk9Si6SOZ6vPnpCyClduHUGqppSO281+7mEL3Xkyv0OH/L2nY+MHei499
1fthgKtZMTvrQL/myrTAILE7KFfCWA==
=9WNU
-----END PGP SIGNATURE-----

--Sig_/P+vlI.MpA0A+.dhb42QwUz5--

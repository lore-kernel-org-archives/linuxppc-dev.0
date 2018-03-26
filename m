Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4099086KnqzF27D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 10:12:24 +1100 (AEDT)
Date: Tue, 27 Mar 2018 10:11:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Paul Mackerras <paulus@ozlabs.org>
Subject: linux-next: manual merge of the powerpc tree with the powerpc-fixes
 tree
Message-ID: <20180327101125.145e4dc5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WD67ZlZokXL67XNA7GOI/8M"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/WD67ZlZokXL67XNA7GOI/8M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  arch/powerpc/include/asm/cputable.h
  arch/powerpc/kernel/dt_cpu_ftrs.c

between commit:

  a5d4b5891c2f ("powerpc/mm: Fixup tlbie vs store ordering issue on POWER9")

from the powerpc-fixes tree and commits:

  9bbf0b576d32 ("powerpc: Free up CPU feature bits on 64-bit machines")
  b5af4f279323 ("powerpc: Add CPU feature bits for TM bug workarounds on PO=
WER9 v2.2")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/include/asm/cputable.h
index 2e2bacbdf6ed,ecee84dea7e7..000000000000
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@@ -174,38 -181,40 +181,41 @@@ static inline void cpu_feature_keys_ini
  #define LONG_ASM_CONST(x)		0
  #endif
 =20
- #define CPU_FTR_HVMODE			LONG_ASM_CONST(0x0000000100000000)
- #define CPU_FTR_ARCH_201		LONG_ASM_CONST(0x0000000200000000)
- #define CPU_FTR_ARCH_206		LONG_ASM_CONST(0x0000000400000000)
- #define CPU_FTR_ARCH_207S		LONG_ASM_CONST(0x0000000800000000)
- #define CPU_FTR_ARCH_300		LONG_ASM_CONST(0x0000001000000000)
- #define CPU_FTR_MMCRA			LONG_ASM_CONST(0x0000002000000000)
- #define CPU_FTR_CTRL			LONG_ASM_CONST(0x0000004000000000)
- #define CPU_FTR_SMT			LONG_ASM_CONST(0x0000008000000000)
- #define CPU_FTR_PAUSE_ZERO		LONG_ASM_CONST(0x0000010000000000)
- #define CPU_FTR_PURR			LONG_ASM_CONST(0x0000020000000000)
- #define CPU_FTR_CELL_TB_BUG		LONG_ASM_CONST(0x0000040000000000)
- #define CPU_FTR_SPURR			LONG_ASM_CONST(0x0000080000000000)
- #define CPU_FTR_DSCR			LONG_ASM_CONST(0x0000100000000000)
- #define CPU_FTR_VSX			LONG_ASM_CONST(0x0000200000000000)
- #define CPU_FTR_SAO			LONG_ASM_CONST(0x0000400000000000)
- #define CPU_FTR_CP_USE_DCBTZ		LONG_ASM_CONST(0x0000800000000000)
- #define CPU_FTR_UNALIGNED_LD_STD	LONG_ASM_CONST(0x0001000000000000)
- #define CPU_FTR_ASYM_SMT		LONG_ASM_CONST(0x0002000000000000)
- #define CPU_FTR_STCX_CHECKS_ADDRESS	LONG_ASM_CONST(0x0004000000000000)
- #define CPU_FTR_POPCNTB			LONG_ASM_CONST(0x0008000000000000)
- #define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0010000000000000)
- #define CPU_FTR_PKEY			LONG_ASM_CONST(0x0020000000000000)
- #define CPU_FTR_VMX_COPY		LONG_ASM_CONST(0x0040000000000000)
- #define CPU_FTR_TM			LONG_ASM_CONST(0x0080000000000000)
- #define CPU_FTR_CFAR			LONG_ASM_CONST(0x0100000000000000)
- #define	CPU_FTR_HAS_PPR			LONG_ASM_CONST(0x0200000000000000)
- #define CPU_FTR_DAWR			LONG_ASM_CONST(0x0400000000000000)
- #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
- #define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
- #define CPU_FTR_P9_TLBIE_BUG		LONG_ASM_CONST(0x2000000000000000)
- #define CPU_FTR_POWER9_DD1		LONG_ASM_CONST(0x4000000000000000)
- #define CPU_FTR_POWER9_DD2_1		LONG_ASM_CONST(0x8000000000000000)
+ #define CPU_FTR_REAL_LE			LONG_ASM_CONST(0x0000000000001000)
+ #define CPU_FTR_HVMODE			LONG_ASM_CONST(0x0000000000002000)
+ #define CPU_FTR_ARCH_201		LONG_ASM_CONST(0x0000000000004000)
+ #define CPU_FTR_ARCH_206		LONG_ASM_CONST(0x0000000000008000)
+ #define CPU_FTR_ARCH_207S		LONG_ASM_CONST(0x0000000000010000)
+ #define CPU_FTR_ARCH_300		LONG_ASM_CONST(0x0000000000020000)
+ #define CPU_FTR_MMCRA			LONG_ASM_CONST(0x0000000000040000)
+ #define CPU_FTR_CTRL			LONG_ASM_CONST(0x0000000000080000)
+ #define CPU_FTR_SMT			LONG_ASM_CONST(0x0000000000100000)
+ #define CPU_FTR_PAUSE_ZERO		LONG_ASM_CONST(0x0000000000200000)
+ #define CPU_FTR_PURR			LONG_ASM_CONST(0x0000000000400000)
+ #define CPU_FTR_CELL_TB_BUG		LONG_ASM_CONST(0x0000000000800000)
+ #define CPU_FTR_SPURR			LONG_ASM_CONST(0x0000000001000000)
+ #define CPU_FTR_DSCR			LONG_ASM_CONST(0x0000000002000000)
+ #define CPU_FTR_VSX			LONG_ASM_CONST(0x0000000004000000)
+ #define CPU_FTR_SAO			LONG_ASM_CONST(0x0000000008000000)
+ #define CPU_FTR_CP_USE_DCBTZ		LONG_ASM_CONST(0x0000000010000000)
+ #define CPU_FTR_UNALIGNED_LD_STD	LONG_ASM_CONST(0x0000000020000000)
+ #define CPU_FTR_ASYM_SMT		LONG_ASM_CONST(0x0000000040000000)
+ #define CPU_FTR_STCX_CHECKS_ADDRESS	LONG_ASM_CONST(0x0000000080000000)
+ #define CPU_FTR_POPCNTB			LONG_ASM_CONST(0x0000000100000000)
+ #define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0000000200000000)
+ #define CPU_FTR_PKEY			LONG_ASM_CONST(0x0000000400000000)
+ #define CPU_FTR_VMX_COPY		LONG_ASM_CONST(0x0000000800000000)
+ #define CPU_FTR_TM			LONG_ASM_CONST(0x0000001000000000)
+ #define CPU_FTR_CFAR			LONG_ASM_CONST(0x0000002000000000)
+ #define	CPU_FTR_HAS_PPR			LONG_ASM_CONST(0x0000004000000000)
+ #define CPU_FTR_DAWR			LONG_ASM_CONST(0x0000008000000000)
+ #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0000010000000000)
+ #define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x0000020000000000)
+ #define CPU_FTR_POWER9_DD1		LONG_ASM_CONST(0x0000040000000000)
+ #define CPU_FTR_POWER9_DD2_1		LONG_ASM_CONST(0x0000080000000000)
+ #define CPU_FTR_P9_TM_HV_ASSIST		LONG_ASM_CONST(0x0000100000000000)
+ #define CPU_FTR_P9_TM_XER_SO_BUG	LONG_ASM_CONST(0x0000200000000000)
++#define CPU_FTR_P9_TLBIE_BUG		LONG_ASM_CONST(0x0000400000000000)
 =20
  #ifndef __ASSEMBLY__
 =20
diff --cc arch/powerpc/kernel/dt_cpu_ftrs.c
index 8ca5d5b74618,0a0c601c6ade..000000000000
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@@ -709,9 -710,9 +710,12 @@@ static __init void cpufeatures_cpu_quir
  		cur_cpu_spec->cpu_features |=3D CPU_FTR_POWER9_DD1;
  	else if ((version & 0xffffefff) =3D=3D 0x004e0201)
  		cur_cpu_spec->cpu_features |=3D CPU_FTR_POWER9_DD2_1;
+ 	else if ((version & 0xffffefff) =3D=3D 0x004e0202)
+ 		cur_cpu_spec->cpu_features |=3D CPU_FTR_P9_TM_HV_ASSIST |
+ 			CPU_FTR_P9_TM_XER_SO_BUG;
 +
 +	if ((version & 0xffff0000) =3D=3D 0x004e0000)
 +		cur_cpu_spec->cpu_features |=3D CPU_FTR_P9_TLBIE_BUG;
  }
 =20
  static void __init cpufeatures_setup_finished(void)

--Sig_/WD67ZlZokXL67XNA7GOI/8M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq5fh0ACgkQAVBC80lX
0GxWPggAmZPYs85ShmegxV2eibDw7nAqp0d4Itu1A8+iBeFZwKnVHPXFo7rVQaxD
SOwQrhaF82LF6GZIdBHeDRJsnurIzTMyWMsaMxQmRFhJwpGDLpA2yeL4uWxiA6FQ
OoFxFsR162ToLjIsKxDu7meu+I2EJ/OjSHGW+uDv62q3fKizwNdtjGn7weoDZ+Nt
Aop61npnDca8x3lneyhJ1jKatP5q/tzbIEEwxVfd1nHHMmL4+Wxpp3iKQSzc+Zeo
R55CgZJ9d1wUOXSP9LZLpsqsrNxH6TGDHHelHCK6PK2MiPKu1EHyBk35RfkKQiA1
RsYVEL8B4FV0HLqXuJu3GHPYuNShmA==
=GXzT
-----END PGP SIGNATURE-----

--Sig_/WD67ZlZokXL67XNA7GOI/8M--

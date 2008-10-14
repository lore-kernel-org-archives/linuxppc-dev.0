Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6F3D2DDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 15:42:23 +1100 (EST)
Date: Tue, 14 Oct 2008 15:24:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: linux-next: manual merge of the tip-core tree
Message-Id: <20081014152447.bc21965d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__14_Oct_2008_15_24_47_+1100_ENoqJd3NqIl5D9I2"
Cc: Benjamin, Jeremy Fitzhardinge <jeremy@goop.org>, Becky,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__14_Oct_2008_15_24_47_+1100_ENoqJd3NqIl5D9I2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip-core tree got a conflict in
arch/powerpc/include/asm/types.h between commit
b9579689ad3a208c342aed806afc7a9a808c4e1e ("powerpc: Make dma_addr_t a u64
if CONFIG_PHYS_64BIT is set") from the powerpc tree and commit
600715dcdf567c86f8b2c6173fcfb4b873e25a19 ("generic: add phys_addr_t for
holding physical addresses") from the tip-core tree.

Just a context clash.  I fixed it up (see below) and can carry the fix.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --cc arch/powerpc/include/asm/types.h
index a9a9262,c646f34..0000000
--- a/arch/powerpc/include/asm/types.h
+++ b/arch/powerpc/include/asm/types.h
@@@ -48,14 -48,7 +48,7 @@@ typedef struct=20
 =20
  typedef __vector128 vector128;
 =20
- /* Physical address used by some IO functions */
- #if defined(CONFIG_PPC64) || defined(CONFIG_PHYS_64BIT)
- typedef u64 phys_addr_t;
- #else
- typedef u32 phys_addr_t;
- #endif
-=20
 -#ifdef __powerpc64__
 +#if defined(__powerpc64__) || defined(CONFIG_PHYS_64BIT)
  typedef u64 dma_addr_t;
  #else
  typedef u32 dma_addr_t;


--Signature=_Tue__14_Oct_2008_15_24_47_+1100_ENoqJd3NqIl5D9I2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkj0Hw8ACgkQjjKRsyhoI8xzHgCfSg8Hdh3Z2s3RSNByfHQxg/s/
M/gAoJGDEiPpONFxNzZlImXaplAdAb7C
=W/b2
-----END PGP SIGNATURE-----

--Signature=_Tue__14_Oct_2008_15_24_47_+1100_ENoqJd3NqIl5D9I2--

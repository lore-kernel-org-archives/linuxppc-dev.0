Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 056981A024F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 12:04:57 +1000 (EST)
Date: Thu, 29 May 2014 12:04:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>, Alexander Graf <agraf@suse.de>
Subject: linux-next: manual merge of the powerpc tree with Linus' tree
Message-ID: <20140529120448.1a90dd4a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_a/MzqsLpGCnGLvuqYeSMEw"; protocol="application/pgp-signature"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/_a/MzqsLpGCnGLvuqYeSMEw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in
arch/powerpc/include/asm/sections.h between commit b18db0b80867 ("KVM
guest: Make pv trampoline code executable") from the  tree and commit
07de8377f748 ("powerpc: Fix ABIv2 issue with
dereference_function_descriptor") from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc arch/powerpc/include/asm/sections.h
index 521790330672,d1bb96d5a298..000000000000
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@@ -39,17 -39,7 +39,18 @@@ static inline int overlaps_kernel_text(
  		(unsigned long)_stext < end;
  }
 =20
 +static inline int overlaps_kvm_tmp(unsigned long start, unsigned long end)
 +{
 +#ifdef CONFIG_KVM_GUEST
 +	extern char kvm_tmp[];
 +	return start < (unsigned long)kvm_tmp &&
 +		(unsigned long)&kvm_tmp[1024 * 1024] < end;
 +#else
 +	return 0;
 +#endif
 +}
 +
+ #if !defined(_CALL_ELF) || _CALL_ELF !=3D 2
  #undef dereference_function_descriptor
  static inline void *dereference_function_descriptor(void *ptr)
  {

--Sig_/_a/MzqsLpGCnGLvuqYeSMEw
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJThpXEAAoJEMDTa8Ir7ZwVN5EP/1a/1IkrYVfT47a2v1PZGbNA
2pBoYeuuXU4Cq7qYlQ6sdhhudWyyNSYXJzdyM/Vz2sX5eu7gqEIzAXj5V/BBud7a
LOGL6mfZ+7MKG15IXAr84ZuwFyVDew/AvSrsIo3pdiQtkw/zLZvXiIDd/eYXJcTH
ottaAn1Grk++xl+6sQa8G+/kVYhWA/jveaABPAFFuevZsPVvLRW52m20F6Zkddem
1YzqC5nN4ScpjPgghB6lwXKOlJG8VxcyBEoj8i8lQYRJq037c4MjsVaTF1rZUPSV
qRZhkQDfSXwOMzW2xTOgl8SSt5iWn/BqfpWEutgi6maB+gBqBmWH8VQIvi63Nkqd
EQkJ3++C7To8Keh3GfJ+OFy71eFg7vp6e1D+kmKu5IqXdS35d/Mkpu47QWXgojF4
0sqDgiqmeqadAiskss9T3AgYvz7wvbb7nryJiV5jcAw4fnOwsV/XmoFl81uPhfFx
l3ILsyBDrFJtR/3Di45PCEoh28GodnqCWYw9ahPGd2tYSrrpOwoLj5nXnv4/Z8Bm
V26W0XAHS9s931mFGomuhAMXE0DS7SPJZKIUej+JMJl9qhZ5naTIk0yc9sqaJGBs
ttVLoIuI07SgzMhqNJKQEk7h8NuGmxnR6e+j8AInH27hcBcB94BqNWpEjSD7CKiR
CK9Ta9lsRVvUGdkQsgUC
=6Ln7
-----END PGP SIGNATURE-----

--Sig_/_a/MzqsLpGCnGLvuqYeSMEw--

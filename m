Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id F4049B6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2012 15:22:34 +1100 (EST)
Date: Fri, 16 Mar 2012 15:19:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/5] init: remove CONFIG_PPC_ISERIES
Message-Id: <20120316151908.e982ce41d848c2b2a4bc045f@canb.auug.org.au>
In-Reply-To: <20120316151459.dab3cdcc2d5984b05e2d2b5c@canb.auug.org.au>
References: <20120316151459.dab3cdcc2d5984b05e2d2b5c@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__16_Mar_2012_15_19_08_+1100__bNtYMZJkaVLtRLN"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__16_Mar_2012_15_19_08_+1100__bNtYMZJkaVLtRLN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It is no longer selectable, so remove the check for it.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 init/do_mounts_rd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 887629e..01f1306 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -178,7 +178,7 @@ int __init rd_load_image(char *from)
 	char *buf =3D NULL;
 	unsigned short rotate =3D 0;
 	decompress_fn decompressor =3D NULL;
-#if !defined(CONFIG_S390) && !defined(CONFIG_PPC_ISERIES)
+#if !defined(CONFIG_S390)
 	char rotator[4] =3D { '|' , '/' , '-' , '\\' };
 #endif
=20
@@ -264,7 +264,7 @@ int __init rd_load_image(char *from)
 		}
 		sys_read(in_fd, buf, BLOCK_SIZE);
 		sys_write(out_fd, buf, BLOCK_SIZE);
-#if !defined(CONFIG_S390) && !defined(CONFIG_PPC_ISERIES)
+#if !defined(CONFIG_S390)
 		if (!(i % 16)) {
 			printk("%c\b", rotator[rotate & 0x3]);
 			rotate++;
--=20
1.7.9.1

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__16_Mar_2012_15_19_08_+1100__bNtYMZJkaVLtRLN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPYr88AAoJEECxmPOUX5FE26kQAKAru4g7+e+btRLi2S0+2jvv
SqpBQO22lwNd7ww6IjL/5/EqFgRbVAu7S9Srdf/ffKO+tiluGsnbo4vple3YPWEi
Bd6zis3o31ULVbPIv+dIagWv9jgCeOgwfLnreOIN/CCR5P312g+BPSWtMKk0AEUn
eQrg71Qrkcwl/L+OkZxB4pxuNONJsxvZEcOSMYpSqrSWXiy8xvwzwty3gf4pcG3R
NqUUcY+dKB7fceASLzqVRfTUyO9xHXtFkSRmsW+ZWdA82P4Gud1e4TVru2bTWIJt
gE9FvPkL78GsNXlXLCWe56Zxlsg0nRIzIvivyGAv3ybSmipRrIoSYL8RvIQWxUto
CDSlq0bETpPEI7/mqZAGzLOODVpSRMTeZyFTCWdJYMui3yu4qVZZjC37AxqNstOS
Ks8+/nVX6I88zGEgvItoA/p7SXAbcZp/QpLIy+EYf/F64M0CTYgKaEa0FU5YU9kp
l5SjzldLB+KiWDI/vbXadLCeKAeM8Vv+u8NI6Oo4uXWzP+siTSU0Sf6memlv1G8x
UgEK5Ei+sjVmqT2PJ4o4uh0aFu6ojOuHKQxjBJHihGUpi+JBZjrvyM2ZkHnQEuGq
PyG51BvfLYmB0nj6d4fyxrF+LHt2QDkktXL2s+pcxHdKN78KRd8/o7AZ8VOqin9M
u/Qwd6Q6zwtwdlwNAB1w
=NWox
-----END PGP SIGNATURE-----

--Signature=_Fri__16_Mar_2012_15_19_08_+1100__bNtYMZJkaVLtRLN--

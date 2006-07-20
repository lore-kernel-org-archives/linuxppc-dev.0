Return-Path: <Geoffrey.Levand@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] clean up pseries hcall interfaces
Date: Thu, 20 Jul 2006 06:14:12 -0700
Message-ID: <591B6A09961C354991CD653B274DC8C2023662CB@ussdixms03.am.sony.com>
From: "Levand, Geoffrey" <Geoffrey.Levand@am.sony.com>
To: "Anton Blanchard " <anton@samba.org>,
	<linuxppc-dev-bounces+geoffrey.levand=am.sony.com@ozlabs.org>,
	<linuxppc-dev@ozlabs.org>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Anton Blanchard
>=20
> Our pseries hcall interfaces are out of control:

Seems like this in needed too...  Untested.



Change the scope of some pSeries routines now called through
ppc_md to static.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

--
Index: a/arch/powerpc/platforms/pseries/lpar.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a.orig/arch/powerpc/platforms/pseries/lpar.c	2006-07-18
12:37:47.000000000 -0700
+++ a/arch/powerpc/platforms/pseries/lpar.c	2006-07-20
05:18:59.000000000 -0700
@@ -268,7 +268,7 @@
 				cpu, hwcpu, vpa, ret);
 }
=20
-long pSeries_lpar_hpte_insert(unsigned long hpte_group,
+static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
  			      unsigned long va, unsigned long pa,
  			      unsigned long rflags, unsigned long
vflags,
  			      int psize)
@@ -494,7 +494,7 @@
  * Take a spinlock around flushes to avoid bouncing the hypervisor
tlbie
  * lock.
  */
-void pSeries_lpar_flush_hash_range(unsigned long number, int local)
+static void pSeries_lpar_flush_hash_range(unsigned long number, int
local)
 {
 	int i;
 	unsigned long flags =3D 0;

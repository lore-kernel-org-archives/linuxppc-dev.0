Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B049CDDF0F
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 15:42:49 +1000 (EST)
Date: Fri, 11 May 2007 15:42:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] trivial ps3 fixups
Message-Id: <20070511154244.34ad81e6.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__11_May_2007_15_42_44_+1000_346z8hBBk9WF7J08"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__11_May_2007_15_42_44_+1000_346z8hBBk9WF7J08
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Fixes warnings:

arch/powerpc/platforms/ps3/system-bus.c: In function 'ps3_map_sg':
arch/powerpc/platforms/ps3/system-bus.c:278: warning: unused variable 'i'
arch/powerpc/platforms/ps3/system-bus.c:277: warning: unused variable 'dev'
arch/powerpc/platforms/ps3/setup.c:103: warning: 'prealloc' defined but not used

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/ps3/setup.c      |    2 +-
 arch/powerpc/platforms/ps3/system-bus.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index c989493..9353967 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -99,6 +99,7 @@ static void ps3_panic(char *str)
 	while(1);
 }

+#ifdef CONFIG_FB_PS3
 static void prealloc(struct ps3_prealloc *p)
 {
 	if (!p->size)
@@ -115,7 +116,6 @@ static void prealloc(struct ps3_prealloc *p)
 	       p->address);
 }

-#ifdef CONFIG_FB_PS3
 struct ps3_prealloc ps3fb_videomemory = {
     .name = "ps3fb videomemory",
     .size = CONFIG_FB_PS3_DEFAULT_SIZE_M*1024*1024,
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 3c48cce..6bda510 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -274,13 +274,13 @@ static void ps3_unmap_single(struct device *_dev, dma_addr_t dma_addr,
 static int ps3_map_sg(struct device *_dev, struct scatterlist *sg, int nents,
 	enum dma_data_direction direction)
 {
-	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
-	int i;
-
 #if defined(CONFIG_PS3_DYNAMIC_DMA)
 	BUG_ON("do");
 	return -EPERM;
 #else
+	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
+	int i;
+
 	for (i = 0; i < nents; i++, sg++) {
 		int result = ps3_dma_map(dev->d_region,
 			page_to_phys(sg->page) + sg->offset, sg->length,
--
1.5.1.4


--Signature=_Fri__11_May_2007_15_42_44_+1000_346z8hBBk9WF7J08
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGRAJYFdBgD/zoJvwRAtdhAJ4x61LBSsWphcEy6QpbMjZ6YZd1OQCfdrJ0
rOGdWrlWNsuj1B9S7xoF+tc=
=5UFt
-----END PGP SIGNATURE-----

--Signature=_Fri__11_May_2007_15_42_44_+1000_346z8hBBk9WF7J08--

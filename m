Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1E0E167AC6
	for <linuxppc-dev@ozlabs.org>; Thu,  4 May 2006 13:49:21 +1000 (EST)
Date: Thu, 4 May 2006 13:47:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 3/4] powerpc: update iSeries vdevice
Message-Id: <20060504134747.0db5233b.sfr@canb.auug.org.au>
In-Reply-To: <20060504134650.7dd45964.sfr@canb.auug.org.au>
References: <20060504134544.2fc295db.sfr@canb.auug.org.au>
	<20060504134650.7dd45964.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make it look more like the pSeries vdevice tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/platforms/iseries/setup.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

e013355bd53f3f51101bc2c86fc082f02f2d0141
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 285f2b2..d3f94b4 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -921,13 +921,14 @@ void dt_vdevices(struct iseries_flat_dt 
 	char buf[32];
 
 	dt_start_node(dt, "vdevice");
+	dt_prop_str(dt, "device_type", "vdevice");
+	dt_prop_str(dt, "compatible", "IBM,iSeries-vdevice");
 	dt_prop_u32(dt, "#address-cells", 1);
 	dt_prop_u32(dt, "#size-cells", 0);
 
-	snprintf(buf, sizeof(buf), "viocons@%08x", reg);
+	snprintf(buf, sizeof(buf), "vty@%08x", reg);
 	dt_start_node(dt, buf);
 	dt_prop_str(dt, "device_type", "serial");
-	dt_prop_str(dt, "compatible", "");
 	dt_prop_u32(dt, "reg", reg);
 	dt_end_node(dt);
 	reg++;
-- 
1.3.1.ge923

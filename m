Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 14 Jan 2009 17:13:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [PATCH 13/13] powerpc/ps3: printing fixups for l64 to ll64
	conversion: drivers/video
Message-Id: <20090114171339.09faa843.sfr@canb.auug.org.au>
In-Reply-To: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
References: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Antonino, cbe-oss-dev@ozlabs.org,
	Daplas <adaplas@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/video/ps3fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Antonino, if it is OK with you, this could go in via the PowerPC tree.

diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index 38ac805..87f826e 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -1006,7 +1006,7 @@ static int ps3fb_xdr_settings(u64 xdr_lpar, struct device *dev)
 			__func__, status);
 		return -ENXIO;
 	}
-	dev_dbg(dev, "video:%p ioif:%lx lpar:%lx size:%lx\n",
+	dev_dbg(dev, "video:%p ioif:%lx lpar:%llx size:%lx\n",
 		ps3fb_videomemory.address, GPU_IOIF, xdr_lpar,
 		ps3fb_videomemory.size);
 
@@ -1133,7 +1133,7 @@ static int __devinit ps3fb_probe(struct ps3_system_bus_device *dev)
 			__func__, status);
 		goto err;
 	}
-	dev_dbg(&dev->core, "ddr:lpar:0x%lx\n", ddr_lpar);
+	dev_dbg(&dev->core, "ddr:lpar:0x%llx\n", ddr_lpar);
 
 	status = lv1_gpu_context_allocate(ps3fb.memory_handle, 0,
 					  &ps3fb.context_handle,
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

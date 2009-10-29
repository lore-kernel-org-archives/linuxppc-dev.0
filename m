Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 2AB34B7C04
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Oct 2009 03:50:45 +1100 (EST)
Date: Thu, 29 Oct 2009 19:50:43 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] USB: fsl_udc_core: Fix kernel oops on module removal
Message-ID: <20091029165043.GA20612@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <lg@denx.de>,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

fsl_udc_release() calls dma_free_coherent() with an inappropriate
device passed to it, and since the device has no dma_ops, the following
oops pops up:

  Kernel BUG at d103ce9c [verbose debug info unavailable]
  Oops: Exception in kernel mode, sig: 5 [#1]
  ...
  NIP [d103ce9c] fsl_udc_release+0x50/0x80 [fsl_usb2_udc]
  LR [d103ce74] fsl_udc_release+0x28/0x80 [fsl_usb2_udc]
  Call Trace:
  [cfbc7dc0] [d103ce74] fsl_udc_release+0x28/0x80 [fsl_usb2_udc]
  [cfbc7dd0] [c01a35c4] device_release+0x2c/0x90
  [cfbc7de0] [c016b480] kobject_cleanup+0x58/0x98
  [cfbc7e00] [c016c52c] kref_put+0x54/0x6c
  [cfbc7e10] [c016b360] kobject_put+0x34/0x64
  [cfbc7e20] [c01a1d0c] put_device+0x1c/0x2c
  [cfbc7e30] [d103dbfc] fsl_udc_remove+0xc0/0x1e4 [fsl_usb2_udc]
  ...

This patch fixes the issue by passing dev->parent, which points to
a correct device.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/usb/gadget/fsl_udc_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 42a74b8..fa3d142 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -2139,7 +2139,7 @@ static int fsl_proc_read(char *page, char **start, off_t off, int count,
 static void fsl_udc_release(struct device *dev)
 {
 	complete(udc_controller->done);
-	dma_free_coherent(dev, udc_controller->ep_qh_size,
+	dma_free_coherent(dev->parent, udc_controller->ep_qh_size,
 			udc_controller->ep_qh, udc_controller->ep_qh_dma);
 	kfree(udc_controller);
 }
-- 
1.6.3.3

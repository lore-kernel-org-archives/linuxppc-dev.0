Return-Path: <mylinux@10.ap.freescale.net>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9CCCDB6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Sep 2011 19:56:26 +1000 (EST)
From: Liu Gang <Gang.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] fsl-rio: Release rapidio port I/O region resource if port
	failed to initialize
Date: Thu, 1 Sep 2011 17:52:24 +0800
Message-ID: <1314870744-27325-1-git-send-email-Gang.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: r58472@freescale.com, r61911@freescale.com, linux-kernel@vger.kernel.org,
	Liu Gang <Gang.Liu@freescale.com>, akpm@linux-foundation.org,
	B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The "struct rio_mport" contains a member of master port I/O memory resource structure
"struct resource iores". This resource will be read from device tree and be used for
rapidio R/W transaction memory space. Rapidio requests the port I/O memory resource
under the root resource "iomem_resource".
			
			struct rio_mport *port;
			port = kzalloc(sizeof(struct rio_mport), GFP_KERNEL);

			request_resource(&iomem_resource, &port->iores);

When port failed to initialize, allocated "rio_mport" structure memory will be freed,
and the port I/O memory resource structure pointer "&port->iores" will be invalid. If
other requests resource under "iomem_resource", "&port->iores" node may be operated in
the child resources list and this will cause the system to crash.

So the requested port I/O memory resource should be released before freeing allocated
"rio_mport" structure.

Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
---
 arch/powerpc/sysdev/fsl_rio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index c65f75a..22ffccd 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -1608,6 +1608,7 @@ int fsl_rio_setup(struct platform_device *dev)
 	return 0;
 err:
 	iounmap(priv->regs_win);
+	release_resource(&port->iores);
 err_res:
 	kfree(priv);
 err_priv:
-- 
1.7.3.1

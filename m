Return-Path: <SRS0=lOLd=5O=de.ibm.com=abergman@srs.kundenserver.de>
Message-Id: <20060323203523.069903000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Date: Thu, 23 Mar 2006 00:00:13 +0100
From: Arnd Bergmann <abergman@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 13/13] spufs: initialize context correctly
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

the mfc member of a new context was not initialized to zero,
which potentially leads to wild memory accesses.

From: Dirk Herrendoerfer <herrendo@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/context.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/spufs/context.c
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/context.c
@@ -51,6 +51,7 @@ struct spu_context *alloc_spu_context(vo
 	ctx->ibox_fasync = NULL;
 	ctx->wbox_fasync = NULL;
 	ctx->mfc_fasync = NULL;
+	ctx->mfc = NULL;
 	ctx->tagwait = 0;
 	ctx->state = SPU_STATE_SAVED;
 	ctx->local_store = NULL;

--

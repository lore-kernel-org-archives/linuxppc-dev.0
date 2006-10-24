Return-Path: <arnd@arndb.de>
Message-Id: <200610241827.31835.arnd@arndb.de>
References: <20061024160140.452484000@arndb.de>
Date: Tue, 24 Oct 2006 18:27:30 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/3] spufs: fix signal2 file to report signal2
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	Dwayne Grant Mcconnell <decimal@us.ibm.com>,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Dwayne Grant Mcconnell <decimal@us.ibm.com>

Here is a simple patch that fixes the /signal2 file to actually give
signal2 data.

Signed-off-by: Dwayne Grant Mcconnell <decimal@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/hw_ops.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/hw_ops.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/hw_ops.c
@@ -147,7 +147,7 @@ static void spu_hw_signal1_write(struct 
 
 static u32 spu_hw_signal2_read(struct spu_context *ctx)
 {
-	return in_be32(&ctx->spu->problem->signal_notify1);
+	return in_be32(&ctx->spu->problem->signal_notify2);
 }
 
 static void spu_hw_signal2_write(struct spu_context *ctx, u32 data)

--

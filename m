Return-Path: <arnd@arndb.de>
Message-Id: <20061120180525.031590000@arndb.de>
References: <20061120174454.067872000@arndb.de>
Date: Mon, 20 Nov 2006 18:45:07 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: [PATCH 13/22] spufs: fix return value of spufs_mfc_write
Cc: Masato Noguchi <Masato.Noguchi@jp.sony.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Masato Noguchi <Masato.Noguchi@jp.sony.com>
This patch changes spufs_mfc_write() to return
correct size instead of 0.

Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
 arch/powerpc/platforms/cell/spufs/file.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.19-rc6-arnd1/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.19-rc6-arnd1.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6.19-rc6-arnd1/arch/powerpc/platforms/cell/spufs/file.c
@@ -1325,6 +1325,7 @@ static ssize_t spufs_mfc_write(struct fi
 		goto out;
 
 	ctx->tagwait |= 1 << cmd.tag;
+	ret = size;
 
 out:
 	return ret;

_______________________________________________
cbe-oss-dev mailing list
cbe-oss-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/cbe-oss-dev

--

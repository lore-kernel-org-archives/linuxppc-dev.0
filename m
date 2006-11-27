Return-Path: <arnd@arndb.de>
Message-Id: <20061127182430.020713000@arndb.de>
References: <20061127181851.796747000@arndb.de>
Date: Mon, 27 Nov 2006 19:18:54 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: [POWERPC 3/9] spufs: we should only execute init_spu_base on cell
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>


diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index 841ed35..bd7bffc 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -663,6 +663,9 @@ static int __init init_spu_base(void)
 {
 	int i, ret;
 
+	if (!spu_management_ops)
+		return 0;
+
 	/* create sysdev class for spus */
 	ret = sysdev_class_register(&spu_sysdev_class);
 	if (ret)
-- 
1.4.4

--

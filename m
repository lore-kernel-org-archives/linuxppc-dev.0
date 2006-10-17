Return-Path: <randy.dunlap@oracle.com>
Received: from rgminet02.oracle.com (rgminet02.oracle.com [148.87.113.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C62FD67BCC
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 05:54:53 +1000 (EST)
Received: from rgminet01.oracle.com (rgminet01.oracle.com [148.87.113.118])
	by rgminet02.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id
	k9HGmpkb025533
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 10:48:51 -0600
Date: Tue, 17 Oct 2006 09:47:42 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] ramdisk: make powerpc allmodconfig build
Message-Id: <20061017094742.a61c4873.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix build error for allmodconfig on powerpc:
arch/powerpc/platforms/built-in.o:(.toc+0x10b0): undefined reference to `rd_size'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/powerpc/platforms/iseries/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2619-rc2-pv.orig/arch/powerpc/platforms/iseries/setup.c
+++ linux-2619-rc2-pv/arch/powerpc/platforms/iseries/setup.c
@@ -295,7 +295,7 @@ static void __init iSeries_init_early(vo
 {
 	DBG(" -> iSeries_init_early()\n");
 
-#if defined(CONFIG_BLK_DEV_INITRD)
+#if defined(CONFIG_BLK_DEV_INITRD) && defined(CONFIG_BLK_DEV_RAM)
 	/*
 	 * If the init RAM disk has been configured and there is
 	 * a non-zero starting address for it, set it up


---
---
~Randy

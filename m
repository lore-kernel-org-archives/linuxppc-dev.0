Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id 4A34167EBE
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 07:01:09 +1100 (EST)
Received: from mail3.sony.co.jp (localhost [127.0.0.1])
	by mail3.sony.co.jp (R8/Sony) with ESMTP id kAAK17bC015319
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:01:07 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail3.sony.co.jp (R8/Sony) with SMTP id kAAK17l5015309
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:01:07 +0900 (JST)
Message-ID: <4554DA7E.8090700@am.sony.com>
Date: Fri, 10 Nov 2006 12:01:02 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/16] powerpc: check for null init_early routine
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a check for a null ppc_md.init_early to allow platforms that
don't require an init_early routine to just set this member to null.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/kernel/setup_64.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: cell--common--6/arch/powerpc/kernel/setup_64.c
===================================================================
--- cell--common--6.orig/arch/powerpc/kernel/setup_64.c
+++ cell--common--6/arch/powerpc/kernel/setup_64.c
@@ -392,7 +392,8 @@
 	 * setting up the hash table pointers. It also sets up some interrupt-mapping
 	 * related options that will be used by finish_device_tree()
 	 */
-	ppc_md.init_early();
+	if (ppc_md.init_early)
+		ppc_md.init_early();
 
  	/*
 	 * We can discover serial ports now since the above did setup the

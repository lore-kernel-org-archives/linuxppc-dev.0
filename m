Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A9037DDEBA
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 04:55:44 +1000 (EST)
Message-ID: <466EEBFD.9080908@am.sony.com>
Date: Tue, 12 Jun 2007 11:54:53 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 28/30] powerpc: Bootwrapper global scope kernel_entry_t.
References: <20070612181825.730300780@am.sony.com>>
In-Reply-To: <20070612181825.730300780@am.sony.com>>
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

For the convenience of custom platform code make the powerpc
bootwrapper typdef kernel_entry_t global in scope.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/boot/main.c |    2 --
 arch/powerpc/boot/ops.h  |    2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -36,8 +36,6 @@ struct addr_range {
 	unsigned long size;
 };
 
-typedef void (*kernel_entry_t)(unsigned long, unsigned long, void *);
-
 #undef DEBUG
 
 static struct addr_range prep_kernel(void)
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -19,6 +19,8 @@
 #define	MAX_PATH_LEN		256
 #define	MAX_PROP_LEN		256 /* What should this be? */
 
+typedef void (*kernel_entry_t)(unsigned long r3, unsigned long r4, void *r5);
+
 /* Platform specific operations */
 struct platform_ops {
 	void	(*fixups)(void);

-- 

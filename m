Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4C1D2DDEDC
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 06:12:35 +1000 (EST)
Message-ID: <46422A6A.4000304@am.sony.com>
Date: Wed, 09 May 2007 13:09:14 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch] PS3: Fix sys manager build error
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix a PS3 build error when CONFIG_PS3_SYS_MANAGER=n.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
Paul,

Please apply for 2.6.22.

 include/asm-powerpc/ps3.h |    5 +++++
 1 file changed, 5 insertions(+)

--- ps3-linux-dev.orig/include/asm-powerpc/ps3.h
+++ ps3-linux-dev/include/asm-powerpc/ps3.h
@@ -377,8 +377,13 @@ int ps3_vuart_port_device_register(struc
 
 /* system manager */
 
+#ifdef CONFIG_PS3_SYS_MANAGER
 void ps3_sys_manager_restart(void);
 void ps3_sys_manager_power_off(void);
+#else
+static inline void ps3_sys_manager_restart(void) {}
+static inline void ps3_sys_manager_power_off(void) {}
+#endif
 
 struct ps3_prealloc {
     const char *name;

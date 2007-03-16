Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 9E595DE634
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 04:29:01 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l2GHSwH5019057
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:28:59 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2GHSwrF009972
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:28:58 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2GH9GOv001427
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:09:17 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 5D50EAEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:28:57 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2GHSvWB029840
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 12:28:57 -0500
Date: Fri, 16 Mar 2007 12:28:57 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/17] bootwrapper: Make set_cmdline non-static,
	and accept a const buffer.
Message-ID: <20070316172857.GK29784@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This allows platform code to call set_cmdline to initialize
/chosen/bootargs with a command line passed by the bootloader.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/main.c |    2 +-
 arch/powerpc/boot/ops.h  |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index 8a60e13..506d7db 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -243,7 +243,7 @@ static void get_cmdline(char *buf, int size)
 		getprop(devp, "bootargs", buf, size);
 }
 
-static void set_cmdline(char *buf)
+void set_cmdline(const char *buf)
 {
 	void *devp;
 
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 64e5472..429ced1 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -83,6 +83,7 @@ int xlate_reg(void *node, int res, unsigned long *addr, unsigned long *size);
 void dt_set_memory(u64 start, u64 len, int ncells);
 void dt_set_cpu_clocks(u32 clock, u32 bus, u32 timebase);
 void dt_set_mac_addresses(u8 **mac_table, int num_addrs);
+void set_cmdline(const char *buf);
 
 static inline void *finddevice(const char *name)
 {
-- 
1.5.0.3

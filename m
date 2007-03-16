Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id BBD6ADE516
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 04:28:49 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l2GHSkSQ019006
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:28:46 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2GHSjkS009934
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:28:46 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2GH94iH001392
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:09:04 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 27469AEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:28:45 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2GHSjwq029816
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 12:28:45 -0500
Date: Fri, 16 Mar 2007 12:28:45 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/17] bootwrapper: misc device tree fixes
Message-ID: <20070316172845.GE29784@ld0162-tx32.am.freescale.net>
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

1. The dtb should be generated in $tmpdir, rather than the current directory.
Normally, $tmpdir is ".", so it doesn't matter, but the wrapper should obey
the -W option if it should be passed.

2. DTC has a habit of complaining about errors which are not really
errors.  Thus, the -f option is now passed to it, to force it to generate
output regardless.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/wrapper |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index f9238f5..a30e45b 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -108,9 +108,9 @@ done
 
 if [ -n "$dts" ]; then
     if [ -z "$dtb" ]; then
-	dtb="$platform.dtb"
+	dtb="$tmpdir/$platform.dtb"
     fi
-    dtc -O dtb -o "$dtb" -b 0 -V 16 "$dts" || exit 1
+    dtc -f -O dtb -o "$dtb" -b 0 -V 16 "$dts" || exit 1
 fi
 
 if [ -z "$kernel" ]; then
-- 
1.5.0.3

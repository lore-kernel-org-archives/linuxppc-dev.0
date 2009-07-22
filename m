Return-Path: <lgrijincu@ixiacom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 894E3B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 01:33:14 +1000 (EST)
Received: from ixro-ex1.ixiacom.com (ixro-out-rtc.ixiacom.com [92.87.192.98])
	by ozlabs.org (Postfix) with ESMTP id 75F2CDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 01:33:12 +1000 (EST)
Message-ID: <4A672E56.2070309@ixiacom.com>
Date: Wed, 22 Jul 2009 18:20:54 +0300
From: Lucian Adrian Grijincu <lgrijincu@ixiacom.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: update wrapper to point to the new location of dtc
Content-Type: multipart/mixed; boundary="------------030801040803010807030801"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030801040803010807030801
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


dtc was moved in 9fffb55f66127b52c937ede5196ebfa0c0d50bce from
arch/powerpc/boot/ to scripts/dtc/

This patch updates the wrapper script to point to the new location of dtc.

Signed-off-by: Lucian Adrian Grijincu <lgrijincu@ixiacom.com>
---
  arch/powerpc/boot/wrapper |    3 ++-
  1 files changed, 2 insertions(+), 1 deletions(-)



--------------030801040803010807030801
Content-Type: text/x-patch;
 name="0001-powerpc-update-wrapper-to-point-to-the-new-location-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-powerpc-update-wrapper-to-point-to-the-new-location-.pa";
 filename*1="tch"

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index e964489..c907540 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -46,6 +46,7 @@ CROSS=
 # directory for object and other files used by this script
 object=arch/powerpc/boot
 objbin=$object
+dtc=scripts/dtc/dtc
 
 # directory for working files
 tmpdir=.
@@ -124,7 +125,7 @@ if [ -n "$dts" ]; then
     if [ -z "$dtb" ]; then
 	dtb="$platform.dtb"
     fi
-    $object/dtc -O dtb -o "$dtb" -b 0 "$dts"
+    $dtc -O dtb -o "$dtb" -b 0 "$dts"
 fi
 
 if [ -z "$kernel" ]; then


--------------030801040803010807030801--

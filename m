Return-Path: <SRS0+0172f75cf8e7244956cd+1562+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0DB5CDDE33
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 13:49:40 +1100 (EST)
Received: from pmac.infradead.org ([2001:8b0:10b:1:20d:93ff:fe7a:3f2c])
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1Iz1NC-0006QT-74
	for linuxppc-dev@ozlabs.org; Mon, 03 Dec 2007 02:49:36 +0000
Subject: [PPC BOOT] Find device-tree source file in default directory.
From: David Woodhouse <dwmw2@infradead.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1196650083.13978.113.camel@pmac.infradead.org>
References: <1196650083.13978.113.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Mon, 03 Dec 2007 02:49:24 +0000
Message-Id: <1196650164.13978.115.camel@pmac.infradead.org>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If a .dts file is given to the bootwrapper script without a full path
name, look in a sensible place for it.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -116,6 +118,9 @@ while [ "$#" -gt 0 ]; do
 done
 
 if [ -n "$dts" ]; then
+    if [ ! -r "$dts" -a -r "$object/dts/$dts" ]; then
+	dts="$object/dts/$dts"
+    fi
     if [ -z "$dtb" ]; then
 	dtb="$platform.dtb"
     fi

-- 
dwmw2

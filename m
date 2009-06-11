Return-Path: <ncase@xes-inc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AE5A9B77EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 05:43:48 +1000 (EST)
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EBFB0DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 05:43:46 +1000 (EST)
From: Nate Case <ncase@xes-inc.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH -next 4/4] powerpc/bootwrapper: Custom build options for
	XPedite52xx targets
Date: Thu, 11 Jun 2009 14:43:01 -0500
Message-Id: <1244749381-17429-5-git-send-email-ncase@xes-inc.com>
In-Reply-To: <1244749381-17429-4-git-send-email-ncase@xes-inc.com>
References: <1244749381-17429-1-git-send-email-ncase@xes-inc.com>
	<1244749381-17429-2-git-send-email-ncase@xes-inc.com>
	<1244749381-17429-3-git-send-email-ncase@xes-inc.com>
	<1244749381-17429-4-git-send-email-ncase@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org, Nate Case <ncase@xes-inc.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some XPedite52xx boards have a legacy boot loader requiring some special
care in the boot wrapper.  The use of cuboot-85xx is needed to fix
up embedded device trees, and a custom link address is specified to
accommodate the boot loader and larger kernel image sizes used on X-ES
MPC85xx platforms.

Signed-off-by: Nate Case <ncase@xes-inc.com>
---
 arch/powerpc/boot/wrapper |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 3ac75ae..4db487d 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -225,6 +225,10 @@ asp834x-redboot)
     platformo="$object/fixed-head.o $object/redboot-83xx.o"
     binary=y
     ;;
+xpedite52*)
+    link_address='0x1400000'
+    platformo=$object/cuboot-85xx.o
+    ;;
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
-- 
1.6.0.4

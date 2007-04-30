Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 50B52DDFB3
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 07:00:57 +1000 (EST)
Message-ID: <463658FE.8050700@am.sony.com>
Date: Mon, 30 Apr 2007 14:00:46 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 1/6] PS3: Remove dev_dbg redefinition in ehci-ps3.c and
	ohci-ps3.c
References: <20070430202420.872228544@am.sony.com>
In-Reply-To: <20070430202420.872228544@am.sony.com>
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

Commit 404d5b185b4eb56d6fa2f7bd27833f8df1c38ce4 changed the definition
of dev_dbg in the !DEBUG case from being a #define to being a static
inline.  There was code in usb/host/ehci-ps3.c and ohci-ps3.c to do
exactly that, which fails to compile now.  This fixes it by removing
the redefinition, as the redefinition is now superfluous.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 drivers/usb/host/ehci-ps3.c |    7 -------
 drivers/usb/host/ohci-ps3.c |    8 --------
 2 files changed, 15 deletions(-)

--- ps3-linux-dev.orig/drivers/usb/host/ehci-ps3.c
+++ ps3-linux-dev/drivers/usb/host/ehci-ps3.c
@@ -73,13 +73,6 @@ static const struct hc_driver ps3_ehci_h
 #endif
 };
 
-#if !defined(DEBUG)
-#undef dev_dbg
-static inline int __attribute__ ((format (printf, 2, 3))) dev_dbg(
-	const struct device *_dev, const char *fmt, ...) {return 0;}
-#endif
-
-
 static int ps3_ehci_sb_probe(struct ps3_system_bus_device *dev)
 {
 	int result;
--- ps3-linux-dev.orig/drivers/usb/host/ohci-ps3.c
+++ ps3-linux-dev/drivers/usb/host/ohci-ps3.c
@@ -75,14 +75,6 @@ static const struct hc_driver ps3_ohci_h
 #endif
 };
 
-/* redefine dev_dbg to do a syntax check */
-
-#if !defined(DEBUG)
-#undef dev_dbg
-static inline int __attribute__ ((format (printf, 2, 3))) dev_dbg(
-	const struct device *_dev, const char *fmt, ...) {return 0;}
-#endif
-
 static int ps3_ohci_sb_probe(struct ps3_system_bus_device *dev)
 {
 	int result;

-- 

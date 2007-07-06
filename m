Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 1E52CDE01F
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 01:52:25 +1000 (EST)
Date: Fri, 6 Jul 2007 17:52:23 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] compat32: ignore the LOOP_CLR_FD ioctl
In-Reply-To: <jevecxhep6.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.62.0707061749250.17331@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0707061431360.1203@pademelon.sonytel.be>
	<jevecxhep6.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1022588381-1183737050=:17331"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Adrian 'Trivial' Bunk <trivial@kernel.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Hiroaki Fuse <Hiroaki_Fuse@hq.scei.sony.co.jp>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1022588381-1183737050=:17331
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.62.0707061751551.17331@pademelon.sonytel.be>

compat32: Ignore the LOOP_CLR_FD ioctl for the loop block device, to kill an
annoying kernel message when e.g. busybox umount is used.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 fs/compat_ioctl.c |    4 ++++
 1 files changed, 4 insertions(+)

--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -63,6 +63,7 @@
 #include <linux/wireless.h>
 #include <linux/atalk.h>
 #include <linux/blktrace_api.h>
+#include <linux/loop.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci.h>
@@ -3489,6 +3490,9 @@ HANDLE_IOCTL(LPSETTIMEOUT, lp_timeout_tr
 
 IGNORE_IOCTL(VFAT_IOCTL_READDIR_BOTH32)
 IGNORE_IOCTL(VFAT_IOCTL_READDIR_SHORT32)
+
+/* loop */
+IGNORE_IOCTL(LOOP_CLR_FD)
 };
 
 #define IOCTL_HASHSIZE 256

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-1022588381-1183737050=:17331--

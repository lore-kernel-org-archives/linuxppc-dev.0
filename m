Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 0728CDDEEF
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 02:30:16 +1000 (EST)
Date: Tue, 14 Aug 2007 18:30:13 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] ps3: Fix no storage devices found
In-Reply-To: <46C1D0D6.7030403@am.sony.com>
Message-ID: <Pine.LNX.4.62.0708141828170.3886@pademelon.sonytel.be>
References: <46C0FDC0.6000503@am.sony.com> <20070814123227.GA18886@suse.de>
	<20070814143537.GA21308@suse.de> <20070814152651.GA22182@suse.de>
	<46C1D0D6.7030403@am.sony.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-721211582-1187109013=:3886"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Hiroyuki Machida <Hiroyuki.Machida@jp.sony.com>, Olaf Hering <olh@suse.de>
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

---584337861-721211582-1187109013=:3886
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Fix probing of PS3 storage devices: in the success case, we should set `error'
to zero, not `result'.

Without this patch no storage devices are found.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
This brown paper bag bug slipped in due to bad patch splitting.
Please apply as soon as possible. Thanks!

 arch/powerpc/platforms/ps3/device-init.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -372,7 +372,7 @@ static int ps3_storage_wait_for_device(c
 		    notify_event->dev_type == repo->dev_type) {
 			pr_debug("%s:%u: device ready: dev_id %u\n", __func__,
 				 __LINE__, repo->dev_id);
-			result = 0;
+			error = 0;
 			break;
 		}
 

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
---584337861-721211582-1187109013=:3886--

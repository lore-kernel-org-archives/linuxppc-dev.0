Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id CCA85DDE11
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 23:53:45 +1000 (EST)
Date: Thu, 19 Jul 2007 15:53:44 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 1/4] ps3disk: use correct bio vector size
In-Reply-To: <Pine.LNX.4.62.0707191548070.8661@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0707191552420.8661@pademelon.sonytel.be>
References: <20070716161539.075822000@pademelon.sonytel.be>
	<20070716162206.392129000@pademelon.sonytel.be>
	<20070718163637.3f0e0164.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0707191039430.8661@pademelon.sonytel.be>
	<20070719021045.c0b994ca.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0707191548070.8661@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1731197132-1184853188=:8661"
Cc: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	Olaf Hering <olaf@aepfle.de>, linux-scsi@vger.kernel.org,
	Jens Axboe <jens.axboe@oracle.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
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

---584337861-1731197132-1184853188=:8661
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.62.0707191553221.8661@pademelon.sonytel.be>

ps3disk: use correct bio vector size

This fixes the O_DIRECT corruptions, as reported by Olaf Hering (triggered by
e.g. parted >= 1.8.0).

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/block/ps3disk.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -108,7 +108,7 @@ static void ps3disk_scatter_gather(struc
 			__func__, __LINE__, i, bio_segments(bio),
 			bio_sectors(bio), sector);
 		bio_for_each_segment(bvec, bio, j) {
-			size = bio_cur_sectors(bio)*KERNEL_SECTOR_SIZE;
+			size = bvec->bv_len;
 			buf = __bio_kmap_atomic(bio, j, KM_IRQ0);
 			if (gather)
 				memcpy(dev->bounce_buf+offset, buf, size);

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
---584337861-1731197132-1184853188=:8661--

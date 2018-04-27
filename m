Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40XbQZ1QBCzF24D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2018 00:09:09 +1000 (AEST)
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Jens Axboe <axboe@kernel.dk>,
 Stan Johnson <userm57@yahoo.com>, Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 4.14 72/80] block/swim: Rename macros to avoid inconsistent
 inverted logic
Date: Fri, 27 Apr 2018 15:59:05 +0200
Message-Id: <20180427135736.636590672@linuxfoundation.org>
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@telegraphics.com.au>

commit 56a1c5ee54f69dd767fb61d301883dc919ddc259 upstream.

The Sony drive status bits use active-low logic. The swim_readbit()
function converts that to 'C' logic for readability. Hence, the
sense of the names of the status bit macros should not be inverted.

Mostly they are correct. However, the TWOMEG_DRIVE, MFM_MODE and
TWOMEG_MEDIA macros have inverted sense (like MkLinux). Fix this
inconsistency and make the following patches less confusing.

The same problem affects swim3.c so fix that too.

No functional change.

The FDHD drive status bits are documented in sonydriv.cpp from MAME
and in swimiii.h from MkLinux.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/swim.c  |    8 ++++----
 drivers/block/swim3.c |    6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -110,7 +110,7 @@ struct iwm {
 /* Select values for swim_select and swim_readbit */
 
 #define READ_DATA_0	0x074
-#define TWOMEG_DRIVE	0x075
+#define ONEMEG_DRIVE	0x075
 #define SINGLE_SIDED	0x076
 #define DRIVE_PRESENT	0x077
 #define DISK_IN		0x170
@@ -118,9 +118,9 @@ struct iwm {
 #define TRACK_ZERO	0x172
 #define TACHO		0x173
 #define READ_DATA_1	0x174
-#define MFM_MODE	0x175
+#define GCR_MODE	0x175
 #define SEEK_COMPLETE	0x176
-#define ONEMEG_MEDIA	0x177
+#define TWOMEG_MEDIA	0x177
 
 /* Bits in handshake register */
 
@@ -612,7 +612,7 @@ static void setup_medium(struct floppy_s
 		struct floppy_struct *g;
 		fs->disk_in = 1;
 		fs->write_protected = swim_readbit(base, WRITE_PROT);
-		fs->type = swim_readbit(base, ONEMEG_MEDIA);
+		fs->type = swim_readbit(base, TWOMEG_MEDIA);
 
 		if (swim_track00(base))
 			printk(KERN_ERR
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -148,7 +148,7 @@ struct swim3 {
 #define MOTOR_ON	2
 #define RELAX		3	/* also eject in progress */
 #define READ_DATA_0	4
-#define TWOMEG_DRIVE	5
+#define ONEMEG_DRIVE	5
 #define SINGLE_SIDED	6	/* drive or diskette is 4MB type? */
 #define DRIVE_PRESENT	7
 #define DISK_IN		8
@@ -156,9 +156,9 @@ struct swim3 {
 #define TRACK_ZERO	10
 #define TACHO		11
 #define READ_DATA_1	12
-#define MFM_MODE	13
+#define GCR_MODE	13
 #define SEEK_COMPLETE	14
-#define ONEMEG_MEDIA	15
+#define TWOMEG_MEDIA	15
 
 /* Definitions of values used in writing and formatting */
 #define DATA_ESCAPE	0x99

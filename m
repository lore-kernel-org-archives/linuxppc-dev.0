Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B4A42C0396
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Sep 2013 16:50:47 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 12 Sep 2013 12:09:45 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C4DDEE0056
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Sep 2013 12:21:31 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8C6qcci24838262
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Sep 2013 12:22:38 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8C6ob1p001048
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Sep 2013 12:20:38 +0530
Subject: [PATCH v2] pstore: Adjust buffer size for compression for smaller
 registered buffers
To: linuxppc-dev@ozlabs.org, tony.luck@intel.com, seiji.aguchi@hds.com,
 linux-kernel@vger.kernel.org, keescook@chromium.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 12 Sep 2013 12:20:34 +0530
Message-ID: <20130912064832.15340.52422.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com, ccross@android.com,
 cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When backends (ex: efivars) have smaller registered buffers, the big_oops_buf
is quite too big for them as number of repeated occurences in the text captured
will be less. Patch takes care of adjusting the buffer size based on the
registered buffer size. cmpr values has been arrived after doing experiments with
plain text for buffers of size 1k - 4k (Smaller the buffer size repeated occurence
will be less) and with sample crash log for buffers ranging from 4k - 10k.

Reported-by: Seiji Aguchi <seiji.aguchi@hds.com>
Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
Changes from v1:
	Retain the cmpr = 45 for buffers ranging of size 4k - 10k. 45 seems to work.
I added an additional headroom of 3%. Revert it back to 45.

 fs/pstore/platform.c |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 4ffb7ab..57b4219 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -195,8 +195,29 @@ error:
 static void allocate_buf_for_compression(void)
 {
 	size_t size;
+	size_t cmpr;
+
+	switch (psinfo->bufsize) {
+	/* buffer range for efivars */
+	case 1000 ... 2000:
+		cmpr = 56;
+		break;
+	case 2001 ... 3000:
+		cmpr = 54;
+		break;
+	case 3001 ... 3999:
+		cmpr = 52;
+		break;
+	/* buffer range for nvram, erst */
+	case 4000 ... 10000:
+		cmpr = 45;
+		break;
+	default:
+		cmpr = 60;
+		break;
+	}
 
-	big_oops_buf_sz = (psinfo->bufsize * 100) / 45;
+	big_oops_buf_sz = (psinfo->bufsize * 100) / cmpr;
 	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
 	if (big_oops_buf) {
 		size = max(zlib_deflate_workspacesize(WINDOW_BITS, MEM_LEVEL),

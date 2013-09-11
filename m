Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A3182C040F
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Sep 2013 22:07:55 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Wed, 11 Sep 2013 17:25:55 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 683451258052
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Sep 2013 17:37:50 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8BC9iNR44040216
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Sep 2013 17:39:44 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8BC7kDD029582
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Sep 2013 17:37:47 +0530
Subject: [PATCH 3/3] pstore: Remove the messages related to compression failure
To: linuxppc-dev@ozlabs.org, tony.luck@intel.com, seiji.aguchi@hds.com,
 linux-kernel@vger.kernel.org, keescook@chromium.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Wed, 11 Sep 2013 17:37:43 +0530
Message-ID: <20130911120729.27730.7479.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130911120639.27730.8671.stgit@aruna-ThinkPad-T420>
References: <20130911120639.27730.8671.stgit@aruna-ThinkPad-T420>
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

Remove the messages indicating compression failure as it will
add to the space during panic path.

Reported-by: Seiji Aguchi <seiji.aguchi@hds.com>
Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 fs/pstore/platform.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 18924c7..4ad8c93 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -316,10 +316,6 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 				compressed = true;
 				total_len = zipped_len;
 			} else {
-				pr_err("pstore: compression failed for Part %d"
-					" returned %d\n", part, zipped_len);
-				pr_err("pstore: Capture uncompressed"
-					" oops/panic report of Part %d\n", part);
 				compressed = false;
 				total_len = copy_kmsg_to_buffer(hsize, len);
 			}

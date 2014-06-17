Return-Path: <Wei.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B2F21A02AF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 17:07:53 +1000 (EST)
From: <Wei.Yang@windriver.com>
To: <horms@verge.net.au>
Subject: [PATCH v1] kexec:fs2dt: Refine kdump device_tree sort
Date: Tue, 17 Jun 2014 14:06:16 +0800
Message-ID: <1402985176-10556-1-git-send-email-Wei.Yang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, wei.yang@windriver.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Yang Wei <Wei.Yang@windriver.com>

The commit b02d735bf was to rearrange the device-tree entries, and
assumed that these entries are sorted in the ascending order. but
acctually when I was validating kexec and kdump, the order of
serial node still is changed. We should not only compare the length
of directory name, but also compare the directory name, it would
ensure that the order of device node is really in ascending order.

Signed-off-by: Yang Wei <Wei.Yang@windriver.com>
---
 
Hi Simon,

   Please help me take a look at this patch. I validated it on freescale t4240qds.

   Thanks
   Wei
 kexec/fs2dt.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 1e5f074..0bffaf5 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -479,6 +479,9 @@ static int comparefunc(const struct dirent **dentry1,
 {
 	char *str1 = (*(struct dirent **)dentry1)->d_name;
 	char *str2 = (*(struct dirent **)dentry2)->d_name;
+	char* ptr1 = strchr(str1, '@');
+	char* ptr2 = strchr(str2, '@');
+	int len1, len2;
 
 	/*
 	 * strcmp scans from left to right and fails to idetify for some
@@ -486,9 +489,13 @@ static int comparefunc(const struct dirent **dentry1,
 	 * Therefore, we get the wrong sorted order like memory@10000000 and
 	 * memory@f000000.
 	 */
-	if (strchr(str1, '@') && strchr(str2, '@') &&
-		(strlen(str1) > strlen(str2)))
-		return 1;
+	if (ptr1 && ptr2) {
+		len1 = ptr1 - str1;
+		len2 = ptr2 - str2;
+		if (!strncmp(str1, str2, len1 >len2 ? len1: len2) &&
+					(strlen(str1) > strlen(str2)))
+				return 1;
+	}
 
 	return strcmp(str1, str2);
 }
-- 
1.7.9.5

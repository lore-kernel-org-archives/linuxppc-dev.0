Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C059B1A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 06:33:11 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 26 Oct 2015 13:33:08 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 08E1E1FF0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 13:21:18 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9QJVg9J59637960
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 12:31:42 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9QJX5bu007792
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 13:33:05 -0600
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: andriy.shevchenko@linux.intel.com
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/pseries: Correct string length in
 pseries_of_derive_parent()
Message-ID: <562E7FF1.1040806@linux.vnet.ibm.com>
Date: Mon, 26 Oct 2015 14:33:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit a030e1e4bbd085bbcfd0a23f8d355fcd41f39bed made a change to use
kstrndup() instead of kmalloc() + strlcpy() in pseries_of_derive_parent()
which introduces a subtle change in the parent path name generated.
The kstrndup() routine will copy n characters followed by a terminating null,
whereas strlcpy() will copy n-1 characters and add a terminating null.

This slight difference results in having a parent path that includes the
trailing '/' character, i.e. "/cpus/" vs. "/cpus". This then causes the
subsequent call to of_find_node_by_path() to fail, and in the case of
DLPAR add operations, the DLPAR request fails.

This patch reduces the total length of the string to copy in kstrndup by 1
so we no longer copy the trailing '/'.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/of_helpers.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
index 4417afe..6d90378 100644
--- a/arch/powerpc/platforms/pseries/of_helpers.c
+++ b/arch/powerpc/platforms/pseries/of_helpers.c
@@ -24,7 +24,7 @@ struct device_node *pseries_of_derive_parent(const char *path)
 		return ERR_PTR(-EINVAL);
 
 	if (tail > path + 1) {
-		parent_path = kstrndup(path, tail - path, GFP_KERNEL);
+		parent_path = kstrndup(path, (tail - 1) - path, GFP_KERNEL);
 		if (!parent_path)
 			return ERR_PTR(-ENOMEM);
 	}

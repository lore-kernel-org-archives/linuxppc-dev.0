Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 450F71A0478
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 02:46:52 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 27 Oct 2015 09:46:49 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id DA96D3E40041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 09:46:47 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9RFklw69306420
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 08:46:47 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9RFkl2V025948
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 09:46:47 -0600
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: [PATCH v2] powerpc/pseries: Correct string length in
 pseries_of_derive_parent()
Message-ID: <562F9C67.3040207@linux.vnet.ibm.com>
Date: Tue, 27 Oct 2015 10:46:47 -0500
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

Commit a030e1e4bbd085bbcfd0a23f8d355fcd41f39bed make a change to use
kstrndup() instead of kmalloc() + strlcpy() in the pseries_of_derive_parent()
routine that introduces a subtle change in the parent path name generated.
The kstrndup() routine will copy n characters followed by a terminating null,
whereas strlcpy() will copy n-1 characters and add a terminating null.

This slight difference results in having a parent path that includes the
tailing '/' character, "/cpus/" vs. "/cpus". This then causes the subsequent
call to of_find_node_by_path() to fail, and in the case of DLPAR add
operations the DLPAR request fails.

This patch decrements the pointer returned from kbasename() to point to the
'/' character before the base name instead of the base name. This then
adjusts the string length calculations to not include the trailing '/'
in the parent path name.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---

Updates for v2: Decrement the pointer returned from kbasename() instead
of subtracting 1 when calculating the string length.
 
 arch/powerpc/platforms/pseries/of_helpers.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
index 4417afe..2798933 100644
--- a/arch/powerpc/platforms/pseries/of_helpers.c
+++ b/arch/powerpc/platforms/pseries/of_helpers.c
@@ -17,13 +17,16 @@ struct device_node *pseries_of_derive_parent(const char *path)
 {
 	struct device_node *parent;
 	char *parent_path = "/";
-	const char *tail = kbasename(path);
+	const char *tail;
+
+	/* We do not want the trailing '/' character */
+	tail = kbasename(path) - 1;
 
 	/* reject if path is "/" */
 	if (!strcmp(path, "/"))
 		return ERR_PTR(-EINVAL);
 
-	if (tail > path + 1) {
+	if (tail > path) {
 		parent_path = kstrndup(path, tail - path, GFP_KERNEL);
 		if (!parent_path)
 			return ERR_PTR(-ENOMEM);

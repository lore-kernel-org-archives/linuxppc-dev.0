Return-Path: <bharata.rao@gmail.com>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D1AF1A2750
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 20:23:32 +1000 (AEST)
Received: by padhy16 with SMTP id hy16so91363782pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2015 03:23:30 -0700 (PDT)
From: Bharata B Rao <bharata.rao@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com,
	Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: [FIX PATCH v1] powerpc/pseries: Release DRC when configure_connector
 fails
Date: Mon,  7 Sep 2015 15:52:40 +0530
Message-Id: <1441621360-1536-1-git-send-email-bharata.rao@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

Commit f32393c943e2 ("powerpc/pseries: Correct cpu affinity for
dlpar added cpus") moved dlpar_acquire_drc() call to before
dlpar_configure_connector() call in dlpar_cpu_probe(), but missed
to release the DRC if dlpar_configure_connector() failed.
During CPU hotplug, if configure-connector fails for any reason,
then this will result in subsequent CPU hotplug attempts to fail.

Release the acquired DRC if dlpar_configure_connector() call fails
so that the DRC is left in right isolation and allocation state
for the subsequent hotplug operation to succeed.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
Changes in v1: Improved patch description.
v0: https://patchwork.ozlabs.org/patch/514370/

This fix should probably go to stable too.

 arch/powerpc/platforms/pseries/dlpar.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 47d9cebe..db17827 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -422,8 +422,10 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
 
 	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
 	of_node_put(parent);
-	if (!dn)
+	if (!dn) {
+		dlpar_release_drc(drc_index);
 		return -EINVAL;
+	}
 
 	rc = dlpar_attach_node(dn);
 	if (rc) {
-- 
1.8.3.1

Return-Path: <prarit@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id CCFB7B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 Jan 2011 01:09:05 +1100 (EST)
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id p0DE93sv020222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jan 2011 09:09:03 -0500
Date: Thu, 13 Jan 2011 09:09:01 -0500
From: Prarit Bhargava <prarit@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Message-Id: <20110113140901.1415.69539.sendpatchset@prarit.bos.redhat.com>
Subject: [PATCH]: ppc: notifier_from_errno() cleanup
Cc: Prarit Bhargava <prarit@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Minor cleanup of notifier_from_errno() in powerpc.

notifier_from_errno() now contains the if(ret)/else conditional.  There is no
need to do it in the powerpc code.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index f480386..3cafc30 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -508,12 +508,7 @@ static int cmm_memory_isolate_cb(struct notifier_block *self,
 	if (action == MEM_ISOLATE_COUNT)
 		ret = cmm_count_pages(arg);
 
-	if (ret)
-		ret = notifier_from_errno(ret);
-	else
-		ret = NOTIFY_OK;
-
-	return ret;
+	return notifier_from_errno(ret);
 }
 
 static struct notifier_block cmm_mem_isolate_nb = {
@@ -635,12 +630,7 @@ static int cmm_memory_cb(struct notifier_block *self,
 		break;
 	}
 
-	if (ret)
-		ret = notifier_from_errno(ret);
-	else
-		ret = NOTIFY_OK;
-
-	return ret;
+	return notifier_from_errno(ret);
 }
 
 static struct notifier_block cmm_mem_nb = {

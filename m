Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 67090DDDE3
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 12:37:09 +1100 (EST)
Date: Mon, 20 Oct 2008 20:37:04 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org
Message-id: <trim-iommu-t2@bga.com>
Subject: powerpc: always trim to numa memory to lmb_end_of_DRAM
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

numa_enforce_memory_limit tried to be smart and only call lmb_end_of_DRAM
when a memory limit was set via mem= on the command line.  However,
the early boot code will also limit memory added to the lmb system
when iommu=off is specified.  When this happens, the page allocator
is given pages not in the linear mapping and this results in a fatal
data reference to the unmapped page.

Signed-off-by: Milton Miller <miltonm@bga.com>
--
X-Patchwork-ID: 19577
Changelog edited.  Patch compiled on next-20081017

A previous version of this patch, id 11774, also looked if if iommu=off
was specified, but it was requested that the check just be removed.

http://oldpatchwork.ozlabs.org/linuxppc/patch?id=11774


---
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index cf4bffb..590406c 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -472,12 +472,10 @@ static unsigned long __init numa_enforce_memory_limit(unsigned long start,
 	/*
 	 * We use lmb_end_of_DRAM() in here instead of memory_limit because
 	 * we've already adjusted it for the limit and it takes care of
-	 * having memory holes below the limit.
+	 * having memory holes below the limit.  Also, in the case of
+	 * iommu_is_off, memory_limit is not set but is implicitly enforced.
 	 */
 
-	if (! memory_limit)
-		return size;
-
 	if (start + size <= lmb_end_of_DRAM())
 		return size;
 

Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1BF67DDF0D
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 07:20:26 +1000 (EST)
Date: Thu, 10 Jul 2008 16:19:06 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <for-27-patch1-0@bga.com>
Message-Id: <for-27-patch3@bga.com>
Subject: powerpc: numa.c: always trim to lmb_end_of_DRAM
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

numa_enforce_memory_limit trys to be smart and only trim the memory it
finds to lmb_end_of_DRAM when a memory limit is set.   However, the
early boot code may also limit memory when iommu=off is specified.  When
this happens, the page allocator is told of pages not in the linear mapping
and gets a fatal DSI.

Signed-off-by: Milton Miller <miltonm@bga.com>
--
Previously this patch tried to check if iommu=off was specified, but it was
requested that the check just be removed.

http://patchwork.ozlabs.org/linuxppc/patch?id=11774

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
 

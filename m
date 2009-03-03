Return-Path: <geoff@hera.kernel.org>
Message-Id: <20090303183304.922607310@am.sony.com>>
References: <20090303183304.791485071@am.sony.com>>
In-Reply-To: <20090303183304.791485071@am.sony.com>>
Date: Tue, 03 Mar 2009 10:33:06 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 2/3] powerpc/ps3: Print memory hotplug errors
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To help users diagnose hotpug memory problems, change the
printing of memory hotplug errors from DBG() to pr_err().

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/mm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -311,7 +311,7 @@ static int __init ps3_mm_add_memory(void
 	result = add_memory(0, start_addr, map.r1.size);
 
 	if (result) {
-		DBG("%s:%d: add_memory failed: (%d)\n",
+		pr_err("%s:%d: add_memory failed: (%d)\n",
 			__func__, __LINE__, result);
 		return result;
 	}
@@ -322,7 +322,7 @@ static int __init ps3_mm_add_memory(void
 	result = online_pages(start_pfn, nr_pages);
 
 	if (result)
-		DBG("%s:%d: online_pages failed: (%d)\n",
+		pr_err("%s:%d: online_pages failed: (%d)\n",
 			__func__, __LINE__, result);
 
 	return result;

-- 

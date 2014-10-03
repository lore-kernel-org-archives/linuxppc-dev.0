Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 81B771A19B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 10:54:04 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 2 Oct 2014 18:54:02 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7A82D19D803E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 18:42:45 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s930s11k49741902
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Oct 2014 02:54:01 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s930wZaf029864
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Oct 2014 18:58:36 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, ak@linux.intel.com,
 Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org
Subject: [PATCH 1/3] tools/perf: Fix error message
Date: Thu,  2 Oct 2014 17:53:34 -0700
Message-Id: <1412297616-14179-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sometimes, eg: with a stripped vmlinux, we can open the file but
cannot load any symbols from it. Update error message accordingly
so the users can better understand the error.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/util/map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index b709059..c478092 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -267,7 +267,7 @@ int map__load(struct map *map, symbol_filter_t filter)
 			pr_warning("%s with build id %s not found",
 				   name, sbuild_id);
 		} else
-			pr_warning("Failed to open %s", name);
+			pr_warning("Failed to load symbols for DSO %s", name);
 
 		pr_warning(", continuing without symbols\n");
 		return -1;
-- 
1.8.3.1

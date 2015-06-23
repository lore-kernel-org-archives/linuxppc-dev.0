Return-Path: <BATV+2e8f70dedfad601fdc44+4321+infradead.org+acme@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF2DC1A1047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 07:49:22 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/13] perf tools: Allow events with dot
Date: Tue, 23 Jun 2015 18:47:21 -0300
Message-Id: <1435096047-32088-8-git-send-email-acme@kernel.org>
In-Reply-To: <1435096047-32088-1-git-send-email-acme@kernel.org>
References: <1435096047-32088-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andi Kleen <ak@linux.intel.com>

The Intel events use a dot to separate event name and unit mask.  Allow
dot in names in the scanner, and remove special handling of dot as EOF.
Also remove the hack in jevents to replace dot with underscore. This way
dotted events can be specified directly by the user.

I'm not fully sure this change to the scanner is correct (what was the
dot special case good for?), but I haven't found anything that breaks
with it so far at least.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1433921123-25327-8-git-send-email-sukadev@linux.vnet.ibm.com
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.l | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 09e738fe9ea2..13cef3c65565 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -119,8 +119,8 @@ event		[^,{}/]+
 num_dec		[0-9]+
 num_hex		0x[a-fA-F0-9]+
 num_raw_hex	[a-fA-F0-9]+
-name		[a-zA-Z_*?][a-zA-Z0-9_*?]*
-name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?]*
+name		[a-zA-Z_*?][a-zA-Z0-9_*?.]*
+name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.]*
 /* If you add a modifier you need to update check_modifier() */
 modifier_event	[ukhpGHSDI]+
 modifier_bp	[rwx]{1,3}
@@ -165,7 +165,6 @@ modifier_bp	[rwx]{1,3}
 			return PE_EVENT_NAME;
 		}
 
-.		|
 <<EOF>>		{
 			BEGIN(INITIAL);
 			REWIND(0);
-- 
2.1.0

Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6314C1A0CEF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 03:12:59 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 2 Jun 2015 11:12:57 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 8D0DC19D804E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 11:03:57 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t52HCt7B38142148
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 10:12:55 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t52HCsEC025707
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 11:12:55 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 04/14] perf, tools: Allow events with dot
Date: Tue,  2 Jun 2015 10:12:04 -0700
Message-Id: <1433265135-20426-5-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andi Kleen <ak@linux.intel.com>

The Intel events use a dot to separate event name and unit mask.
Allow dot in names in the scanner, and remove special handling
of dot as EOF. Also remove the hack in jevents to replace dot
with underscore. This way dotted events can be specified
directly by the user.

I'm not fully sure this change to the scanner is correct
(what was the dot special case good for?), but I haven't
found anything that breaks with it so far at least.

V2: Add the dot to name too, to handle events outside cpu//
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/util/parse-events.l |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 09e738f..13cef3c 100644
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
1.7.9.5

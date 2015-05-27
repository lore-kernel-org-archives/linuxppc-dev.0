Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 34F491A0E01
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 07:24:10 +1000 (AEST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 27 May 2015 15:24:08 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id B46A019D8026
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 15:15:07 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4RLNZwX15794418
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 14:23:35 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4RLO4NZ012231
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 15:24:04 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/10] perf, tools: Allow events with dot
Date: Wed, 27 May 2015 14:23:24 -0700
Message-Id: <1432761809-4344-6-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1432761809-4344-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1432761809-4344-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
---
 tools/perf/util/parse-events.l |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 8895cf3..242fe2a 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -98,8 +98,8 @@ event		[^,{}/]+
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
@@ -137,7 +137,6 @@ modifier_bp	[rwx]{1,3}
 			return PE_EVENT_NAME;
 		}
 
-.		|
 <<EOF>>		{
 			BEGIN(INITIAL); yyless(0);
 		}
-- 
1.7.9.5

Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3C0A72C0098
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2014 15:42:21 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 5 Mar 2014 21:42:18 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 737F519D8048
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2014 21:42:14 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with
 ESMTP id s264fmJj63635456
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2014 05:41:48 +0100
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s264gFEE008058
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2014 21:42:16 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: [PATCH 3/3] perf: Use 64-bit value when comparing sample_regs
Date: Wed,  5 Mar 2014 20:41:59 -0800
Message-Id: <1394080919-17957-4-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1394080919-17957-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1394080919-17957-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When checking whether a bit representing a register is set in
sample_regs, a 64-bit mask, use 64-bit value (1LL).

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/util/unwind.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/unwind.c b/tools/perf/util/unwind.c
index 742f23b..2b888c6 100644
--- a/tools/perf/util/unwind.c
+++ b/tools/perf/util/unwind.c
@@ -396,11 +396,11 @@ static int reg_value(unw_word_t *valp, struct regs_dump *regs, int id,
 {
 	int i, idx = 0;
 
-	if (!(sample_regs & (1 << id)))
+	if (!(sample_regs & (1LL << id)))
 		return -EINVAL;
 
 	for (i = 0; i < id; i++) {
-		if (sample_regs & (1 << i))
+		if (sample_regs & (1LL << i))
 			idx++;
 	}
 
-- 
1.7.9.5

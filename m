Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A018A1A0E34
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 08:47:23 +1100 (AEDT)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 30 Jan 2015 14:47:21 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 5FDD43E40030
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 14:47:19 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0ULlJJl35258540
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 14:47:27 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0ULkjXq032135
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 14:46:46 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH v7 3/7] perf: define EVENT_DEFINE_RANGE_FORMAT_LITE helper
Date: Fri, 30 Jan 2015 13:45:59 -0800
Message-Id: <1422654363-2035-4-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1422654363-2035-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1422654363-2035-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dev@codyps.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define a lite version of the EVENT_DEFINE_RANGE_FORMAT() that avoids
defining helper functions for the bit-field ranges.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-common.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/perf/hv-common.h b/arch/powerpc/perf/hv-common.h
index 5d79cec..349aaba 100644
--- a/arch/powerpc/perf/hv-common.h
+++ b/arch/powerpc/perf/hv-common.h
@@ -20,6 +20,16 @@ unsigned long hv_perf_caps_get(struct hv_perf_caps *caps);
 PMU_FORMAT_ATTR(name, #attr_var ":" #bit_start "-" #bit_end);		\
 EVENT_DEFINE_RANGE(name, attr_var, bit_start, bit_end)
 
+/*
+ * The EVENT_DEFINE_RANGE_FORMAT() macro above includes helper functions
+ * for the fields (eg: event_get_starting_index()). For some fields we
+ * need the bit-range definition, but no the helper functions. Define a
+ * lite version of the above macro without the helpers and silence
+ * compiler warnings unused static functions.
+ */
+#define EVENT_DEFINE_RANGE_FORMAT_LITE(name, attr_var, bit_start, bit_end) \
+PMU_FORMAT_ATTR(name, #attr_var ":" #bit_start "-" #bit_end);
+
 #define EVENT_DEFINE_RANGE(name, attr_var, bit_start, bit_end)	\
 static u64 event_get_##name##_max(void)					\
 {									\
-- 
1.8.3.1

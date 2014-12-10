Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEFDE1A01A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 18:09:43 +1100 (AEDT)
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 351B51400EA
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2014 18:09:43 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 10 Dec 2014 00:09:41 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 5B66DC40001
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2014 23:58:23 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBA7AJ1k41615592
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2014 00:10:19 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBA79cOA010129
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2014 00:09:38 -0700
Date: Tue, 9 Dec 2014 23:09:17 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <michaele@au1.ibm.com>
Subject: [PATCH 2/2] perf/power/hv-24x7: Use kmem_cache_free() instead of kfree
Message-ID: <20141210070917.GB27377@us.ibm.com>
References: <20141210070637.GA27377@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141210070637.GA27377@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, dev@codyps.com, Jiri Olsa <jolsa@redhat.com>,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 982bf5a660ae33fbe2f9187187caa6752c66783d Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Wed, 10 Dec 2014 01:43:34 -0500
Subject: [PATCH 2/2] power/perf: hv-24x7: Use kmem_cache_free() instead of
 kfree

Use kmem_cache_free() to free a buffer allocated with kmem_cache_alloc().

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

p#	set2.log
---
 arch/powerpc/perf/hv-24x7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 18e1f49..a2c6211 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -177,7 +177,7 @@ static ssize_t _name##_show(struct device *dev,			\
 	}							\
 	ret = sprintf(buf, _fmt, _expr);			\
 e_free:								\
-	kfree(page);						\
+	kmem_cache_free(hv_page_cache, page);			\
 	return ret;						\
 }								\
 static DEVICE_ATTR_RO(_name)
-- 
1.8.3.1

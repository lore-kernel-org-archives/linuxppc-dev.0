Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8874E2C02AD
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2013 10:19:49 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 5 Feb 2013 18:19:45 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 370F838C801B
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2013 18:19:43 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r15NJgs3310606
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Feb 2013 18:19:42 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r15NJf73022688
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Feb 2013 21:19:42 -0200
Date: Tue, 5 Feb 2013 15:19:38 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: [PATCH] perf/powerpc: Fix compile warnings
Message-ID: <20130205231938.GA24125@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au, mingo@kernel.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Tue, 5 Feb 2013 15:04:49 -0800
Subject: [PATCH] perf/powerpc: Fix compile warnings

Fix compile errors like those below:

  CC      arch/powerpc/perf/power7-pmu.o
/home/git/linux/arch/powerpc/perf/power7-pmu.c:397:2: error: initialization from
incompatible pointer type [-Werror]

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/perf_event_server.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index ee63205..92460bc 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -124,7 +124,7 @@ extern ssize_t power_events_sysfs_show(struct device *dev,
  * POWER CPU specification.
  */
 #define	EVENT_VAR(_id, _suffix)		event_attr_##_id##_suffix
-#define	EVENT_PTR(_id, _suffix)		&EVENT_VAR(_id, _suffix)
+#define	EVENT_PTR(_id, _suffix)		&EVENT_VAR(_id, _suffix).attr.attr
 
 #define	EVENT_ATTR(_name, _id, _suffix)					\
 	PMU_EVENT_ATTR(_name, EVENT_VAR(_id, _suffix), PME_PM_##_id,	\
-- 
1.7.1

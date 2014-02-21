Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5D21B2C0326
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 11:15:07 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Fri, 21 Feb 2014 10:15:06 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 32E213578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 11:15:04 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1KNtPsQ9240970
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 10:55:25 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1L0F3jg004285
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 11:15:03 +1100
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, hegdevasant@linux.vnet.ibm.com
Subject: [PATCH v2] powernv: don't attempt to refetch the FSP dump until the
 user has explicitly acked it.
Date: Fri, 21 Feb 2014 11:15:01 +1100
Message-Id: <1392941701-2871-1-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <20140116121411.624.55662.stgit@hegdevasant.in.ibm.com>
References: <20140116121411.624.55662.stgit@hegdevasant.in.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes a bug where we would get two events from OPAL with DUMP_AVAIL
set (which is valid for OPAL to do) and in the second run of extract_dump()
we would fail to free the memory previously allocated for the dump
(leaking ~6MB+) as well as on the second dump_read_data() call OPAL
would not retrieve the dump, leaving us with a dump in linux that was
the correct size but all zeros.

Changes since v1: fixed typo

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/opal-dump.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index 4447027..53c2675 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -238,6 +238,14 @@ static int extract_dump(void)
 {
 	int rc;
 
+	/* We can get notified that a dump is available multiple times
+	 * (dump_read_info clears the bit in the event from OPAL).
+	 * But we should not re-read the dump from OPAL as we
+	 * don't get the next dump until we've explicitly acked this one.
+	 */
+	if (dump_avail)
+		return OPAL_SUCCESS;
+
 	/* Get dump ID, size */
 	rc = dump_read_info();
 	if (rc != OPAL_SUCCESS)
-- 
1.7.10.4

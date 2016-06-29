Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfhVl1BnYzDqvp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 22:16:45 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5TCG7es063176
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 08:16:43 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23v09pj55g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 08:16:42 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 29 Jun 2016 22:16:40 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CC8913578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 22:16:37 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5TCGbSb7471394
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 22:16:37 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5TCGbbS027624
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 22:16:37 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 1/2] cxl: Fix allowing bogus AFU descriptors with 0 maximum
 processes
Date: Wed, 29 Jun 2016 22:16:25 +1000
Message-Id: <1467202586-13412-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

If the AFU descriptor of an AFU directed AFU indicates that it supports
0 maximum processes, we will accept that value and attempt to use it.
The SPA will still be allocated (with 2 pages due to another minor bug
and room for 958 processes), and when a context is allocated we will
pass the value of 0 to idr_alloc as the maximum. However, idr_alloc will
treat that as meaning no maximum and will allocate a context number and
we return a valid context.

Conceivably, this could lead to a buffer overflow of the SPA if more
than 958 contexts were allocated, however this is mitigated by the fact
that there are no known AFUs in the wild with a bogus AFU descriptor
like this, and that only the root user is allowed to flash an AFU image
to a card.

Add a check when validating the AFU descriptor to reject any with 0
maximum processes.

We do still allow a dedicated process only AFU to indicate that it
supports 0 contexts even though that is forbidden in the architecture,
as in that case we ignore the value and use 1 instead. This is just on
the off-chance that such a dedicated process AFU may exist (not that I
am aware of any), since their developers are less likely to have cared
about this value at all.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/pci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 648817a..58d7d821 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -775,6 +775,21 @@ static int cxl_afu_descriptor_looks_ok(struct cxl_afu *afu)
 		}
 	}
 
+	if ((afu->modes_supported & ~CXL_MODE_DEDICATED) && afu->max_procs_virtualised == 0) {
+		/*
+		 * We could also check this for the dedicated process model
+		 * since the architecture indicates it should be set to 1, but
+		 * in that case we ignore the value and I'd rather not risk
+		 * breaking any existing dedicated process AFUs that left it as
+		 * 0 (not that I'm aware of any). It is clearly an error for an
+		 * AFU directed AFU to set this to 0, and would have previously
+		 * triggered a bug resulting in the maximum not being enforced
+		 * at all since idr_alloc treats 0 as no maximum.
+		 */
+		dev_err(&afu->dev, "AFU does not support any processes\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.8.1

Return-Path: <srs0=y3wq=ju=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LTGJ0YsszF1LJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 03:57:12 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41LTGH73f1z8tKh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 03:57:11 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41LTGH37DNz9s4c
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Jul 2018 03:57:11 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w64HnaXu085402
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Jul 2018 13:57:09 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k0xh12peb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 04 Jul 2018 13:57:09 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 4 Jul 2018 18:57:07 +0100
Subject: [PATCH v6 1/8] powerpc/pseries: Avoid using the size greater than
 RTAS_ERROR_LOG_MAX.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Michal Suchanek <msuchanek@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 04 Jul 2018 23:27:02 +0530
In-Reply-To: <153072695700.29016.8614312307132803349.stgit@jupiter.in.ibm.com>
References: <153072695700.29016.8614312307132803349.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153072701775.29016.13501175476729182702.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

The global mce data buffer that used to copy rtas error log is of 2048
(RTAS_ERROR_LOG_MAX) bytes in size. Before the copy we read
extended_log_length from rtas error log header, then use max of
extended_log_length and RTAS_ERROR_LOG_MAX as a size of data to be copied.
Ideally the platform (phyp) will never send extended error log with
size > 2048. But if that happens, then we have a risk of buffer overrun
and corruption. Fix this by using min_t instead.

Fixes: d368514c3097 ("powerpc: Fix corruption when grabbing FWNMI data")
Reported-by: Michal Suchanek <msuchanek@suse.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/ras.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 5e1ef9150182..ef104144d4bc 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -371,7 +371,7 @@ static struct rtas_error_log *fwnmi_get_errinfo(struct pt_regs *regs)
 		int len, error_log_length;
 
 		error_log_length = 8 + rtas_error_extended_log_length(h);
-		len = max_t(int, error_log_length, RTAS_ERROR_LOG_MAX);
+		len = min_t(int, error_log_length, RTAS_ERROR_LOG_MAX);
 		memset(global_mce_data_buf, 0, RTAS_ERROR_LOG_MAX);
 		memcpy(global_mce_data_buf, h, len);
 		errhdr = (struct rtas_error_log *)global_mce_data_buf;

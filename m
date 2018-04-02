Return-Path: <srs0=ruhu=gx=linux.vnet.ibm.com=prvs=0630f71b8d=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40F2RX0YNPzF23B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Apr 2018 16:31:04 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40F2RW5FD9z8vT0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Apr 2018 16:31:03 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40F2RT0R44z9s28
 for <linuxppc-dev@ozlabs.org>; Mon,  2 Apr 2018 16:31:00 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w326TXu8117686
 for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2018 02:30:58 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h3e7xa704-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 02 Apr 2018 02:30:58 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 2 Apr 2018 07:30:57 +0100
Subject: [PATCH v3 7/7] powerpc/fadump: un-register fadump on kexec path.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, kernelfans@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 02 Apr 2018 12:00:52 +0530
In-Reply-To: <152265046485.23251.1392824827444770657.stgit@jupiter.in.ibm.com>
References: <152265046485.23251.1392824827444770657.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152265065140.23251.6907340015155817430.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

otherwise the fadump registration in new kexec-ed kernel complains that
fadump is already registered. This makes new kernel to continue using
fadump registered by previous kernel which may lead to invalid vmcore
generation. Hence this patch fixes this issue by un-registering fadump
in fadump_cleanup() which is called during kexec path so that new kernel
can register fadump with new valid values.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 2c3c7e655eec..cb496c8f40f3 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1345,6 +1345,9 @@ void fadump_cleanup(void)
 		init_fadump_mem_struct(&fdm,
 				get_fadump_metadata_base(fdm_active));
 		fadump_invalidate_dump(&fdm);
+	} else if (fw_dump.dump_registered) {
+		/* Un-register Firmware-assisted dump if it was registered. */
+		fadump_unregister_dump(&fdm);
 	}
 }
 

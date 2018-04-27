Return-Path: <srs0=we2z=hq=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40XP5C2bq9zF24d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2018 16:23:27 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40XP5C1kN3z8tF7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2018 16:23:27 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40XP5B4dbyz9rxx
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2018 16:23:26 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3R6MxCA137363
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2018 02:23:24 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hkvkjkwcu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2018 02:23:24 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 27 Apr 2018 07:23:22 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w3R6NKCx8061204
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2018 06:23:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 578624C04E
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2018 07:15:37 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6F124C044
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2018 07:15:36 +0100 (BST)
Received: from jupiter.in.ibm.com (unknown [9.109.203.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2018 07:15:36 +0100 (BST)
Subject: [PATCH] powerpc/fadump: Unregister fadump on kexec down path.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Fri, 27 Apr 2018 11:53:18 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152481017041.9024.9087742951572073802.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Unregister fadump on kexec down path otherwise the fadump registration in
new kexec-ed kernel complains that fadump is already registered. This
makes new kernel to continue using fadump registered by previous kernel
which may lead to invalid vmcore generation. Hence this patch fixes this
issue by un-registering fadump in fadump_cleanup() which is called during
kexec path so that new kernel can register fadump with new valid values.

Fixes: b500afff11f6 ("fadump: Invalidate registration and release reserved memory for general use.")
Cc: stable@vger.kernel.org
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 8ceabef40d3d..07e8396d472b 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1180,6 +1180,9 @@ void fadump_cleanup(void)
 		init_fadump_mem_struct(&fdm,
 			be64_to_cpu(fdm_active->cpu_state_data.destination_address));
 		fadump_invalidate_dump(&fdm);
+	} else if (fw_dump.dump_registered) {
+		/* Un-register Firmware-assisted dump if it was registered. */
+		fadump_unregister_dump(&fdm);
 	}
 }
 

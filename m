Return-Path: <srs0=trvj=hp=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WwCT0mmdzF24t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 21:42:13 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40WwCS6mFLz8tF7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 21:42:12 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40WwCS2kzcz9rxs
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 21:42:12 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3QBd9wx030562
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 07:42:10 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hkcp2byy2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 07:42:10 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 26 Apr 2018 12:42:08 +0100
Subject: [PATCH v5 1/4] powerpc/fadump: un-register fadump on kexec path.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, kernelfans@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>
Date: Thu, 26 Apr 2018 17:12:03 +0530
In-Reply-To: <152474278043.5697.2553982145593952228.stgit@jupiter.in.ibm.com>
References: <152474278043.5697.2553982145593952228.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152474292369.5697.4957552670306451723.stgit@jupiter.in.ibm.com>
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
 

Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4830BC10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 11:01:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C312073F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 11:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C312073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k2VL5jdzzDqDt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 21:01:14 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44k1xh1MMtzDqFF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 20:36:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44k1xh0Fh9z8tVP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 20:36:24 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44k1xg6xlCz9s5c; Tue, 16 Apr 2019 20:36:23 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=hbathini@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44k1xg3mgBz9s00
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 20:36:23 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3GAWf5W044545
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 06:36:22 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rwbr3vvjw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 06:36:21 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Tue, 16 Apr 2019 11:36:19 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Apr 2019 11:36:17 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3GAaFCT60227752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2019 10:36:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84D6EA4060;
 Tue, 16 Apr 2019 10:36:15 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34DB5A405B;
 Tue, 16 Apr 2019 10:36:14 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.184.183.117])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2019 10:36:14 +0000 (GMT)
Subject: [PATCH v2 15/16] powernv/fadump: consider f/w load area
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Tue, 16 Apr 2019 16:06:13 +0530
In-Reply-To: <155541065470.812.7120798773144842076.stgit@hbathini.in.ibm.com>
References: <155541065470.812.7120798773144842076.stgit@hbathini.in.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041610-0012-0000-0000-0000030F5E0A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041610-0013-0000-0000-00002147967B
Message-Id: <155541097094.812.18328895014763068053.stgit@hbathini.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-16_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160072
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Stewart Smith <stewart@linux.ibm.com>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

OPAL loads kernel & initrd at 512MB offset (256MB size), also exported
as ibm,opal/dump/fw-load-area. So, if boot memory size of FADump is
less than 768MB, kernel memory to be exported as '/proc/vmcore' would
be overwritten by f/w while loading kernel & initrd. To avoid such a
scenario, enforce a minimum boot memory size of 768MB on OPAL platform.

Also, skip using FADump if a newer F/W version loads kernel & initrd
above 768MB.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/kernel/fadump-common.h          |   15 +++++++++++++--
 arch/powerpc/kernel/fadump.c                 |    8 ++++++++
 arch/powerpc/platforms/powernv/opal-fadump.c |   23 +++++++++++++++++++++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/fadump-common.h b/arch/powerpc/kernel/fadump-common.h
index 1bd3aeb..f59fdc7 100644
--- a/arch/powerpc/kernel/fadump-common.h
+++ b/arch/powerpc/kernel/fadump-common.h
@@ -24,14 +24,25 @@
 #define RMA_END		(ppc64_rma_size)
 
 /*
+ * With kernel & initrd loaded at 512MB (with 256MB size), enforce a minimum
+ * boot memory size of 768MB to ensure f/w loading kernel and initrd doesn't
+ * mess with crash'ed kernel's memory during MPIPL.
+ */
+#define OPAL_MIN_BOOT_MEM	(0x30000000UL)
+
+/*
  * On some Power systems where RMO is 128MB, it still requires minimum of
  * 256MB for kernel to boot successfully. When kdump infrastructure is
  * configured to save vmcore over network, we run into OOM issue while
  * loading modules related to network setup. Hence we need additional 64M
  * of memory to avoid OOM issue.
  */
-#define MIN_BOOT_MEM	(((RMA_END < (0x1UL << 28)) ? (0x1UL << 28) : RMA_END) \
-			+ (0x1UL << 26))
+#define PSERIES_MIN_BOOT_MEM	(((RMA_END < (0x1UL << 28)) ? (0x1UL << 28) : \
+				 RMA_END) + (0x1UL << 26))
+
+#define MIN_BOOT_MEM	((fw_dump.fadump_platform ==			\
+			 FADUMP_PLATFORM_POWERNV) ? OPAL_MIN_BOOT_MEM :	\
+			 PSERIES_MIN_BOOT_MEM)
 
 /* The upper limit percentage for user specified boot memory size (25%) */
 #define MAX_BOOT_MEM_RATIO			4
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index ba26169..3c3adc2 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -582,6 +582,14 @@ int __init fadump_reserve_mem(void)
 				ALIGN(fw_dump.boot_memory_size,
 							FADUMP_CMA_ALIGNMENT);
 #endif
+
+		if ((fw_dump.fadump_platform == FADUMP_PLATFORM_POWERNV) &&
+		    (fw_dump.boot_memory_size < OPAL_MIN_BOOT_MEM)) {
+			pr_err("Can't enable fadump with boot memory size (0x%lx) less than 0x%lx\n",
+			       fw_dump.boot_memory_size, OPAL_MIN_BOOT_MEM);
+			goto error_out;
+		}
+
 		fw_dump.rmr_source_len = fw_dump.boot_memory_size;
 		if (!fadump_get_rmr_regions()) {
 			pr_err("Too many holes in boot memory area to enable fadump\n");
diff --git a/arch/powerpc/platforms/powernv/opal-fadump.c b/arch/powerpc/platforms/powernv/opal-fadump.c
index f530df0..0a22257 100644
--- a/arch/powerpc/platforms/powernv/opal-fadump.c
+++ b/arch/powerpc/platforms/powernv/opal-fadump.c
@@ -528,6 +528,29 @@ int __init opal_dt_scan_fadump(struct fw_dump *fadump_conf, ulong node)
 			fadump_conf->cpu_state_entry_size =
 						of_read_number(prop, 1);
 		}
+	} else {
+		int i, len;
+
+		prop = of_get_flat_dt_prop(dn, "fw-load-area", &len);
+		if (prop) {
+			/*
+			 * Each f/w load area is an (address,size) pair,
+			 * 2 cells each, totalling 4 cells per range.
+			 */
+			for (i = 0; i < len / (sizeof(*prop) * 4); i++) {
+				u64 base, end;
+
+				base = of_read_number(prop + (i * 4) + 0, 2);
+				end = base;
+				end += of_read_number(prop + (i * 4) + 2, 2);
+				if (end > OPAL_MIN_BOOT_MEM) {
+					pr_err("F/W load area: 0x%llx-0x%llx\n",
+					       base, end);
+					pr_err("F/W version not supported!\n");
+					return 1;
+				}
+			}
+		}
 	}
 
 	fadump_conf->ops		= &opal_fadump_ops;


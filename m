Return-Path: <linuxppc-dev+bounces-27662-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B53C88E75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 06:42:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmNMk3Glhz2y2W;
	Fri, 18 Sep 2026 16:42:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789713730;
	cv=none; b=F1i2lspP1Nst0OsUVlu/rEIl2JijFEfbQ41kAeb/8cfMRYazAro7K8zmRI4LnqQPCK5t7VInegvwq+8ZndQ3ywforqVDdsgpb20RgFl9lK1wm1tPz5ueNy63gU4HHAV6QcGwlJDF3lPeXYqus2pnHQt9GoJEouETBDmhJ18W+22tWUqhfCYBcPz+2A+2gJQBDYjz28vC7bayyAA9RV3S0032CeDH/OmARFY9Tam+NP1p98L2aWhiJ0YP6If32dDjUxiN5glU43EIlZAU8/z97JDtKRQepQa2L9gs5AT5BoaYuHA8gM7U+FLxtObX/DmkxSjlui5Iz6XR3lRW2VKM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789713730; c=relaxed/relaxed;
	bh=6Ff/k2AQNw9Zhejj8Wnz7dSuHmbKQb6zOecLLIG7u+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eh0ABk4RiSTiuBaiCHEwk9+QjTkfHK4DpdIVbFr6EnGdx/LoKDlRK5rxasOzJEBPZ9bit13Ue8Wr2Yjs+2uQq6Hz+KmE/QDwWQClZLJJycuFjdXU5KJfMKAz+NZXpqiWrK//PZxLH6kVnkZjX4X+vhgsLgvRzYc8Xvq2ur1/kUkJ3/iWK1RyiWI080tUhZg72/eT6XHTUOCb5TdkupDDrtzYE3Xwlx/5A+xf7rICwvBvkNQ7gLI9IONkW+6idFARxLj7KWDV0HFnrydnmF/jb7dKc75B3pJVUySsyaou8LVU4CSyxj0PF6h920e07UEIOQKVk+bdvB9637RWqQyg6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kMzt8Zn6; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shirisha@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kMzt8Zn6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shirisha@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmNMj0Mzwz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 16:42:08 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I2VhEm4092216;
	Fri, 18 Sep 2026 05:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6Ff/k2
	AQNw9Zhejj8Wnz7dSuHmbKQb6zOecLLIG7u+g=; b=kMzt8Zn6x5QPHoR7sxRyrC
	tPiNwKrEmjDC2pnG0H6caQTY2VuFZIx5z8G7CnYa13QL42Y9lRlv0oBzAnUoh+nH
	Iady+2rsjZbg9vnKzDQZIhs62UKDGy57YwmiGNYT3eW+GXPU2wu8vBCf1ssomgB0
	f76+N3Cs0Ai1lMw4Ks1pD6TfccM/tklIRXaddh6IqnPVX2Vwqlhvc8I0sV5fifx3
	EuSoNXpHzbRFp2CySapToRF0y2j0yFjTKiwQB9Cnfz0fjP65k+Zu0yy0QHgU5D/6
	TULut12cWFyqPQHQt9WtoJnlRSSbFF1419QyS1jR/Uoti4J84NJ4R+zju3355KvQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j63a4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 05:23:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I2Z4HU4128766;
	Fri, 18 Sep 2026 05:23:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3fcy5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 05:23:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I5Nbfj32309794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 05:23:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BD1020043;
	Fri, 18 Sep 2026 05:23:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B23E920040;
	Fri, 18 Sep 2026 05:23:33 +0000 (GMT)
Received: from li-d12addcc-2792-11b2-a85c-bd8df30615ab.ibm.com.com (unknown [9.66.68.7])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 05:23:33 +0000 (GMT)
From: Shirisha G <shirisha@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kselftest@vger.kernel.org, maddy@linux.ibm.com,
        venkat88@linux.ibm.com, shirisha@linux.ibm.com
Subject: [PATCH 2/7] Subject: [PATCH] selftests/powerpc: Add NVRAM access test
Date: Fri, 18 Sep 2026 10:52:37 +0530
Message-ID: <20260918052321.932660-2-shirisha@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918052321.932660-1-shirisha@linux.ibm.com>
References: <20260918052321.932660-1-shirisha@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA2NCBTYWx0ZWRfX4vbSnxLxCEMZ
 qWjVeL2xM51TyVYU8YQ1qZIW4Knhdvj/w9NEmmBny//AaCdAREBnr4NqwIrxRWYmKSu2mfBxW69
 wEwAK+op1m2AJJZPFAaTvbyGTG5FhIVmUjx1xkW7RNgMaROg2UUeOMLd4Yii54bjEm+myZSTq2M
 7n+SB8ubkg5MBf0A4IlfPP3Odm29yY0A/3NoX2WoK+pGMm/qGBGdDw53Oxf8OenEB00z7uhGptn
 U4fRXOs8irkfUKAXzb2FJnFR/Iz/j3aJ5xhsCUL3aUNToUlkwF09SmgXx3WXeI8dqdK036714CN
 TR/eYnJ5Tmy0GozmSeeDpWAh8Q3Tz/S0HLTBOxM2DX8EEOJN7x1VJP/Xa3lt8LsgP18nHHax6Lv
 UdkUubyC0iIZIxIUNrqhtGvko2MyvX2bY+iMXgRl7L5PmbW5zzsusFKfkrnTYlOGj7Js4imWXWy
 h+Lig0DFzz4LvUQIT1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA2NCBTYWx0ZWRfXxEaWHmlscVTg
 ZaiumB1GsWsYPWf9LxYTThzLRHOop4p6t0iyNO4tlEvon8+vFknkt4eq8rVZll/leAL9hlOhLNx
 tNmi55O0qnBIasH4XkIKbkbtIPPdZNA=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aaccade cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=DMQjfiTAl8tXje2OjmwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vUCDbKeqlxPu80BcQ9wAOU6YVTvvlEh5
X-Proofpoint-GUID: vUCDbKeqlxPu80BcQ9wAOU6YVTvvlEh5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180064

Add kselftest for NVRAM access on pseries/PowerVM systems. This test
validates basic device operations and partition discovery via pstore,
which replaces the legacy /proc/ppc64/nvram interface.

The test verifies:
- Existence and readability of /dev/nvram
- Discovery of NVRAM partitions from /sys/fs/pstore
- Correct parsing of partition names and indices
- Basic read and lseek operations on the device
- Overflow protection by rejecting reads beyond device size

Signed-off-by: Shirisha G <shirisha@linux.ibm.com>
---
 .../selftests/powerpc/rtas/nvram_test.c       | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/rtas/nvram_test.c

diff --git a/tools/testing/selftests/powerpc/rtas/nvram_test.c b/tools/testing/selftests/powerpc/rtas/nvram_test.c
new file mode 100644
index 000000000000..b0582d17324f
--- /dev/null
+++ b/tools/testing/selftests/powerpc/rtas/nvram_test.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NVRAM Access Test
+ * Copyright (C) 2026 IBM Corporation
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <dirent.h>
+#include <errno.h>
+#include "utils.h"
+
+#define NVRAM_DEV       "/dev/nvram"
+#define NVRAM_PSTORE    "/sys/fs/pstore"   /* replaces dead /proc/ppc64/nvram */
+#define NVRAM_SIZE      8192               /* Typical NVRAM size */
+
+struct nvram_partition {
+	char name[64];
+	unsigned int index;
+};
+
+/*
+ * Discover NVRAM partitions from /sys/fs/pstore by listing entries whose
+ * names contain "nvram".  On RTAS/PowerVM systems /proc/ppc64/nvram does
+ * not exist; pstore is the authoritative in-kernel view of NVRAM regions.
+ *
+ * Returns number of partitions found, or -1 if the directory cannot be
+ * opened (caller should SKIP_IF the result is < 0).
+ */
+static int read_nvram_partitions(struct nvram_partition *parts, int max_parts)
+{
+	DIR *dir;
+	struct dirent *ent;
+	int count = 0;
+
+	dir = opendir(NVRAM_PSTORE);
+	if (!dir)
+		return -1;
+
+	while ((ent = readdir(dir)) != NULL && count < max_parts) {
+		/* Only interested in entries that contain "nvram" */
+		if (strstr(ent->d_name, "nvram") == NULL)
+			continue;
+
+		/*
+		 * pstore filenames follow the pattern  <type>-nvram-<id>
+		 * e.g. "rtas-nvram-2", "dmesg-nvram-1".
+		 * Parse the trailing numeric id as the partition index.
+		 */
+		strncpy(parts[count].name, ent->d_name,
+			sizeof(parts[count].name) - 1);
+		parts[count].name[sizeof(parts[count].name) - 1] = '\0';
+
+		/* Extract trailing index after the last '-' */
+		char *p = strrchr(ent->d_name, '-');
+		parts[count].index = p ? (unsigned int)atoi(p + 1) : 0;
+
+		count++;
+	}
+
+	closedir(dir);
+	return count;
+}
+
+int main(void)
+{
+	int fd, ret;
+	char buf[256];
+	struct nvram_partition parts[32];
+	int part_count;
+	off_t offset;
+
+	test_harness_set_timeout(10);
+
+	/* Test 1: Verify /dev/nvram exists — skip gracefully if not */
+	SKIP_IF(access(NVRAM_DEV, R_OK) != 0);
+
+	/* Test 2: Open NVRAM device */
+	fd = open(NVRAM_DEV, O_RDONLY);
+	FAIL_IF(fd < 0);
+
+	/*
+	 * Test 3: Read NVRAM partition table from /sys/fs/pstore.
+	 * Use SKIP_IF when the directory is absent (part_count < 0) so the
+	 * test does not hard-fail on kernels/configs that lack pstore, while
+	 * still failing when the directory exists but is empty (part_count==0).
+	 */
+	part_count = read_nvram_partitions(parts, 32);
+	SKIP_IF(part_count < 0);
+	FAIL_IF_MSG(part_count == 0, "No NVRAM partitions found in " NVRAM_PSTORE);
+
+	printf("Found %d NVRAM partition(s) in " NVRAM_PSTORE ":\n", part_count);
+	for (int i = 0; i < part_count; i++)
+		printf("  %s (index=%u)\n", parts[i].name, parts[i].index);
+
+	/* Test 4: Read from start of device */
+	ret = read(fd, buf, sizeof(buf));
+	FAIL_IF_MSG(ret < 0, "Failed to read from " NVRAM_DEV);
+
+	/* Test 5: lseek to start */
+	offset = lseek(fd, 0, SEEK_SET);
+	FAIL_IF_MSG(offset != 0, "lseek to start failed");
+
+	/* Test 6: lseek to arbitrary offset */
+	offset = lseek(fd, 100, SEEK_SET);
+	FAIL_IF_MSG(offset != 100, "lseek to offset 100 failed");
+
+	/* Test 7: Overflow protection — read past NVRAM_SIZE must not succeed */
+	/*
+     	 * Test 7: Overflow protection.
+     	 * Discover the real device size via SEEK_END; if the driver supports it,
+     	 * attempt a read past that boundary — it must return 0 or error.
+     	 * Do not use a hardcoded NVRAM_SIZE: the actual size varies by platform
+     	 * and the RTAS driver will happily return data if the seek lands within
+     	 * the real (larger) device.                                  FIX 2
+     	 */
+	off_t nvram_size = lseek(fd, 0, SEEK_END);
+	if (nvram_size > 0) {
+		offset = lseek(fd, nvram_size + 1000, SEEK_SET);
+		ret = read(fd, buf, sizeof(buf));
+		FAIL_IF_MSG(ret > 0, "Read succeeded beyond NVRAM size");
+	}
+
+	close(fd);
+	printf("NVRAM test passed\n");
+	return 0;
+}
-- 
2.43.5



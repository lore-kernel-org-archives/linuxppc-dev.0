Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF64B606A32E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mh5Ua1v/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYlFf3ld4z2yCP;
	Wed, 25 Nov 2026 01:15:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795529718;
	cv=none; b=Nc+wEIDdy/T7fasQxbObtlcpiH/jP15Gq+x/ADNGPpxLPYMIs6Dtraw/JmJWDgJNLJQyeFiMHcXyf1kWvZx+9+H1ojPTz3RACDuMu4hEj8gTge2ShCuH8P2jou3QCkFxysivMzXVikUJUHrNEdpsLf0u3a2D+LLxp3E1kHFcTLir2mm9GnwQKj4noGL0BuIbj0PFDw9bT2vJNCwnJCvpvLJODtnqSkak1qF3FJx55YVghWXdcm+L0zE89lS6y+s+SJKCR5RgeTU7kwMqg9L9NEreUyYkNn5vr+5ojKLW/MFN9qZ8ULk7IOYdPDpRHbJiVKyHyWgVtYkTH1TWf35F4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795529718; c=relaxed/relaxed;
	bh=oWUJPzvdHM2TxxBtphXU4nSre1M/5xSbG4Mi8R6YQ3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVKhquS7DuHXAAKx+Dk1WAZ7M/4YXPX0gNh2jVV1J0cOtWqiXEzG13PGTjD3Xfq7gfETr/mrXVVRFiJFYYujL0hbNGFnstSxvoIKi5Br1H+qPxXCcf6iMp1ngyvjof+GS0KEpno53h0jFpp/vnUbkYbfIFnjRwJdu0JgJlhVsRR5mIGFAB7I5nh2Pzm+OLoi3nMwDpY1f5CK/C153YvpC2J4/BVRGn4/UxHqIj4aodUH/lqEluE9U2A9vD/lnSo+nqPNIkwoBiKkLNXb/NC87ZBwwvtbbtEm3BLtxx4hF9nsyXx0MGFhwzCO5lwN6EnKp0h1ovgaDbcORSxtr69muw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mh5Ua1v/; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mh5Ua1v/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYlFc6QvJz2y2b
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 01:15:16 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOB4vSN2190287;
	Tue, 24 Nov 2026 14:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oWUJPz
	vdHM2TxxBtphXU4nSre1M/5xSbG4Mi8R6YQ3A=; b=mh5Ua1v/amhWItAoZzhqrU
	A0A2loAt/bgnKHR0ZMvHafKebaMA5f+gy8zy5UmhXlMyUZwR669ZMd4zBO3gSPFJ
	th3RZbm6RtcH5KmJtNAFWbGGLk+WQgyE9u8JlOhKnh65Ep3Hn2sEGjfNtsp/m+/b
	MjCk1IWt1RmOXO/zNqzl/WH+7ZXFY5AQaNLmW0/GsHafVBCKEeNaooD3HJTog3Tb
	UqU3wvXQ+Mhy6WTJziQkHI/gviwoizxz3vsbmrSHrBFvWWV/uIVvXhv/QFVPTyIg
	VaMksAmuo2Lq5MoNMa3tu/Yy610qK+ojEVf7YN+clJjoSNiBFv9YGqPcIoFaVnpw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv7nhe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 14:15:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOBripr595739;
	Tue, 24 Nov 2026 14:15:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5a410de2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 14:15:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOEF8L454591846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 14:15:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5EC820043;
	Tue, 24 Nov 2026 14:15:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A0062004B;
	Tue, 24 Nov 2026 14:15:07 +0000 (GMT)
Received: from [9.124.211.71] (unknown [9.124.211.71])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 14:15:06 +0000 (GMT)
Message-ID: <1ebc499d-3a44-44ba-96d2-11888cbdecee@linux.ibm.com>
Date: Tue, 24 Nov 2026 19:45:04 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] Subject: [PATCH] selftests/powerpc: Add FADump sysfs
 interface test
To: Shirisha G <shirisha@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kselftest@vger.kernel.org, maddy@linux.ibm.com,
        venkat88@linux.ibm.com
References: <20260918052321.932660-1-shirisha@linux.ibm.com>
 <20260918052321.932660-4-shirisha@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260918052321.932660-4-shirisha@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b059bf1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=UhH_I6G2SCkOxVmFqGYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1NSBTYWx0ZWRfX0WRV7rsnHmPy
 K9F0A9Jtzmn60IJUtmmDGS+qQ1iisuL8JR5/qDgWfnFGcvtLEvJ3xiGjdkZSf1dBRw+0Nyx5GJI
 sHYW1IYAxQJgS3Lt8FS/gLDb2oRqt/8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1NSBTYWx0ZWRfXw9N1eKk+rqQe
 e0GHQjTYR6jkRfZWHBVe8rf7uvb6nfHeOV6Z4+nQyX/JUnL0JmroDYtBLuNEb6o8unXAy5u0rEw
 GRFt8YSXHc0rlTwL7lKLHE4qX7zUtE6e8ehBPRAPYh0ngCQyoNQcZXnrH5NL5PSv0EwxlkDxDPx
 VGNRhzYs5ppXwN/GWfKjmp56DAqBxahciiZQGFDVqxjCLnAGcWemSaoxbUViHiEGK6ijJB0XdtJ
 URxlkNvyn/TAsCJXkIJkKDgkrvDAzW/sqn/skPt8D4Mc6vouSgEJYh/4hUwOJMDZvsTyR+EoQZa
 Sp+cGTS4KM8C+pHJKu+bU5sCwikljV9sIwF1+VIPQDdRZWeb6YgNGzDcpBaOGS4jf4/6FaKV3dc
 VpxK4kewWz9ByRn7TjiQ10qlVLkGCLZZU2XVgvyqlJj3v6I/pCMjFkR4njDmtVOeIDfwxj2N9Dw
 WiOmHzJaxeAWhE3kePg==
X-Proofpoint-ORIG-GUID: 021ftE_km-GnqmrIAZ95qms1m9DLhBpV
X-Proofpoint-GUID: 021ftE_km-GnqmrIAZ95qms1m9DLhBpV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240055
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Shirisha,

The commit title has a Subject: [PATCH] prefix, which is not needed.
This applies to all patches in this series.

On 18/09/26 10:52, Shirisha G wrote:
> Add kselftest for Firmware-Assisted Dump (FADump) sysfs interface
> on pseries/PowerVM systems. This test validates registration and
> status reporting without triggering an actual crash.
>
> The test verifies:
> - Existence of `/sys/kernel/fadump/` directory
> - Reading enabled and registered status
> - Reserved memory size is non-zero when enabled
> - Attribute readability and permissions
> - Handling of invalid registration attempts
>
> Signed-off-by: Shirisha G <shirisha@linux.ibm.com>
> ---
>   .../selftests/powerpc/rtas/fadump_test.c      | 85 +++++++++++++++++++
>   1 file changed, 85 insertions(+)
>   create mode 100644 tools/testing/selftests/powerpc/rtas/fadump_test.c
>
> diff --git a/tools/testing/selftests/powerpc/rtas/fadump_test.c b/tools/testing/selftests/powerpc/rtas/fadump_test.c
> new file mode 100644
> index 000000000000..92ff70e4b580
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/rtas/fadump_test.c

Why is the fadump sysfs test under rtas? It has hardly anything to do
with RTAS. Please find a better place for this test.


Here is an optimized version of this test case with fewer lines of code:

#include <stdio.h>
#include <unistd.h>
#include "utils.h"

#define FADUMP_SYSFS    "/sys/kernel/fadump/"

static int test_fadump_sysfs(void)
{
     long enabled, registered, mem_reserved;

     SKIP_IF_MSG(access(FADUMP_SYSFS "enabled", R_OK),
             "FADump not supported on this platform");

     FAIL_IF(read_long(FADUMP_SYSFS "enabled", &enabled, 10));
     FAIL_IF(enabled != 0 && enabled != 1);

     /* Remaining attributes are only created when FADump is enabled */
     SKIP_IF_MSG(!enabled, "FADump supported but not enabled");

     FAIL_IF(read_long(FADUMP_SYSFS "registered", &registered, 10));
     FAIL_IF(read_long(FADUMP_SYSFS "mem_reserved", &mem_reserved, 10));

     printf("registered=%ld mem_reserved=%ld\n", registered, mem_reserved);

     FAIL_IF(registered != 0 && registered != 1);
     FAIL_IF(!mem_reserved);

     return 0;
}

int main(void)
{
     test_harness_set_timeout(10);
     return test_harness(test_fadump_sysfs, "fadump_test");
}

Can you please review the APIs used in the above test and use them in 
the other
tests introduced in this patch series to make them more modular?

- Sourabh Jain

> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Firmware-Assisted Dump (FADump) Test
> + * Copyright (C) 2026 IBM Corporation
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include "utils.h"
> +
> +#define FADUMP_DIR "/sys/kernel/fadump"
> +#define FADUMP_ENABLED "/sys/kernel/fadump/enabled"
> +#define FADUMP_REGISTERED "/sys/kernel/fadump/registered"
> +#define FADUMP_MEM_RESERVED "/sys/kernel/fadump/mem_reserved"
> +#define FADUMP_REGISTER "/sys/kernel/fadump/fadump_register"
> +
> +static int read_sysfs_int(const char *path)
> +{
> +	FILE *fp;
> +	int value = -1;
> +
> +	fp = fopen(path, "r");
> +	if (fp) {
> +		fscanf(fp, "%d", &value);
> +		fclose(fp);
> +	}
> +	return value;
> +}
> +
> +static unsigned long read_sysfs_ulong(const char *path)
> +{
> +	FILE *fp;
> +	unsigned long value = 0;
> +
> +	fp = fopen(path, "r");
> +	if (fp) {
> +		fscanf(fp, "%lu", &value);
> +		fclose(fp);
> +	}
> +	return value;
> +}
> +
> +int main(void)
> +{
> +	int enabled, registered;
> +	unsigned long mem_reserved;
> +
> +	test_harness_set_timeout(10);
> +
> +	/* Test 1: Verify FADump sysfs directory exists */
> +	SKIP_IF(access(FADUMP_DIR, R_OK) != 0);
> +
> +	/* Test 2: Read enabled status */
> +	enabled = read_sysfs_int(FADUMP_ENABLED);
> +	FAIL_IF_MSG(enabled < 0, "Failed to read FADump enabled status");
> +	printf("FADump enabled: %d\n", enabled);
> +
> +	/* Test 3: Read registered status */
> +	registered = read_sysfs_int(FADUMP_REGISTERED);
> +	FAIL_IF_MSG(registered < 0, "Failed to read FADump registered status");
> +	printf("FADump registered: %d\n", registered);
> +
> +	/* Test 4: Read reserved memory */
> +	mem_reserved = read_sysfs_ulong(FADUMP_MEM_RESERVED);
> +	printf("FADump reserved memory: %lu bytes\n", mem_reserved);
> +
> +	if (enabled) {
> +		FAIL_IF_MSG(mem_reserved == 0,
> +		            "FADump enabled but no memory reserved");
> +	}
> +
> +	/* Test 5: Verify sysfs attributes are readable */
> +	FAIL_IF(access(FADUMP_ENABLED, R_OK) != 0);
> +	FAIL_IF(access(FADUMP_REGISTERED, R_OK) != 0);
> +	FAIL_IF(access(FADUMP_MEM_RESERVED, R_OK) != 0);
> +
> +	/* Note: We don't test actual registration/unregistration here
> +	 * as it requires root and could affect system stability */
> +
> +	printf("FADump test passed\n");
> +	return 0;
> +}



Return-Path: <linuxppc-dev+bounces-26662-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D27CC79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 09:21:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdhR22FcLz2y2L;
	Mon, 07 Sep 2026 19:21:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788772910;
	cv=none; b=ehsOSghdD+jO9nlbPZr6q+4DuoSPtx2Ja83HbhZuV2yAOr8fmSgi/wj2Bx2+gTZIuul8Vewif9JVPcf+MXl/uFD2DqBt7Nrr88lSg5u4Rg/uiwCVz30d/aN5ssjXh4BiwPPvXG+sIhp0jwki4oew14WzCqM5GPL+CREp/tUXhJRpjSzAyRA++BlYxFidC95eMMIz5FVRo0+3BJiE3M35AeY8aAIwm/VNq+LD+AsCm13brbCuRVptd8dDE32/rri/JeRox9DAmnWTAuproDdgV43GGknakzTj/2r9lgCn0LOoHxFLTCdp3LIYMcoR9NiEqx4XomQVVjdR7F/XK50HOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788772910; c=relaxed/relaxed;
	bh=jTy6krjh9Wngiv7weaIsbsylnvOTMdxdKMueqpNN9ok=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CaAuKW5cD+WLrDwfAimQVkXudOpsGi69Nlmz3te3knU9/3ozWM34zwDYRmDuRNCreu5sBha8nrrmHamWHv2f8FomwrQ1qLSqcOXwOrMwiULCTAjVNC+L+ebv6GG31RrNmeH4o6Em60UP/K+AUePLWACRBjX0iPX5nC37lgDs85Q955baC2ypRXsotOpslJvx0QRy/dI5ghILGzScrE4323DRJQob5ycMPnyzt+KmWlnU+1jSH0uFY0mVVH86i2KeeoCUt9pCKtlJ0vSFD6/WbpAGeKoWccEOETvkJBuWV6LPwpBJjGLLM1mcBhgBHMoQ1RjJOicaeh/sTX3luwGfqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y1NQI8NX; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=pavrampu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y1NQI8NX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=pavrampu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdhR03ff4z2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 19:21:48 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6877VhWi137356;
	Mon, 7 Sep 2026 09:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jTy6kr
	jh9Wngiv7weaIsbsylnvOTMdxdKMueqpNN9ok=; b=Y1NQI8NXfOvVzZDdIdZ7WG
	7ZONe+OPq8bz1eEyMwwCrDqs4lje+SC/lfUdfBkxdr1xSBTqv+bklHqqNQj8UrkJ
	FlKRmAckzNboizzmARbhwn8ZTknIby3KaF4pXFMF+8+HuA4D6sFoeSdHJOF8073G
	kZhiXEvv17MdP21fpdyfZBipA35EyjpACZp7X8zTLy8ZWT/u3KCf6couztTPgKAz
	EC4z3h+swicH4pjiPkAK0bLWQnHwqn4vFL3tz/D9fgvXUG+Ge9uGKNhnYwM9S0/m
	8T/UvJI2lJg+URKlZ2J+fdMR8xl2CjoGiYtS4k70Na98VTVKrntHyc9exNRsCDVA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrfnyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 09:21:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6879BM3B026683;
	Mon, 7 Sep 2026 09:21:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03y4ud2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 09:21:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6879LbwU11666052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 09:21:37 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AE8358045;
	Mon,  7 Sep 2026 09:21:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5C0958050;
	Mon,  7 Sep 2026 09:21:36 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Sep 2026 09:21:36 +0000 (GMT)
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
Date: Mon, 07 Sep 2026 14:51:36 +0530
From: pavrampu <pavrampu@linux.ibm.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests/powerpc: add papr_pseries test suite
In-Reply-To: <20260905182656.993870-1-pavrampu@linux.ibm.com>
References: <20260905182656.993870-1-pavrampu@linux.ibm.com>
Message-ID: <47ba2affa6402621d3b56267f0e0500b@linux.ibm.com>
X-Sender: pavrampu@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6a9e8222 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=voM4FWlXAAAA:8
 a=VnNF1IyMAAAA:8 a=nmevRPdqCHaCiig-EqUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5OCBTYWx0ZWRfX++PmI27GiaSY
 AE4cdfNMRtgd54ptxsi3Gs6Gb7B5cnK4OSx4eyHy6N3uEbs2eZFbcfdqMiDwp4plnMj+qHbFhhc
 Kn3cvsnXc4u8zcIS7HMzWHF9v/DTRrM=
X-Proofpoint-ORIG-GUID: cYCrzBrgsAD7Ucknb3NT24OyIEu_8Tpa
X-Proofpoint-GUID: cYCrzBrgsAD7Ucknb3NT24OyIEu_8Tpa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5OCBTYWx0ZWRfXx7Y7H/QlCQ9U
 R9jCs8wOYfZCO6dqWIA2tPAnu7NwyuWyIpybU4b5K3V4jBtJMN14gtln44QDartcjUAsDrVjEHX
 OE3r8R5WqIq0eF/SofYD8zwXvVO6bh0hIt6B33eZ5vTtjY4O40UByUwhWepV9YJ0OF+VjFNSKhm
 hd2V/KTU9CWuYoJSKJeT3mZQwsZNfl2adUiGPEC+QcRHrSdr8s9yFg/NaIH0ZBKsMNzwIM31i/Z
 ruyZl9H/LCRWrSV+tOkkpSftOjl1Y0Gtzd3ypGmt/qhECSE+au5gpZjNSInoxuLYYjAFXKcq2KQ
 eVCpU4d6pXlLXQBvXdSxlvB7zrlNeOv1Doz4In1vOHBWCmR7q1/QnO7qnSQita8w8AgE+Y2B0iw
 JCC7ujLxtMDNk8aQWk2SaL1IHCGbAI3Kbu6ss1q6MDmj11gvVo7KTHdz3gYMl2VNfdZBm2cSVdG
 8iH73cVZFPSxac+HbgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070098

++ adding linuxppc-dev@lists.ozlabs.org

On 2026-09-05 23:56, Pavithra wrote:
> Add a set of selftests for pSeries/PowerVM-specific kernel interfaces:
> - lparcfg_test: validates /proc/ppc64/lparcfg fields (partition_id,
>   shared_processor_mode, processor counts, partition_entitled_capacity,
>   partition_name, system_type)
> - dtl_test: validates the vpa_dtl perf PMU by running perf record
>   against the DTL event source and confirming samples are captured;
>   skips gracefully if the PMU is absent or perf is not installed
> - pseries_energy_test: validates CPU frequency from /proc/cpuinfo and
>   power management fields from /proc/ppc64/lparcfg
>   (partition_entitled_capacity, partition_max_entitled_capacity,
>   power_mode_data as a 16-character hex string)
> - papr_rtas_common_test: exercises RTAS work-area serialisation by
>   issuing 1000 concurrent get-time-of-day calls across 10 threads via
>   syscall(__NR_rtas) and asserting every call returns status 0
> 
> Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
> ---
>  tools/testing/selftests/powerpc/Makefile      |   1 +
>  .../selftests/powerpc/papr_pseries/Makefile   |  19 ++
>  .../selftests/powerpc/papr_pseries/dtl_test.c |  93 ++++++++++
>  .../powerpc/papr_pseries/lparcfg_test.c       | 125 +++++++++++++
>  .../papr_pseries/papr_rtas_common_test.c      | 171 ++++++++++++++++++
>  .../papr_pseries/pseries_energy_test.c        | 155 ++++++++++++++++
>  .../selftests/powerpc/papr_pseries/utils.h    |  19 ++
>  7 files changed, 583 insertions(+)
>  create mode 100644 
> tools/testing/selftests/powerpc/papr_pseries/Makefile
>  create mode 100644 
> tools/testing/selftests/powerpc/papr_pseries/dtl_test.c
>  create mode 100644 
> tools/testing/selftests/powerpc/papr_pseries/lparcfg_test.c
>  create mode 100644
> tools/testing/selftests/powerpc/papr_pseries/papr_rtas_common_test.c
>  create mode 100644
> tools/testing/selftests/powerpc/papr_pseries/pseries_energy_test.c
>  create mode 100644 
> tools/testing/selftests/powerpc/papr_pseries/utils.h
> 
> diff --git a/tools/testing/selftests/powerpc/Makefile
> b/tools/testing/selftests/powerpc/Makefile
> index b175e94e1901..93aaa7a90a1b 100644
> --- a/tools/testing/selftests/powerpc/Makefile
> +++ b/tools/testing/selftests/powerpc/Makefile
> @@ -26,6 +26,7 @@ SUB_DIRS = alignment		\
>  	   vphn         \
>  	   math		\
>  	   papr_attributes	\
> +	   papr_pseries		\
>  	   papr_vpd		\
>  	   papr_sysparm		\
>  	   ptrace	\
> diff --git a/tools/testing/selftests/powerpc/papr_pseries/Makefile
> b/tools/testing/selftests/powerpc/papr_pseries/Makefile
> new file mode 100644
> index 000000000000..2016a6e3a8e7
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/papr_pseries/Makefile
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0
> +noarg:
> +	$(MAKE) -C ../
> +
> +TEST_GEN_PROGS := lparcfg_test
> +TEST_GEN_PROGS += dtl_test
> +TEST_GEN_PROGS += pseries_energy_test
> +TEST_GEN_PROGS += papr_rtas_common_test
> +
> +top_srcdir = ../../../../..
> +include ../../lib.mk
> +include ../flags.mk
> +
> +$(TEST_GEN_PROGS): ../harness.c ../utils.c
> +
> +$(OUTPUT)/papr_rtas_common_test: CFLAGS += $(KHDR_INCLUDES)
> +$(OUTPUT)/papr_rtas_common_test: LDFLAGS += -lpthread
> +
> +$(OUTPUT)/dtl_test: CFLAGS += $(KHDR_INCLUDES)
> diff --git a/tools/testing/selftests/powerpc/papr_pseries/dtl_test.c
> b/tools/testing/selftests/powerpc/papr_pseries/dtl_test.c
> new file mode 100644
> index 000000000000..097c80def4c9
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/papr_pseries/dtl_test.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Dispatch Trace Log (DTL) Test
> + * Copyright (C) 2025 IBM Corporation
> + *
> + * Validates the vpa_dtl perf PMU on PowerVM LPARs.  The PMU sysfs 
> directory
> + * is created by the DTL subsystem when FW_FEATURE_SPLPAR is set.
> + *
> + * The test SKIPs when the vpa_dtl PMU is absent or perf is not 
> installed.
> + * The test FAILs when the PMU is present and perf is installed but 
> the
> + * event cannot be opened or produces no samples.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
> +#include <sys/wait.h>
> +#include "utils.h"
> +
> +#define VPA_DTL_PMU_PATH "/sys/bus/event_source/devices/vpa_dtl"
> +
> +static int perf_is_installed(void)
> +{
> +	return system("perf version >/dev/null 2>&1") == 0;
> +}
> +
> +static int test_dtl_via_perf(void)
> +{
> +	char outfile[] = "/tmp/dtl_test_XXXXXX";
> +	char cmd[256];
> +	struct stat st;
> +	int fd, ret;
> +
> +	fd = mkstemp(outfile);
> +	if (fd < 0) {
> +		fprintf(stderr, "[FAIL] mkstemp failed\n");
> +		return -1;
> +	}
> +	close(fd);
> +
> +	snprintf(cmd, sizeof(cmd),
> +		 "perf record -e vpa_dtl/dtl_all/ -a -o %s sleep 1 2>/dev/null",
> +		 outfile);
> +
> +	printf("Running: %s\n", cmd);
> +	ret = system(cmd);
> +
> +	if (ret != 0) {
> +		fprintf(stderr,
> +			"[FAIL] perf record failed (exit %d) -- vpa_dtl PMU present but
> perf could not open the event\n",
> +			WEXITSTATUS(ret));
> +		unlink(outfile);
> +		return -1;
> +	}
> +
> +	if (stat(outfile, &st) != 0) {
> +		fprintf(stderr,
> +			"[FAIL] perf record succeeded but output file was not created\n");
> +		unlink(outfile);
> +		return -1;
> +	}
> +
> +	if (st.st_size < 1024) {
> +		fprintf(stderr,
> +			"[FAIL] perf.data is only %ld bytes -- vpa_dtl PMU opened but
> delivered no samples\n",
> +			(long)st.st_size);
> +		unlink(outfile);
> +		return -1;
> +	}
> +
> +	printf("vpa_dtl PMU: %ld bytes of samples captured\n",
> +	       (long)st.st_size);
> +	unlink(outfile);
> +	return 0;
> +}
> +
> +int main(void)
> +{
> +	test_harness_set_timeout(30);
> +
> +	SKIP_IF_MSG(access(VPA_DTL_PMU_PATH, F_OK) != 0,
> +		    "vpa_dtl PMU not present (" VPA_DTL_PMU_PATH " missing)");
> +
> +	SKIP_IF_MSG(!perf_is_installed(),
> +		    "perf binary not found -- install perf to run this test");
> +
> +	printf("vpa_dtl PMU present, perf available\n");
> +	FAIL_IF(test_dtl_via_perf() != 0);
> +
> +	printf("dtl_test passed\n");
> +	return 0;
> +}
> diff --git
> a/tools/testing/selftests/powerpc/papr_pseries/lparcfg_test.c
> b/tools/testing/selftests/powerpc/papr_pseries/lparcfg_test.c
> new file mode 100644
> index 000000000000..b43af7e1c4e7
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/papr_pseries/lparcfg_test.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * LPAR Configuration Test
> + * Copyright (C) 2026 IBM Corporation
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include "utils.h"
> +
> +#define LPARCFG_PATH "/proc/ppc64/lparcfg"
> +
> +struct lparcfg_data {
> +	int partition_id;
> +	char partition_name[256];
> +	char system_type[256];
> +	int shared_processor_mode;
> +	int system_active_processors;
> +	int partition_active_processors;
> +	int partition_potential_processors;
> +	int partition_entitled_capacity;
> +	int found_fields;
> +};
> +
> +static int parse_lparcfg(struct lparcfg_data *data)
> +{
> +	FILE *fp;
> +	char line[512];
> +	char key[128], value[256];
> +
> +	memset(data, 0, sizeof(*data));
> +
> +	fp = fopen(LPARCFG_PATH, "r");
> +	if (!fp)
> +		return -1;
> +
> +	while (fgets(line, sizeof(line), fp)) {
> +		if (sscanf(line, "%127[^=]=%255[^\n]", key, value) == 2) {
> +			if (strcmp(key, "partition_id") == 0) {
> +				data->partition_id = atoi(value);
> +				data->found_fields++;
> +			} else if (strcmp(key, "partition_name") == 0) {
> +				snprintf(data->partition_name,
> +					 sizeof(data->partition_name),
> +					 "%s", value);
> +				data->found_fields++;
> +			} else if (strcmp(key, "system_type") == 0) {
> +				snprintf(data->system_type,
> +					 sizeof(data->system_type),
> +					 "%s", value);
> +				data->found_fields++;
> +			} else if (strcmp(key, "shared_processor_mode") == 0) {
> +				data->shared_processor_mode = atoi(value);
> +				data->found_fields++;
> +			} else if (strcmp(key, "system_active_processors") == 0) {
> +				data->system_active_processors = atoi(value);
> +				data->found_fields++;
> +			} else if (strcmp(key, "partition_active_processors") == 0) {
> +				data->partition_active_processors = atoi(value);
> +				data->found_fields++;
> +			} else if (strcmp(key, "partition_potential_processors") == 0) {
> +				data->partition_potential_processors = atoi(value);
> +				data->found_fields++;
> +			} else if (strcmp(key, "partition_entitled_capacity") == 0) {
> +				data->partition_entitled_capacity = atoi(value);
> +				data->found_fields++;
> +			}
> +		}
> +	}
> +
> +	fclose(fp);
> +	return 0;
> +}
> +
> +int main(void)
> +{
> +	struct lparcfg_data data;
> +
> +	test_harness_set_timeout(10);
> +
> +	SKIP_IF(access(LPARCFG_PATH, R_OK) != 0);
> +
> +	FAIL_IF(parse_lparcfg(&data) != 0);
> +
> +	FAIL_IF_MSG(data.found_fields < 5,
> +		    "Only found %d fields (expected at least 5)", 
> data.found_fields);
> +
> +	FAIL_IF_MSG(data.partition_id == 0, "partition_id is 0 (invalid)");
> +	printf("partition_id: %d\n", data.partition_id);
> +
> +	FAIL_IF_MSG(data.shared_processor_mode != 0 &&
> data.shared_processor_mode != 1,
> +		    "shared_processor_mode is %d (expected 0 or 1)",
> +		    data.shared_processor_mode);
> +	printf("shared_processor_mode: %d\n", data.shared_processor_mode);
> +
> +	FAIL_IF_MSG(data.system_active_processors <= 0,
> +		    "system_active_processors is %d (expected > 0)",
> +		    data.system_active_processors);
> +	printf("system_active_processors: %d\n", 
> data.system_active_processors);
> +
> +	FAIL_IF_MSG(data.partition_active_processors <= 0,
> +		    "partition_active_processors is %d (expected > 0)",
> +		    data.partition_active_processors);
> +	printf("partition_active_processors: %d\n", 
> data.partition_active_processors);
> +
> +	FAIL_IF_MSG(data.partition_potential_processors > 0 &&
> +		    data.partition_active_processors > 
> data.partition_potential_processors,
> +		    "partition_active_processors (%d) > 
> partition_potential_processors (%d)",
> +		    data.partition_active_processors, 
> data.partition_potential_processors);
> +
> +	FAIL_IF_MSG(data.partition_entitled_capacity == 0,
> +		    "partition_entitled_capacity is 0 (invalid)");
> +	printf("partition_entitled_capacity: %d\n", 
> data.partition_entitled_capacity);
> +
> +	FAIL_IF_MSG(strlen(data.partition_name) == 0, "partition_name is 
> empty");
> +	printf("partition_name: %s\n", data.partition_name);
> +
> +	FAIL_IF_MSG(strlen(data.system_type) == 0, "system_type is empty");
> +	printf("system_type: %s\n", data.system_type);
> +
> +	printf("lparcfg test passed\n");
> +	return 0;
> +}
> diff --git
> a/tools/testing/selftests/powerpc/papr_pseries/papr_rtas_common_test.c
> b/tools/testing/selftests/powerpc/papr_pseries/papr_rtas_common_test.c
> new file mode 100644
> index 000000000000..56e4ec6aa0fd
> --- /dev/null
> +++ 
> b/tools/testing/selftests/powerpc/papr_pseries/papr_rtas_common_test.c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PAPR RTAS Work-Area Locking Test
> + * Copyright (C) 2026 IBM Corporation
> + *
> + * Exercises the kernel's RTAS work-area serialisation under 
> concurrent load
> + * by spawning multiple threads that simultaneously issue the 
> get-time-of-day
> + * RTAS call via __NR_rtas.  Every call must return status 0; a 
> non-zero
> + * status indicates work-area corruption caused by a locking failure.
> + */
> +
> +#include <byteswap.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <pthread.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <sys/syscall.h>
> +#include "utils.h"
> +
> +#ifndef __NR_rtas
> +#error "This test requires a pSeries kernel (__NR_rtas is not 
> defined)"
> +#endif
> +
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> +#define cpu_to_be32(x)  bswap_32(x)
> +#define be32_to_cpu(x)  bswap_32(x)
> +#else
> +#define cpu_to_be32(x)  (x)
> +#define be32_to_cpu(x)  (x)
> +#endif
> +
> +#define OFDT_RTAS_PATH  "/proc/device-tree/rtas"
> +#define RTAS_UNKNOWN_OP (-1099)
> +
> +#define NUM_THREADS     10
> +#define ITERATIONS      100
> +
> +struct rtas_args {
> +	__be32  token;
> +	__be32  nargs;
> +	__be32  nret;
> +	__be32  args[16];
> +	__be32 *rets;
> +};
> +
> +static int gtod_token = RTAS_UNKNOWN_OP;
> +
> +static int rtas_get_token(const char *call_name)
> +{
> +	char path[256];
> +	__be32 raw;
> +	ssize_t n;
> +	int fd;
> +
> +	snprintf(path, sizeof(path), "%s/%s", OFDT_RTAS_PATH, call_name);
> +
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0)
> +		return RTAS_UNKNOWN_OP;
> +
> +	n = read(fd, &raw, sizeof(raw));
> +	close(fd);
> +
> +	if (n != (ssize_t)sizeof(raw))
> +		return RTAS_UNKNOWN_OP;
> +
> +	return (int)be32_to_cpu(raw);
> +}
> +
> +static int rtas_call_gtod(void)
> +{
> +	struct rtas_args args;
> +
> +	memset(&args, 0, sizeof(args));
> +	args.token = cpu_to_be32(gtod_token);
> +	args.nargs = cpu_to_be32(0);
> +	args.nret  = cpu_to_be32(1);
> +	args.rets  = &args.args[0];
> +
> +	if (syscall(__NR_rtas, &args) != 0)
> +		return -errno;
> +
> +	return (int)be32_to_cpu(args.args[0]);
> +}
> +
> +struct thread_data {
> +	int thread_id;
> +	int success_count;
> +	int error_count;
> +};
> +
> +static void *rtas_worker(void *arg)
> +{
> +	struct thread_data *data = (struct thread_data *)arg;
> +	int i, rc;
> +
> +	for (i = 0; i < ITERATIONS; i++) {
> +		rc = rtas_call_gtod();
> +		if (rc != 0) {
> +			fprintf(stderr,
> +				"[FAIL] thread %d iteration %d: get-time-of-day returned %d\n",
> +				data->thread_id, i, rc);
> +			data->error_count++;
> +		} else {
> +			data->success_count++;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +int main(void)
> +{
> +	pthread_t      threads[NUM_THREADS];
> +	struct thread_data thread_data[NUM_THREADS];
> +	int total_success = 0;
> +	int total_errors  = 0;
> +	int i, rc;
> +
> +	test_harness_set_timeout(60);
> +
> +	SKIP_IF(access(OFDT_RTAS_PATH, R_OK) != 0);
> +
> +	gtod_token = rtas_get_token("get-time-of-day");
> +	SKIP_IF(gtod_token == RTAS_UNKNOWN_OP);
> +	printf("get-time-of-day token: %d\n", gtod_token);
> +
> +	rc = rtas_call_gtod();
> +	FAIL_IF_MSG(rc != 0,
> +		    "Baseline get-time-of-day failed with status %d", rc);
> +	printf("Baseline get-time-of-day: OK\n");
> +
> +	printf("Spawning %d threads, %d RTAS calls each...\n",
> +	       NUM_THREADS, ITERATIONS);
> +
> +	for (i = 0; i < NUM_THREADS; i++) {
> +		thread_data[i].thread_id     = i;
> +		thread_data[i].success_count = 0;
> +		thread_data[i].error_count   = 0;
> +
> +		FAIL_IF(pthread_create(&threads[i], NULL, rtas_worker,
> +				       &thread_data[i]) != 0);
> +	}
> +
> +	for (i = 0; i < NUM_THREADS; i++) {
> +		FAIL_IF(pthread_join(threads[i], NULL) != 0);
> +		total_success += thread_data[i].success_count;
> +		total_errors  += thread_data[i].error_count;
> +		printf("Thread %2d: %d ok, %d errors\n",
> +		       i, thread_data[i].success_count,
> +		       thread_data[i].error_count);
> +	}
> +
> +	printf("Total: %d successful RTAS calls, %d errors\n",
> +	       total_success, total_errors);
> +
> +	FAIL_IF_MSG(total_errors != 0,
> +		    "%d of %d concurrent RTAS calls returned non-zero status; "
> +		    "possible work-area lock corruption",
> +		    total_errors, NUM_THREADS * ITERATIONS);
> +
> +	FAIL_IF_MSG(total_success != NUM_THREADS * ITERATIONS,
> +		    "Expected %d successful calls, got %d",
> +		    NUM_THREADS * ITERATIONS, total_success);
> +
> +	printf("papr_rtas_common_test passed\n");
> +	return 0;
> +}
> diff --git
> a/tools/testing/selftests/powerpc/papr_pseries/pseries_energy_test.c
> b/tools/testing/selftests/powerpc/papr_pseries/pseries_energy_test.c
> new file mode 100644
> index 000000000000..db6eb86d4647
> --- /dev/null
> +++ 
> b/tools/testing/selftests/powerpc/papr_pseries/pseries_energy_test.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * pseries Energy/Power Management Test
> + * Copyright (C) 2026 IBM Corporation
> + *
> + * Validates CPU frequency and power management on pSeries LPARs by 
> reading
> + * /proc/cpuinfo and /proc/ppc64/lparcfg directly.
> + *
> + * Tests performed:
> + *   1. CPU clock frequency is readable from /proc/cpuinfo and is > 0.
> + *   2. partition_entitled_capacity is present in lparcfg and is > 0.
> + *   3. partition_max_entitled_capacity is present and >= 
> entitled_capacity.
> + *   4. power_mode_data is present and is a 16-character hex string.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <ctype.h>
> +#include "utils.h"
> +
> +#define PROC_CPUINFO        "/proc/cpuinfo"
> +#define LPARCFG             "/proc/ppc64/lparcfg"
> +
> +#define POWER_MODE_DATA_LEN 16
> +
> +static double read_cpuinfo_freq(void)
> +{
> +	FILE *fp;
> +	char line[256];
> +	double mhz = 0.0;
> +
> +	fp = fopen(PROC_CPUINFO, "r");
> +	if (!fp)
> +		return 0.0;
> +
> +	while (fgets(line, sizeof(line), fp)) {
> +		char *colon;
> +
> +		/* "clock : <value>MHz" — pSeries dedicated-mode LPAR */
> +		if (strncmp(line, "clock", 5) == 0) {
> +			colon = strchr(line, ':');
> +			if (colon)
> +				mhz = strtod(colon + 1, NULL);
> +			break;
> +		}
> +
> +		/* "cpu MHz : <value>" — other Power configurations */
> +		if (strncmp(line, "cpu MHz", 7) == 0) {
> +			colon = strchr(line, ':');
> +			if (colon)
> +				mhz = strtod(colon + 1, NULL);
> +			break;
> +		}
> +	}
> +
> +	fclose(fp);
> +	return mhz;
> +}
> +
> +static int read_lparcfg_ulong(FILE *fp, const char *key, unsigned long 
> *out)
> +{
> +	char line[256];
> +	size_t keylen = strlen(key);
> +	char *endptr;
> +
> +	rewind(fp);
> +	while (fgets(line, sizeof(line), fp)) {
> +		if (strncmp(line, key, keylen) == 0 && line[keylen] == '=') {
> +			*out = strtoul(line + keylen + 1, &endptr, 10);
> +			if (endptr == line + keylen + 1)
> +				return -1;
> +			return 0;
> +		}
> +	}
> +	return -1;
> +}
> +
> +static int read_lparcfg_str(FILE *fp, const char *key, char *buf, 
> size_t size)
> +{
> +	char line[256];
> +	size_t keylen = strlen(key);
> +
> +	rewind(fp);
> +	while (fgets(line, sizeof(line), fp)) {
> +		if (strncmp(line, key, keylen) == 0 && line[keylen] == '=') {
> +			char *val = line + keylen + 1;
> +			size_t vlen;
> +
> +			val[strcspn(val, "\n")] = 0;
> +			vlen = strlen(val);
> +			if (vlen == 0 || vlen >= size)
> +				return -1;
> +			memcpy(buf, val, vlen + 1);
> +			return 0;
> +		}
> +	}
> +	return -1;
> +}
> +
> +/* ------------------------------------------------------------------ 
> */
> +
> +int main(void)
> +{
> +	double mhz;
> +	FILE *fp;
> +	unsigned long entitled, max_entitled;
> +	char power_mode[32];
> +	size_t i;
> +
> +	test_harness_set_timeout(10);
> +
> +	SKIP_IF(access(LPARCFG, R_OK) != 0);
> +
> +	mhz = read_cpuinfo_freq();
> +	FAIL_IF_MSG(mhz <= 0.0,
> +		    "Could not read a valid CPU frequency from " PROC_CPUINFO);
> +	printf("CPU frequency: %.3f GHz\n", mhz / 1000.0);
> +
> +	fp = fopen(LPARCFG, "r");
> +	FAIL_IF_MSG(!fp, "Cannot open " LPARCFG);
> +
> +	FAIL_IF_MSG(read_lparcfg_ulong(fp, "partition_entitled_capacity",
> +				       &entitled) != 0,
> +		    "partition_entitled_capacity missing from " LPARCFG);
> +	FAIL_IF_MSG(entitled == 0, "partition_entitled_capacity is 0");
> +	printf("partition_entitled_capacity: %lu\n", entitled);
> +
> +	FAIL_IF_MSG(read_lparcfg_ulong(fp, "partition_max_entitled_capacity",
> +				       &max_entitled) != 0,
> +		    "partition_max_entitled_capacity missing from " LPARCFG);
> +	printf("partition_max_entitled_capacity: %lu\n", max_entitled);
> +	FAIL_IF_MSG(max_entitled < entitled,
> +		    "partition_max_entitled_capacity (%lu) <
> partition_entitled_capacity (%lu)",
> +		    max_entitled, entitled);
> +
> +	FAIL_IF_MSG(read_lparcfg_str(fp, "power_mode_data",
> +				     power_mode, sizeof(power_mode)) != 0,
> +		    "power_mode_data missing from " LPARCFG);
> +	fclose(fp);
> +	fp = NULL;
> +	printf("power_mode_data: %s\n", power_mode);
> +	FAIL_IF_MSG(strlen(power_mode) != POWER_MODE_DATA_LEN,
> +		    "power_mode_data '%s' is %zu chars, expected %d",
> +		    power_mode, strlen(power_mode), POWER_MODE_DATA_LEN);
> +	for (i = 0; i < POWER_MODE_DATA_LEN; i++) {
> +		FAIL_IF_MSG(!isxdigit((unsigned char)power_mode[i]),
> +			    "power_mode_data '%s' has non-hex char '%c' at position %zu",
> +			    power_mode, power_mode[i], i);
> +	}
> +
> +	printf("pseries_energy test passed\n");
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/powerpc/papr_pseries/utils.h
> b/tools/testing/selftests/powerpc/papr_pseries/utils.h
> new file mode 100644
> index 000000000000..6eb88958a0ba
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/papr_pseries/utils.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Local test utilities for papr_pseries selftests.
> + */
> +#ifndef _PAPR_PSERIES_TEST_UTILS_H
> +#define _PAPR_PSERIES_TEST_UTILS_H
> +
> +#include "../include/utils.h"
> +
> +#undef FAIL_IF_MSG
> +#define FAIL_IF_MSG(x, fmt, ...)					\
> +do {									\
> +	if ((x)) {							\
> +		fprintf(stderr, "[FAIL] " fmt "\n", ##__VA_ARGS__);	\
> +		return 1;						\
> +	}								\
> +} while (0)
> +
> +#endif /* _PAPR_PSERIES_TEST_UTILS_H */


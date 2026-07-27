Return-Path: <linuxppc-dev+bounces-24854-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD54C531FC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 05:34:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7nNP52d5z2yRC;
	Mon, 27 Jul 2026 15:34:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785130485;
	cv=none; b=EBtazrPVZE9WNPet03lny2LUT/K4SwucueKuuIEG2OqvSfu7uYpyhMQQmcTVb+HQ/Yv/cUFYJkz6wQfkN/5XVBMBfHjnpqjVHq9V+mveeeIk+oZ44NeqltyCZigBWiTD0J2l5rjydov5qALmJdURoMxj3khBixaChwEidclIi3ph6PTgs6gwmKqCExovtYhFiJcJvfiKyoFK57drfvSex45HTDst4/xM0N2/W3ICixn4fzNMVz/wNJ0EF7CbhpEsCGham9flXwyopIowAlYZrLo7+jsYOsAq1k8lpqyvLIICG0WQGD5oxnx0UTtMkyIUMDZPFx4Thxxeqt5BjQdZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785130485; c=relaxed/relaxed;
	bh=QulKqYqXwWiS0anuPAc7iNnoeMmEliARs50oM1enzr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z3qgMHQvoO5nG1AYrHpp7iRVRKsaPjhJXkuUXYYYMZHVWmv1J/ghb1mKGm0znrHZf9IbFIQU1WSfl85Y9U8JrFSGOjpNaQQcXYgsNpAc2n1eezCri3SPTsQFMYCruo8RNeRxXUiTs1mlc4S1KSqbgaKbu6tj6U/1GbqDA6mH6ruhvaD8kvy4Rt7chEQJaXImMtcPSrHsKGSaooLUqZX19W5cHE72X2I7vsMoKkwy/Sec1EBjR3p9vAvfRD78srhmMThfpwZDYyCk9uWMEKKJR3h+rMhgjPYKi5CoiHukFdGLBt77iCYlOyJ77Voe00hV22wZ93UTbMwQG/zsCCqO1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZSHkqEae; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZSHkqEae;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7nNN4jBDz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 15:34:44 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R1lpU3891807;
	Mon, 27 Jul 2026 05:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=QulKqYqXwWiS0anuPAc7iNnoeMmEliARs50oM1enz
	r0=; b=ZSHkqEae6mSwiVDR6G0/q7ofiVBf6gUhZjL7R0FZtQuV550E+39KPJbHN
	FExzNeaZTKKFaAmLlNolzZhb3hSMZ3VZ1z/DawY8TQzRe4rIlZa+JsS4Icjg/8jy
	w2Zmsefl5aRDJgOFec1eP35vx2i1c0zE04LWeOLGazRIDkVVFE/EbmETdqZUyurG
	UNNwe+F7pma1nD6BNh84S2tavmYi505rHTkWqQqMprBynqyhFUcZ0ByISpJVvAen
	yyVyl80QVRoAqN1e7Xy/U9WkDfokY9yWOd25aVB4nCYZJ+7TNfgd+fucNTnpcQRU
	px6Dc74UJk8SFNeqkNcxsAFjAeLKA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xe9a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 05:34:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R5WBAF016380;
	Mon, 27 Jul 2026 05:34:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjv12k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 05:34:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R5YTDs51249652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 05:34:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EE032013A;
	Mon, 27 Jul 2026 05:34:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EE4E20139;
	Mon, 27 Jul 2026 05:34:26 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 05:34:26 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        ritesh.list@gmail.com
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v3 0/3]  powerpc/crash: protect kdump from active watchdogs
Date: Mon, 27 Jul 2026 11:04:13 +0530
Message-ID: <20260727053416.276317-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: F4J_u9NjnUxkq3hak52RFVlVuOIzA8Zw
X-Proofpoint-ORIG-GUID: poidp5P9pHRQKSSHxMfOY8s1F8yfGwL7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA1MCBTYWx0ZWRfXza8ynsjOP1V3
 X6KhmF0mSNx7dqhHyMaiXkm8Frz1nAyKbUW+09Tfn2pndBIQ7cYc/5SKCC51RSg0ZjQxY1ShhFe
 S1SN3lV3dN/WbWfGdoK8Za0qTuPsL2o=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a66edea cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=Gk6Qg7I2AAAA:20 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=akTv58P-d981-2rlXkgA:9 a=O8hF6Hzn-FEA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA1MCBTYWx0ZWRfX/qlPtqDkOMe6
 PgeCk2aIiI+YMHnXmp+MYpkXfFFQJd5yZF1IynS++/ZQoiU8bYfYR+R1LAMc0o/SvB4N/EkiH0a
 Hta03SYoScdmh2YYnogWhnDPKgC3v18oA7ysXu1B7VeeuxCMSXMc46KVfEMjNJzdipeQp0GYzik
 3OjSBkKkapGWuuFb2+QQMXK9DHk4lf8n5jXyCIfjMWIeo7+qQv+2nvJ3IW6ebQ6Ty0jZauvwjfl
 F4ruYN2Du6a9n/f2A1y5y5MskIIk2MnePTITSM0XIVTkLYHJkapjqMoK6QCtU2otydQhv+ZgUyh
 4dJe2cY1dIgTht6ShAV1urJACeVFUykxH258sfrhNn18oL/h+ryDxL7aX35XwkLVMIVZlUL5iSN
 m22bTp/2IEGJc+BK3qvMp4a3L0CIBFsyB9lXqX+wk2XxZkprvZkaELh5YjHB7pqSBq2jDZyUawu
 cwKRtkto8G8q7+OaXlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270050

On pseries LPAR systems in a high-availability environment using the
SBD[1][2] service, I observed that the system abruptly rebooted before
dump capture could complete.

Further investigation showed that SBD had configured a watchdog with
a 30-second timeout. Since the kernel crashes directly into the
kdump kernel without shutting down userspace services, the watchdog
remained active during dump capture. Once the watchdog timeout
expired, PHYP reset the LPAR, causing dump capture to fail.

The issue was reproducible only when the watchdog was active. Dump
capture completed successfully after disabling the watchdog,
stopping the SBD service, or increasing the watchdog timeout value.

This patch fixes the issue by stopping all active watchdogs on the
crash shutdown path before booting the kdump kernel.

Driver that export the hardware watchdog device is:
drivers/watchdog/pseries-wdt.c

[1] https://github.com/clusterlabs/sbd/blob/main/man/sbd.8.pod.in
[2] https://documentation.suse.com/sle-ha/15-SP4/html/SLE-HA-all/cha-ha-storage-protect.html

Changelog:
==========

v3:
 - Fix header gurad 1/3
 - Rename local variable pseries_wdt_dev to pdev 2/3
 - Document PSERIES_WDT_NUM_ALL macro 3/3
 - Remove ifdef CONFIG_CRASH_DUMP 3/3

v2:
https://lore.kernel.org/all/20260713035954.1559605-1-sourabhjain@linux.ibm.com/
 - Move H_WATCHDOG definitions to a common header for shared use
   across pseries code. 1/3
 - Added a new patch to handle pseries watchdog device registration
   failure. 2/3
 - Stop active watchdogs in crash hanlder. 3/3 Ritesh
 - Add suggested-by tag 1/3 & 3/3

v1:
https://lore.kernel.org/all/20260603070217.483696-1-sourabhjain@linux.ibm.com/

This issue can be reproduce using below program:
------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <linux/watchdog.h>

#define WATCHDOG_DEV    "/dev/watchdog"
#define TIMEOUT         10
#define PET_INTERVAL    1

static int wdt_fd = -1;

static void watchdog_close(int disarm)
{
    int flags;

    if (wdt_fd < 0)
        return;

    if (disarm) {
        flags = WDIOS_DISABLECARD;
        if (ioctl(wdt_fd, WDIOC_SETOPTIONS, &flags) < 0)
            printf("WDIOS_DISABLECARD failed: %m (nowayout may be set)\n");
        else
            printf("Watchdog disabled via WDIOS_DISABLECARD\n");

        if (write(wdt_fd, "V", 1) < 0)
            printf("Magic 'V' write failed: %m\n");
        else
            printf("Magic 'V' written\n");
    } else {
        printf("Closing WITHOUT disarming - watchdog keeps running!\n");
    }

    close(wdt_fd);
    wdt_fd = -1;
    printf("Watchdog fd closed\n");
}

static void safe_exit(int sig)
{
    printf("\nSignal %d received - disarming watchdog...\n", sig);
    watchdog_close(1);
    exit(0);
}

static int watchdog_init(void)
{
    int flags, timeout = TIMEOUT;
    struct watchdog_info ident;

    printf("Opening %s...\n", WATCHDOG_DEV);
    wdt_fd = open(WATCHDOG_DEV, O_WRONLY);
    if (wdt_fd < 0) {
        printf("Failed to open %s: %m\n", WATCHDOG_DEV);
        return -1;
    }
    printf("Watchdog opened and ARMED\n");

    flags = WDIOS_ENABLECARD;
    if (ioctl(wdt_fd, WDIOC_SETOPTIONS, &flags) < 0)
        /* ENOTTY = driver always enabled, that's fine */
        printf("WDIOS_ENABLECARD: %m (ok if ENOTTY)\n");
    else
        printf("Watchdog enabled via WDIOS_ENABLECARD\n");

    if (ioctl(wdt_fd, WDIOC_SETTIMEOUT, &timeout) < 0)
        printf("WDIOC_SETTIMEOUT failed: %m\n");
    else
        printf("Timeout set to %d seconds\n", timeout);

    /* verify what the driver actually set */
    if (ioctl(wdt_fd, WDIOC_GETTIMEOUT, &timeout) == 0)
        printf("Actual timeout  : %d seconds\n", timeout);

    if (ioctl(wdt_fd, WDIOC_GETSUPPORT, &ident) == 0)
        printf("Identity        : %s\n", ident.identity);

    return 0;
}

static void watchdog_tickle(void)
{
    int timeleft = 0;

    if (ioctl(wdt_fd, WDIOC_KEEPALIVE, 0) < 0) {
        printf("WDIOC_KEEPALIVE failed: %m - falling back to write\n");
        write(wdt_fd, "1", 1);
    }

    if (ioctl(wdt_fd, WDIOC_GETTIMELEFT, &timeleft) == 0)
        printf("Petted watchdog. Timeleft: %d sec\n", timeleft);
    else
        printf("Petted watchdog.\n");
}

int main(void)
{
    signal(SIGINT,  safe_exit);
    signal(SIGTERM, safe_exit);

    if (watchdog_init() < 0)
        return 1;

    printf("\nPetting every %d seconds. Ctrl+C to safely stop.\n\n",
           PET_INTERVAL);

    while (1) {
        watchdog_tickle();
        sleep(PET_INTERVAL);
    }

    return 0;
}

Steps to reproduce the issue:
-----------------------------
1. Load kdump kernel
2. Insert pseries-wdt driver
3. Compile the above proram and run the binary
4. Crash the kernel (echo c > /proc/sysrq-trigger)

Sourabh Jain (3):
  powerpc/pseries: Move H_WATCHDOG definitions to a common header
  powerpc/pseries: Handle and log pseries-wdt registration failures
  powerpc/crash: stop watchdogs before booting kdump kernel

 arch/powerpc/include/asm/papr-watchdog.h | 64 ++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c   | 28 ++++++++++-
 drivers/watchdog/pseries-wdt.c           | 53 +-------------------
 3 files changed, 91 insertions(+), 54 deletions(-)
 create mode 100644 arch/powerpc/include/asm/papr-watchdog.h

-- 
2.52.0



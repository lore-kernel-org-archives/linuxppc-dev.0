Return-Path: <linuxppc-dev+bounces-29255-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E9BCA9EDE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 10:21:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3D5V0xMBz30hC;
	Mon, 12 Oct 2026 21:21:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791800478;
	cv=none; b=ktziH/+pQ5SDNuz5FbVZz4WJusAMbBcfOFUKtA9k2JyUeXonDuWHOehuZXWDcUq1Tsd8JWunZDb4SSUxmjV+hhMmx+TneSKPGegGkbJemuSlnJJPUaMKkiB2zIMXIlhRoBIoQgxQPC2/Af6o9PLGIngcFZV8ZQtqjRwEErkDV2wZX8ZRFMEMRpj2Y/zxYe7lLyZLMdTFUFz9RHO0W4eOHJ45RotfULqI54bSVlljFcvFPqBY+Rk2UTRfMnTQALCdTCpUT9tRj+SfvQ28zVU3uqcGnBCKkldJkOHXXpu0IA0xMO67nn1zSbyVhbp2SzQaBP9KebbJdQnpL8A7e6hTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791800478; c=relaxed/relaxed;
	bh=5yWO6epFGZto47IRJbkuCap12gP2Wd5i3HVgbNNi0xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqb3qumTA9C+IYqH3UdxF1YxtWtDjzss8JcqhcotWHgP58WtGQm6LYjFKXY7VqK3T7bpRG2rmOPcR5lw1e8xsD6DP+WzYqlz62bjFZayApX2/SEaLcGPN/1gPIRZ/OcIBUidng9CXD2V4vQL/oWNSwjqL1qZola3lCo0lwg4v04LxDBMgXFRU19PD6DNaR059Qd4n8mrKu9c7tWk6AkPdrJEgWQSe2erPh6lY6XbI7kveKoFof4inxsQZasWfxMCHJRT72o18wfel7YrOCQBEbXnN3Ofei2mRQoAVGkqiNnS89ID2P3C68Y8bDAVH2SzPOuxTDt0ezHXxq7mU1h4EA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xn0TPGW+; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xn0TPGW+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3D5T0Nndz2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 21:21:16 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8iLkI3810252;
	Mon, 12 Oct 2026 10:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5yWO6epFGZto47IRJ
	bkuCap12gP2Wd5i3HVgbNNi0xg=; b=Xn0TPGW+9jlmP3a9WjwI61uK2aCNnhOaD
	AdvnOmJshb8JP2xqHRpS+2pW+uwBXKcEJ8TenYVvc/XkRkcbvJ4mYn2jrRIWz/pb
	kaCNgMLiknARFzyb+/jqm+LL1uV/ZVFsn7U+cKo9Ca2qPbuVWBQUUOCq9NA5i/FD
	2xXq2EJUlOHPY34TcvZRe5+mxMfYv5dZzeZgjhzePy0M3044JwS5vcyL8AUOuOwE
	qTcrI9Alm2dGEEAK0qxB/gjZjXcIQRfLcVPNkQzRVI6OhSiXm9h60vWd5Eqg0F/n
	YAPq9qRUOAZO8iI43tGVSM0SKmbdVQVhXVHtbpaZFDNlziZyOGudg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhr23v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 10:20:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K2Pu935491;
	Mon, 12 Oct 2026 10:20:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjmpe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 10:20:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CAKpPf33685834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 10:20:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F348C20043;
	Mon, 12 Oct 2026 10:20:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5F6A20040;
	Mon, 12 Oct 2026 10:20:45 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.215.77])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 10:20:45 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        tim.c.chen@linux.intel.com
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
        kprateek.nayak@amd.com, yu.c.chen@intel.com, vineethr@linux.ibm.com,
        vincent.guittot@linaro.org, srikar@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au
Subject: [PATCH 1/4] powerpc/topology: Introduce llc_override debug knob
Date: Mon, 12 Oct 2026 15:50:34 +0530
Message-ID: <20261012102037.2477378-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261012102037.2477378-1-sshegde@linux.ibm.com>
References: <20261012102037.2477378-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0MCBTYWx0ZWRfXyHhp3GL76O43
 uwfQ+3IzQg39TyuvJ/FP9CQlulGtrmQyChI12HgmLRz20SLOHjlNk9noM3g0nUf+/I7kqp6e9gL
 dSDyuvpYNapw8EIEppLnXNuRo1xor8eky9uYtnAzpJ0DQKPqdMHGFnSljV6o3Tx6dJe1PPTiG92
 qRrNE79fzJcRL3A3mfTP3qJFN7oj1+9p03/9M98ziSrDANA5YU5JN6AX3W4FkAydvH3bj8ZBDun
 yi5RYuPUr9pleFng/LFJrl/rHLC6iJsc+vIVZhQy4HWHXaKw7pw3kJNcEKo4Y9I+oVG0iJ/NKEz
 8ZrvGQGHKxV3MrjeuD/UgfrhAlOlHaf3wdkku8zikj7UDJNZSDV7mwrhbTlIamsAEeOeu9EGcRq
 mjzIxWtsYxeoQ9LLgcaYlcvnBZpttiFknwU2/AI7BM8UITZIoicxKQ12qymjf+sIRmAPUJkc+bE
 KUPK0DkfHQVaqNquG2w==
X-Proofpoint-GUID: 4pkY9AI7_CKBf4XHne0jN1rBI9rQzYb_
X-Proofpoint-ORIG-GUID: _N1QxW1eY4L5aKvWwXqLxqhEmB9TkEGS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0MCBTYWx0ZWRfXwZnpfyZrr5/O
 Kdzz7xjSYEEbZJZutCKx+RSfaftOZ99hXC9YnJAdYH2qtCKqPs9l/hYsIKnpLy3IqaMLlM2n5eX
 iw5h1UNT7/U90n1bIhT8zXBrJLEROWk=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6accb488 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=K3W2r7DSbAiZMpyZ5AwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120040

There is a new feature in scheduler called as Cache Aware Scheduling.
It tries to keep related tasks within the same LLC domain while
keeping the system reasonably balanced.

Cache Aware Scheduling assumes that the scheduler LLC domain is large
enough to be a useful placement target. This is true on many systems
where an LLC spans several cores, but not on PowerPC systems where the
scheduler-visible LLC is at the SMT level.
In that case, sd_llc_size is effectively the SMT width.

This becomes visible in the capacity check:

  !fits_capacity((mm->sc_stat.nr_running_avg * cpu_smt_num_threads),
                  scale * per_cpu(sd_llc_size, cpu));

As a result, it may be enabled but has no room to operate.
Hence provide a debugfs option one can set to try experiment their
workload with cache aware scheduling. This also provides ways to explore
it on system with SMT=4 to see if there are any opportunities
to improve or uncover bugs if there is any.

This does not change the hardware cache topology. It only changes the
sched-domain level at which SD_SHARE_LLC is set.

Initially start with,
- New debugs file called llc_override. It can be set/get on
  /sys/kernel/debug/powerpc/llc_override
- Adds parser logic for the debug knob.

There is no point in setting NUMA as the LLC domain. So give option
until pkg to experiment with.

Actual flag manipulations and rebuilding sched domains are introduced
in subsequent patches.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
PS: Split is deliberate. If squashing all this into one patch helps,
    let me know.

 arch/powerpc/kernel/smp.c | 90 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 6a5a5469aaae..433757511adb 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -36,6 +36,7 @@
 #include <linux/pgtable.h>
 #include <linux/clockchips.h>
 #include <linux/kexec.h>
+#include <linux/debugfs.h>
 
 #include <asm/ptrace.h>
 #include <linux/atomic.h>
@@ -1826,3 +1827,92 @@ void __noreturn arch_cpu_idle_dead(void)
 }
 
 #endif
+
+enum llc_override_values {
+	LLC_OVERRIDE_DISABLED,
+	LLC_OVERRIDE_SMT,
+	LLC_OVERRIDE_MC,
+	LLC_OVERRIDE_PKG,
+};
+
+static int llc_override;
+static int llc_override_changed;
+static DEFINE_MUTEX(llc_override_mutex);
+
+static const char * const llc_override_str[] = {
+	[LLC_OVERRIDE_DISABLED]	= "0",
+	[LLC_OVERRIDE_SMT]	= "smt",
+	[LLC_OVERRIDE_MC]	= "mc",
+	[LLC_OVERRIDE_PKG]	= "pkg",
+};
+
+static ssize_t llc_override_get(struct file *file, char __user *ubuf,
+				size_t count, loff_t *ppos)
+{
+	int override;
+	char buf[8];
+	int len;
+
+	override = READ_ONCE(llc_override);
+	len = scnprintf(buf, sizeof(buf), "%s\n", llc_override_str[override]);
+	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+}
+
+static ssize_t llc_override_set(struct file *file, const char __user *ubuf,
+				size_t count, loff_t *ppos)
+{
+	char buf[8];
+	int override;
+
+	if (!count || count >= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, ubuf, count))
+		return -EFAULT;
+
+	buf[count] = '\0';
+	strim(buf);
+
+	if (!strcmp(buf, "0"))
+		override = LLC_OVERRIDE_DISABLED;
+	else if (!strcasecmp(buf, "smt"))
+		override = LLC_OVERRIDE_SMT;
+	else if (!strcasecmp(buf, "mc"))
+		override = LLC_OVERRIDE_MC;
+	else if (!strcasecmp(buf, "pkg"))
+		override = LLC_OVERRIDE_PKG;
+	else
+		return -EINVAL;
+
+	if (override == LLC_OVERRIDE_MC && !has_coregroup_support())
+		return -EINVAL;
+
+	mutex_lock(&llc_override_mutex);
+
+	if (override != READ_ONCE(llc_override)) {
+		WRITE_ONCE(llc_override, override);
+		WRITE_ONCE(llc_override_changed, 1);
+		pr_info("sched LLC override set to %s\n",
+			llc_override_str[override]);
+
+		/* Will be calling rebuild sched domain in later patches */
+	}
+
+	mutex_unlock(&llc_override_mutex);
+	return count;
+}
+
+static const struct file_operations llc_override_fops = {
+	.open		= simple_open,
+	.read		= llc_override_get,
+	.write		= llc_override_set,
+	.llseek		= default_llseek,
+};
+
+static __init int llc_override_debugfs_init(void)
+{
+	debugfs_create_file("llc_override", 0600, arch_debugfs_dir, NULL,
+			    &llc_override_fops);
+	return 0;
+}
+device_initcall(llc_override_debugfs_init);
-- 
2.52.0



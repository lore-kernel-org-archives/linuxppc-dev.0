Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB4E606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JMmqUw3q
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMgs24zcz2yMP;
	Tue, 17 Nov 2026 22:19:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794914361;
	cv=none; b=B+B0AQz04qq/uPD+cUCywDZp0kUFQFQuo/K06Pupn3pmgjtqh0bxRyVut7gWkeIMmAMC7hBhSWOm9oKPl3paT0N4l6Wqj6INE2PfVKQ6ddQ0BXvLCtR8vxV0qPYijxT/DpTthdGFkSrB9xmDb56jJF6AWQrAo61455Wr1CbixxfmHmgl8gZXbJxhdkR93D2vMQFvBkq56PpGlCKon7JTx/wUB5BorLQYNNz+7V6REWvroTRy/OUNroxEs0qo4tLJSonuSNZKXBMXYjLaW46MwSJVg5t6JqPjrUWQAge4fwzQiR/qrzE1Vo3psr/ZQpUOpDkakFKOiNafnYaK4FKykw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794914361; c=relaxed/relaxed;
	bh=ae1+zxnmYBA6LucaV0oeD7zsBTx99sDPE5ClpSm1UfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZjhHNHGHdeyiq+SAFtSC3ZCNfN6CE6TlDpHcBIo/rot0qQimy4ZeYCw95AFwSHOaCBjOARkIIEIuuJDg/q+lBrUL6Ifnx+v51Czs1gRqSGYdcKYZgXZcc5aXTZcReYPQIKM4ZfXr5gaA0INVL0g3tZKafk84NdF7O36ErNzNypMWB4kmKtij26HiGQMw1oUlZy+ApLVqSIs/IIKC0iYT0ogb3v5659vpgyeMgefbhm0EhS0pe4lCNv/OVoVpYs1lMd1ufkh+dVQmO2k/eWAbNnoUIHa08OzkfctC/HLgY4rlERiMfjBWdQ5JhWqSu3h0sl+G+vNPGUZMYJ9LahI1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JMmqUw3q; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JMmqUw3q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMgr32SQz2yMK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:19:20 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A3151BF7;
	Tue, 17 Nov 2026 03:18:46 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 278713F763;
	Tue, 17 Nov 2026 03:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914329; bh=gGwUF9uzvgflmhqCUjHXKFSBYmW8th+wZveFeobE1dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMmqUw3qcRzMiqHL+zkl2lg3vrPOi4FA+IQufjra561byq3Wejw8Md9lp1ra9Ji3v
	 CU+CG8XBFqHVJ+nygGzVEjUtVpRUfenzODtZmt0GJtA7714YbKi3bafCR7zWJNGIT3
	 THE8bGYiGcWMZ5yTfvyzZL+NEkFtc6S2vNGAB9fc=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Dan Williams <djbw@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 10/19] ACPI: extlog: Simplify fatal record printing
Date: Tue, 17 Nov 2026 12:10:20 +0100
Message-ID: <20261117111444.4185512-11-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117111444.4185512-1-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Only fatal CPER records reach print_extlog_rcd().
Merge the two helpers, remove the unused prefix argument
and return value, and keep a single rate limiter.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/acpi_extlog.c | 39 ++++++++------------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 16a16b12d8ccf..1782a19eb474b 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -95,46 +95,23 @@ static struct acpi_hest_generic_status *extlog_elog_entry_check(int cpu, int ban
 	return estatus;
 }
 
-static void __print_extlog_rcd(const char *pfx,
-			       struct acpi_hest_generic_status *estatus, int cpu)
+static void print_extlog_rcd(struct acpi_hest_generic_status *estatus, int cpu)
 {
+	/* Not more than 2 messages every 5 seconds */
+	static DEFINE_RATELIMIT_STATE(ratelimit, 5 * HZ, 2);
 	static atomic_t seqno;
 	unsigned int curr_seqno;
 	char pfx_seq[64];
 
-	if (!pfx) {
-		if (estatus->error_severity <= CPER_SEV_CORRECTED)
-			pfx = KERN_INFO;
-		else
-			pfx = KERN_ERR;
-	}
+	if (!__ratelimit(&ratelimit))
+		return;
+
 	curr_seqno = atomic_inc_return(&seqno);
-	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}", pfx, curr_seqno);
+	snprintf(pfx_seq, sizeof(pfx_seq), KERN_ERR "{%u}", curr_seqno);
 	printk("%s""Hardware error detected on CPU%d\n", pfx_seq, cpu);
 	cper_estatus_print(pfx_seq, estatus);
 }
 
-static int print_extlog_rcd(const char *pfx,
-			    struct acpi_hest_generic_status *estatus, int cpu)
-{
-	/* Not more than 2 messages every 5 seconds */
-	static DEFINE_RATELIMIT_STATE(ratelimit_corrected, 5*HZ, 2);
-	static DEFINE_RATELIMIT_STATE(ratelimit_uncorrected, 5*HZ, 2);
-	struct ratelimit_state *ratelimit;
-
-	if (estatus->error_severity == CPER_SEV_CORRECTED ||
-	    (estatus->error_severity == CPER_SEV_INFORMATIONAL))
-		ratelimit = &ratelimit_corrected;
-	else
-		ratelimit = &ratelimit_uncorrected;
-	if (__ratelimit(ratelimit)) {
-		__print_extlog_rcd(pfx, estatus, cpu);
-		return 0;
-	}
-
-	return 1;
-}
-
 static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
 {
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -210,7 +187,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 
 	/* Print fatal records regardless of RAS consumer registration. */
 	if (tmp->error_severity == CPER_SEV_FATAL)
-		print_extlog_rcd(NULL, tmp, cpu);
+		print_extlog_rcd(tmp, cpu);
 
 	/* log event via trace */
 	err_seq++;
-- 
2.43.0



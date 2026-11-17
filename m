Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E66B606A323
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=R1St63Gq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMgT2jY5z2y2B;
	Tue, 17 Nov 2026 22:19:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794914341;
	cv=none; b=VwFaIUOIsTjG6hAlg0k5OX4PGTecq16X1e9MZ/8svQGMxi/2kn8gPhSWmpktNgLPqPfCErv/cNRY4/LmzNqHpSSYqJbmaMpAiu5PqKapV7bOzRALzGZas3499la5A/cp35L2sVHNK/xr71QGMfP+wqrWNqkrKb+un/aGpNNrEqgbSRLV1CEovctOMtt9fP/CMsS/9W3j6TPocoPakjRlhJ4XvLb92P8Eejzsz7JK90VOYKaF2kXhO9XzjiOB0iPsDS6zlhOu9ZcQdMUfWw3MsLOq/ochRvsvkVOfidAm2ysononjx/Cvh7r1F60DeLh8fTad0Su/XkgDahMoxSD8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794914341; c=relaxed/relaxed;
	bh=JBdBGYVRxNYOJdT2394qct33hCcjoUXwpWM/aTSPVhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0BNKhlcMpD3DFycGoYlzc6AXyKeAivH9yuMNZqNtgF2p2tRdN/gp9HWVA7NxjqstrpQqW1EV5RIPZYBL85zr2bKABHILr+zshquEEpmTlFrGe9d1lSRgsLv0aAQI869Yhy9JUoSGKR3vbMVBPdhtDLW0WsBBVi3Tqaj0damtezzrmf+INyIlQqPj2Q9BopUl81Zg7v/rEBnmM7h2aRK5ZEi9hzcLe59DpBSl9azoQRe2AbYYRCgcnWmIF5GhpDNvttq29DUkOSrWVSa0SUxLSo1HrHiEVgarSgvowfZIrWvCW7Fzmqq479W2UXkZk9L9S+VQAj5R+UkIKd4NSRHcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=R1St63Gq; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=R1St63Gq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMgS3dKtz2xqL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:19:00 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AFD41BD0;
	Tue, 17 Nov 2026 03:18:26 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5F6413F763;
	Tue, 17 Nov 2026 03:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914309; bh=Pk6YrAE/nTxDcvg8Hm+R5p8sZab+WMj8uqsEYyAJctY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1St63GqI5kTgA9jTyvQVN61vkTHDA+4ypR44INnVvGa7bkEC1LsO5i/DFwnOHLwr
	 hxTscmTwbf9li29BlibU0B5NIYF/tH73sL3pv5tdT8MCK0ksLYcYlMnWppK/NBW6hH
	 z7I7rbwM8EN022PRX03/5Vg8Q80KI4fBgqMgg4Wc=
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
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 09/19] ACPI: extlog: Report errors independently of RAS consumers
Date: Tue, 17 Nov 2026 12:10:19 +0100
Message-ID: <20261117111444.4185512-10-pierre.gondois@arm.com>
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

The RAS consumer check removes:
- trace events when no daemon is registered
- CPER console report when one is registered
This ties tracing, PCIe recovery and CXL protocol delivery to daemon
registration, and can hide a fatal record when userspace cannot process
its trace event before a reset.

Remove the RAS consumer registration condition and:
- always emit trace events
- print the CPER record only for CPER_SEV_FATAL

[1] additionally suggested to have a cmdline parameter to dynamically
update the above policy. Keep a simple hard coded policy for now.

[1]
https://lore.kernel.org/lkml/20240521183913.GGZkzqUSN1hdE-_OEY@fat_crate.local/

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/acpi_extlog.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index e09ea571c32f5..16a16b12d8ccf 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -208,10 +208,9 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	if (cper_estatus_len(tmp) > ELOG_ENTRY_LEN || cper_estatus_check(tmp))
 		return NOTIFY_DONE;
 
-	if (!ras_userspace_consumers()) {
+	/* Print fatal records regardless of RAS consumer registration. */
+	if (tmp->error_severity == CPER_SEV_FATAL)
 		print_extlog_rcd(NULL, tmp, cpu);
-		goto out;
-	}
 
 	/* log event via trace */
 	err_seq++;
@@ -255,7 +254,6 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 		}
 	}
 
-out:
 	mce->kflags |= MCE_HANDLED_EXTLOG;
 	return NOTIFY_OK;
 }
-- 
2.43.0



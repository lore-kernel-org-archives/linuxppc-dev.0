Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0021C606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UE0kJdzu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMdC5H0bz2y8p;
	Tue, 17 Nov 2026 22:17:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794914223;
	cv=none; b=bs6BjKI67J0yo2Oe/mLNCAYUq+n1U+YXKrlFKLV0VHuPHhcLfpxXSmTAAO52oAKAp2T9cvp2uqRMeZlWttkzvbP3W3cdI+ENebaMXVaG3i9Vc3uWjPGR5irZGmSfqCiymght/ZmPu6zsdUCbtmIBJvvV4V15ktF8H4xoY5EkhS+M0SXr64JOCa/9ctKbzjqhShy8PZ4UdK0gkt942357TeczZoNHA4iho5maVWLFz5V+Z+AA+0/o/w9ww2me5zNNHdzv4u6LO1xwOpqiTF7WnChwYUcdxpXx2gbQtSgar/a/JhNQWqJXACtrSUe887j+NzSbM5LNRmEnmXjyBPH5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794914223; c=relaxed/relaxed;
	bh=G2N13G5utyTe7izqnWDvvwrQ2fOwakujOweKmNqrGrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M25mqqiknsWVa9TdnyAlBVqrWkhMP/PosDC+GQhqocrTgkQ6ojdYvUynpIu15z7oIFn8pcW5ykP668WxVlfnazUiFXaGf19o0HSl9wpeKDv3i2uJmI1FxKUgQoOBVop2QkwejqnzjNj82HprafAceIQTLS/AcbG3fI4oZ5umB3BYCHkwaj9RjH/7kxO+VkLm+lvaVefrQ1cF3BTXdQVSOEpDS3CzWWeubySMqlcdVkAgxZ+EmX+rUmeSg7Cb5bqZDD8z0obEZV+Pp4baLQcjIACXqXtbif3+G2XkUYm4l10C3BTjcY30NNaCpYHBrQNXTYFyLMmI8Se+ZID034EVFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UE0kJdzu; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UE0kJdzu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMdC1Tw9z2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:17:03 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E28441682;
	Tue, 17 Nov 2026 03:16:28 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A46E3F763;
	Tue, 17 Nov 2026 03:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914191; bh=nQ/pGewZ6c/kd9JIrH7S2KTGuPSpp1O8X6Rcs0KcnQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UE0kJdzuB5u+54VYGkLHh9IxD6zwtneuQSgzckgRUphS2F6ekg0cdSJG4nhoBtzyj
	 eVdZ3PQcTpnwHS/ywvKtG7aSuAIbf9QXDXq3ei3yhCzJcRN9Ig9Bdk8ebrsbSfPjYZ
	 9WkL0MWcxwOgbX0INOdI6xO0+nf5fQKsj4viqusA=
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
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 03/19] ras: Bound CPER FRU strings in trace events
Date: Tue, 17 Nov 2026 12:10:13 +0100
Message-ID: <20261117111444.4185512-4-pierre.gondois@arm.com>
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

CPER FRU text occupies a fixed 20-byte field and need not contain a NUL
terminator. Using __string() can read past the field and, for a short
nonstandard section, past the end of the firmware record.

Bound FRU text in the legacy memory and nonstandard trace events with
__string_len() and strnlen(), as already done for the Section 2 event.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 include/ras/ras_event.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index ce759ee1cf4cc..069c7b3a5e6c0 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -39,7 +39,7 @@ TRACE_EVENT(extlog_mem_event,
 		__field(u64, pa)
 		__field(u8, pa_mask_lsb)
 		__field_struct(guid_t, fru_id)
-		__string(fru_text, fru_text)
+		__string_len(fru_text, fru_text, strnlen(fru_text, 20))
 		__field_struct(struct cper_mem_err_compact, data)
 	),
 
@@ -370,7 +370,7 @@ TRACE_EVENT(non_standard_event,
 	TP_STRUCT__entry(
 		__array(char, sec_type, UUID_SIZE)
 		__array(char, fru_id, UUID_SIZE)
-		__string(fru_text, fru_text)
+		__string_len(fru_text, fru_text, strnlen(fru_text, 20))
 		__field(u8, sev)
 		__field(u32, len)
 		__dynamic_array(u8, buf, len)
-- 
2.43.0



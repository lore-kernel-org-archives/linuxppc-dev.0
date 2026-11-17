Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040AE606A329
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=o7QcNwPV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMk35Ft8z2yfS;
	Tue, 17 Nov 2026 22:21:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794914475;
	cv=none; b=YdP79cK1XjFg1v66JkUPUIjEjRCGH/nraLjLgrmEdKWULF76V1shuznwWmroySQj/pjmkpaemR/jTtNxMAhgelaYle5jZ0zsvmLU94vdv8jolwWl00ZQEJCQYwLmPkfzpN/IP6oIlHRnWYU8sVfQQE+e5+01WuCjHLSM8jqFLFBhmcXk0hPAZ7Qgpmk8C4Bta+5TWz2CP620TdYKkViWDu0FO1UossiAvHpSxkVW1LgwFQoVpYPOUTkzTVAVoVWh1NTVTRYUNKu50G5NGeks4ZWr78+t+l9PnTkls+Yp7N+6JexGatnHplU0FEQgEmDyO7qFbRYdEN+96tzKhNmdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794914475; c=relaxed/relaxed;
	bh=09rZsuWp6CtR9LOTXoLoaUtfkW84uWWxOZaFgvige7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dM+yj70fe9h7g5zSewbKv0rlhyvM8o2xUIUh0jdTWwAyij4olyuNIoQ4sfQGSS6Et+yoKbxUJpMTZcOnptGvHU9ENW/q3COKSPgY/iunMXbQbRpchi5OsS/5iIQSniQ7AoF9hc38sa4kOfKt0RWdFH2FKCJB86dOs7UVPfm94HmWoFByGtA25tRfANQrM6GfIjp8d+aCKlYPCmanw+nmaoq4NKQEU9DyKteLwMuHDQ4DlMFpJh3TBIL8vNtOYYZsuKXwrIh7oXiBQxOLTsXuMU1Dno9nOW66XsPmMV1c2cLuKdDjVJJ6Zfvg8Vdy51nhz0vG7F37orhnAtxPV6N1Bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=o7QcNwPV; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=o7QcNwPV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMk26V9nz2yLg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:21:14 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA9601C2B;
	Tue, 17 Nov 2026 03:20:40 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 72CBA3F763;
	Tue, 17 Nov 2026 03:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914443; bh=trVuWSDFiGkBDhc3DOcsF8Ag/Ixhu7mOBHZTT9DfJC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o7QcNwPVEYbkit4dugp52SPlNUGTA/LWgN93kS73LQ3MAYgcoOsJPBmgWysestjsx
	 motBi9i03VoGIBTSHOZVOnMv0zd5FJ99CyLLqBPz1VR+3F7UN8x3KK9WD+MkagPP/i
	 Mj1WcyzvPEcFXtVqi/yWxqB+Q+2bDvspMGZLQvi4=
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
	Radu Rendec <radu@rendec.net>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 16/19] ACPI: extlog: Report error severity using GHES bindings in MCE
Date: Tue, 17 Nov 2026 12:10:26 +0100
Message-ID: <20261117111444.4185512-17-pierre.gondois@arm.com>
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

MCE extended logs report raw CPER severity values to
log_non_standard_event(). GHES relies on the GHES bindings in
ghes_do_proc(). The rasdaemon interprets the severity
as a GHES_SEV_* value.

Translate the CPER severity with ghes_severity() before reporting
the event.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/apei/extlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/extlog.c b/drivers/acpi/apei/extlog.c
index 8cae5bdacf1c6..bd407436928b4 100644
--- a/drivers/acpi/apei/extlog.c
+++ b/drivers/acpi/apei/extlog.c
@@ -216,7 +216,7 @@ void acpi_extlog_report(const struct acpi_hest_generic_status *estatus)
 			void *err = acpi_hest_get_payload(gdata);
 
 			log_non_standard_event(sec_type, fru_id, fru_text,
-					       gdata->error_severity, err,
+					       ghes_severity(gdata->error_severity), err,
 					       gdata->error_data_length);
 		}
 	}
-- 
2.43.0



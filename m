Return-Path: <linuxppc-dev+bounces-24255-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292F1C44508
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 16:58:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h058p5KqFz2yY0;
	Wed, 15 Jul 2026 02:58:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784048282;
	cv=none; b=L6heVusOUYDfclNGhC86WvIdacBholpOccOIiF2TZQngsbIzwImHZHRmrG+b340z73cH5yrYbE2rXZws/wTr3Swm8UZacjST3otH47T4A9dfvnLpasPQyRmXdwOt/PNDhY0lKC2IWGLaoCuHmQmF+sSRC71COu4ALSEfzphDSShe6GrGzGAD3tAZQiE/BBUZJE3/xq5ctE8hQq3CxBG7lWid5vRHYez1dYStcmB5AgZKKuzyn4atZgAa9nspLT2CoyivghFS3klv2o74T0c51PA/pkBPoMl17m7ZNDCMc8Kxk3xA1CNxh/9u3/u6DTO8VZbNeeBuJz9X/BNzFkPY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784048282; c=relaxed/relaxed;
	bh=e5blKI9T2RVcmKZdgBfUGMw3JZBxqWeVrnUE0eWQYNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jsyG109OwQ3ODPmJPLyTJD71OzXSqTQooct4UAJBZCrP/HYuKcPaMp4qcPZD9bMn6BcDTTwoLEMRnkh/RXe6kyXyXif8hmRWcVDkNBWQceA01VdEqD95wwGsk1PJJLu9RUOBE0K1g5ZZjTZhnzoLVqfoBJjwyWfWGgRgFiOIvspjxRHWUN3isGPL/IM5x5SnM5dsmE5Cwx0gupwYHNg2ixAN6BXOJKMPUmHcbe48nG0uwjH8k8RYRVZd0oxo3933LZK3JUsZGNAdKHjnp8SDSa2ijPcguyrVN4dsLQLS0zfK7UaVwx6xOk9u5R7+j6PtZSWrHWFPHumlYJxNEESO3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=RyYhrUuY; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=RyYhrUuY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h058m6rQsz2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 02:58:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1784047914;
	bh=g89D7a4XpoHeRm3Z+DDM6ulsaVeCNUY/pAXw/B1rrIk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RyYhrUuY0VRYIxcc9jWksSkw7dIf0uM/QpFUvw4D6iOEoFlbFIW2ghfJRleLK/WNQ
	 rey2x6MFE92RNNXOIwhwvX6xLLST98AEg4K+nKvLxlguxYiWa22Mt2e548F4Dtwvr/
	 0PbWPM6Nq0WBZlQHJvhrSADefcIap0eArXNpynw4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 14 Jul 2026 18:51:48 +0200
Subject: [PATCH 1/3] x86/mce: Use __DEVICE_ATTR() macro to initialize
 dev_ext_attribute
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260714-sysfs-const-attr-dev_ext_attr-v1-1-6b2c0435d621@weissschuh.net>
References: <20260714-sysfs-const-attr-dev_ext_attr-v1-0-6b2c0435d621@weissschuh.net>
In-Reply-To: <20260714-sysfs-const-attr-dev_ext_attr-v1-0-6b2c0435d621@weissschuh.net>
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, 
 Yushan Wang <wangyushan12@huawei.com>, Jijie Shao <shaojijie@huawei.com>, 
 Khuong Dinh <khuong@os.amperecomputing.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-cxl@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, driver-core@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784047913; l=1433;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=g89D7a4XpoHeRm3Z+DDM6ulsaVeCNUY/pAXw/B1rrIk=;
 b=al6DQcUFY/kmhepddTJ9a3tiSk4uB2AABkAFZK53JWe7hXFh8iP5oigjsKCNTsx5CGLx1aAPi
 S+roPX/wX0VCQ+JQgOIpHnCiy71QTSy4QX9NJBT275qiNhAXHQF7RQx
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The upcoming constification of the device_show_int() and
device_show_bool() signatures requires the users to handle the
transition automatically.

Switch to the __DEVICE_ATTR() macro which can do this.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/x86/kernel/cpu/mce/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 9bba1e2f03af..7fc9aa9e2ec9 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2621,17 +2621,17 @@ static DEVICE_BOOL_ATTR(dont_log_ce, 0644, mca_cfg.dont_log_ce);
 static DEVICE_BOOL_ATTR(print_all, 0644, mca_cfg.print_all);
 
 static struct dev_ext_attribute dev_attr_check_interval = {
-	__ATTR(check_interval, 0644, device_show_int, store_int_with_restart),
+	__DEVICE_ATTR(check_interval, 0644, device_show_int, store_int_with_restart),
 	&check_interval
 };
 
 static struct dev_ext_attribute dev_attr_ignore_ce = {
-	__ATTR(ignore_ce, 0644, device_show_bool, set_ignore_ce),
+	__DEVICE_ATTR(ignore_ce, 0644, device_show_bool, set_ignore_ce),
 	&mca_cfg.ignore_ce
 };
 
 static struct dev_ext_attribute dev_attr_cmci_disabled = {
-	__ATTR(cmci_disabled, 0644, device_show_bool, set_cmci_disabled),
+	__DEVICE_ATTR(cmci_disabled, 0644, device_show_bool, set_cmci_disabled),
 	&mca_cfg.cmci_disabled
 };
 

-- 
2.55.0



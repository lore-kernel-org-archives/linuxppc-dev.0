Return-Path: <linuxppc-dev+bounces-26646-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881C9C79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 05:52:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdbmy4ZtVz2yvv;
	Mon, 07 Sep 2026 15:52:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788760322;
	cv=none; b=EzRQp3dC3Qw+hAO3r6I4BT8IbzeXh9ChCgtNNG6qAm4Y9AYd5Q5STkaO6qZoCw/d7iuq/pX4AaiuWAt7tLHhxmH6M0jpkjYxaup8QTE+Ylq1NqEIN0Xc/oE/MNX43Fcfp+dm7ySY/u/JpNXexirHKRL6h4tlmFYEVfBIOQUycezggnUIQ1SfpBwMzYjKw+7b44I5Cz04JEqblGlzIh348U2OR5ISThuIxqItm/X/8SYpROiMLSU4LnWLn6jduLchDxjsVOiCGGBa6TFhf8v50lKA9AiqPbV4/h+HX95wQtT0svqp81NtDKrTzAQ9YC7gB8iqq2d9SldQzaE4JlZA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788760322; c=relaxed/relaxed;
	bh=jRYb+bei6+DQO38gLjylQZSOtSK8oSUs1xZR6GAs5kU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BRqn7Drvf8T5BiTimnOOdJALQ6n+0JgzQ8yCwz7KzJdmstmEznwNsE7/H02jEFI+kTpcQYRGiCwvn31tp8DePJJ9JRXUwwCAMA2CwVeNVUsZZjNsL9agQ9qzE+YG5ecXE9vQUMD4mH9aYQOGSXL4lImIEXc1byKKsbnY9rmCKEoTZH4qCk/PV1zUGMEcSaSs9SkVQuyLg3vkU4zUnL3lT4Kq2kCAl7T/lYrB4yy2GrZr1tdfxcMrjW8VFc8w+VbZKV103YxR7Y8fq9tsnlpItdOwfiiXuRPvzoa/1teDtJxPkxJv1pGMAML4KPmy3fmtnNYKeE/bO9G+u5ZjpHe07w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=SQXB8XnG; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=SQXB8XnG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 400 seconds by postgrey-1.37 at boromir; Mon, 07 Sep 2026 15:52:00 AEST
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdbmw43zSz2yvX
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 15:52:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1788759912;
	bh=zjio8W22GynDJMVZ+Z9fSpGxkhflvi4bv0Y2DSF0wFw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SQXB8XnGsJyqjxufdq52uGMyP66SmCPZVptYp9ENSeTt5tP7mhw7YQu9uXwTcFeep
	 GlHZxFjMGWPggeRC8rXbvtI19KQhNekEX/w7Tue0lDBs0alRb/mq5qnI660Md9QzeU
	 8qIQJsmlySp7VykKWyoyDrfuR6APyfnS9LmvwhBs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 07 Sep 2026 07:45:01 +0200
Subject: [PATCH v2 1/3] x86/mce: Use __DEVICE_ATTR() macro to initialize
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
Message-Id: <20260907-sysfs-const-attr-dev_ext_attr-v2-1-bf53afe57071@weissschuh.net>
References: <20260907-sysfs-const-attr-dev_ext_attr-v2-0-bf53afe57071@weissschuh.net>
In-Reply-To: <20260907-sysfs-const-attr-dev_ext_attr-v2-0-bf53afe57071@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788759912; l=1433;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=zjio8W22GynDJMVZ+Z9fSpGxkhflvi4bv0Y2DSF0wFw=;
 b=wCxOSjxvbbdreCrZQx/QcuWsGUDp3AKhme52hKzrMTjWGgj6/Xl3pga+77EN2z3Mzhz+s7r9O
 8kTcsTZ75BoDvjUCgBSrCP/Sgoye7IpQl3Y3m9Rg5T6F7BJNf2fq9E0
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
index ab469605fc89..d67f3b6b83d8 100644
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



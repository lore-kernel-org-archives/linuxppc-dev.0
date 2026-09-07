Return-Path: <linuxppc-dev+bounces-26647-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34D8C79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 05:52:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdbmz63dxz2yys;
	Mon, 07 Sep 2026 15:52:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:c010:41de::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788760323;
	cv=none; b=KqQP7s3+Zecn98BwsXY9phzGa7HuGX3LfmqjyIlDZ3SzYywi7MZslALSJ8NK7Ee1bTzEsyPRY6FZL3f3lOL/PhWTAF5Q0W3665GFbZ3+QZ0Pqs2/yV0FXVMsszXGe5/1A6keYqeXqI4f6AiXU9jnLQbfPs4V/ohg0FH+MLqM1hTNu1TaO+oZcTQz5EqSsv2lCTBZ94xNds2g/FAy31z7N3JTZpr1zLV5wiQimZVS3PrKtsKzUaB104jYl3+O0AH2zALAsC9humv3uiKHUWjwhtQO5Bq7CU8qT3fAVhGjnLHlQ7Ww2k1itf/XBnS4JqYn2UHp2GTD0jbuFbSCgaIHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788760323; c=relaxed/relaxed;
	bh=n6tgaHbVtiWTh3fQBGQAiRrlbsazgMdvtDokO7aUJ4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Srdp1d3ZN1Lm/xuLdxE1EwOtbeDUFU6N7MoltC+ss5WpS3JOKzazYE4w39uAp/0plBw5VqrSicG34nhee6wRqdqlKg073qV8R0YNuh58WOTRnYCAc0x/K+NoMoJyiD+48oDqCBfZQ4Nkl04p/p6HMtNbBpjWCqFl+Hcrv+5XCQ+Ix5o+Enp5aY6xApeJr1BxrPyJFZ+jXDRr6RfAOG0SsDGbjoodCYj0s8klImGwb11v1Bt1RS/41y/ltFDdVuxH2hkcN7SCuTsOBIjc9xmMjexDkMDRy9FCDGk5yCBG2SVZkZmUeiQWtq3Krt0Rf8fsZ4qe4q1xSwXqUoH/XonkIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=SfWSK/ah; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=SfWSK/ah;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdbmx1ZNPz2yvY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 15:52:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1788759912;
	bh=jHaxIQ3pA1eeWIle1Pk9J90EZmpff5RsKw2PfaVnl9A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SfWSK/ahn06kZntBnbhT0gYtxboxUyXFW9sznUoNgaeOlkScL/EVWj5kKaLRsnxwj
	 qMTCIvjn1ZFkBsUI621/mshp8jAEz3LFaTdQTx92ltJp+/r/7ijQnRwI9imYQl/R3l
	 jWF+lfEnUxnVx74sACHqIQFXMyfW7+dmRlk0kr4s=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 07 Sep 2026 07:45:03 +0200
Subject: [PATCH v2 3/3] driver core: Constify the signature of
 device_show/store_*()
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
Message-Id: <20260907-sysfs-const-attr-dev_ext_attr-v2-3-bf53afe57071@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788759912; l=5954;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jHaxIQ3pA1eeWIle1Pk9J90EZmpff5RsKw2PfaVnl9A=;
 b=HSiLRH38g3xSkpGb5oIKBJaK+SOmvIEuNwqO/eqdT7KHt7JaySzEjU5t5xVPUxSbcL/2oSJ8q
 Vg+/kfFlctnBza+sS9aoCZ//ve+6Dyrc1y3gZ5QVZWXlD8L1tbcV9W2
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Prepare for the constification of 'struct dev_ext_attribute' by changing
the signature of the standard callback functions.

Migrate the hv-24x7 driver in the same commit. It is the only user to
manually assign one of the standard callbacks.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/powerpc/perf/hv-24x7.c |  2 +-
 drivers/base/core.c         | 30 +++++++++++++++---------------
 include/linux/device.h      | 14 +++++++-------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index b0eedf185960..3e094dc7d76b 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -462,7 +462,7 @@ static struct attribute *device_str_attr_create_(char *name, char *str)
 	attr->var = str;
 	attr->attr.attr.name = name;
 	attr->attr.attr.mode = 0444;
-	attr->attr.show = device_show_string;
+	attr->attr.show_const = device_show_string;
 
 	return &attr->attr.attr;
 }
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4c0c373998a1..5daa88fa724a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2517,13 +2517,13 @@ static const struct sysfs_ops dev_sysfs_ops = {
 	.store	= dev_attr_store,
 };
 
-#define to_ext_attr(x) container_of(x, struct dev_ext_attribute, attr)
+#define to_ext_attr(x) container_of_const(x, struct dev_ext_attribute, attr)
 
 ssize_t device_store_ulong(struct device *dev,
-			   struct device_attribute *attr,
+			   const struct device_attribute *attr,
 			   const char *buf, size_t size)
 {
-	struct dev_ext_attribute *ea = to_ext_attr(attr);
+	const struct dev_ext_attribute *ea = to_ext_attr(attr);
 	int ret;
 	unsigned long new;
 
@@ -2537,19 +2537,19 @@ ssize_t device_store_ulong(struct device *dev,
 EXPORT_SYMBOL_GPL(device_store_ulong);
 
 ssize_t device_show_ulong(struct device *dev,
-			  struct device_attribute *attr,
+			  const struct device_attribute *attr,
 			  char *buf)
 {
-	struct dev_ext_attribute *ea = to_ext_attr(attr);
+	const struct dev_ext_attribute *ea = to_ext_attr(attr);
 	return sysfs_emit(buf, "%lx\n", *(unsigned long *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_ulong);
 
 ssize_t device_store_int(struct device *dev,
-			 struct device_attribute *attr,
+			 const struct device_attribute *attr,
 			 const char *buf, size_t size)
 {
-	struct dev_ext_attribute *ea = to_ext_attr(attr);
+	const struct dev_ext_attribute *ea = to_ext_attr(attr);
 	int ret;
 	long new;
 
@@ -2566,19 +2566,19 @@ ssize_t device_store_int(struct device *dev,
 EXPORT_SYMBOL_GPL(device_store_int);
 
 ssize_t device_show_int(struct device *dev,
-			struct device_attribute *attr,
+			const struct device_attribute *attr,
 			char *buf)
 {
-	struct dev_ext_attribute *ea = to_ext_attr(attr);
+	const struct dev_ext_attribute *ea = to_ext_attr(attr);
 
 	return sysfs_emit(buf, "%d\n", *(int *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_int);
 
-ssize_t device_store_bool(struct device *dev, struct device_attribute *attr,
+ssize_t device_store_bool(struct device *dev, const struct device_attribute *attr,
 			  const char *buf, size_t size)
 {
-	struct dev_ext_attribute *ea = to_ext_attr(attr);
+	const struct dev_ext_attribute *ea = to_ext_attr(attr);
 
 	if (kstrtobool(buf, ea->var) < 0)
 		return -EINVAL;
@@ -2587,19 +2587,19 @@ ssize_t device_store_bool(struct device *dev, struct device_attribute *attr,
 }
 EXPORT_SYMBOL_GPL(device_store_bool);
 
-ssize_t device_show_bool(struct device *dev, struct device_attribute *attr,
+ssize_t device_show_bool(struct device *dev, const struct device_attribute *attr,
 			 char *buf)
 {
-	struct dev_ext_attribute *ea = to_ext_attr(attr);
+	const struct dev_ext_attribute *ea = to_ext_attr(attr);
 
 	return sysfs_emit(buf, "%d\n", *(bool *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_bool);
 
 ssize_t device_show_string(struct device *dev,
-			   struct device_attribute *attr, char *buf)
+			   const struct device_attribute *attr, char *buf)
 {
-	struct dev_ext_attribute *ea = to_ext_attr(attr);
+	const struct dev_ext_attribute *ea = to_ext_attr(attr);
 
 	return sysfs_emit(buf, "%s\n", (char *)ea->var);
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index aee79fd6b32b..90cdd77458bb 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -129,19 +129,19 @@ struct dev_ext_attribute {
 	void *var;
 };
 
-ssize_t device_show_ulong(struct device *dev, struct device_attribute *attr,
+ssize_t device_show_ulong(struct device *dev, const struct device_attribute *attr,
 			  char *buf);
-ssize_t device_store_ulong(struct device *dev, struct device_attribute *attr,
+ssize_t device_store_ulong(struct device *dev, const struct device_attribute *attr,
 			   const char *buf, size_t count);
-ssize_t device_show_int(struct device *dev, struct device_attribute *attr,
+ssize_t device_show_int(struct device *dev, const struct device_attribute *attr,
 			char *buf);
-ssize_t device_store_int(struct device *dev, struct device_attribute *attr,
+ssize_t device_store_int(struct device *dev, const struct device_attribute *attr,
 			 const char *buf, size_t count);
-ssize_t device_show_bool(struct device *dev, struct device_attribute *attr,
+ssize_t device_show_bool(struct device *dev, const struct device_attribute *attr,
 			char *buf);
-ssize_t device_store_bool(struct device *dev, struct device_attribute *attr,
+ssize_t device_store_bool(struct device *dev, const struct device_attribute *attr,
 			 const char *buf, size_t count);
-ssize_t device_show_string(struct device *dev, struct device_attribute *attr,
+ssize_t device_show_string(struct device *dev, const struct device_attribute *attr,
 			   char *buf);
 
 typedef ssize_t __device_show_handler_const(struct device *dev, const struct device_attribute *attr,

-- 
2.55.0



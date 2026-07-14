Return-Path: <linuxppc-dev+bounces-24258-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66959C4450A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 16:58:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h058r58mQz3092;
	Wed, 15 Jul 2026 02:58:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:c010:41de::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784048284;
	cv=none; b=l/ycC9EABNN582h96JkP9YylGLWZ8OsjzJgGx1r1Ru4OuVlqsI5fwPoDUDUBSwEKx5EzLiFIAt4hdyYZRz2+bwJSwUNrNcFKC2tlN3k4txw5gsbl8yvm9QI2S8iB8NmeYXJX9ygpa+45N6Ui6yda9hrCISWX3aP+DvMuf9rXdsDkTpiRmBu1PbTETgMTGw/hXiERtb0zgxFWYXWBEaWWQf614SSzdPUyLnaAhOtoLGKo9nSnpGfyJvPNpmBcmr8sSh/V9081imoadD5I4xcVaLVCvAQmudEGjVqy/RT3W5xIrzbcBt9pP5B+1cF4DHk5qmWQQyF31Dg2ZUdDOXeiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784048284; c=relaxed/relaxed;
	bh=rar/kdWXc0FAws5pLlRcMXbbvccLEgPpbnHbobO2LGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CMsGrG+VsIZQJKP+ul0mwGfTrwsrcv77eew46nMZNtpEeHxiXDtdkQi7P1QMEWbLO/iFK5upCRU+WBUDY3dJ6lV3KjeVSBgpXPc+V1W5EijpZOLPzxqMPlPMNq7GIMO3uPA6zyYbLCOcnKYP21n3+T5aYAu6urFBK/ArH6BndRX9IPk2HQ4TxUD7+Ts/hwTVvX9iO6ktzsvMAIkDCx0ayafwtTl+lPuovclMfwUt3xsLy2BnXEsDgbpdQWZA6R9Of2CZ8T9hOzpHkhOpH8igpN70P4evWnC/Y1ebboQXWh4ElE9kBerQWQETVMbn0NeeqFNIXkrFpIWueBnLk4n8vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=AfRCxkVh; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=AfRCxkVh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 359 seconds by postgrey-1.37 at boromir; Wed, 15 Jul 2026 02:58:00 AEST
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h058m6Qppz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 02:58:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1784047914;
	bh=y+nMsMtnPzeoRMm6XOGdcqLiE1JJKdTJFdXgVfqhtcg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AfRCxkVhMPXaeJ4X2pakjBoLYVMtENgqh6kslhbd+3AQg3WfIGgBcX2hDtINAVg+v
	 Hw6tnma1FmLBkiT/Ldj7crCME1oCD5BjCY6CJbbzBhJYmNVDVsdn5FyukoGu1QvVSV
	 BKkbdrDrb2bAHn8Ii1Z7+wIuZQYUY5Pu5/df8wFo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 14 Jul 2026 18:51:50 +0200
Subject: [PATCH 3/3] driver core: Constify the signature of
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
Message-Id: <20260714-sysfs-const-attr-dev_ext_attr-v1-3-6b2c0435d621@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784047913; l=5833;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=y+nMsMtnPzeoRMm6XOGdcqLiE1JJKdTJFdXgVfqhtcg=;
 b=CE/PLEPjEk9Clk2ILAqAI/VCFiwwgxAk66fuzdwrBCBYf62zj4nI5gb6xVcT3JfCfpR44koSU
 BdRAPrwT0zcBc20cdAFo7P5079v7q7Z6w6civBd2ZOcqPBwj5qITrGA
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Prepare for the constification of 'struct dev_ext_attribute' by changing
the signature of the standard callback functions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/powerpc/perf/hv-24x7.c |  2 +-
 drivers/base/core.c         | 30 +++++++++++++++---------------
 include/linux/device.h      | 14 +++++++-------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index abb4cfb11fcc..c0abac00e026 100644
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
index 4d026682944f..649b8a126920 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2513,13 +2513,13 @@ static const struct sysfs_ops dev_sysfs_ops = {
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
 
@@ -2533,19 +2533,19 @@ ssize_t device_store_ulong(struct device *dev,
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
 
@@ -2562,19 +2562,19 @@ ssize_t device_store_int(struct device *dev,
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
@@ -2583,19 +2583,19 @@ ssize_t device_store_bool(struct device *dev, struct device_attribute *attr,
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
index 7b2baffdd2f5..61e2b98b38a4 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -127,19 +127,19 @@ struct dev_ext_attribute {
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



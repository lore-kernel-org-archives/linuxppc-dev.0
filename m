Return-Path: <linuxppc-dev+bounces-19416-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24C3FB5179
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 23:25:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqQS12wtyz2ygY;
	Tue, 07 Apr 2026 09:25:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775517953;
	cv=none; b=L4LYVQZdO75MBUucw9vj+XBiVHCPrVIskHhH6UnjTSPg2zcaKUeohpj9TGEQ0ZtKNtDeQbBZqJ1DaNJPxRqiCu2X+iyGbfLL9LgxnZ0piO3DWQe180DTLRvULtnAU2Xezk7ammntRib6KCiPyFkny/NJ9ucXPT36e9bW4VVhiJTyysvtIMofIH81dzB9U35hMAAn6lnkrSfQWjZQzlyQuWbLapBAnaQcx9BWQItas85YEQTQny/GtEAU0f6wd2izJy+P97bjc0ALHv360Fh3fZRrAs5mESw9seCQOKoMmGFY32jvdC2oPGoU/8ltot9d0GRql3DL9mjVIzgLj29Egg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775517953; c=relaxed/relaxed;
	bh=+7fxdjSi9+RKgdFwjeRu5DfLfM5rFKPeYpJSBLh/9No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRQRYS9guV5IbFcLID7NuzmEMnJ5lXpu2zUYIZ+6B/ogmq8AjyGSw7nSP3joJqUFgDfP4KAivwuhS97Xq/C7oQSJtFICMrxT3tU3Env15ntaVRsufFhgByx2p+j5z/PVygA/38c9oGb3qdaoxl/rc9lD2q6651zU5tKqC8x+2NCR/ImxC48Ex+zbLIKJejoCzhm63jsLXH6V5A2SRKEdNrFY8ehEiTW9etisp1baaVSF8q4Z1g1M/DmRdFMTGpP8VN01wrD2Dw8NzYdlr1wziGe4w7MHUxtpZ3gEDyy3FOsaAlHbl3bhImxBSVxWHhHlAe3qJeytpvhBw0hU5xsEFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=X1F1k2Qr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=dianders@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=X1F1k2Qr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=dianders@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqQS037vXz2yfs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 09:25:52 +1000 (AEST)
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-2c7d8bbad06so9857502eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 16:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775517950; x=1776122750; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7fxdjSi9+RKgdFwjeRu5DfLfM5rFKPeYpJSBLh/9No=;
        b=X1F1k2Qry1mxzsM/0ZAsQ2WObdLynAtuI/xgfj6pDv31JWy2liuz7loynqc+3zpIis
         R+ok6Y2gbVTTRykQaIPuJUnnDBDx5yshekg8L5FQKlYt5Ir91CABZUP21Cabt8dyANLY
         uuiz/JNn9AmKG/wGu5+PRKWIagZkb8IQ+6UHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775517950; x=1776122750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+7fxdjSi9+RKgdFwjeRu5DfLfM5rFKPeYpJSBLh/9No=;
        b=lxhNb5WSGHX2kPRZ2Ynsi1GWKKyDRr+8XmAy/7vL+hvuviAo1Qy57ONfJKvnVL0rzt
         lmB1SpeorILbnzyEw7nQdCUJ3z0c84iUQvYSqwnHX0P730mxp6JVSOwTHXazLE3N1pNO
         3s1vSXIbGhPaVDkDQHCkgupb+mTwvTVWtbWqWx4uWJUro/ERmmk4M/LKg+xCRcwSbfqn
         4RhfX02GeZpLbY3JTGSkgwCfOjNLA/CiG3VOKQ9vO/FouhL1e7vr2Tz6OPxG+FxtXxKS
         LpLthXIsr8K0awHJK0U4yq6wvW0v8MsAVTwgsccLyCU62DU9lkGl4lVx0XHilXGjo+fs
         PU8w==
X-Forwarded-Encrypted: i=1; AJvYcCWotOMGjcftUcICKpXeSBc5z/i6D/qrTCxwTmJtd0qWepP4rkMrPYV3HZexgrJlhhyDDpRVPsAe3faOyCA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx39RdyhvFnPCwZkbBC/xp1dZ/UP/b8H0F76GjXdIeCEEc2hQ2+
	wPnDadcCkyj8J/TqY+1Z2M7Q8WOPI6MKOa+ZamKFt2L1LRR3DjbJUnRREcn6cSXDrA==
X-Gm-Gg: AeBDiesJdaCl+fcHuYKoZbIcCTNKApIdTNSVREjlV4clDLImM8fYhdK+ZJqdEvpvTgq
	4UhUoz/vo5ouj2ArZ8VEiPY7NOnKF01ioVUz9NbEYuwiCxe9n+TrC2QyThjO89p4YXSCN6EchXb
	gbMG2dKwoa5G7symwU+wNPBhJyq8XfQ3/YostA1Cc03WiKirHEnR6gS+AkR+TgOpDVYO5ougXLK
	uZiTOKl5OyvB7GkGos5qCchxAvdkOzFXhF9Yaw5o+VLaWtfzgTjDNJaZemhfc4TbIcC6Pqo763G
	s64rtVr5Ph61vTzt2MJARJOESiF9h5+N7H/iJXICuWGjqJ1ClmQGx/qX02t7IYpFXfD/m3J+/Xv
	dutpwaesTINJ4tjviJEjW0Z6HJjtis+79iXCXOZVXNURbu0pNkjlpyK+IWSHyz3rsxVYDyX90Y9
	PWmMkHe+Im1hJW7CGw/wREhO9siEusBeGRXDb5Phc3qSqejjnEBzDQaswnv4yG1bpp7kMDZWc7k
	sHKFE6+cQ==
X-Received: by 2002:a05:7301:434b:b0:2c8:6361:ab38 with SMTP id 5a478bee46e88-2cbfa5c1258mr7548017eec.15.1775517950390;
        Mon, 06 Apr 2026 16:25:50 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:c071:3b78:5a5:824a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca760b0518sm14730975eec.0.2026.04.06.16.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:25:49 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	maz@kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	ardb@kernel.org,
	catalin.marinas@arm.com,
	chleroy@kernel.org,
	david@kernel.org,
	driver-core@lists.linux.dev,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	miko.lenczewski@arm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	osalvador@suse.de,
	oupton@kernel.org,
	peterz@infradead.org,
	tglx@kernel.org,
	will@kernel.org,
	yangyicong@hisilicon.com,
	yeoreum.yun@arm.com
Subject: [PATCH v5 9/9] driver core: Replace dev->offline + ->offline_disabled with accessors
Date: Mon,  6 Apr 2026 16:23:02 -0700
Message-ID: <20260406162231.v5.9.I897d478b4a9361d79cd5073207c1062fd4d0d0e4@changeid>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260406232444.3117516-1-dianders@chromium.org>
References: <20260406232444.3117516-1-dianders@chromium.org>
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

In C, bitfields are not necessarily safe to modify from multiple
threads without locking. Switch "offline" and "offline_disabled" over
to the "flags" field so modifications are safe.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Not fixing any known bugs; problem is theoretical and found by code
inspection. Change is done somewhat manually and only lightly tested
(mostly compile-time tested).

(no changes since v4)

Changes in v4:
- Use accessor functions for flags

Changes in v3:
- New

 arch/arm64/kernel/cpufeature.c                 |  2 +-
 .../powerpc/platforms/pseries/hotplug-memory.c |  4 ++--
 drivers/acpi/scan.c                            |  2 +-
 drivers/base/core.c                            | 18 +++++++++---------
 drivers/base/cpu.c                             |  4 ++--
 drivers/base/memory.c                          |  2 +-
 include/linux/device.h                         | 12 ++++++------
 kernel/cpu.c                                   |  4 ++--
 8 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 32c2dbcc0c64..c832aa565dc2 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -4042,7 +4042,7 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
 	 */
 	lucky_winner = cpu_32bit ? cpu : cpumask_any_and(cpu_32bit_el0_mask,
 							 cpu_active_mask);
-	get_cpu_device(lucky_winner)->offline_disabled = true;
+	dev_set_offline_disabled(get_cpu_device(lucky_winner));
 	setup_elf_hwcaps(compat_elf_hwcaps);
 	elf_hwcap_fixup();
 	pr_info("Asymmetric 32-bit EL0 support detected on CPU %u; CPU hot-unplug disabled on CPU %u\n",
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index b2f14db59034..75f85a5da981 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -213,9 +213,9 @@ static int dlpar_change_lmb_state(struct drmem_lmb *lmb, bool online)
 		return -EINVAL;
 	}
 
-	if (online && mem_block->dev.offline)
+	if (online && dev_offline(&mem_block->dev))
 		rc = device_online(&mem_block->dev);
-	else if (!online && !mem_block->dev.offline)
+	else if (!online && !dev_offline(&mem_block->dev))
 		rc = device_offline(&mem_block->dev);
 	else
 		rc = 0;
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e8cdbdb46fdb..1353adbcc234 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -122,7 +122,7 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
 	mutex_lock_nested(&adev->physical_node_lock, SINGLE_DEPTH_NESTING);
 
 	list_for_each_entry(pn, &adev->physical_node_list, node)
-		if (device_supports_offline(pn->dev) && !pn->dev->offline) {
+		if (device_supports_offline(pn->dev) && !dev_offline(pn->dev)) {
 			if (uevent)
 				kobject_uevent_env(&pn->dev->kobj, KOBJ_CHANGE, envp);
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 30825bf83234..4f293aed879a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2788,7 +2788,7 @@ static ssize_t online_show(struct device *dev, struct device_attribute *attr,
 	bool val;
 
 	device_lock(dev);
-	val = !dev->offline;
+	val = !dev_offline(dev);
 	device_unlock(dev);
 	return sysfs_emit(buf, "%u\n", val);
 }
@@ -2913,7 +2913,7 @@ static int device_add_attrs(struct device *dev)
 	if (error)
 		goto err_remove_type_groups;
 
-	if (device_supports_offline(dev) && !dev->offline_disabled) {
+	if (device_supports_offline(dev) && !dev_offline_disabled(dev)) {
 		error = device_create_file(dev, &dev_attr_online);
 		if (error)
 			goto err_remove_dev_groups;
@@ -4180,7 +4180,7 @@ static int device_check_offline(struct device *dev, void *not_used)
 	if (ret)
 		return ret;
 
-	return device_supports_offline(dev) && !dev->offline ? -EBUSY : 0;
+	return device_supports_offline(dev) && !dev_offline(dev) ? -EBUSY : 0;
 }
 
 /**
@@ -4198,7 +4198,7 @@ int device_offline(struct device *dev)
 {
 	int ret;
 
-	if (dev->offline_disabled)
+	if (dev_offline_disabled(dev))
 		return -EPERM;
 
 	ret = device_for_each_child(dev, NULL, device_check_offline);
@@ -4207,13 +4207,13 @@ int device_offline(struct device *dev)
 
 	device_lock(dev);
 	if (device_supports_offline(dev)) {
-		if (dev->offline) {
+		if (dev_offline(dev)) {
 			ret = 1;
 		} else {
 			ret = dev->bus->offline(dev);
 			if (!ret) {
 				kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
-				dev->offline = true;
+				dev_set_offline(dev);
 			}
 		}
 	}
@@ -4238,11 +4238,11 @@ int device_online(struct device *dev)
 
 	device_lock(dev);
 	if (device_supports_offline(dev)) {
-		if (dev->offline) {
+		if (dev_offline(dev)) {
 			ret = dev->bus->online(dev);
 			if (!ret) {
 				kobject_uevent(&dev->kobj, KOBJ_ONLINE);
-				dev->offline = false;
+				dev_clear_offline(dev);
 			}
 		} else {
 			ret = 1;
@@ -4716,7 +4716,7 @@ static int device_attrs_change_owner(struct device *dev, kuid_t kuid,
 	if (error)
 		return error;
 
-	if (device_supports_offline(dev) && !dev->offline_disabled) {
+	if (device_supports_offline(dev) && !dev_offline_disabled(dev)) {
 		/* Change online device attributes of @dev to @kuid/@kgid. */
 		error = sysfs_file_change_owner(kobj, dev_attr_online.attr.name,
 						kuid, kgid);
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 875abdc9942e..19d288a3c80c 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -422,8 +422,8 @@ int register_cpu(struct cpu *cpu, int num)
 	cpu->dev.id = num;
 	cpu->dev.bus = &cpu_subsys;
 	cpu->dev.release = cpu_device_release;
-	cpu->dev.offline_disabled = !cpu->hotpluggable;
-	cpu->dev.offline = !cpu_online(num);
+	dev_assign_offline_disabled(&cpu->dev, !cpu->hotpluggable);
+	dev_assign_offline(&cpu->dev, !cpu_online(num));
 	cpu->dev.of_node = of_get_cpu_node(num, NULL);
 	cpu->dev.groups = common_cpu_attr_groups;
 	if (cpu->hotpluggable)
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index a3091924918b..5005654f44fa 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -697,7 +697,7 @@ static int __add_memory_block(struct memory_block *memory)
 	memory->dev.id = memory->start_section_nr / sections_per_block;
 	memory->dev.release = memory_block_release;
 	memory->dev.groups = memory_memblk_attr_groups;
-	memory->dev.offline = memory->state == MEM_OFFLINE;
+	dev_assign_offline(&memory->dev, memory->state == MEM_OFFLINE);
 
 	ret = device_register(&memory->dev);
 	if (ret) {
diff --git a/include/linux/device.h b/include/linux/device.h
index a79865a212e9..d695f7537112 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -485,6 +485,8 @@ struct device_physical_location {
  *		architecture supports non-coherent devices.
  * @DEV_FLAG_OF_NODE_REUSED: Set if the device-tree node is shared with an
  *		ancestor device.
+ * @DEV_FLAG_OFFLINE_DISABLED: If set, the device is permanently online.
+ * @DEV_FLAG_OFFLINE: Set after successful invocation of bus type's .offline().
  */
 enum struct_device_flags {
 	DEV_FLAG_READY_TO_PROBE = 0,
@@ -495,6 +497,8 @@ enum struct_device_flags {
 	DEV_FLAG_STATE_SYNCED = 5,
 	DEV_FLAG_DMA_COHERENT = 6,
 	DEV_FLAG_OF_NODE_REUSED = 7,
+	DEV_FLAG_OFFLINE_DISABLED = 8,
+	DEV_FLAG_OFFLINE = 9,
 
 	DEV_FLAG_COUNT
 };
@@ -573,9 +577,6 @@ enum struct_device_flags {
  * @removable:  Whether the device can be removed from the system. This
  *              should be set by the subsystem / bus driver that discovered
  *              the device.
- *
- * @offline_disabled: If set, the device is permanently online.
- * @offline:	Set after successful invocation of bus type's .offline().
  * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
@@ -680,9 +681,6 @@ struct device {
 
 	enum device_removable	removable;
 
-	bool			offline_disabled:1;
-	bool			offline:1;
-
 	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
 };
 
@@ -716,6 +714,8 @@ __create_dev_flag_accessors(dma_ops_bypass, DEV_FLAG_DMA_OPS_BYPASS);
 __create_dev_flag_accessors(state_synced, DEV_FLAG_STATE_SYNCED);
 __create_dev_flag_accessors(dma_coherent, DEV_FLAG_DMA_COHERENT);
 __create_dev_flag_accessors(of_node_reused, DEV_FLAG_OF_NODE_REUSED);
+__create_dev_flag_accessors(offline_disabled, DEV_FLAG_OFFLINE_DISABLED);
+__create_dev_flag_accessors(offline, DEV_FLAG_OFFLINE);
 
 #undef __create_dev_flag_accessors
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index bc4f7a9ba64e..f975bb34915b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2639,7 +2639,7 @@ static void cpuhp_offline_cpu_device(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
 
-	dev->offline = true;
+	dev_set_offline(dev);
 	/* Tell user space about the state change */
 	kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
 }
@@ -2648,7 +2648,7 @@ static void cpuhp_online_cpu_device(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
 
-	dev->offline = false;
+	dev_clear_offline(dev);
 	/* Tell user space about the state change */
 	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
 }
-- 
2.53.0.1213.gd9a14994de-goog



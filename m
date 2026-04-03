Return-Path: <linuxppc-dev+bounces-19246-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73DCCC6B1D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 00:52:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn0YN3cxkz2ydq;
	Fri, 03 Apr 2026 11:52:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775177528;
	cv=none; b=DByvDcZns7l8pB7VyoR5RvODkEI8aWnl8b2EXlG2i2nYpbO+/HFtuCqF4+GGjyRt+spXyskTtBIz29PkU9uYy+mEoQ+8JNMVCleWedBwbY0YzkeTPOWYN4gumXJv74DfjLqWw0Xc8lT0mEyoN9D7B16jWVuB7IjAVSTdIX2V6TRmSMwFcq6HqnjVZU1Ujn67z9URABd4EtV0p9rK/fJ+dET/A13ak+uau15UiIAAvpjLGe20oVuqrkXjU0gYPiD1JYmPyNTsPqu5NfIMaijObBtxWHk7eh+si3OQ7PNTyP1JmRm9H3sUCS+ceHRjmeDnjFsgShmGsIvdO3B4wkXVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775177528; c=relaxed/relaxed;
	bh=VEt3hSd9EKLTT0Wo55fxgtHBJYKHT3uVPRy+V8bzYNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkPZGWkq9CB/sg0tJIU85J+AJnL3WD+JLY6M7ujVNznqq7S2JYQH4U4u7s+vTqghOj1uDaQfciN1jKEyrofDr2pvfwvZ3IxPZjEgOwLKw5l2TBl9aIEjNYC9WaNuZFHkRlIpg2Dn+92EEmcYvkcShqRgoyPE09X7TuMTMMwTRYGYf/KZD8DGCMJuo5+uiL0VFLC0YqPztZXOqPvfXwTMbk/espo4bRAERe36o0Kon4f9wm/uMqIU8loaXZkMAKBQciShp9SJV6sK0nG6gzrLAyXm/NhuefdgksLkZsr2aVKKSxjCH7+nB36zJ3GXOTbSW3E5OBMRoz570LqYj2Okog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iR2WHh9H; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=dianders@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iR2WHh9H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=dianders@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn0YM21bJz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 11:52:07 +1100 (AEDT)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-2c7e5f38b37so2036281eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 17:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775177525; x=1775782325; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEt3hSd9EKLTT0Wo55fxgtHBJYKHT3uVPRy+V8bzYNY=;
        b=iR2WHh9H5p8UyuAPwbUCG39jnoECapeh++khIrT+WqVvqyfwFLMhMbNjBOu7rhIfUw
         3t64R2WUZtu3/J0lmtEy29rQUnc5dPQI40LztqJb8oKMf0cjZTCyH+GqSWxhVXGAvSpJ
         aPPu0FPPQFvKx2klQAn1M8l13CP9fTC9N63Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775177525; x=1775782325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VEt3hSd9EKLTT0Wo55fxgtHBJYKHT3uVPRy+V8bzYNY=;
        b=KPdWc/lQVK+UyxYeJFtaJpF0yEi+3zRB1tYA9gP2rGyKTyMybXrZjQxtvgBQqe2Uyu
         hhZhBQQb7YAIWNfnTlXNKnZOMYteWAcTBaWABFhVKwwnU4BdTHVlTic/PoFXEMM7pjvy
         y8PTq5QCBaZ56r5R2UuFD9J8qrcYhHJlBlvpXMsnf79KTv95kcKQpdfhYPvJK5zOHYpe
         +ojIz0ZpcBIocN2hyY1ocyVdsQmKOp5vd/71xww7o+EUnflQ4pWuxwq7jePeZLVK+M8Z
         BN/9nlVKSN+2AlunvN7V4EcFIyee41z21Saw5ucgHq0Zx1INhb2eyYDQlQQik2erjncl
         mYow==
X-Forwarded-Encrypted: i=1; AJvYcCXTVBSzx5BaBbQsKrYUEGC/Iv8XhFx3Elh8RJHJ4zPtbTuiKYYX0hOscityMMwtnF8WjAtxMpVUcgF6e/M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwXa8I58aSRAWOOAHxQKn9rg/IRo27v4483akUMw9M1gEef/NCq
	4WaYl/VoVfh04NlyTxzhLeserJOM0VCL26vaT5iuiQ0FmsEzL/yy0e02fO4QNN9JzA==
X-Gm-Gg: ATEYQzwQa2sICQU7mZ5cJg2PoV51QYVrrzyB0RNYsV/HLQmj93nrx8/u63i5YdGeUBR
	Ub1GGoRZN7ASAJrdiIXfNSzK25hi/VJRwvrvSiFbgGnrImNgaTf+rrDXFW3yejczCXHOq4XnAvY
	Efa3Go/loRP67HFL2LbcupribnEkf2C+ggmtR7Fl5WO/2XaMaaoTO9EceBDLlBLcvXQjsNZ24li
	B+XWohJh2Jp5KmcXrytFXgF65Dnsas4u67FR5zzrk2N2ia5wCVnoMea0UNozcQ4YfPqjsY1VV9Q
	jyBHLS5lqoMvdgE/QG4InjbQc+LPTw1EyrD91zCSjJ9QEoBrdG5cG51UJTHHqBj16jdTHs7dM5n
	rLxDxHY9Nj57AH6WAxm0TgaM+VJ7RokAhsH7I6sJMarSyTkRwQhxnpg4B/Z6SaIHIOMpfJAHB1n
	Ad80Sjg6p+KTg8dHVUO9HmUHv45mXTkmHekFw81kFlyiVCDlJ9PBOPWBqy6R1okEHcpykA7rfUw
	XlY+4kUtFY=
X-Received: by 2002:a05:7022:423:b0:119:e56b:91ec with SMTP id a92af1059eb24-12bfb75ee38mr560487c88.29.1775177525063;
        Thu, 02 Apr 2026 17:52:05 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:5db3:7542:a530:f43a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df3b84sm3630074eec.5.2026.04.02.17.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:52:04 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Paul Burton <paul.burton@mips.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Christoph Hellwig <hch@lst.de>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	ardb@kernel.org,
	broonie@kernel.org,
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
	maz@kernel.org,
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
Subject: [PATCH v3 9/9] driver core: Replace dev->offline + ->offline_disabled with DEV_FLAGs
Date: Thu,  2 Apr 2026 17:49:55 -0700
Message-ID: <20260402174925.v3.9.I897d478b4a9361d79cd5073207c1062fd4d0d0e4@changeid>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260403005005.30424-1-dianders@chromium.org>
References: <20260403005005.30424-1-dianders@chromium.org>
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
Cc: Toshi Kani <toshi.kani@hp.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Not fixing any known bugs; problem is theoretical and found by code
inspection. Change is done somewhat manually and only lightly tested
(mostly compile-time tested).

Changes in v3:
- New

 arch/arm64/kernel/cpufeature.c                |  2 +-
 .../platforms/pseries/hotplug-memory.c        |  4 ++--
 drivers/acpi/scan.c                           |  3 ++-
 drivers/base/core.c                           | 19 ++++++++++---------
 drivers/base/cpu.c                            |  4 ++--
 drivers/base/memory.c                         |  2 +-
 include/linux/device.h                        |  9 ++++-----
 kernel/cpu.c                                  |  4 ++--
 8 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 32c2dbcc0c64..f6f7c35b7a93 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -4042,7 +4042,7 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
 	 */
 	lucky_winner = cpu_32bit ? cpu : cpumask_any_and(cpu_32bit_el0_mask,
 							 cpu_active_mask);
-	get_cpu_device(lucky_winner)->offline_disabled = true;
+	set_bit(DEV_FLAG_OFFLINE_DISABLED, &get_cpu_device(lucky_winner)->flags);
 	setup_elf_hwcaps(compat_elf_hwcaps);
 	elf_hwcap_fixup();
 	pr_info("Asymmetric 32-bit EL0 support detected on CPU %u; CPU hot-unplug disabled on CPU %u\n",
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index b2f14db59034..d9a0a75ada46 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -213,9 +213,9 @@ static int dlpar_change_lmb_state(struct drmem_lmb *lmb, bool online)
 		return -EINVAL;
 	}
 
-	if (online && mem_block->dev.offline)
+	if (online && test_bit(DEV_FLAG_OFFLINE, &mem_block->dev.flags))
 		rc = device_online(&mem_block->dev);
-	else if (!online && !mem_block->dev.offline)
+	else if (!online && !test_bit(DEV_FLAG_OFFLINE, &mem_block->dev.flags))
 		rc = device_offline(&mem_block->dev);
 	else
 		rc = 0;
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e8cdbdb46fdb..f2707b704468 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -122,7 +122,8 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
 	mutex_lock_nested(&adev->physical_node_lock, SINGLE_DEPTH_NESTING);
 
 	list_for_each_entry(pn, &adev->physical_node_list, node)
-		if (device_supports_offline(pn->dev) && !pn->dev->offline) {
+		if (device_supports_offline(pn->dev) &&
+		    !test_bit(DEV_FLAG_OFFLINE, &pn->dev->flags)) {
 			if (uevent)
 				kobject_uevent_env(&pn->dev->kobj, KOBJ_CHANGE, envp);
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index a87bd40499b6..63d724ece384 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2789,7 +2789,7 @@ static ssize_t online_show(struct device *dev, struct device_attribute *attr,
 	bool val;
 
 	device_lock(dev);
-	val = !dev->offline;
+	val = !test_bit(DEV_FLAG_OFFLINE, &dev->flags);
 	device_unlock(dev);
 	return sysfs_emit(buf, "%u\n", val);
 }
@@ -2914,7 +2914,7 @@ static int device_add_attrs(struct device *dev)
 	if (error)
 		goto err_remove_type_groups;
 
-	if (device_supports_offline(dev) && !dev->offline_disabled) {
+	if (device_supports_offline(dev) && !test_bit(DEV_FLAG_OFFLINE_DISABLED, &dev->flags)) {
 		error = device_create_file(dev, &dev_attr_online);
 		if (error)
 			goto err_remove_dev_groups;
@@ -4179,7 +4179,8 @@ static int device_check_offline(struct device *dev, void *not_used)
 	if (ret)
 		return ret;
 
-	return device_supports_offline(dev) && !dev->offline ? -EBUSY : 0;
+	return device_supports_offline(dev) &&
+	       !test_bit(DEV_FLAG_OFFLINE, &dev->flags) ? -EBUSY : 0;
 }
 
 /**
@@ -4197,7 +4198,7 @@ int device_offline(struct device *dev)
 {
 	int ret;
 
-	if (dev->offline_disabled)
+	if (test_bit(DEV_FLAG_OFFLINE_DISABLED, &dev->flags))
 		return -EPERM;
 
 	ret = device_for_each_child(dev, NULL, device_check_offline);
@@ -4206,13 +4207,13 @@ int device_offline(struct device *dev)
 
 	device_lock(dev);
 	if (device_supports_offline(dev)) {
-		if (dev->offline) {
+		if (test_bit(DEV_FLAG_OFFLINE, &dev->flags)) {
 			ret = 1;
 		} else {
 			ret = dev->bus->offline(dev);
 			if (!ret) {
 				kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
-				dev->offline = true;
+				set_bit(DEV_FLAG_OFFLINE, &dev->flags);
 			}
 		}
 	}
@@ -4237,11 +4238,11 @@ int device_online(struct device *dev)
 
 	device_lock(dev);
 	if (device_supports_offline(dev)) {
-		if (dev->offline) {
+		if (test_bit(DEV_FLAG_OFFLINE, &dev->flags)) {
 			ret = dev->bus->online(dev);
 			if (!ret) {
 				kobject_uevent(&dev->kobj, KOBJ_ONLINE);
-				dev->offline = false;
+				clear_bit(DEV_FLAG_OFFLINE, &dev->flags);
 			}
 		} else {
 			ret = 1;
@@ -4715,7 +4716,7 @@ static int device_attrs_change_owner(struct device *dev, kuid_t kuid,
 	if (error)
 		return error;
 
-	if (device_supports_offline(dev) && !dev->offline_disabled) {
+	if (device_supports_offline(dev) && !test_bit(DEV_FLAG_OFFLINE_DISABLED, &dev->flags)) {
 		/* Change online device attributes of @dev to @kuid/@kgid. */
 		error = sysfs_file_change_owner(kobj, dev_attr_online.attr.name,
 						kuid, kgid);
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 875abdc9942e..e4e6a399def4 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -422,8 +422,8 @@ int register_cpu(struct cpu *cpu, int num)
 	cpu->dev.id = num;
 	cpu->dev.bus = &cpu_subsys;
 	cpu->dev.release = cpu_device_release;
-	cpu->dev.offline_disabled = !cpu->hotpluggable;
-	cpu->dev.offline = !cpu_online(num);
+	assign_bit(DEV_FLAG_OFFLINE_DISABLED, &cpu->dev.flags, !cpu->hotpluggable);
+	assign_bit(DEV_FLAG_OFFLINE, &cpu->dev.flags, !cpu_online(num));
 	cpu->dev.of_node = of_get_cpu_node(num, NULL);
 	cpu->dev.groups = common_cpu_attr_groups;
 	if (cpu->hotpluggable)
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index a3091924918b..7f42727dde81 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -697,7 +697,7 @@ static int __add_memory_block(struct memory_block *memory)
 	memory->dev.id = memory->start_section_nr / sections_per_block;
 	memory->dev.release = memory_block_release;
 	memory->dev.groups = memory_memblk_attr_groups;
-	memory->dev.offline = memory->state == MEM_OFFLINE;
+	assign_bit(DEV_FLAG_OFFLINE, &memory->dev.flags, memory->state == MEM_OFFLINE);
 
 	ret = device_register(&memory->dev);
 	if (ret) {
diff --git a/include/linux/device.h b/include/linux/device.h
index f6ca067bacca..fd53aa04cad9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -484,6 +484,8 @@ struct device_physical_location {
  *		architecture supports non-coherent devices.
  * @DEV_FLAG_OF_NODE_REUSED: Set if the device-tree node is shared with an
  *		ancestor device.
+ * @DEV_FLAG_OFFLINE_DISABLED: If set, the device is permanently online.
+ * @DEV_FLAG_OFFLINE: Set after successful invocation of bus type's .offline().
  */
 enum struct_device_flags {
 	DEV_FLAG_READY_TO_PROBE,
@@ -494,6 +496,8 @@ enum struct_device_flags {
 	DEV_FLAG_STATE_SYNCED,
 	DEV_FLAG_DMA_COHERENT,
 	DEV_FLAG_OF_NODE_REUSED,
+	DEV_FLAG_OFFLINE_DISABLED,
+	DEV_FLAG_OFFLINE,
 };
 
 /**
@@ -571,8 +575,6 @@ enum struct_device_flags {
  *              should be set by the subsystem / bus driver that discovered
  *              the device.
  *
- * @offline_disabled: If set, the device is permanently online.
- * @offline:	Set after successful invocation of bus type's .offline().
  * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
@@ -677,9 +679,6 @@ struct device {
 
 	enum device_removable	removable;
 
-	bool			offline_disabled:1;
-	bool			offline:1;
-
 	unsigned long		flags;
 };
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index bc4f7a9ba64e..15a873ad8025 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2639,7 +2639,7 @@ static void cpuhp_offline_cpu_device(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
 
-	dev->offline = true;
+	set_bit(DEV_FLAG_OFFLINE, &dev->flags);
 	/* Tell user space about the state change */
 	kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
 }
@@ -2648,7 +2648,7 @@ static void cpuhp_online_cpu_device(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
 
-	dev->offline = false;
+	clear_bit(DEV_FLAG_OFFLINE, &dev->flags);
 	/* Tell user space about the state change */
 	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
 }
-- 
2.53.0.1213.gd9a14994de-goog



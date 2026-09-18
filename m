Return-Path: <linuxppc-dev+bounces-27704-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98ABC982D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:05:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmSsG5kplz3bkL;
	Fri, 18 Sep 2026 20:04:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789725873;
	cv=none; b=cqXdENDmxa+GoJbtcvUUZi3gtX2U+DfH2HoDPWVG0unxK9nvlD95ZhNPAA55e1n+V/5epKEkZ0Fbo8k7QoO6Y4zdKdB4qnA7Pj2V+7o/XDOZrGeJIt99PzLGStWzM/gOhH7tXj9O+ZPoqbdTY+XdRewp/cVaLDTN0pLCHMKtNVSoc8M/4cxwo2fHUNYNBYpDo2qFy/HIL+x5cbEEODIbp7n3K1f6Q4hPN+OYZdQ+hPnVWCrPRRxNPS58Tz1s9Dvk+4pCPugko5W/0HAqRRIX2irWQMtWD461+3QjEDtwWM6FLYdr1LPO8qQel0GfaFi68mB5LLdFesZGJwAjHGFOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789725873; c=relaxed/relaxed;
	bh=zufRRvpwVHCucp4/a8wU/krIeaWea9Chc2jByLlFL4c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmUdIVOqDrXrcOhD88E1tuYPfU0NzGTfElhTMNSNF09SmCmc5zYGN8HcZWVAwCp2ZeUNIvC5dVfgDPWIlycn9hE+/9D8aXYMAvCYd2+NEJTv9KiD533ZXP8BK/rEIyAamf7T+KbYeh+99LWOOuqvdHAGGUs0C6l/+TzF9PEE9sQYWu46ypHCOJ/7zlMzxvJuTMBBZZnwLlL6sDWxG3aKt1pwe2DiyeLWzxHay0egW+HfcuZpUnC5rXjANrNcSb5Rmu9gksR9w9KhbXV+y5D1rfkPs2UFnGIdOlKOJ5mZ4grXKIVX4kKxh3kNcdKxmYTeMvkyC3B/H4X/TVvPtMsI4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=BckyjycA; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=BckyjycA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmSsC2VNqz3bSF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:04:31 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zufRRvpwVHCucp4/a8wU/krIeaWea9Chc2jByLlFL4c=;
	b=BckyjycAl3ciFIMoUA4aZPGw9VUPen7PpwqZaxbivk06HsP2G2e1o1OYRpVjCGxZ5ScmXWiON
	VLeKRZcC4u9YJAKQArJ+X4FgbKFWIz3sdq8RcX+POy8ZO6Pxq07qezk90rBm7yrQxrk4UOcJCME
	uqEZBVLJJhWv39vUktkr7hk=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hmScN3dtKzKm8V;
	Fri, 18 Sep 2026 17:53:24 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 17A674057C;
	Fri, 18 Sep 2026 18:04:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 18:04:26 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<ruanjinjie@huawei.com>, <gshan@redhat.com>, <ardb@kernel.org>,
	<james.morse@arm.com>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <liukexin@kylinos.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <zhangtianyang@loongson.cn>, <blum@kernel.org>,
	<adityag@linux.ibm.com>, <chao.gao@intel.com>, <kas@kernel.org>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<jbouron@amazon.com>, <me@linux.beauty>, <mclapinski@google.com>,
	<graf@amazon.com>, <bgwin@google.com>, <eric.devolder@oracle.com>,
	<hbathini@linux.ibm.com>, <takahiro.akashi@linaro.org>,
	<lizhengyu3@huawei.com>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<driver-core@lists.linux.dev>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v5 13/17] crash: Assert device_hotplug_lock in crash_get_memory_ranges_nolock()
Date: Fri, 18 Sep 2026 18:04:38 +0800
Message-ID: <20260918100442.3841135-14-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918100442.3841135-1-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
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
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200008.china.huawei.com (7.202.194.74)

crash_get_memory_ranges_nolock() walks memblock, which memory hotplug
modifies under device_hotplug_lock.  A caller that does not hold the lock
can race with memblock_double_array() and iterate a freed regions array.

Add device_hotplug_lock_assert_held() and call it at the top of the
function so that such callers are caught by lockdep.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/base/core.c    | 5 +++++
 include/linux/device.h | 1 +
 kernel/crash_core.c    | 7 +++++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4c0c373998a1..c04adc457a96 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2420,6 +2420,11 @@ void unlock_device_hotplug(void)
 	mutex_unlock(&device_hotplug_lock);
 }
 
+void device_hotplug_lock_assert_held(void)
+{
+	lockdep_assert_held(&device_hotplug_lock);
+}
+
 int lock_device_hotplug_sysfs(void)
 {
 	if (mutex_trylock(&device_hotplug_lock))
diff --git a/include/linux/device.h b/include/linux/device.h
index aee79fd6b32b..9cca8c8bd372 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1261,6 +1261,7 @@ do { \
 void lock_device_hotplug(void);
 void unlock_device_hotplug(void);
 int lock_device_hotplug_sysfs(void);
+void device_hotplug_lock_assert_held(void);
 int device_offline(struct device *dev);
 int device_online(struct device *dev);
 
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 760ca9822a13..852a5f51d472 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -338,6 +338,13 @@ int crash_get_memory_ranges_nolock(struct crash_mem **mem_ranges)
 	struct crash_mem *cmem;
 	int ret;
 
+	/*
+	 * Callers must serialize against memory hotplug by holding
+	 * device_hotplug_lock, otherwise the memblock iteration below can
+	 * race with memblock_double_array() and read freed memory.
+	 */
+	device_hotplug_lock_assert_held();
+
 	max_nr_ranges = arch_get_system_nr_ranges();
 	if (!max_nr_ranges)
 		return -ENOMEM;
-- 
2.34.1



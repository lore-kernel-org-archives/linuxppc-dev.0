Return-Path: <linuxppc-dev+bounces-27831-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A033C982E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:05:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHNn5b62z2yqx;
	Mon, 21 Sep 2026 19:04:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789981481;
	cv=none; b=apT8+096ptAZMU7P9Iu4b7A3zlax3w1IWHZ21jX3PQdwS9WZR6pQ1tq0plqwL6Hw8JfKqSt+UwMCAui8YCnJmEAwtwwXQehQ5rXq5ph6VvWJv6CLQBuZA5Qk2IxzDRsVwLgoxqaN6PGoY1s43ojJ+JoT1VGJ8CoBLEgoANZnPwNLn/+HBmF/wuYjhgGwPpWkKKC0HnChYjjlHE/fJPsg1buqyr2jF9Qtfw4Dtad7z2riAk17EHWJfl8+PvoGYgAn9DDl+QPe4s1aLQsZlfeHDtBBFXZqOlNCwydQ766cK+4yp1h9W7CYpv0XZokoBD83WfQRUt0Y0wepeQvwwPOXnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789981481; c=relaxed/relaxed;
	bh=7Gly1btZ/qtetqt6PZXoWzbx2dJha17PF7md6d6YHEg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNPLj+yoHfUkEfhnVhZya6rKV+qSrVpgnuZC3IwCfsxAGZLgbX3637OyCAxdgH04hyycR8512a/MYe7ean2w2sQH2IqtxS/5tXtPuRFvl/+S4sKhktzU9V1BJKvzItekmGV1IrD8D78w2qReoHnGL1ZzrsVnuOAgfuuyWlw2vbGIGWx3/pH1NV5RPLe0mHK5tXNxZ/X5mhyHMaMnzR0hGvEbr3Zd6HYJ4PXApKGCuhhLqIlFttlFzyTSXM49pJwFu3hL5NRkL8MkHhlgXo4JuhNGfJQH4I5saLSaZMK938yO/rpcboJfW3eJ2LQ+w6BZDF6PfruBmx2Psu0xYv9atg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NLfB55gt; dkim-atps=neutral; spf=pass (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NLfB55gt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHNm5Knzz303F
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:04:40 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7Gly1btZ/qtetqt6PZXoWzbx2dJha17PF7md6d6YHEg=;
	b=NLfB55gt4vcsyPjJv21R+FR/t3i0Zfpu9+ajOViW02naV5Sz3HgaYwJgkq03z4u4M068FVcuf
	v6HCRypcJ9fT+TroC7eKOYwp9DB7wJNdWeXuUop0ibOhPKdLIrdyTrXZnTAIan70wbc0IB+MKEM
	pjgvJWFJlJ9pg7owuY6S8R8=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hpH7w69Z7zLlTm;
	Mon, 21 Sep 2026 16:53:32 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 91E6B4058E;
	Mon, 21 Sep 2026 17:04:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 17:04:18 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<kees@kernel.org>, <tangyouling@kylinos.cn>, <liukexin@kylinos.cn>,
	<zhangtianyang@loongson.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <chao.gao@intel.com>, <kai.huang@intel.com>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<thuth@redhat.com>, <jbouron@amazon.com>, <me@linux.beauty>,
	<mclapinski@google.com>, <graf@amazon.com>, <bgwin@google.com>,
	<hbathini@linux.ibm.com>, <eric.devolder@oracle.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <palmer@rivosinc.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <driver-core@lists.linux.dev>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v6 13/14] driver core: Add device_hotplug_lock_assert_held() helper
Date: Mon, 21 Sep 2026 17:04:49 +0800
Message-ID: <20260921090450.807575-14-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921090450.807575-1-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)

crash_get_memory_ranges() walks memblock, which memory hotplug
modifies under device_hotplug_lock.  A caller that does not hold
the lock can race with memblock_double_array() and iterate a freed
regions array.

Add device_hotplug_lock_assert_held() so that crash code can
use it to catch such unsafe callers via lockdep.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/base/core.c    | 5 +++++
 include/linux/device.h | 1 +
 2 files changed, 6 insertions(+)

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
 
-- 
2.34.1



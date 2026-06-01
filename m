Return-Path: <linuxppc-dev+bounces-21793-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438C1CD6E56
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 09:50:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTTgx5MH8z3c2h;
	Mon, 01 Jun 2026 19:49:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780307357;
	cv=none; b=AfT8vt58doPHymsDDSfjpd3DK0nHyenO+2Pf+eQBogrscirOPbFMuKxPOUHR9hH0/3/5fi3zAuD16gKuFhzznuUBwxKGBcoQtCg5IOWsyO8EYuukVSI/IAVi8p9KxRNaS8KHihMoJ46pVpbA7oAGtApdglk+qm23LA83rFyQFOvQ+8ipSLyGBsjI24U9jpciOxCtMkawuc10zX9qZLGUV/n+6l2mZI0m6duJUZDzblp5BY+PJCNS65s8Ttd1qfSDU1XDRwOH/vBZTLbINpMdNPzKlMQK8G/VdI+7zs7F+iEwpopByw2QD7izTgFXSmzkzVA9XSpwkhc1EQLpIxt7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780307357; c=relaxed/relaxed;
	bh=/EZ2c7x/ajxc2orWikWAwwQyMa5jAYw6SumwsI32OoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UeZMRgOYwnDIEo0NTUrIw0+6ZcSQ9fzCTaT16mY3gHb360g1Yyn8WJE9gYidVawwzBmWC/uObNRwcfXFkCqcfkRfjrDHcvktsjLCKCPG7P9vPzXXkNpSc3lDw2sWVZaTedoams/pEzIqXpQtonuPhhR3L3GkFMeL4lzUsDlZx5xo6wUouEdrMt/MxKmd28SdxDwDEy7+v1pg0+fmqr3g8+ROi0FULbyc0VUmmVOVmwQ2oXRlCcZjuzuLAnDGtCzaiMjoTAaDNsuO2zLAmAaYFvjdzATBqf60rNZI/6If4jpg+V1A0KJQZITmPIL0jtT2S5MLxpE7q0YdkROmqItWhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HGwpKv0O; dkim-atps=neutral; spf=pass (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HGwpKv0O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTTgw5V17z2ytJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 19:49:16 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/EZ2c7x/ajxc2orWikWAwwQyMa5jAYw6SumwsI32OoA=;
	b=HGwpKv0O7ApKJjaW9gsuJUkkrhmpM/LvH/twujKd6Oaga2aDJrYaqhAKElmgvbL1/f5dvUiQj
	QuSJuPvXSHv7wARw1n2QwLSueQXjDCFmfk6PeMrwk2F9wSKSFUPtdktFv5z5XXlNLvBvFP5SxwP
	zMIhcXDosQjj/FFU5cUAqoo=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gTTVq32VdzmV6x;
	Mon,  1 Jun 2026 17:41:23 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 57E0240539;
	Mon,  1 Jun 2026 17:49:13 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Jun
 2026 17:49:09 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<rdunlap@infradead.org>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<kuba@kernel.org>, <lirongqing@baidu.com>, <ebiggers@kernel.org>,
	<paulmck@kernel.org>, <sourabhjain@linux.ibm.com>, <thuth@redhat.com>,
	<ardb@kernel.org>, <masahiroy@kernel.org>, <gshan@redhat.com>,
	<james.morse@arm.com>, <maz@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <coxu@redhat.com>, <suzuki.poulose@arm.com>,
	<cfsworks@gmail.com>, <osandov@fb.com>, <jbohac@suse.cz>,
	<ryan.roberts@arm.com>, <tangyouling@kylinos.cn>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <hbathini@linux.ibm.com>, <bjorn@rivosinc.com>,
	<songshuaishuai@tinylab.org>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <djordje.todorovic@htecgroup.com>,
	<austin.kim@lge.com>, <namcao@linutronix.de>, <djbw@kernel.org>,
	<chao.gao@intel.com>, <seanjc@google.com>, <fuqiang.wang@easystack.cn>,
	<liaoyuanhong@vivo.com>, <makb@juniper.net>, <graf@amazon.com>,
	<piliu@redhat.com>, <rafael.j.wysocki@intel.com>,
	<mario.limonciello@amd.com>, <jbouron@amazon.com>, <chenjiahao16@huawei.com>,
	<guoren@kernel.org>, <bauerman@linux.ibm.com>, <bgwin@google.com>,
	<takahiro.akashi@linaro.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v15 10/23] crash_core: Introduce CRASH_HOTPLUG_SAFETY_PADDING for memory hotplug safety
Date: Mon, 1 Jun 2026 17:47:52 +0800
Message-ID: <20260601094805.2928614-11-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260601094805.2928614-1-ruanjinjie@huawei.com>
References: <20260601094805.2928614-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Introduce CRASH_HOTPLUG_SAFETY_PADDING to allocate extra slots
for the crash memory ranges array, mitigating potential TOCTOU races
caused by concurrent memory hotplug events. When CONFIG_MEMORY_HOTPLUG
is disabled, the padding safely defaults to 0 as the memory
layout remains static.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/crash_core.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index c1dee3f971a9..d4762e000098 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -14,6 +14,12 @@ struct crash_mem {
 	struct range ranges[] __counted_by(max_nr_ranges);
 };
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+#define CRASH_HOTPLUG_SAFETY_PADDING 128
+#else
+#define CRASH_HOTPLUG_SAFETY_PADDING 0
+#endif
+
 #ifdef CONFIG_CRASH_DUMP
 
 int crash_shrink_memory(unsigned long new_size);
-- 
2.34.1



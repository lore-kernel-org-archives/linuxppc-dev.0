Return-Path: <linuxppc-dev+bounces-19264-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5BAE7E345
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 09:15:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnCjt16Yqz2yVP;
	Fri, 03 Apr 2026 20:15:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775207714;
	cv=none; b=GtfPYLx7FGCL6L7Ji++tKn2c+gImI1QXmLnQBP3ltB84XmDPYJ2pMuOPTXPQk72DIWKGYSpLKckPJDBwl/Oyp3qqiKuYGwJNrqOoLGtaRVSUiYs5OTIuYoYrIMXKR2E7PzWHDzZhS51z38O0mEQWWiSyKwoervvHuezgLVM8re5FIn1Cw/kQH6/2oCwZUUxafZS72sdSTFZKoBrCI8RBH9VMo8NTx9QWpN8jwis7t8Gx1UKqA/MEvjWrVqvE6ShN2Rhp/A5uCxREGUwzBmb26QYLr2Qb5rQZN47pnxJIGrJKvg6vMmCs2wySchyJOp8POLzgL/IaWh4ezz1pwVkrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775207714; c=relaxed/relaxed;
	bh=1u/gaQ+oVmmKaoGhJfA0lv+PgPfetH5Z+BotMjq1x2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wrlxa9ONrz9Kz5G/4NEbDYGj0Tn5NaBL/DdFlMOIKk2M7Mk16rFN5yqawEymzbMO69cU8Hg//5svzKHUv0t7pTj4FHKgTG/hW0LVKDMmrygDqLcRV9yKuABUdjIiWSejCj3Vmvvrp3c+FuZO/aVSu6BaDcjOFXbCz990xqApdUZTzbUuzKDEbIT03G7uvnlNO2WWIfzjALAiMJys3uLP3i9wh4ZQem/x/f7AL6aKDk9xEmIam9yGTVL69cviWkTK/sy7dxbS77R1wGIKFuMm8z1p4diU3kw56GfsaQCcasORe0DfvxbS1MrLLE/Asbt4PMJJ6fp4q6ddSux1X7pNow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Ng5I2f7+; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Ng5I2f7+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnCjq4tcXz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 20:15:09 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1u/gaQ+oVmmKaoGhJfA0lv+PgPfetH5Z+BotMjq1x2M=;
	b=Ng5I2f7+M26BlWo+f15W4F3KICwNL5iu3h39vY8J/Yh43OjddzRD1MsWnEf25APCV36pJ7jaV
	E+dS9RuezRSZ5OUSyATrJYym/oMSq0Q/fgtStWYYumuP16zq8mKRFCRw0duIgZtaeNEb1yxvcFU
	83ODrCmyuPyUV05deMYPVP0=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fnCZW0jdKz1prlD;
	Fri,  3 Apr 2026 17:08:51 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id E56E540571;
	Fri,  3 Apr 2026 17:15:04 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 3 Apr 2026 17:15:01 +0800
Message-ID: <c5ee66fe-ecc4-2eb4-4b58-44f7d292d221@huawei.com>
Date: Fri, 3 Apr 2026 17:14:58 +0800
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
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v12 00/15] arm64/riscv: Add support for crashkernel CMA
 reservation
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<robh@kernel.org>, <saravanak@kernel.org>, <akpm@linux-foundation.org>,
	<bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<rdunlap@infradead.org>, <peterz@infradead.org>,
	<pawan.kumar.gupta@linux.intel.com>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <rppt@kernel.org>,
	<leitao@debian.org>, <ardb@kernel.org>, <jbohac@suse.cz>,
	<cfsworks@gmail.com>, <tangyouling@kylinos.cn>, <sourabhjain@linux.ibm.com>,
	<ritesh.list@gmail.com>, <hbathini@linux.ibm.com>, <eajames@linux.ibm.com>,
	<guoren@kernel.org>, <songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <coxu@redhat.com>,
	<fuqiang.wang@easystack.cn>, <liaoyuanhong@vivo.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <lizhengyu3@huawei.com>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
References: <20260402072701.628293-1-ruanjinjie@huawei.com>
 <20260402113137.GAac5Tmc5b7SL98KdY@fat_crate.local>
 <c6eb858c-5275-6fdc-b6e9-bd6d4b169e05@huawei.com>
 <20260402133644.GBac5w7OYl9MwvVxY_@fat_crate.local>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260402133644.GBac5w7OYl9MwvVxY_@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2026/4/2 21:36, Borislav Petkov wrote:
> On Thu, Apr 02, 2026 at 07:47:53PM +0800, Jinjie Ruan wrote:
>> Thank you for the reminder and for your patience. I apologize for the
>> frequent updates; I am becoming more familiar with the community's
>> workflow.
> 
> Yap, and you can use that time while waiting to learn about it:

Thanks for the pointer! I'm using the wait time to dive into the process
docs. Definitely a lot to learn about the workflow, but I'm getting there.

> 
> Documentation/process/
> 


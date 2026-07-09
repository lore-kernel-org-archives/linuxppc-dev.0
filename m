Return-Path: <linuxppc-dev+bounces-23913-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB619C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 07:59:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwnRs0Qdqz3c9k;
	Thu, 09 Jul 2026 17:59:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783583976;
	cv=none; b=b6+x4ltSd3Ck9oFL0Mq9G/PM8THMZFB/znxF2GhptcqfAPDRqQpS9NgAFIh4w9W4sX73o/dq5MBHZgcU5f3K7ded/K+Auhpq/jGks72ZTDwqkdmZZgu9HTZdVRcNm16ZATZ0fE4Uos8kOknnDG2kHf1R5H/BIB445IMrDtqI0W8/OEGT7iXyKoD0g2eUkdNV8dYsQoB2+jIWJZ+8tny5RDa2ePoaix7avJkwgbgjQPSdXUNFHFws70ynLC4ZRfh5TvoSwahod83EAAIaIxAZKoEELCtwRqUv6dkmpUczbG2qvKxJUm+8jf5ZhNP0VunvMMlBJ7m3ijz/e+cSyKcnmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783583976; c=relaxed/relaxed;
	bh=amF18KHfc8NodmLlIFl9+tYxitLhQeTXu6ioMRTAIhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X98ie7FCjhZaAUZ2A6lxcnkDbON0RYBUDh+/mwN/w6++sAJ5lcW7VJ3T7BA3uceD3Sl8T9WS1ndljvPm4Fah30HIq3i6MiN1544VqDWdGrTiESB8sa8vmaKpxY4tP0T4a8xFa+v8iwYM2D3/ZTmrBJBJzfIZGNGp7X4z4ONSOKndJPSAiID216xPOwVCNTP5t/glhBS/4dEuHL7nh8Wfq04d15FCJa+2HP6WEs45yndqMjn+RGHEn3t77dy+sj8yNz9648+UZWQN9NMmPdCKu/qsTcUo6SZMvKdH7yBY3zZsf3yTQiihHy7zKuz4GWHwpTy8Six6OlYSWrIG3s01Bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=DwmhEa4J; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=DwmhEa4J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwnRp4Cl1z3c05
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 17:59:32 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=amF18KHfc8NodmLlIFl9+tYxitLhQeTXu6ioMRTAIhg=;
	b=DwmhEa4JsZH1zyt75IBFUEkYJMYW+ez6g3GqbaAAdGlvMivx7XQMpEbeY+BIMBJbg82eFYJRv
	A6w879pWEbnndkDFcInfs1Lz7SgEszZcAusSMg9XCYhmUtHeZlgmbQA/qxsMc6wVD2uKd7y78Pu
	9gaY7eN4pgIJHOHwJ3k/0pg=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gwnF96JgNzcb0T;
	Thu,  9 Jul 2026 15:50:21 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id C128A40537;
	Thu,  9 Jul 2026 15:59:26 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jul 2026 15:59:22 +0800
Message-ID: <dfc05f53-6cef-4da2-83c1-6e765ec419fe@huawei.com>
Date: Thu, 9 Jul 2026 15:59:21 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] syscall_user_dispatch: Introduce
 ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
CC: <chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
	<agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <nathan@kernel.org>,
	<kees@kernel.org>, <xur@google.com>, <peterz@infradead.org>,
	<gourry@gourry.net>, <lukas.bulwahn@redhat.com>, <ryan.roberts@arm.com>,
	<yangtiezhu@loongson.cn>, <sshegde@linux.ibm.com>, <mchauras@linux.ibm.com>,
	<austin.kim@lge.com>, <arnd@arndb.de>, <jchrist@linux.ibm.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>
References: <20260709072803.3843948-1-ruanjinjie@huawei.com>
 <20260709093404-0b19988f-8d19-4fae-86d8-396aa747307d@linutronix.de>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260709093404-0b19988f-8d19-4fae-86d8-396aa747307d@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 7/9/2026 3:36 PM, Thomas Weißschuh wrote:
> On Thu, Jul 09, 2026 at 03:28:03PM +0800, Jinjie Ruan wrote:
>> Currently, only x86 genuinely implements and supports Syscall User
>> Dispatch (SUD). Multiple architectures provide a stub
>> arch_syscall_is_vdso_sigreturn() returning 'false' simply to satisfy
>> GENERIC_ENTRY compilation, which creates a false impression of feature
>> support.
>>
>> Introduce ARCH_SUPPORTS_SYSCALL_USER_DISPATCH to decouple this mechanism
>> from GENERIC_ENTRY. Select it exclusively on x86 and remove the redundant
>> stub functions from other architectures.
> 
> Nice, this confused me before.
> 
>> Link: https://lore.kernel.org/linux-arm-kernel/akZgV0Y4YAmB43_g@J2N7QTR9R3.cambridge.arm.com/
>> Cc: Thomas Gleixner <tglx@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
>> Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/Kconfig                         | 1 +
>>  arch/loongarch/include/asm/syscall.h | 6 ------
>>  arch/powerpc/include/asm/syscall.h   | 5 -----
>>  arch/riscv/include/asm/syscall.h     | 5 -----
>>  arch/s390/include/asm/syscall.h      | 5 -----
>>  arch/x86/Kconfig                     | 1 +
>>  6 files changed, 2 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 0c01521c2f3f..393d0fb75eac 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -116,6 +116,7 @@ config GENERIC_ENTRY
>>  
>>  config SYSCALL_USER_DISPATCH
>>  	bool "Syscall User Dispatch"
>> +	depends on ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
> 
> ARCH_SUPPORTS_SYSCALL_USER_DISPATCH is not declared as a config option,
> so the 'select' will not do anything. Needs this:
> 
> config ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
> 	bool

Yes, this is missing here.
> 
>>  	depends on GENERIC_ENTRY
>>  	default y
>>  	help
> 
> (...)



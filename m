Return-Path: <linuxppc-dev+bounces-17240-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D14FC591C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 09:35:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fM5sr47CQz2yFc;
	Thu, 26 Feb 2026 20:35:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772098528;
	cv=none; b=NYq+BNhQVmUtIWLL/91tZHCRG67DW55Uy99ohcs4nKt13e/nBe5iXyMQ+LblKtu7JsC2vG6rtQ6etpQmwYeZWpPAFJvHve5RMLVfzzkN/FmZYLkWTZzcxCQlvyGnsw3DXsKi+5svs6YaxprkVTJZH11EdFenCEQ++3huQvALY8/kXqQjTIwHzgnvxLLp/Aa72XVHZJI1b5g5Ws3lK0ptfgoSodWlMjfXBVSyWUwIIfHK4Go3qX4flAANj46YcgJksCKLDE5j3AU17f07YIHWQLX/FJnzfVXcvkwNSvMkVWocQjw32ya0YroDIQopUAFLT7XW4bEg1Jt6m3LqaZwBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772098528; c=relaxed/relaxed;
	bh=cArUbXgPd0s4ZtREeL/7x46kP7PE/lat666eUsS6sDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oOk3G/aw6XumIJ8g2TX5JFlfTPJ8MtPzVfX9u+RZjZtgG/TiB4FTDxH5JGJIhjWaX89Fk+N3N27JCun0vHoJIcAOvBli1Oqus7B1hyYrqxMcfDZznfWd55wF+TVCNBy470JVbZG4MtAV2Fi71iePJK5+KtvH7y3Z/lisQpKdU86mzGC5EJVNCI2o7vi9geIh8bbiZoF9dJerlGOleC73lVekKVNMV02KBgmUHwVWn+pe2Hj1lU5DtavJ5ekEANFN4dLpa4N6aZ4e7ldGIDerNIRCiO2uZY6PqDHeQSi2IaXbGmP4s1iHzB0GkPnJa6wm+HY4JznHyo2HBvigiVTD2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=DWNv0GeH; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=DWNv0GeH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fM5sn6Z0Lz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 20:35:25 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cArUbXgPd0s4ZtREeL/7x46kP7PE/lat666eUsS6sDM=;
	b=DWNv0GeHcKAOhD5xvaCowiagwlW275NAmdFdeG8qlLEXg0HK9DVne1d75o15RGyJa7vwcAWO6
	vwEOtoSqxVKaatv+CDrTZSmvfXkTGoof3Dzf35VFrW/nnCipbp9TUQ6QsuUvS03Qv/DbB9CjEPb
	Q7rsPApKKIvJvhGOP5dZOd0=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fM5m15ySPz1T4Fg;
	Thu, 26 Feb 2026 17:30:25 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 11EC340567;
	Thu, 26 Feb 2026 17:35:19 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Feb 2026 17:35:15 +0800
Message-ID: <15ea8a98-2b0c-dd51-b0d4-911905b194c3@huawei.com>
Date: Thu, 26 Feb 2026 17:35:14 +0800
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
Subject: Re: [PATCH v6 1/5] powerpc/crash: sort crash memory ranges before
 preparing elfcorehdr
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <rdunlap@infradead.org>, <pmladek@suse.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <paulmck@kernel.org>,
	<lirongqing@baidu.com>, <arnd@arndb.de>, <ardb@kernel.org>,
	<leitao@debian.org>, <rppt@kernel.org>, <cfsworks@gmail.com>,
	<ryan.roberts@arm.com>, <sourabhjain@linux.ibm.com>,
	<tangyouling@kylinos.cn>, <eajames@linux.ibm.com>, <hbathini@linux.ibm.com>,
	<ritesh.list@gmail.com>, <songshuaishuai@tinylab.org>,
	<samuel.holland@sifive.com>, <kevin.brodsky@arm.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <coxu@redhat.com>,
	<liaoyuanhong@vivo.com>, <fuqiang.wang@easystack.cn>, <jbohac@suse.cz>,
	<brgerst@gmail.com>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
References: <20260224085342.387996-1-ruanjinjie@huawei.com>
 <20260224085342.387996-2-ruanjinjie@huawei.com>
 <aaARRZh9k_0oG3Qo@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <aaARRZh9k_0oG3Qo@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2026/2/26 17:24, Baoquan He wrote:
> On 02/24/26 at 04:53pm, Jinjie Ruan wrote:
>> From: Sourabh Jain <sourabhjain@linux.ibm.com>
>>
>> During a memory hot-remove event, the elfcorehdr is rebuilt to exclude
>> the removed memory. While updating the crash memory ranges for this
>> operation, the crash memory ranges array can become unsorted. This
>> happens because remove_mem_range() may split a memory range into two
>> parts and append the higher-address part as a separate range at the end
>> of the array.
>>
>> So far, no issues have been observed due to the unsorted crash memory
>> ranges. However, this could lead to problems once crash memory range
>> removal is handled by generic code, as introduced in the upcoming
>> patches in this series.
>>
>> Currently, powerpc uses a platform-specific function,
>> remove_mem_range(), to exclude hot-removed memory from the crash memory
>> ranges. This function performs the same task as the generic
>> crash_exclude_mem_range() in crash_core.c. The generic helper also
>> ensures that the crash memory ranges remain sorted. So remove the
>> redundant powerpc-specific implementation and instead call
>> crash_exclude_mem_range_guarded() (which internally calls
>> crash_exclude_mem_range()) to exclude the hot-removed memory ranges.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Baoquan he <bhe@redhat.com>
>> Cc: Jinjie Ruan <ruanjinjie@huawei.com>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
>> Cc: linux-kernel@vger.kernel.org
>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> 
> You should add your own Signed-off-by since you sent it out.

Ack, I'll add my Signed-off-by in the next revision.
Thanks,

> 
>> ---
>>  arch/powerpc/include/asm/kexec_ranges.h |  4 +-
>>  arch/powerpc/kexec/crash.c              |  5 +-
>>  arch/powerpc/kexec/ranges.c             | 87 +------------------------
>>  3 files changed, 7 insertions(+), 89 deletions(-)
> ......snip...
> 
> 


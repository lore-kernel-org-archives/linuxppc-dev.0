Return-Path: <linuxppc-dev+bounces-27792-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EEFC982E1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Sep 2026 03:52:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hnXVz33JSz2y8G;
	Sun, 20 Sep 2026 13:52:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789876347;
	cv=none; b=U66DAlrsHQ62nFGs1y1J+gWcwT+onFJpS+6873MWprTcCJRKTmLg+hZfU0bRU2eIMj59CrY8ovllZiWKUrDVK1IFvYA1o1fx+zJ9S5FVNLgldJa4gEKmrOBmsQLMNMV8syyBTf5YyqGWYV2iomWZYfwOQpCAMFfjjKsWb9VInoBE37Tp1SAF6Rh2w5bICNWae2w1hFlYVExiwdObot+m8dCCU4Ut1OsFaTbnp9Dk9kaiGVrR6Y3nqnZ0an01INRwBmqBBawXSRcG5lCIz+npPMVTtfjPg9WCTrnnp4Gtwyh+g6iNczot5323CNNQ/IZsaf0W4uy2JD4Ia++us1mH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789876347; c=relaxed/relaxed;
	bh=4CXJGmKHG01Cx5WADm45ZnwIf+yzPgsSp4LXsSCGK8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BLFctPVqJjke9zbWMGM+OLO2Oyt7n9wW09lErxiTYkWidj2PxoyuT8j7MRyeMwaj+qeEU7NfJFB6NoebRKqfNoHtVuuVdIpcE5Y4RGibmbXXUUo+PyKV9nZHADSCGn1tuSda3Y5FbZ+YwkexUzCRZ6PKC9xutUPDqoGJlmxKNpXuqnEcp9eKLc9X9ayuVSvrCjgYr4IJwfOiIitfRmrYneQ0481w9rtjAqS70Nu772VpEtMQjkvUYEI80u5h7xdsUjlnZeaa1+tmdJRhwuNkFnRT1xMQPHjs/iDbn4L7BwVqZlThj8H7oG6N7xyRFfyj8okiPcwxDiWaWVubHLb10Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1lkRrGqD; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1lkRrGqD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hnXVw1H8cz2xSg
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2026 13:52:21 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4CXJGmKHG01Cx5WADm45ZnwIf+yzPgsSp4LXsSCGK8w=;
	b=1lkRrGqDddig7anIp5WuNHAm+CuT3FvIsggB6VBKbwEF2UUvgcG9HIXey+Zr7ZvRIoY0aGqG4
	b1NaWsV+IYNc9zNPu7OWgW8LLxF5UL3Hg51zBkUv0TQ316qIuIhBTx2h1CSpbZOxa4mSd/F9cTt
	FP44s2lWygtUjNf1ecHgMFI=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hnXG031FSznTZk;
	Sun, 20 Sep 2026 11:41:12 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E14F40572;
	Sun, 20 Sep 2026 11:52:15 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemk200008.china.huawei.com (7.202.194.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 20 Sep 2026 11:52:12 +0800
Message-ID: <7e624b9b-b759-44c6-b1b8-810c36a066c5@huawei.com>
Date: Sun, 20 Sep 2026 11:52:12 +0800
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
Subject: Re: [PATCH v5 11/17] crash: Normalize the kexec_load elfcorehdr at
 load time
To: <sashiko-reviews@lists.linux.dev>, <baoquan.he@linux.dev>,
	<gregkh@linuxfoundation.org>, <ruirui.yang@linux.dev>, <npiggin@gmail.com>,
	<liukexin@kylinos.cn>, <dave.hansen@linux.intel.com>,
	<mclapinski@google.com>, <ritesh.list@gmail.com>,
	<takahiro.akashi@linaro.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <will@kernel.org>, <pratyush@kernel.org>,
	<coxu@redhat.com>, <mingo@redhat.com>, <zhangtianyang@loongson.cn>,
	<linux-fsdevel@vger.kernel.org>, <sourabhjain@linux.ibm.com>,
	<hpa@zytor.com>, <rafael@kernel.org>, <graf@amazon.com>,
	<jbouron@amazon.com>, <yeoreum.yun@arm.com>, <hbathini@linux.ibm.com>,
	<chenhuacai@kernel.org>, <akpm@linux-foundation.org>,
	<lizhengyu3@huawei.com>, <chleroy@kernel.org>, <adityag@linux.ibm.com>,
	<dakr@kernel.org>, <piliu@redhat.com>, <pasha.tatashin@soleen.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
	<ardb@kernel.org>, <leitao@debian.org>, <catalin.marinas@arm.com>,
	<kees@kernel.org>, <thuth@redhat.com>, <blum@kernel.org>, <kas@kernel.org>,
	<maddy@linux.ibm.com>, <james.morse@arm.com>, <tglx@kernel.org>,
	<bp@alien8.d>, <e@domain.invalid>, <mark.rutland@arm.com>,
	<driver-core@lists.linux.dev>, <kernel@xen0n.name>, <chao.gao@intel.com>,
	<eric.devolder@oracle.com>, <tangyouling@kylinos.cn>, <palmer@rivosinc.com>,
	<loongarch@lists.linux.dev>, <bgwin@google.com>, <guodongtai@kylinos.cn>,
	<rppt@kernel.org>, <linuxppc-dev@lists.ozlabs.org>, <maqianga@uniontech.com>,
	<seanjc@google.com>, <vishal.l.verma@intel.com>, <robh@kernel.org>,
	<gshan@redhat.com>, <me@linux.beauty>, <sshegde@linux.ibm.com>,
	<mpe@ellerman.id.au>
CC: <kexec@lists.infradead.org>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-12-ruanjinjie@huawei.com>
 <20260918102742.414E21F000FF@smtp.kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260918102742.414E21F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/9/18 18:27, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] kexec: elfcorehdr_updated in struct kimage is write-only and unused
> --
> 
> commit 463b7b7692d8e96dc1be8ffaed1b6d0c8d298c9f
> Author: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> crash: Normalize the kexec_load elfcorehdr at load time
> 
> This commit changes kexec_load to normalize the elfcorehdr at load time
> instead of waiting for the first crash hotplug event. By doing this while
> the device_hotplug_lock can be safely taken, it allows hotplug paths to
> skip CPU events safely and avoid racing with memory hotplug.
> 
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 3c9f4fbbe7ff0..f34fa8dba0288 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -457,9 +457,8 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>>  	 * possible CPUs, there is no need to update the elfcorehdr
>>  	 * for additional CPU changes.
>>  	 */
>> -	if ((image->file_mode || image->elfcorehdr_updated) &&
>> -		((image->hp_action == KEXEC_CRASH_HP_ADD_CPU) ||
>> -		(image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)))
>> +	if (image->hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>> +	    image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>>  		return;
> 
> [Severity: Low]
> Does this leave elfcorehdr_updated as a write-only and unused field?
> 
> Since this patch removes the last reader of image->elfcorehdr_updated,
> the field is now only written to in crash_handle_hotplug_event() and
> initialized in kernel/kexec_core.c:

Will remove unused  elfcorehdr_updated in v6.

> 
> kernel/crash_core.c:crash_handle_hotplug_event() {
>     ...
>     image->hp_action = KEXEC_CRASH_HP_NONE;
>     image->elfcorehdr_updated = true;
>     ...
> }
> 
> Should the elfcorehdr_updated field be completely removed from struct kimage
> in include/linux/kexec.h along with its assignments to avoid dead code and
> structure overhead?
> 

-- 
Best regards,
Jinjie



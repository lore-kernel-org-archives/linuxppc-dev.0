Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311ED606A329
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3Lj0XuRp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKvxJ42nTz2xSV;
	Thu, 05 Nov 2026 19:05:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793865908;
	cv=none; b=g8T5MlKok+hO8jJBS6cCZRO5yZGRtPT1/yt5ts171DH22Q+/A7Oxt9NNK8/nMOgZiMe9eTYND3nzX/XSXKgfWagqVImXAzw4NEptIg0IwXmFYX0NQDsRnRvCmOWRcUEMqQawfF7FkRj8td7XCUOxYBDE/lPLakKHxoHdXBizHUkEYLYF8tugcGUMh1S7iiijxVj5PLEOnvquELZsVr6AzDfIgeM1b8UFNd8iMX7uQiucpFhejmKNdIWJCrca2KfHFH7DbGhUUioBSCTIvlvlEer00l/HeemMrKG2/y34e3Iea6IvJd4AwVT5jLfkFe/rRIqD3pdDOZAjUD7yoKrPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793865908; c=relaxed/relaxed;
	bh=CCGzWBfX1X9cSsHPu2mqWEF8NpNHLDATFqyNNjfsFkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZamAwx7FfnYXBwN47OyrGoG6qvE7KscH9b/5HiBghScY6MQ+EiNyoR2E3ARyE/nfoAoxPCEOmeWzFIupza0O8dP2I99C4V+B99r4ez4uYPfZv+MZE3TgL9dwXkCwofPG0beydt1m4PJH/3e4gWL+BlTmWgUHCGw9RS+DVh1/wKk8QA4Rxf9MonOH0fQz8SQTo1ODiqAGaS/a6VTP1aOTloVktrBJYfb89+eRGAP13mn7E+cFyC6biMlifW9W+rEwyhmbbS1nBHZ57ynip+QGpv8DUop3+yVFjFj1Krv8kic1ah/I182OXjucUqFlpAaXHJm+wyIMQAwBCMWvCMiOEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3Lj0XuRp; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3Lj0XuRp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKvxF6rSGz2xN4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 19:05:03 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CCGzWBfX1X9cSsHPu2mqWEF8NpNHLDATFqyNNjfsFkw=;
	b=3Lj0XuRpdOCEztpedA6GSSl5x4O4JddmtxEbTLNoJlR2C54wDBW8jorT/6aOBic8BqPVyewSl
	x8e38gtEwgurpOUkkDhNyzVD/e6X4ayKuii44trLaEH0J0I7w9kRCxr2qDXmrth0z2EzyiGCtdk
	TbamYBpLt/lj+b5ImptgI7A=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jKvx71hllz12LDh;
	Thu,  5 Nov 2026 16:04:59 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id D2F8E4057F;
	Thu,  5 Nov 2026 16:04:57 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 16:04:56 +0800
Message-ID: <2db15115-a06a-48ba-86a2-9a343f1e2a2b@huawei.com>
Date: Thu, 5 Nov 2026 16:04:55 +0800
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/15] kexec: Fix CMA and elf header leaks and rework
To: Mike Rapoport <rppt@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<thuth@redhat.com>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<robh@kernel.org>, <sourabhjain@linux.ibm.com>, <kees@kernel.org>,
	<coiby.xu@gmail.com>, <Yeking@red54.com>, <tangyouling@kylinos.cn>,
	<maqianga@uniontech.com>, <zhangtianyang@loongson.cn>,
	<guodongtai@kylinos.cn>, <blum@kernel.org>, <adityag@linux.ibm.com>,
	<hui.wang@canonical.com>, <sohammetha01@gmail.com>, <guoren@kernel.org>,
	<gaohan@iscas.ac.cn>, <kai.huang@intel.com>, <kas@kernel.org>,
	<vishal.l.verma@intel.com>, <piliu@redhat.com>, <jbouron@amazon.com>,
	<mclapinski@google.com>, <me@linux.beauty>, <graf@amazon.com>,
	<bgwin@google.com>, <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <179380419709.28814.2122135856184991710.b4-review@b4>
 <932cdfda-7030-4829-8b43-062d208450e4@huawei.com>
 <auw1qgmjWko52oS_@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <auw1qgmjWko52oS_@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/5 15:52, Mike Rapoport 写道:
> On Thu, Nov 05, 2026 at 11:45:39AM +0800, Jinjie Ruan wrote:
>> 在 2026/11/4 22:56, Mike Rapoport 写道:
>>
>>>> Patches 8-10 pass the kbuf fields to crash_prepare_headers() to
>>>> simplfy code.
>>>>
>>>> Patch 11 frees the elf core header from the generic post-load cleanup.
>>>>
>>>> Patches 12-15 add kexec_load_other_segments() and convert the three
>>>> architectures, and arch_kexec_setup_other_segments() builds
>>>> the architecture specific boot parameters (a DTB or a command line).
>>>
>>> I think the refactoring should go before the identical fixes in arch/
>>> code.
>>
>> However, this will cause trouble for the fix patch in the stable round.
> 
> That's right, but since actual fixes anyway require changes to kexec core,
> I think it's better to refactor first. The core than will take care of
> proper freeing in the most cases.

This way, each architecture doesn't have to worry about the issue of
incomplete resource release.

> 
> And since CMA support in kexec is quite new I think the entire set can be
> backported to stable then.

Make sense for me.

> 
> I'm planning to have a closer look at the refactoring Really Soon :) 

Thank you very much! Looking forward to your review.

> 
>> -- 
>> Best regards,
>> Jinjie
>>
> 

-- 
Best regards,
Jinjie



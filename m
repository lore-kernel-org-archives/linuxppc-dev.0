Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42F2606A329
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NbsVxKtA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j85mk26Vkz2xLs;
	Tue, 20 Oct 2026 19:53:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792486422;
	cv=none; b=UagqX8KwVLGJc7CvxJRRXbpd6SpiKdJAOojbjO1K7A0cMg9hg9pTx7dnkbLiGXuDarqNBjL4ZmlVC8UyRehn9qxWMksVPkS8C8w15YzH7UUwusKtN4a809eOSiCfMuVD7PqUp5SxjAq+DrgO0NfRf0zErpp7D29HD9WSuvpyqLF776BSGr+ntZHH1jDDt9/EWBNtA0dCrSI8XAaRGuSLGzabzlwSWvEDQhlEmaeJ/RA9owI2rjL3/wW5Vm5A/ZqbGh9GDz5V/iqFRLadBYJpTxflBP7FogiSmyyxzJwIOxkSi730QFN0QQggiTwP4dojvFtKx6OBnUu/1C28ZU2pfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792486422; c=relaxed/relaxed;
	bh=LW2Z/J5kgMKXP1MQQy5oBk/GKxhYgHES/KC5diFwAwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P0FmSgifSxsnsqJplCUdTDT+TC+HQI6tIl3GKaBS/Chi5er+v/K8r1n0NAClLbwsyhpsAvbzQ+8VipWcoG7KFxseblP45SpO3EpnnJQUlsbd6qvTWH6Cza+nDgmOILi3FwiOLGemv/wCFpprzBqstp99d9PZ8g/naBV5WR6znJVxDedKQzSnRUAnggJEhrlfsQPsVP/Ftu0U6UOdqvXdPSYnZ6LoP1XY1JBsCtRF/l9VqW5xIPJIQb1GRNPan0aBWYJy4WzEIygugj+4HFPNBE8dTyn2WV6yMTwWrSn7zmWN1UMLFvxKvqp9kd2edwC8QyNKTRRbO6RFTgsqXwBzGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NbsVxKtA; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NbsVxKtA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j85mf6snqz2xKN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 19:53:36 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LW2Z/J5kgMKXP1MQQy5oBk/GKxhYgHES/KC5diFwAwA=;
	b=NbsVxKtA29oXvQv/BfIHkDIBuquaJ8mOke66Zav3POdMVfniAavgzeyYLX4KFePFgCEEiAP8V
	LAWFJMvvXYYOUMp0DrjKbjReXkvW9nAjpeYca8UmdFdXPeU0CXN+17VXYoRs37XNl+P0MKp1FNZ
	OM4Cc0ebyyVRcrXWBmTXElY=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j85mQ36FBzKm5F;
	Tue, 20 Oct 2026 16:53:26 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 701724058A;
	Tue, 20 Oct 2026 16:53:30 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 20 Oct
 2026 16:53:28 +0800
Message-ID: <c1e0217c-d2a8-43e2-8038-984663c08fd7@huawei.com>
Date: Tue, 20 Oct 2026 16:53:27 +0800
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
Subject: Re: [PATCH v6 00/14] crash: Fix several bugs
To: Mike Rapoport <rppt@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<leitao@debian.org>, <yeoreum.yun@arm.com>, <sourabhjain@linux.ibm.com>,
	<robh@kernel.org>, <coxu@redhat.com>, <kees@kernel.org>,
	<tangyouling@kylinos.cn>, <liukexin@kylinos.cn>, <zhangtianyang@loongson.cn>,
	<guodongtai@kylinos.cn>, <maqianga@uniontech.com>, <chao.gao@intel.com>,
	<kai.huang@intel.com>, <vishal.l.verma@intel.com>, <seanjc@google.com>,
	<piliu@redhat.com>, <thuth@redhat.com>, <jbouron@amazon.com>,
	<me@linux.beauty>, <mclapinski@google.com>, <graf@amazon.com>,
	<bgwin@google.com>, <hbathini@linux.ibm.com>, <eric.devolder@oracle.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <palmer@rivosinc.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <driver-core@lists.linux.dev>,
	<kexec@lists.infradead.org>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <179248377975.302547.11812783408034710690.b4-review@b4>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <179248377975.302547.11812783408034710690.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/10/20 16:09, Mike Rapoport 写道:
> Hi Jinjie,
> 
> Sorry for the delay, it's been really busy time for me.

Hi Mike,

Thank you for the feedback, and no problem at all for the delay.

> 
>> As Baoquan and Catalin suggested, this patch set fixes
>> several pre-existing code issues found by Sashiko AI [1][2][3].
>>
>> The major improvements and fixes included in this series are:
>> - Fix several memory leaks for arm64, and similar issues on LoongArch
>> - Fix out-of-bounds write on 32-bit Highmem for x86.
>> - Fix TOCTOU race in crash memory range collection.
> 
> It feels like these are three independent series, maybe with slight
> dependencies because they touch related code, but it's not really a
> single series:

Ok, will split this into three independent patch series.

> 
>> Jinjie Ruan (14):
>>   kexec: Fix CMA segment address translation with non-zero text_offset
>>   kexec: Record allocated CMA pages to fix release size mismatch
>>   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
>>   arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
>>   arm64: kexec_file: Fix elf_headers memory leak in retry loop
>>   LoongArch: kexec_file: Fix CMA page leaks in segment placement retry
>>     loops
>>   LoongArch: kexec_file: Fix elf_headers memory leak in retry loop
> 
> The very similar commits for arm64 and LoongArch imply that that we have
> some code duplication that should be addressed regardless of these

Will clean up the duplicated code in generic kexec first, and then fix
the bugs.

> fixes.
> 

-- 
Best regards,
Jinjie



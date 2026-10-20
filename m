Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD615606A326
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Kk+jgumG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j85LN2MdVz2xJ5;
	Tue, 20 Oct 2026 19:34:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792485260;
	cv=none; b=njkR9C5yd9xBBIhEGpWW8KWGJesnU9qViUJecfHXRcHJkHqS75KZx5SZDM3N4GscYmUb8YwWn+EP93aoGn5II+9QktsbppcqLJaXPS27bDGKchAnQEE3qM5bNSVbIOGz50lYDL7ea9tP0jNz1eyala/sGejeyktPrNYk0WaOqhL78VVhaCAz4oEcU2tXbm1BD1VtMHVhUlrIfUI5xW49YNxnElpxVYdlwV4HE8egKph6sBRZ6q6SQL1Mi2DhoqHQxebz1bGaMjsO86svSiijtYl04xjE+SO6R/v0D8gcuYeesRQx8nWB/CU8At5RkN3a419Ja2GqPItMET+b/yTLQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792485260; c=relaxed/relaxed;
	bh=vBKNWH+6fXgb7uSlyDkZ/sbNDxzLeASFOGVrmanI1ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tos5nW73hdLZ8nZjDZ9AAxIED1f5h02jHu8RE5adNW92nPBsGy+PCKZc+WPOY6SjLZH4gMF1RiLEEzoxCBB8Qjab1l7IJvRTStdcgqeRNAeUywALMas74ShRw0zc51ZqqxrfN3TlqdppUz5IQwLRHinfKIkfvtTX9hx1+nunz+PTU6FwdJ9fRtL2AUb+xW0AW8CFJP2sQSc7QD6petrxRlVvQXif0sEzr7aLuAwShKsZWJs5wu6mw+uDBxcnA7v/K3+Tf8wg6TrAgDkTGfuiLPzoAgNEAPdBxLb0bdpakzG5Sp0jVGpwiVnEBbTBUdojeWwm61lWXzsF+pQ5z2khJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Kk+jgumG; dkim-atps=neutral; spf=pass (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Kk+jgumG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j85LJ5RJwz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 19:34:14 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vBKNWH+6fXgb7uSlyDkZ/sbNDxzLeASFOGVrmanI1ag=;
	b=Kk+jgumG+pv7XnaPZDeeAU8MQ3LXTfm6oVnCbW8jazUZnqZ/ORtrC7JgFvxdnO+cDQzOI4t2U
	7vALOi9vHSSqoltGoZVUZISYSqkFZA0i7RhDVImMBjBBYnv3lpqm+y9AiV7PJ3swzXlcKzvnvXx
	8keUXFd5fYMskZHOl9KyGJI=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4j85L156ycz1K9Xh;
	Tue, 20 Oct 2026 16:34:01 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A9C04048B;
	Tue, 20 Oct 2026 16:34:05 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 20 Oct
 2026 16:34:02 +0800
Message-ID: <d7dc6528-4ec8-46d0-b21e-8a4c38edd4ce@huawei.com>
Date: Tue, 20 Oct 2026 16:34:02 +0800
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
Subject: Re: [PATCH v6 01/14] kexec: Fix CMA segment address translation with
 non-zero text_offset
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
 <20260921090450.807575-2-ruanjinjie@huawei.com>
 <179248377975.302547.13172455257147735569.b4-review@b4>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <179248377975.302547.13172455257147735569.b4-review@b4>
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
>> kimage_load_cma_segment() and kimage_map_segment() both translate
>> a CMA segment using page_address(cma), which returns the CMA base
>> address. This ignores segment->mem.
>>
>> On arm64, image_load() adds text_offset to segment->mem before the
>> segment is loaded:
>>
>> 	kernel_segment->mem += text_offset;
>> 	kernel_segment->memsz -= text_offset;
>> 	image->start = kernel_segment->mem;
> 
> That's true, but since commit 751c263bb74f ("arm64: remove TEXT_OFFSET
> randomization") TEXT_OFFSET is always zero. This is upstream from v5.8,
> so no LTS kernels has non-zero TEST_OFFSET.

Yes, My concern is what if the kdump kernel is an old one without this
patch?

Should we just add a WARN_ON_ONCE(text_offset != 0); here?

> 
> Maybe we should rather start deprecating .text_offset in arm64?
> 

-- 
Best regards,
Jinjie



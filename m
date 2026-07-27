Return-Path: <linuxppc-dev+bounces-24849-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0091C531F9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 01:32:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7h0s3pzFz2yPR;
	Mon, 27 Jul 2026 11:32:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785115949;
	cv=none; b=KbG0+bxjR0i2hk0g4RTf0MDwzvPhwBL6PeGPMeaCSFHxjGcBvEPaAu0itp3pBG2OaLeDUaNwMjgZV2MUklCWUuYOn+ka3tAZbaf8M0NT+dBD0H8QLSrxSx4VV9kzXy9BV8O1Xav85bvIrZBy2Abe0saIOX5LD9lJTQUzmIN7mzQGWau5qJMpbQfiy44xjkHXc+tF07uyyoeYanslYvN30RpXsSUuVwIdvmS/G7FCguBnn1/wlOkZwCoreSnpmxvUForwUeYfi8hmRy27dfg5kcv4OuZj021lu7MzXTZX0NStG5mL7Hh1DxgF/Ot1l4CqzsBJljPzC/Eue/oUAjTKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785115949; c=relaxed/relaxed;
	bh=C+DQuJXtADinBrFCl9u83kOzDJmpXPtN8cvR9o59Eeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JXb1gYErgXAEX5xzQz49n7gIrgbbezxAX+gKFVVVk6RxiAcXuFVnlyzqneDfLbRrqRQ/pn/bFVdiKunMeQ3FrsGt1OuNstfr12vd7KJC1cO7OzyABeYDroncvywK0wvvwJ29FLvcJLif5YkG3Gnk46aXBb+msmBVynhO2PTUuy32tJ7ChA27Xv0tPOxIZPgfcvi0EwC+jz21qPKbR5OFr3NmjIBjaeekOROgY6JSYfPKg0wH4QsCBLQAQW6axgmA/BOdcDeDGOKZFLs5GJrG96kNMw/NJZ++wwb/a+pyoDWOKex74k19afFIVePhJx9o5RzeGjoCPzALH0frC/rNTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=262EiEg4; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=262EiEg4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7h0p72qsz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 11:32:24 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=C+DQuJXtADinBrFCl9u83kOzDJmpXPtN8cvR9o59Eeg=;
	b=262EiEg47p4Yk/QZEwB6ElVSigThJqHw96cWY80zBP43FBPhtya38MnR6k8zkROGFHzy6yINi
	VmQU9B2QODp5BZNQwkB/UZzVPFOlf+6R3I+hEhy8W0raS9PZQ8D8Tq6tpHNxUzlPziDZ0yz2cYQ
	jK1Y8tqKkMpnvedw+Kyyk2M=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h7gnh056nz1T4Fq;
	Mon, 27 Jul 2026 09:22:48 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 37B8940561;
	Mon, 27 Jul 2026 09:32:15 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Jul 2026 09:32:13 +0800
Message-ID: <b36172d1-fdc4-480f-a60c-6da02e847709@huawei.com>
Date: Mon, 27 Jul 2026 09:32:12 +0800
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
Subject: Re: [PATCH 0/8] arm64: crash: Add crash hotplug support
To: Mike Rapoport <rppt@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <thuth@redhat.com>,
	<vladimir.murzin@arm.com>, <mark.rutland@arm.com>, <ardb@kernel.org>,
	<james.morse@arm.com>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<robh@kernel.org>, <kees@kernel.org>, <coxu@redhat.com>,
	<sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <hbathini@linux.ibm.com>, <makb@juniper.net>,
	<piliu@redhat.com>, <graf@amazon.com>, <liaoyuanhong@vivo.com>,
	<jbouron@amazon.com>, <bauerman@linux.ibm.com>, <bgwin@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <kexec@lists.infradead.org>
References: <20260723131242.1537633-1-ruanjinjie@huawei.com>
 <amWy4u9tXoWX6Wtp@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <amWy4u9tXoWX6Wtp@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)



在 2026/7/26 15:10, Mike Rapoport 写道:
> Hi Jinjie,
> 
> On Thu, Jul 23, 2026 at 09:12:34PM +0800, Jinjie Ruan wrote:
>> When CPU or memory hotplug events occur, the elfcorehdr in the kdump image
>> becomes stale, potentially leading to incomplete crash dumps.
>>
>> Currently, userspace udev rules reload the entire kdump image upon such
>> events, which is inefficient and leaves kdump inactive for a long time.
>>
>> Commit 247262756121 ("crash: add generic infrastructure for crash hotplug
>> support") introduced a kernel mechanism to update only the elfcorehdr.
>> This patch set implements crash hotplug support for arm64.
>>
>> It also addresses and fixes several critical pre-existing code issues
>> and Sashiko AI review findings extracted from the previous patch set,
>> following Baoquan's suggestions.
>>
>> The major improvements and fixes included in this series are:
>>
>> - Fix powerpc memory leak, null-ptr-def and overlapping memory
>>   range truncation bug.
>>
>> - Fix several memory leaks for arm64.
>>
>> - Simplify arm64 load_other_segments().
>>
>> - Implement infrastructure for arm64 crash memory hotplug support.
>>
>> This patch set is rebased on liveupdate/crashkernel-cma.
>>
>> Link: https://lore.kernel.org/all/20260601094805.2928614-1-ruanjinjie@huawei.com/
>>
>> Jinjie Ruan (8):
>>   powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
>>   powerpc/kexec_file: Fix null-ptr-def in extra size calculation
>>   powerpc/kexec_file: Prevent kexec range truncation
> 
> It's weird to see powerpc fixes in a series that adds a feature for arm64.
> Judging by the subjects, they are completely unrelated to to crash support
> for hotplug and should be sent as a separate set.

Hi Mike,

You are right, I'll rebase and post v2 shortly, and send the powerpc
fixes as a standalone series.

> 
>>   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
>>   arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
>>   arm64: kexec_file: Fix image->elf_headers memory leak during retry
>>     loop
>>   arm64: kexec_file: Simplify load_other_segments()
>>   arm64: crash: Add crash hotplug support
>>
>>  arch/arm64/Kconfig                     |   3 +
>>  arch/arm64/include/asm/kexec.h         |  13 +++
>>  arch/arm64/kernel/Makefile             |   2 +-
>>  arch/arm64/kernel/crash.c              | 148 +++++++++++++++++++++++++
>>  arch/arm64/kernel/kexec_image.c        |   1 +
>>  arch/arm64/kernel/machine_kexec_file.c |  76 ++++++-------
>>  arch/powerpc/kexec/crash.c             |   2 +-
>>  arch/powerpc/kexec/file_load_64.c      |   2 +-
>>  arch/powerpc/kexec/ranges.c            |  12 +-
>>  include/linux/kexec.h                  |   2 +
>>  kernel/kexec_core.c                    |  25 +++--
>>  11 files changed, 223 insertions(+), 63 deletions(-)
>>  create mode 100644 arch/arm64/kernel/crash.c
>>
>> -- 
>> 2.34.1
>>
> 



Return-Path: <linuxppc-dev+bounces-26205-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75844C61DE4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 01:24:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYB9Z4KnNz2y2g;
	Mon, 31 Aug 2026 11:24:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788139474;
	cv=none; b=Rrx+Lot5PaYttHllDatyEebh08r9uDEi4c5/gp+TcOfHWE15lJIfEfyERFJoS0OAEwQbmgkq5uVFuzzgwLozX0f52KDx/csFJ5aycl9EV0/+1KWAXZylTtksxJiBiXQJNJrhZUrrlv2oeTXK4v17p1EmIJTUgGHmGf2kU5BOnqNwMn9mPQx+UbHANnHG4qPldvG2koSXdodwrl9FvNQTB/S7CXfn2xu8S6OmCkhQaFPWVFzjD+YG8vQpZ/Ae9rfZEodz3H5Q4f/JL+TX3p/Ri9JWpyXSyiMv5NdDoNayfBXAlRDexU93jjLeeX281P550nWC5UvTkavrnRevL4Zybw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788139474; c=relaxed/relaxed;
	bh=XoeDNcLDw7hqig4W64iLCrlEHYGNT6SfF67o40azHuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ehl5IgR3QD/YhemiqPt0ItsyTq5L7fVDHvYvsELDWLmLaZqzGcMJKPjxhUhrWI9pkQf+u3EnIK9sowLhAM5FUiPGuX4/hN5zafjJIFAzYj1HPfqGAqg/NeP6OTcBLOz48JovPN38GoZa9skdqG9vqtumJ/JcbNkCigb8RidZ+vWH7ZKu5ewwRUom+Qz572TkDDVJAyWmMd2KWd/ojeFCj58l/AHZZO4cQ8B7I+/Dx6n6ss7HPzRalulKxuZx2CpZ5DsAdksx89ugUmz+l9bIo9ckpP4FJ8u58WhcEofHcqRzl6bVHuiAsbXrzW2tmqbr0o90Yizc18dxTmbEmj9Fxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Fs/xB0Yg; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Fs/xB0Yg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYB9V4hC4z2y2f
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 11:24:26 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XoeDNcLDw7hqig4W64iLCrlEHYGNT6SfF67o40azHuY=;
	b=Fs/xB0Yg8kWOG2+vbJXCQn6KxCz4jWLUSzEAq/b1HKUjTI6Zn6a1TBwmvuGGuCcesE500xj3A
	SHlJN9aRXKf3A7Fs3t9RDcaKDSzLORDLcS8OYgkK4sJKg+bVG/PW2a9vzhyuN23Kf3k818vtagI
	kSNrNpmr3MK18T+muYRiL2Q=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hY9w638lvzpSvb;
	Mon, 31 Aug 2026 09:12:54 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BA4140577;
	Mon, 31 Aug 2026 09:24:11 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 31 Aug 2026 09:24:08 +0800
Message-ID: <fecbe6ee-12e3-4f3d-94ac-eb7cd08eeb0d@huawei.com>
Date: Mon, 31 Aug 2026 09:24:07 +0800
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
Subject: Re: [PATCH v3 07/17] crash_dump: Fix potential double-free of
 keys_header
To: Sourabh Jain <sourabhjain@linux.ibm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <mark.rutland@arm.com>, <chenhuacai@kernel.org>,
	<kernel@xen0n.name>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <chleroy@kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<gshan@redhat.com>, <jic23@kernel.org>, <james.morse@arm.com>,
	<ardb@kernel.org>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<coxu@redhat.com>, <tangyouling@kylinos.cn>, <hbathini@linux.ibm.com>,
	<adityag@linux.ibm.com>, <ionut.nechita@windriver.com>,
	<liaoyuanhong@vivo.com>, <seanjc@google.com>, <fuqiang.wang@easystack.cn>,
	<makb@juniper.net>, <piliu@redhat.com>, <ebiggers@kernel.org>,
	<jbouron@amazon.com>, <mclapinski@google.com>, <me@linux.beauty>,
	<graf@amazon.com>, <bgwin@google.com>, <robh@kernel.org>,
	<takahiro.akashi@linaro.org>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, Coiby Xu <coiby.xu@gmail.com>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-8-ruanjinjie@huawei.com>
 <87186b8a-f68c-400b-97cf-8ea6129eba69@linux.ibm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <87186b8a-f68c-400b-97cf-8ea6129eba69@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)



在 2026/8/30 13:59, Sourabh Jain 写道:
> Hello Jinjie,
> 
> Coiby is handling this issue in the below patch series:
> https://lore.kernel.org/all/20260828084900.1496839-2-coiby.xu@gmail.com/
> 
> Since the above patch series is all about crash_load_dm_crypt_keys,
> could you
> please consider dropping this patch from your series and reviewing his
> patch
> instead?

Absolutely, happy to do so — I'll drop this patch and review Coiby's
series instead.

> 
> Thanks,
> Sourabh Jain
> 
> On 26/08/26 14:55, Jinjie Ruan wrote:
>> `keys_header` was freed in `build_keys_header()` without being reset
>> to NULL, and the error path in `crash_load_dm_crypt_keys()` freed it
>> unconditionally even when reused, leading to double-free or
>> use-after-free.
>>
>> Add `free_keys_header()` to centralize freeing and NULL-setting.
>> Use it in `build_keys_header()` and only free in the error path when
>> the header was newly built (`!is_dm_key_reused`).
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Cc: Pratyush Yadav <pratyush@kernel.org>
>> Cc: Dave Young <ruirui.yang@linux.dev>
>> Cc: stable@vger.kernel.org
>> Fixes: e3a84be1ec2f ("arm64,ppc64le/kdump: pass dm-crypt keys to kdump
>> kernel")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   kernel/crash_dump_dm_crypt.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>> index c685497cd470..ed0960ff0987 100644
>> --- a/kernel/crash_dump_dm_crypt.c
>> +++ b/kernel/crash_dump_dm_crypt.c
>> @@ -363,15 +363,21 @@ static struct configfs_subsystem
>> config_keys_subsys = {
>>       },
>>   };
>>   +static void free_keys_header(void)
>> +{
>> +    if (keys_header) {
>> +        kvfree(keys_header);
>> +        keys_header = NULL;
>> +    }
>> +}
>> +
>>   static int build_keys_header(void)
>>   {
>>       struct config_item *item = NULL;
>>       struct config_key *key;
>>       int i, r;
>>   -    if (keys_header != NULL)
>> -        kvfree(keys_header);
>> -
>> +    free_keys_header();
>>       keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
>>       if (!keys_header)
>>           return -ENOMEM;
>> @@ -441,7 +447,8 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>       r = kexec_add_buffer(&kbuf);
>>       if (r) {
>>           pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
>> -        kvfree((void *)kbuf.buffer);
>> +        if (!is_dm_key_reused)
>> +            free_keys_header();
>>           return r;
>>       }
>>       image->dm_crypt_keys_addr = kbuf.mem;
> 



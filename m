Return-Path: <linuxppc-dev+bounces-26343-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C9EC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 21:35:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYj305c0dz2xxr;
	Tue, 01 Sep 2026 07:35:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788183609;
	cv=none; b=J2Xbk4ULCo1QgkZe5c5xtv52y7Li+8GQJzoehBwttKYfV26rFt1egXCb/dLydW2IPFINUjRQ5di96r9chBhFjuIcRKJ/UxSyZadH5KJUFGQs5oJZixIpLyKWTadXako/GYd5jxgjx/DgiWpU04eaVm0Pa3LLzePVgUqcsiw2NT5RsdeMXlrhUjDcfKb4WzEOW+5ZQNKs28gRut3ers913/2mjv2s2CH20PlFuSiSsJl2zlXljKdqnEesp45+OVgMbWsqFRi2OKNAoq5uRsd/Oq5fvsAlJTGcbztznD3fhu9aSjzUiQaPwbi136j+7yYNdDF2jOf8ICAci3gvy6tXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788183609; c=relaxed/relaxed;
	bh=53920xzB8XLNSjeZIZbkJ3m9LVbpBiAgUUyw5Vt5WJg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEtx6hwLkg+o/ytXTCUWExWxCCB5b0UOBSM1oueKyEsg0wO0qbJxq23Tmdr8rLHor4qzqYJKO7D0ppKH+O/PlQ6FhYnU83+sINAFMY1vRs7mMHx0bPfatq+dWNU5tH+4pW5dkXKX9dTVP9880geaJyPg/B3uo9/05da0xWuLRBTpQdbWA5gmIPTEdGtG1VTQWpx3LtsyaI866T3hnDilecz9CWPyewbLcqmdIHbKwg8HiATyJ3pC3olnR8VbCElLvtQ+3nXds+Zv+nFAYxggvk1wH+9mVWqU0l1k0UKXYuPCNS+ZmFt4U9LQmgvsipzw1h9XJtAj895GBku3ZGvnzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oOAo2fZj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=coiby.xu@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oOAo2fZj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=coiby.xu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYVVJ2vlMz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 23:40:08 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2d91ded8174so9975505ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 06:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788183605; x=1788788405; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=53920xzB8XLNSjeZIZbkJ3m9LVbpBiAgUUyw5Vt5WJg=;
        b=oOAo2fZj3qMbt0HsVvJF6Ad93p9lKlYCvlEjxVg9FncSr2yJo9+zgajHQhWqcUswZY
         c3+Ym56hIho6IB4+WOgIRLTOzA8AzMgddrrhQXUs6+r7+mL4s/weTVIOXemxg+b2sgTt
         spXFWEf7EGzT32aNimPwNfsG8eqX48MQGnapzrICieM3htHWGRW+bg5Er8VptWoFv53R
         Wrpo1KXDaO8Wh8yGJpfA8dqHC26jB0hDhp0FzR9DD36W+oW9XrMy3xnKANonAPJhZZq1
         YJIphK/lbDjytDUq/fORWkNIDKp80oA0cJfaBNgAsub3t/KGvXBKoOEwYWjT+8cqxo70
         cKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788183605; x=1788788405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=53920xzB8XLNSjeZIZbkJ3m9LVbpBiAgUUyw5Vt5WJg=;
        b=XVC4zwsdu0npr8j4+ZzWzzVnEJkgpW0a4cNJuRYfK6fFqKdtyBdBPCSUGgdbHcVx4L
         DFjHcmj+tCsfLORV3WB3eIZOf/INz4pQOXsPXeUF/bKDDk8HO/tJOAxCA2nUenBeqqqU
         BJQkWHJCLXhDrcQvi0W4LuqGp9NCS0k7hHMpvfiw1wca7+wX8/gQLA2mlJfXtgFiT57k
         y1uiL1eXhX2167ZKqhiL4XEZOM+GhDd4IrmGiKcKPTHjxgG2TW/Yw8IDZjZcm9HYOvQU
         SsYa6ZCMxs/fz3z3MKo3ebgYSnpRqfcnLv4QkfI4RPH/vx2rnCzdzi8ix5E/aEYhdH29
         PY1w==
X-Forwarded-Encrypted: i=1; AKwUvBxVaCqTjw3zk/UVD6VnqJAIYgFiF4uReoWxGfktlbi2npNFLR65wGnkOkbuKEwfymY3t4SeH8MoJHww9sU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n2jy/UwzBYRbSS3s5r4ZttnfH6nYzOZ0sEAsaRjUeE8P4UBF7q
	7aKUafWf+yD+nonUxN4tvp6hf0BmwCbwFDndP2AHgpSW3cMLDE1of1Iv
X-Gm-Gg: AYBFou13ht8FKhJm5BxJUJXKYHfSsTA1rxa7Cg0hLP4YBU7lhg2jMl3pPXvAfdG9PF8
	a4Q3rrj7fnYbTdFkOjjl4IyvLH7hiUh8pRQH2RzmYCv2KEty/uzyOiL6aAcrQWBcZyYsm7Jvx72
	Bije6knAXUuIPz2qZupyBDG6uOsp3FNcYuX+zXQQ8T4o/7xH/0XsgZtQdY8iTlGTL9Y+jZem2dD
	tUdGVuPBXxsYhllRe0/nuaTvVRFjP1RM6DhymaOZk7kyH8nv6nK4UhIK1pwSR0wDd3Doj9qu8if
	V1wsGWJzxL1r0f3AczrzV6u0CFHTsfL1Ale1cCJJ+jmgLF7sXSeRI3g/z5ac3+GyoRUuRZKitJS
	ismLOa1JIKc1RIQfBk/8orlrtOn3r05FZjMr/OYfz5zcUN8CfrGFRiqhOuVEKsWHET/IMKnoaMD
	6z2Ig1GgMMTBf+HwGaW4BZ+W/IF+QW8dHRwf5VG6PWHuTb/i0ziKm5Jg==
X-Received: by 2002:a17:902:ce88:b0:2c9:c952:6e9 with SMTP id d9443c01a7336-2d74dca2281mr379634065ad.2.1788183605112;
        Mon, 31 Aug 2026 06:40:05 -0700 (PDT)
Received: from localhost ([45.112.44.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa20e2fsm30550306eec.28.2026.08.31.06.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:40:04 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Mon, 31 Aug 2026 21:36:33 +0800
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, catalin.marinas@arm.com, 
	will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
	pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, kees@kernel.org, 
	thuth@redhat.com, gshan@redhat.com, jic23@kernel.org, james.morse@arm.com, 
	ardb@kernel.org, leitao@debian.org, yeoreum.yun@arm.com, tangyouling@kylinos.cn, 
	hbathini@linux.ibm.com, adityag@linux.ibm.com, ionut.nechita@windriver.com, 
	liaoyuanhong@vivo.com, seanjc@google.com, fuqiang.wang@easystack.cn, makb@juniper.net, 
	piliu@redhat.com, ebiggers@kernel.org, jbouron@amazon.com, mclapinski@google.com, 
	me@linux.beauty, graf@amazon.com, bgwin@google.com, robh@kernel.org, 
	takahiro.akashi@linaro.org, palmer@rivosinc.com, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v3 07/17] crash_dump: Fix potential double-free of
 keys_header
Message-ID: <apWDDWhkVMIpKWS-@Rk>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-8-ruanjinjie@huawei.com>
 <87186b8a-f68c-400b-97cf-8ea6129eba69@linux.ibm.com>
 <fecbe6ee-12e3-4f3d-94ac-eb7cd08eeb0d@huawei.com>
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
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fecbe6ee-12e3-4f3d-94ac-eb7cd08eeb0d@huawei.com>

On Mon, Aug 31, 2026 at 09:24:07AM +0800, Jinjie Ruan wrote:
>
>
>在 2026/8/30 13:59, Sourabh Jain 写道:
>> Hello Jinjie,
>>
>> Coiby is handling this issue in the below patch series:
>> https://lore.kernel.org/all/20260828084900.1496839-2-coiby.xu@gmail.com/
>>
>> Since the above patch series is all about crash_load_dm_crypt_keys,
>> could you
>> please consider dropping this patch from your series and reviewing his
>> patch
>> instead?
>
>Absolutely, happy to do so — I'll drop this patch and review Coiby's
>series instead.

Hi Jinjie,

Thank you for agreeing to drop your patch and review mine instead!

>
>>
>> Thanks,
>> Sourabh Jain
>>
>> On 26/08/26 14:55, Jinjie Ruan wrote:
>>> `keys_header` was freed in `build_keys_header()` without being reset
>>> to NULL, and the error path in `crash_load_dm_crypt_keys()` freed it
>>> unconditionally even when reused, leading to double-free or
>>> use-after-free.
>>>
>>> Add `free_keys_header()` to centralize freeing and NULL-setting.
>>> Use it in `build_keys_header()` and only free in the error path when
>>> the header was newly built (`!is_dm_key_reused`).
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Baoquan He <bhe@redhat.com>
>>> Cc: Mike Rapoport <rppt@kernel.org>
>>> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
>>> Cc: Pratyush Yadav <pratyush@kernel.org>
>>> Cc: Dave Young <ruirui.yang@linux.dev>
>>> Cc: stable@vger.kernel.org
>>> Fixes: e3a84be1ec2f ("arm64,ppc64le/kdump: pass dm-crypt keys to kdump
>>> kernel")
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>>   kernel/crash_dump_dm_crypt.c | 15 +++++++++++----
>>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>> index c685497cd470..ed0960ff0987 100644
>>> --- a/kernel/crash_dump_dm_crypt.c
>>> +++ b/kernel/crash_dump_dm_crypt.c
>>> @@ -363,15 +363,21 @@ static struct configfs_subsystem
>>> config_keys_subsys = {
>>>       },
>>>   };
>>>   +static void free_keys_header(void)
>>> +{
>>> +    if (keys_header) {
>>> +        kvfree(keys_header);
>>> +        keys_header = NULL;
>>> +    }
>>> +}
>>> +
>>>   static int build_keys_header(void)
>>>   {
>>>       struct config_item *item = NULL;
>>>       struct config_key *key;
>>>       int i, r;
>>>   -    if (keys_header != NULL)
>>> -        kvfree(keys_header);
>>> -
>>> +    free_keys_header();
>>>       keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
>>>       if (!keys_header)
>>>           return -ENOMEM;
>>> @@ -441,7 +447,8 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>>       r = kexec_add_buffer(&kbuf);
>>>       if (r) {
>>>           pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
>>> -        kvfree((void *)kbuf.buffer);
>>> +        if (!is_dm_key_reused)
>>> +            free_keys_header();
>>>           return r;
>>>       }
>>>       image->dm_crypt_keys_addr = kbuf.mem;
>>
>

-- 
Best regards,
Coiby


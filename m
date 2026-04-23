Return-Path: <linuxppc-dev+bounces-20012-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB10F589AE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 12:34:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1bBm6PP6z2yGX;
	Thu, 23 Apr 2026 22:34:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.186
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776947680;
	cv=none; b=SUIkYa2ELC1gvcF9wKV8QbZ8xelpx5hp1/Q6HLKnkr3jgMs3FezilFSDI1TzTpxyKFI/EFjmkI1THwK3crtlYjOmhywpDjauGBEUbNyF0BtOlEboLW4wsNNDEqBq0TYHsavK9KvokuBy4as7bDxYpwM4bJMR6lxDMZCA7SMksKBiTvXJsUa/u7kdkA6pmYfwgY0JE4J+F3hooI4MYR1a+kyzeTd0uiDLz0bFXqn/ApeVu33riYkNBaOWbZTAUGCkvhduUljtGXxEJh/BTNbsUr6fCzsXli0+S4Rj3+CA+squlVMzRkeui9ufGnhbL4UefnFIyedD0mDM2bp3VBStkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776947680; c=relaxed/relaxed;
	bh=Lw49zwURroj4cNnSa8wLXSWhI5yryxe8VvIKls8yX7s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KZqhaENtIFQZttBE5lyU6PokcGNd+Edo9preuCwFueYMiL/n7nJcjzsCbyUyAOkSf8dac90siX0ZeutWdaKDMWixcbyEGuBA7TTPYof0BUiPM9qDig9Is/tcLNo0psMpkUeAA2GBbUhyULNgeUPHsG13BnqVzggisiyTqsYsHGs84E9lesBH3nDHiAKfh7iVjeNW8jJ5Dcy0D3/hw+hqL/Llt/QPOMX5dq6efER0uVEi7TrkJSvYcvHq1J01a7ZO9Ol/SuGAQQQZGkFg84wrdZhi+vTHGPzeJ6Rqfpw9XOhF1Ek9m1UWjke8IhfcZKNm6T8aLhzoPoAuxb1pmr0i2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=l9X21ct7; dkim-atps=neutral; spf=pass (client-ip=95.215.58.186; helo=out-186.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=l9X21ct7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.186; helo=out-186.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1bBg5VHXz2y8d
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 22:34:34 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776947654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lw49zwURroj4cNnSa8wLXSWhI5yryxe8VvIKls8yX7s=;
	b=l9X21ct7waizi915h79BbuDuGau1Z93SKDUm3rxRMbrJGUAaqEMlOwYvImdQpDAywOkq1b
	7DS686VPF0wKsgRwF0xtHtANLNQFUVR9ubGe9ZJSbHxez84vmZtSE+OmDO2IWJNQqbhnYY
	DFRh+2d9ph8oyKsM7CW1J63XOari2lw=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v5 v5 2/6] mm/memory_hotplug: Fix incorrect altmap passing
 in error path
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <25aac60c-8510-4d92-85f3-368cfe9d83ef@kernel.org>
Date: Thu, 23 Apr 2026 20:31:04 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <139193CD-6D52-4114-82D1-3093B3F3C9E1@linux.dev>
References: <20260423071911.1962859-1-songmuchun@bytedance.com>
 <20260423071911.1962859-3-songmuchun@bytedance.com>
 <e0ed4524-36d5-41ff-8ded-ba036d6ff6e4@kernel.org>
 <A542CA17-C6BB-4D1C-BBAB-154FA5E35B36@linux.dev>
 <25aac60c-8510-4d92-85f3-368cfe9d83ef@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 23, 2026, at 20:28, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 4/23/26 14:18, Muchun Song wrote:
>>=20
>>=20
>>> On Apr 23, 2026, at 18:38, David Hildenbrand (Arm) =
<david@kernel.org> wrote:
>>>=20
>>> On 4/23/26 09:19, Muchun Song wrote:
>>>> In create_altmaps_and_memory_blocks(), when arch_add_memory() =
succeeds
>>>> with memmap_on_memory enabled, the vmemmap pages are allocated from
>>>> params.altmap. If create_memory_block_devices() subsequently fails, =
the
>>>> error path calls arch_remove_memory() with a NULL altmap instead of
>>>> params.altmap.
>>>>=20
>>>> This is a bug that could lead to memory corruption. Since altmap is
>>>> NULL, vmemmap_free() falls back to freeing the vmemmap pages into =
the
>>>> system buddy allocator via free_pages() instead of the altmap.
>>>> arch_remove_memory() then immediately destroys the physical linear
>>>> mapping for this memory. This injects unowned pages into the buddy
>>>> allocator, causing machine checks or memory corruption if the =
system
>>>> later attempts to allocate and use those freed pages.
>>>>=20
>>>> Fix this by passing params.altmap to arch_remove_memory() in the =
error
>>>> path.
>>>>=20
>>>> Fixes: 6b8f0798b85a ("mm/memory_hotplug: split memmap_on_memory =
requests across memblocks")
>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>> ---
>>>> mm/memory_hotplug.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>>> index 2a943ec57c85..0bad2aed2bde 100644
>>>> --- a/mm/memory_hotplug.c
>>>> +++ b/mm/memory_hotplug.c
>>>> @@ -1468,7 +1468,7 @@ static int =
create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
>>>> ret =3D create_memory_block_devices(cur_start, memblock_size, nid,
>>>> params.altmap, group);
>>>> if (ret) {
>>>> -  arch_remove_memory(cur_start, memblock_size, NULL);
>>>> +  arch_remove_memory(cur_start, memblock_size, params.altmap);
>>>> kfree(params.altmap);
>>>> goto out;
>>>> }
>>>=20
>>> Yeah, that's nasty. We should CC stable.
>>=20
>> Make sense.
>>=20
>>>=20
>>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>>=20
>> Thanks.
>>=20
>>>=20
>>>=20
>>>=20
>>> Should we extend the safety checks we already have on the other =
path?
>>=20
>> Better to have.
>>=20
>>>=20
>>>=20
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index 2a943ec57c85..1c304468af08 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -1402,6 +1402,12 @@ bool mhp_supports_memmap_on_memory(void)
>>> }
>>> EXPORT_SYMBOL_GPL(mhp_supports_memmap_on_memory);
>>>=20
>>> +static void altmap_free(struct vmemmap_altmap *altmap)
>>> +{
>>> +       WARN(altmap->alloc, "Altmap not fully unmapped");
>>=20
>> Should we change it to WARN_ONCE?
>=20
> Was debating with myself, and yes, I think so.
>=20
>>=20
>>> +       kfree(altmap);
>>> +}
>>> +
>>> static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
>>> {
>>>       unsigned long memblock_size =3D memory_block_size_bytes();
>>> @@ -1426,10 +1432,7 @@ static void =
remove_memory_blocks_and_altmaps(u64 start, u64 size)
>>>               remove_memory_block_devices(cur_start, memblock_size);
>>>=20
>>>               arch_remove_memory(cur_start, memblock_size, altmap);
>>> -
>>> -               /* Verify that all vmemmap pages have actually been =
freed. */
>>> -               WARN(altmap->alloc, "Altmap not fully unmapped");
>>> -               kfree(altmap);
>>> +               altmap_free(altmap);
>>>       }
>>> }
>>>=20
>>> @@ -1460,7 +1463,7 @@ static int =
create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
>>>               /* call arch's memory hotadd */
>>>               ret =3D arch_add_memory(nid, cur_start, memblock_size, =
&params);
>>>               if (ret < 0) {
>>> -                       kfree(params.altmap);
>>> +                       altmap_free(params.altmap);
>>>                       goto out;
>>>               }
>>>=20
>>> @@ -1469,13 +1472,12 @@ static int =
create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
>>>                                                 params.altmap, =
group);
>>>               if (ret) {
>>>                       arch_remove_memory(cur_start, memblock_size, =
NULL);
>>> -                       kfree(params.altmap);
>>> +                       altmap_free(params.altmap);
>>>                       goto out;
>>>               }
>>>       }
>>>=20
>>>       return 0;
>>> -out:
>>>       if (ret && cur_start !=3D start)
>>>               remove_memory_blocks_and_altmaps(start, cur_start - =
start);
>>>       return ret;
>>>=20
>>>=20
>>> Maybe the helper should even go into altmap code? Not sure.
>>=20
>> I think the current changes look great as they are. While I believe =
this is valuable
>> as a standalone cleanup, what do you think?
> Makes sense. Could you do me the favor and follow up with that, on top =
of the fixes?

No problem.

>=20
> --=20
> Cheers,
>=20
> David




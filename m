Return-Path: <linuxppc-dev+bounces-20009-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D086CF589B0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 12:25:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1b0f32P5z2yGX;
	Thu, 23 Apr 2026 22:25:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::ba"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776947154;
	cv=none; b=nsJdOSJ7JkPUB1XUSf/PTzwGSc3sNteo0Xb5JMJ/0ca9NV0Uvv4g/EsGF4hfem6af0fyutsJLoWIqibDH5/0QMx3LavnoKdBsd9BZg7ICc4cQwOQw8l5C05Bv3xgF9lzsNYffS62kkFktfwBOag2UQK74DclhRN2dCwlXcrznkc/lnIljjuytkbKZcOaokEuWCtooPINaFeLIu6auNkIR+gtAV7DebiHyagzM/bq0vge1WyFZvXxK6Gq438jW1LZA3shlpOPffLddyUt0yuu1F//VvyskBa3tG4jLrBtUYDypzkzvHR4ST//VCCpnLCL5AE+1mmAWEQxNT36sUvUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776947154; c=relaxed/relaxed;
	bh=Q4LgpLetqEJMUYqZ9nmv9qSQLNKswZwmhvnZvNQKMWs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GUHgcEEVLb7CzUwMWhCNFl5p1uDI3b5pKZKXBTnwJf8HhAcV898/wUbwk+6VVKTaVRGUVifkw76i/Mm84Kqg/0Dth2vAme30mlmTrF0qSe6esztPo5izJzIR3KifFfGYJf40ceOQ0kCErPqEfOXiNCbAiKiDcDH4+zh4QHJcLVmKzUqeDoJoZhrJZ7qfu/k6uei0vXBvujpVZ4fUOwn22Gq06U4ItJA/CFdVJkkBv1wTuN9RDsIrS90pZ+sgqykSZSRNSgkZmSOHg2sEnjR0Pzq+lVLl2lTsB/9leYNfGK3rcNRCmBakJsWEd7e45+4lmLfOUbtp9ZTfqKQmWTrc3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=E64lGpsK; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::ba; helo=out-186.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=E64lGpsK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::ba; helo=out-186.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ba])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1b0b2W6qz2y8d
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 22:25:50 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776947125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4LgpLetqEJMUYqZ9nmv9qSQLNKswZwmhvnZvNQKMWs=;
	b=E64lGpsKIAp0+7yqcT34z/MtVPASA0p+X46tbKSZ5VzzVuD4yhmTK/MLRJyOoG5xPYXO3/
	bu0/dIkxxRSxYj7Wq3EhzzP/r7oe+ItOHS3YgcKc6tBrnkucgv13Ys2XocFFJkuL64Ybzo
	6mbLW5WEfZNLIHF24XAxEOc/41LbejE=
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
In-Reply-To: <e0ed4524-36d5-41ff-8ded-ba036d6ff6e4@kernel.org>
Date: Thu, 23 Apr 2026 20:18:15 +0800
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
Message-Id: <A542CA17-C6BB-4D1C-BBAB-154FA5E35B36@linux.dev>
References: <20260423071911.1962859-1-songmuchun@bytedance.com>
 <20260423071911.1962859-3-songmuchun@bytedance.com>
 <e0ed4524-36d5-41ff-8ded-ba036d6ff6e4@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 23, 2026, at 18:38, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 4/23/26 09:19, Muchun Song wrote:
>> In create_altmaps_and_memory_blocks(), when arch_add_memory() =
succeeds
>> with memmap_on_memory enabled, the vmemmap pages are allocated from
>> params.altmap. If create_memory_block_devices() subsequently fails, =
the
>> error path calls arch_remove_memory() with a NULL altmap instead of
>> params.altmap.
>>=20
>> This is a bug that could lead to memory corruption. Since altmap is
>> NULL, vmemmap_free() falls back to freeing the vmemmap pages into the
>> system buddy allocator via free_pages() instead of the altmap.
>> arch_remove_memory() then immediately destroys the physical linear
>> mapping for this memory. This injects unowned pages into the buddy
>> allocator, causing machine checks or memory corruption if the system
>> later attempts to allocate and use those freed pages.
>>=20
>> Fix this by passing params.altmap to arch_remove_memory() in the =
error
>> path.
>>=20
>> Fixes: 6b8f0798b85a ("mm/memory_hotplug: split memmap_on_memory =
requests across memblocks")
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> mm/memory_hotplug.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 2a943ec57c85..0bad2aed2bde 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1468,7 +1468,7 @@ static int create_altmaps_and_memory_blocks(int =
nid, struct memory_group *group,
>> 	ret =3D create_memory_block_devices(cur_start, memblock_size, =
nid,
>>  					params.altmap, group);
>> 	if (ret) {
>> - 		arch_remove_memory(cur_start, memblock_size, NULL);
>> + 		arch_remove_memory(cur_start, memblock_size, =
params.altmap);
>> 		kfree(params.altmap);
>> 		goto out;
>> 	}
>=20
> Yeah, that's nasty. We should CC stable.

Make sense.

>=20
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks.

>=20
>=20
>=20
> Should we extend the safety checks we already have on the other path?

Better to have.

>=20
>=20
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 2a943ec57c85..1c304468af08 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1402,6 +1402,12 @@ bool mhp_supports_memmap_on_memory(void)
> }
> EXPORT_SYMBOL_GPL(mhp_supports_memmap_on_memory);
>=20
> +static void altmap_free(struct vmemmap_altmap *altmap)
> +{
> +       WARN(altmap->alloc, "Altmap not fully unmapped");

Should we change it to WARN_ONCE?

> +       kfree(altmap);
> +}
> +
> static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
> {
>        unsigned long memblock_size =3D memory_block_size_bytes();
> @@ -1426,10 +1432,7 @@ static void =
remove_memory_blocks_and_altmaps(u64 start, u64 size)
>                remove_memory_block_devices(cur_start, memblock_size);
>=20
>                arch_remove_memory(cur_start, memblock_size, altmap);
> -
> -               /* Verify that all vmemmap pages have actually been =
freed. */
> -               WARN(altmap->alloc, "Altmap not fully unmapped");
> -               kfree(altmap);
> +               altmap_free(altmap);
>        }
> }
>=20
> @@ -1460,7 +1463,7 @@ static int create_altmaps_and_memory_blocks(int =
nid, struct memory_group *group,
>                /* call arch's memory hotadd */
>                ret =3D arch_add_memory(nid, cur_start, memblock_size, =
&params);
>                if (ret < 0) {
> -                       kfree(params.altmap);
> +                       altmap_free(params.altmap);
>                        goto out;
>                }
>=20
> @@ -1469,13 +1472,12 @@ static int =
create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
>                                                  params.altmap, =
group);
>                if (ret) {
>                        arch_remove_memory(cur_start, memblock_size, =
NULL);
> -                       kfree(params.altmap);
> +                       altmap_free(params.altmap);
>                        goto out;
>                }
>        }
>=20
>        return 0;
> -out:
>        if (ret && cur_start !=3D start)
>                remove_memory_blocks_and_altmaps(start, cur_start - =
start);
>        return ret;
>=20
>=20
> Maybe the helper should even go into altmap code? Not sure.

I think the current changes look great as they are. While I believe this =
is valuable
as a standalone cleanup, what do you think?

Thanks,
Muchun.

>=20
>=20
> --=20
> Cheers,
>=20
> David



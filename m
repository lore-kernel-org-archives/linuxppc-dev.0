Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC49606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cmSt9/t2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGJQr3Rqkz30Vd;
	Fri, 30 Oct 2026 22:14:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::4f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793358884;
	cv=none; b=NjdrSQndMkoUQYs0ilpioxhjWiTv8YyJsE1AV4Wev96IsUzban7Xg5Zf7NHIwiTIObpGtK2mugA3z8BQ5+cl6YRxIhOfqGTlbHF6o0dLh1VErPHgnVAdn8FxE3FQiwOVyVahzzo7AP4TYxqJrI2JhtbIVvnQzdEVkxt3HPPCPw5+T+WXkQqXrvDaQBflxRieeT7dzhHMLStn8D/LiZgqH0Ek7pFKViLoh5yhXPtmJXIdXIyEapV56vynjWgtAS1bWgij37U9NE13fwMTHNNZKTmYJ8ovlf7XlnXP29OuUE21kR6wLkhwcd0dT37+HH+g9/NaT/ekVcWv6OTj3FONug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793358884; c=relaxed/relaxed;
	bh=j0Dpk8F16jUjSTTEQzXZMl1K/eyyCO+RqBTSF8+llHA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gYaxfeosKRa+8HCUD/a24BzkGGN6u9SXsxTcHrqoQ8/750K5fa3K0jwMQxUePzLjq4Wy650sb8LRV1Jzl2sQDZ3E2sbfeExGptRj4UgqrpaGJvAmgnQ9H/9QJ37Sc8aum8h5E4UkQZ6XVuTKKuGCzXAi191yQSNrqaZ0HGLmgZ0KMYAGnSx1QC51yvHOUe4VEpDQxEcZnV0fdzd5YYtgL+UGAX4QOwFk/n8I4vOVjlQo1qxYEKCekQoWHhgKy3Z11FTomT6YrdvK2jtZVlhL3KCtZf3M0p/zRtdkyu8R1eoVZrQHmUkNQQASbnrIgicGUtBscBUG6SpfP0sRyWGrrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cmSt9/t2; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::4f; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cmSt9/t2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::4f; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-79.mta0.migadu.com [IPv6:2001:41d0:1004:224b::4f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGJQm17Cfz2yFj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 22:14:37 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=/hkUgSZjp6AaXOgYubi6gjf4bGt54M8qSHBq7xoR5Gg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793358854; v=1; x=1793963654;
 b=cmSt9/t2ekgeN+2H/AK/CaONcMFVjcHbkmbY5R6QVwNwIafaZIRdVdxfLYha7wkaiigOJK5t
 1qvsdzatIi3O/HdgnSUa/XDORt/kanQgoaQgaO10saR7IA2e39I/vUA5wuMoDszngd5t2rPswa6
 FEZeNrh52rNvZCIqLEpd68/o=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta11.migadu.com with ESMTPS id 419879ff3a6aaf8f;
	Fri, 30 Oct 2026 11:14:14 +0000
X-Mizu-Trace-ID: 419879ff3a6aaf8f
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH] powerpc/mm: fix uninitialized ZONE_DEVICE struct pages
 with PMDs
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <bj8bwkuf.ritesh.list@gmail.com>
Date: Fri, 30 Oct 2026 19:13:53 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Pavithra <pavrampu@linux.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <96A93324-9979-45B6-A288-4BCF9E6970BF@linux.dev>
References: <20261029063601.1961415-1-songmuchun@bytedance.com>
 <h5i4wlx5.ritesh.list@gmail.com>
 <20FE1232-A48B-4F72-8F18-89EFF70EE0FE@linux.dev>
 <bj8bwkuf.ritesh.list@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On Oct 30, 2026, at 18:20, Ritesh Harjani (IBM) =
<ritesh.list@gmail.com> wrote:
>=20
> Muchun Song <muchun.song@linux.dev> writes:
>=20
>>> On Oct 29, 2026, at 23:45, Ritesh Harjani (IBM) =
<ritesh.list@gmail.com> wrote:
>>>=20
>>> Muchun Song <songmuchun@bytedance.com> writes:
>>>=20
>>> Thanks Muchun,
>>>=20
>>>> PowerPC radix vmemmap population can reuse an existing PMD mapping =
while
>>>> populating a device DAX range whose section is marked as =
HVO-enabled. The
>>>> reused mapping is an ordinary vmemmap mapping: the redundant tail =
struct
>>>> pages are not remapped to the shared tail page.
>>>>=20
>>>> Leaving the section marked as HVO-enabled makes later ZONE_DEVICE
>>>> initialization treat the range as optimized and initialize only the =
struct
>>>> pages that would be backed by a real HVO mapping. The remaining =
tail struct
>>>> pages can then be left uninitialized even though they are still =
used as
>>>> metadata for the device DAX compound page.
>>>>=20
>>>> This first triggers a zone mismatch warning in =
__init_single_page(), then
>>>> faults while initializing the pageblock flags:
>>>>=20
>>>> WARNING: mm/mm_init.c:600 at __init_single_page+0xd0/0xf4
>>>> Call Trace:
>>>>   memmap_init_zone_device+0x164/0x430
>>>>   memremap_pages+0x43c/0x93c
>>>>   devm_memremap_pages+0x3c/0xa4
>>>>   dev_dax_probe+0x264/0x3d0
>>>>   dax_bus_probe+0x140/0x1c8
>>>>=20
>>>> BUG: Kernel NULL pointer dereference on read at 0x00001400
>>>>   __set_pfnblock_flags_mask.constprop.0+0x34/0x160
>>>>   memmap_init_zone_device+0x358/0x430
>>>>=20
>>>> On kernels without these initialization-time diagnostics, the
>>>> uninitialized metadata remains latent. When userspace later maps =
and
>>>> accesses the affected device DAX range, the kernel operates on =
those struct
>>>> pages and panics at that point instead of during device =
initialization.
>>>>=20
>>>> The Fixes target predates the section-based vmemmap optimization
>>>> infrastructure, so older kernels do not have section state that can =
be
>>>> marked non-HVO. Backports to such kernels need to handle the =
PMD-reuse case
>>>> in powerpc radix code directly, for example by initializing the =
tail struct
>>>> pages that core ZONE_DEVICE initialization would otherwise skip.
>>>>=20
>>>=20
>>> Actually that would be totally new code right? It won't be a =
straight
>>> forward backport, correct? ...=20
>>=20
>> Right. Because it's impossible to backport the whole section-based =
vmemmap
>> optimization infrastructure (48 commits).
>>=20
>>>=20
>>>> Mark the section as non-HVO when reusing an existing PMD mapping, =
so the
>>>> section's HVO state matches the actual vmemmap layout and all =
required
>>>> struct pages are initialized.
>>>>=20
>>>> Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for =
vmemmap optimization for radix")
>>>> Cc: stable@vger.kernel.org
>>>=20
>>> ... then should we mark Cc: stable here with the above mentioned =
fixes
>>> tag? Because this patch cannot be backported as is to older kernels =
-
>>> for the reasons you mentioned above.
>>=20
>> The comment following the trailer is used to guide stable maintainers =
to
>> backport proper prerequisite commits. It's hard to do that. So I =
choose to
>> mention the alternative in the commit message. But with the help of =
LLM,
>> I found the alternative is also not the right solution. The reason is =
as below.
>>=20
>> That pmd_leaf() path only creates or reuses the vmemmap mapping. =
After it
>> returns, sparse_add_section() calls page_init_poison() on the whole =
memmap,
>> which overwrites any page state initialized there.
>>=20
>> Therefore, older kernels must pass the PMD-leaf information to
>> memmap_init_zone_device() and let it initialize all real tail struct
>> page entries. Initializing them immediately in the PowerPC pmd_leaf()
>> branch would be too early.
>>=20
>> Another solution is making vmemmap_can_optimize() range-aware by =
passing
>> the vmemmap start and end addresses.
>>=20
>> On PowerPC, reject the optimization when any part of the range is =
already
>> covered by a PMD leaf. This ensures that an existing PMD mapping is =
reused
>> normally and that all real tail struct page entries are initialized =
later
>> by the core code.
>>=20
>> Maybe it should be a separate patch for old kernels? Thoughts?
>>=20
>=20
> yes, I think we can do a separate patch later for older kernels. I
> will look at your suggestions to see what can be done in that case.

Thanks.

>=20
>=20
>>>=20
>>>> Reported-by: Pavithra <pavrampu@linux.ibm.com>
>>>> Closes: =
https://lore.kernel.org/r/97f85592bb78a273be8519e6897e7f9b9bd31469.1793070=
429.git.ritesh.list@gmail.com
>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>> ---
>>>> arch/powerpc/mm/book3s64/radix_pgtable.c | 11 ++++++++++-
>>>> 1 file changed, 10 insertions(+), 1 deletion(-)
>>>>=20
>>>=20
>>> I think, this patch should go via mm tree, due to all the =
dependencies
>>> coming from there, right?
>>=20
>> Better. I hope Andrew will pick it up once I send a v2 version with =
more
>> proper commit message changed.
>>=20
>=20
> I think we can add an explicit comment like this then?
>=20
> Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap =
optimization for radix")
> Cc: <stable@vger.kernel.org> # see patch description, needs a =
different fix for <=3D 7.3

Oh, yeah, I'll add this in v2. Thanks for your suggestion.

Thanks.

>=20
> -ritesh




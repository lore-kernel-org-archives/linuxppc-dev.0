Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDBA606D806
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UhsJopj7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL42v5SCVz2xN4;
	Fri, 06 Nov 2026 01:10:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.201
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793887831;
	cv=none; b=HheDn3srwRzYFSgX3i3gn5N9w8sGLKGbTCYqt/RTXG4vWUtIBKN6v7RCE6iuRu4JX+zJq65SotpCGrZ0p2M2+UGyPjWoYyxAUr8AwUsl2QqGanpyfDOHf/LHNvew3B2ftU56wQpBjVrJ3traMZodN9r3WtG9hcDtOzVS98SmY0cyRE97J3QKG/p9Eipid1FGTNU4tYfYITC17hfo+lEhtCftVoq2Qf2oCN8Wbxq8hEy1dBPjK7QEbf+65A4pIV3rdzeeqFqfMY+HrX30ZcnlJbvYc+qlsOlhTQuG0iz1dWO+J30Ua1CfDpwJTdPjBkBFaqFmxyPR9He4xA9D6CWQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793887831; c=relaxed/relaxed;
	bh=rXYKCnFMOcWT/GHOYQM/Rfu/7o9VqnHXStFCMJH6+uU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dEYu4csgPK54O4u2h3U8CGfKCvbkooqJcY0o+IxojvORbaEjK+L6Txdzs5xO66oglCErNCgoiQOKKlpIZDegkoYsCMlRqSHDd4pXkusvU3TFlbbKKwX8BCE5CuD73L/YH43TNn9Ke8BXyHpykkdKEtKoT70RfrYbysMHhe8gQWC8ChWnZQHBmALGSzyVf1YzYF1mNDTB7xtk9jYTJ51Wc8+mhET45eWBLRL/QU8o3mYUm5MbUEnu5H+nAW+qRG9mDRfksKSdt68Vf8o5J/mtkIlLJDeFS/p1wQGK+h4BRO/3mg+wfeLYSq29MPUzJSKXQ2TGdb00+4F8zPqrqaCNiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UhsJopj7; dkim-atps=neutral; spf=pass (client-ip=95.215.58.201; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UhsJopj7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.201; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-201.mta1.migadu.com [95.215.58.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL42q5Wy8z2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 01:10:25 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=rXYKCnFMOcWT/GHOYQM/Rfu/7o9VqnHXStFCMJH6+uU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793887806; v=1; x=1794492606;
 b=UhsJopj7eHfVHFq050D9+MxCSJ5dHBhv8RJ2yrFPYzZTJmr+fFjQwFUL4NIeyiehkWQbe6du
 OwMc6YjYlYxGapwGW6wa+IIA9cAAL3q2QEymLQesF7UnpiBLFL31BY1Z2zzcJ+2U4mahw4VDRVk
 qasCYPCXLuwXvbxG4cxAdrNc=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta12.migadu.com with ESMTPS id dd249d3f7c375ee6;
	Thu, 05 Nov 2026 14:10:05 +0000
X-Mizu-Trace-ID: dd249d3f7c375ee6
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 0/4] mm: Enforce read-only shared vmemmap tail mappings
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <0851db25-fef3-4f96-8d37-81ad5c51d6c8@kernel.org>
Date: Thu, 5 Nov 2026 22:09:33 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Lance Yang <lance.yang@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Qi Zheng <qi.zheng@linux.dev>,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6492A4DD-B00E-40EA-85D6-93183E8D3ADC@linux.dev>
References: <20261019090830.1917657-1-songmuchun@bytedance.com>
 <0851db25-fef3-4f96-8d37-81ad5c51d6c8@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

> On Nov 5, 2026, at 18:33, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 10/19/26 11:08, Muchun Song wrote:
>> This series is split out from the earlier, larger series "mm: =
Generalize
>> HVO for HugeTLB and device DAX" [1]. While the parent series =
generalizes
>> vmemmap optimization across HugeTLB and device DAX, this subset =
addresses
>> a single, self-contained step: mapping shared vmemmap tail pages =
read-only
>> at population time.
>>=20
>> After the previous HugeTLB and device DAX conversions, both can =
install
>> optimized shared-tail mappings during vmemmap population. These =
mappings
>> should be read-only because each shared tail vmemmap page backs =
metadata
>> for many tail pages. HugeTLB applies this protection in a later,
>> subsystem-specific pass, but device DAX currently lacks it.
>>=20
>> This series moves the protection into the generic sparse-vmemmap and
>> powerpc radix population paths. This protects device DAX mappings and
>> makes the HugeTLB-specific vmemmap_wrprotect_hvo() pass redundant. =
With
>> that pass gone, the bootmem-only optimization wrapper has no distinct
>> work and is removed as well.
>>=20
>> This is intended to be the fifth smaller step toward the broader HVO
>> generalization. The remaining HVO naming and enablement consolidation =
is
>> left for follow-up series.
>=20
> I assume this patch series is no longer applicable after we remove the =
RO
> protection for HVO.
>=20
> Or am I missing something? :)

Not quite :) The runtime RO part yes, but the vmemmap population path is
a different story =E2=80=94 struct page isn't initialized there, so =
there are no
concurrent accessors and setting RO is safe.

So we can keep it and enjoy the protection RO gives us: if something =
goes
wrong, we catch it right at the first scene. So I think this series is =
still
needed.

Thanks,
Muchun

>=20
> --=20
> Cheers,
>=20
> David




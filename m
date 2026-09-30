Return-Path: <linuxppc-dev+bounces-28533-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D62CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 01:26:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvcpT4fG5z2yYd;
	Wed, 30 Sep 2026 11:26:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::27"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790731617;
	cv=none; b=bMLPYFLpAxgHm2J4hiJ9ylYAGKy+kkPJbiONWfLHBpdU3DDryufG9e+v7jO4C2Gusm2zqVfVA4KKpcRCYXw7wgNGjxNDNL4lcPPM2Y5507PJUxd1zyHF5/CWj3FM33rRpwk3UDYwIREDcbsR4j2kFq5y4wt+gL70cCIKCnJ7nogZTc//+KO6zt+J6fCBnCPwOc9mplatmYuKJ/27wjXwfpH/IBxAAyyNPVA1o/kOw2ClL8WMc4UbpTzfWaP5ul+iYB1LGwMHzRmuOV87pdEDzTLeMIGPnoTNivR9pfdQ1ED2OwUResdeyG2cFVKlawb59S1jpM/lD7iTAlJs2t5LHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790731617; c=relaxed/relaxed;
	bh=wCIueztMn6qtMBchJfx2etXVyYzxHf3iBKEIk5t2QtY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FLOGEMDvC99GSXduX+IWVvgXTw724J/09Is8GrfH+A6z8Yo5THXolIVCqsRXQ9Jzh4NHN6r1ROB/YNj165BIgZZyhusff148cQn4ufzWimMzMrsBIGTCbd0j614mdeeyQ324cBuTSIB3WXvXZFogDrNVMKjFlSLO28ZIe0kNE8Oa5Og8MBHIznzMDxuYSEqaegqlH1brPW+lsA8VEmAkw6trceIoY0XGDAIA9E1hBF20SGSkCI1bMJzWNtSnti+/2rYTKArnilwRNIfp1P2TXXj3ssWNX8Iey/MyGNUCJrGDqL4tMxEo2PF7J05vzNvDpbg7HA8y6+yYiVbuq+5GtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WDOIv36O; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::27; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WDOIv36O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::27; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-39.mta0.migadu.com [IPv6:2001:41d0:1004:224b::27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvcpQ35fbz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 11:26:52 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=IQRBqTSVWWALaW1mPWAac9TGAVH6p8Unuj/FQbT1y4Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790731588; v=1; x=1791336388;
 b=WDOIv36OO9lrltIsdKn1p/Dl5TCsZQOqtzhZ8Dh1WEGBKT/HjfCUvVmpfOfIXp1XoKlaFc5q
 Z3PVdE5TDYrfp7jP531Qv+J/ZtxbQfGTyP0S81oSGM/0+/SL5QyDC3zfxAlgMxdGtO07+QVXXD2
 I9GSrh5b69ZqKxDrURbeoZXg=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta10.migadu.com with ESMTPS id c8969253a912e5f2;
	Wed, 30 Sep 2026 01:26:28 +0000
X-Mizu-Trace-ID: c8969253a912e5f2
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH v3 0/6] mm: Unify device DAX and HugeTLB vmemmap
 population paths
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260929143214.9061bcf284369163192968d1@linux-foundation.org>
Date: Wed, 30 Sep 2026 09:26:09 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Qi Zheng <qi.zheng@linux.dev>,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D1333E60-93C8-4459-9CC0-48D6F10D3EC0@linux.dev>
References: <20260929053231.66085-1-songmuchun@bytedance.com>
 <20260929143214.9061bcf284369163192968d1@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)



> On Sep 30, 2026, at 05:32, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Tue, 29 Sep 2026 13:32:25 +0800 Muchun Song =
<songmuchun@bytedance.com> wrote:
>=20
>> This v3 is based on mm-new commit 2ddb90ee544a, which contains v5 of
>> "mm: Switch device DAX to section-based vmemmap optimization" [1].
>>=20
>> This series is split out from the earlier, larger series "mm: =
Generalize
>> HVO for HugeTLB and device DAX" [2]. While the parent series =
generalizes
>> vmemmap optimization across HugeTLB and device DAX, this subset =
addresses
>> a single, self-contained step: unifying their vmemmap population =
paths.
>>=20
>> After the preceding Device DAX conversion, both HugeTLB and Device =
DAX
>> describe optimized vmemmap mappings through memory-section metadata =
and
>> use per-zone shared tail vmemmap pages. The generic code, however, =
still
>> carries a Device DAX-specific population flag and compound-page =
population
>> path, along with arguments and helpers needed only by that path.
>>=20
>> This series first removes VMEMMAP_POPULATE_DAX and moves selection =
and
>> reference handling for the shared tail page into the common vmemmap
>> population path. It then removes the generic Device DAX-specific
>> compound-page population path and routes section vmemmap population
>> through vmemmap_populate(). The powerpc radix path continues to use =
its
>> architecture-specific compound-page population implementation for
>> optimizable sections.
>>=20
>> The remaining patches remove the unused ptpfn argument, open-code
>> vmemmap_populate_address() now that no caller needs its returned PTE, =
and
>> add a warning for inconsistent zone initialization of shared tail =
vmemmap
>> pages.
>>=20
>> This is the fourth smaller step toward the broader HVO =
generalization.
>> After this series, HugeTLB and Device DAX use the same population =
model
>> instead of parallel generic paths, while powerpc keeps its
>> architecture-specific implementation.
>=20
> afaict the whole series is "no functional changes intended".  Apart
> from [6/6]'s new WARN_ON.

Yes.

>=20
> And [3/6] is the one which could cause unintended fuctional changes!

Understood. However, the resulting vmemmap layout is intended to remain
unchanged.

>=20
> Thanks.  I'll queue it.  Reluctantly.  We're up to 688 MM patches this
> cycle and it's time to stop.

Thanks for taking it despite the load.

Muchun,
Thanks.



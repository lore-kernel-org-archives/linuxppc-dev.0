Return-Path: <linuxppc-dev+bounces-27008-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9404BC79F9F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 06:49:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgSvN70Z5z2y2L;
	Thu, 10 Sep 2026 16:49:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.237
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789022944;
	cv=none; b=ctrrbl0917BfHiVhPng20nu+BgO8aMP4QsFAcDuwN7uVumYc9fDn/JgnUjAwK9KrCPuf6nUREyGdL/Q+W+cJ2EiCac2vr757DQosEnP+a5g+L2fXZlgwv0Lum8Q0Js4ZIPYanZ0qoo2Gbr5vZtUc94uQZUM7HAwzleaTHqytHomQZQOVx0MwZYD31CHw3vy4EMMuN1f/ZzVnTqx934Upj5s1RdEOmrZN9ffLNoA1iEqJ/VoEOi6XPmyTAkk3YuQ4BdJLtqcFYn+K2MQ9ro2Ay8OQutur9e6IMHvxjSFicNaRyDRBzkXao5/NcV5Li/V1wMsa+BtOy8ZSLS1TjJM36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789022944; c=relaxed/relaxed;
	bh=cdbujpu4aOo0T4Gyax2Ea3UO60X2jGQ9aFI7VTtnyXU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UpphVy9qEv9idWmtrHfuRBNhXwylltTD/I6dS16UTLbm+HWe/j/tYOMr1rdA9XOVYo1mK1qUD4g9izMb2A4HxnRVYXivekuj4CcaRLyfWkJaI+yjFTM7/m0967ZozcJ2Aa6mX5Uf+jrhtC2qOqoSUCvqn2cN/29pT2DTT3Jig0hyOqpJ+qfjBMhHIPlwGBYpLHundKAq4xm74dB4/WXby5eVmSskhSE0pYgNA0Ugd1ov0vTGyUjeJRIeM+AhuiEnfkvUua9CYnYb381m2J4cs7j1K8NYaA2X9cOIIKj9gxs2YlfWsLLp+Wh1EjFTXgLVQ/rA5Kg7b4IRZfzHLve6Tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W8/NzpWV; dkim-atps=neutral; spf=pass (client-ip=95.215.58.237; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W8/NzpWV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.237; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-237.mta1.migadu.com [95.215.58.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgSvD5jZxz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 16:48:49 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=YHacq/CRvcLogvUw1Z/iF5AmWhyhaW1ODj1zgiJ2k7E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789022910; v=1; x=1789627710;
 b=W8/NzpWVVXERmI5NSrKpWItFXtN/X+flt4m4J/PVB1v3gCT24ku4gX7V4pAviM6gktup4Y5c
 h6ByV4vdw5PdjhRRk6RCOp2jvp6LInuYR9h2YyTBk0iAP+jL4tGwNZ8HLT3qjE34u5DtZAUzaIe
 7s0QQUbnrI9i+o046EGpK6sg=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta12.migadu.com with ESMTPS id e82ef4c2d92f9736;
	Thu, 10 Sep 2026 06:48:30 +0000
X-Mizu-Trace-ID: e82ef4c2d92f9736
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH v2 00/11] mm: Switch device DAX to section-based vmemmap
 optimization
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260908184516.c026438445ff3db78ee120fa@linux-foundation.org>
Date: Thu, 10 Sep 2026 14:48:15 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org,
 Lorenzo Stoakes <ljs@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D743D6A9-2D4A-4708-9099-AE29613CC3BF@linux.dev>
References: <20260908030335.96549-1-songmuchun@bytedance.com>
 <20260908184516.c026438445ff3db78ee120fa@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Sep 9, 2026, at 09:45, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Tue,  8 Sep 2026 11:03:24 +0800 Muchun Song =
<songmuchun@bytedance.com> wrote:
>=20
>> This series is split out from the earlier, larger series "mm: =
Generalize
>> HVO for HugeTLB and device DAX" [1]. While the parent series =
generalizes
>> vmemmap optimization across HugeTLB and device DAX, this subset =
addresses
>> a single, self-contained step: switching device DAX to the =
section-based
>> sparse-vmemmap optimization infrastructure introduced for HugeTLB.
>>=20
>> ...
>>=20
>> This is intended to be the third smaller step toward the broader HVO
>> generalization. The wider HVO consolidation between HugeTLB and =
device
>> DAX is left for follow-up series.
>=20
> Thanks both, I'll add it to mm.git's mm-new branch.

Hi Andrew,

I've updated series [1] to v6 to address David's review comments from
yesterday. Since the current series depends on this v6 version, I =
suggest
dropping these two series from mm-new. Once the v6 version of the =
dependent
series is merged in, I will re-update the current series to v3 based on =
the
new mm-new branch, and also fix the compilation error under !CONFIG_NUMA =
[2]
in that version.

[1] =
https://lore.kernel.org/all/20260910063256.64386-1-songmuchun@bytedance.co=
m/
[2] https://lore.kernel.org/all/202609100517.0DrzxrW4-lkp@intel.com/

Thanks,
Muchun



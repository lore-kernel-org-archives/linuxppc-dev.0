Return-Path: <linuxppc-dev+bounces-19775-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57991F4199B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 12:22:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwgJw5Pq7z2yvh;
	Wed, 15 Apr 2026 22:22:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776255776;
	cv=none; b=TCtZH/p9x5pNP7QUF5c/0c3/pO5AUkxMgjd2qqLQNF2Y/xBt8XuIDXRIFizSMCrA49KtM8zvNkuhj4jmhscb7DCIEewEfE2YqbtADfic7XKcTjbF6Tbgc/xX8Mf4BCWh8p8qI58LxTLgq4x5bGswRi458gB/PigPA6nhsJb3mllZbR+NN8VsvXhCMKSE/+9gLYEs3450cZ885ceseKIDOzIz6NI1KM7BMh/pNC2/2LdNwUAv+fWaEnWx6IpxQnjLZSPWFDChqija8f5QZtrjZBBqxakjfu2dMfj4qKPVM1mk7ql9uuu4fjMuiP3QeEQrszJ7h3sA4ZfxeeEWHXT0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776255776; c=relaxed/relaxed;
	bh=VCECXRZt1tRWhYO2f/EdS9u/dfLhHAlOtvQp6eMeCao=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Gc/eaNc/Eg/FAwH2uNw4MZfZqmZYSoZ41lJcHPaWxFyIUFAFcLiklxhoZL7H72mV/IvXP7ODAjaj/6q1lfbYh8g42OR1Cp4G4MdTfrZpojvNp2ktSiJtozmHLWcLKeHdNT/yH03rqvvZOfcc4rczOxEAQ0YyncnQIRISKa/JyjUsdtODajSq7gOJ2xQruDHQmUzi/uWvNWuP1Z4t1/aXIK+QAB0z7Vxn/iEOtdZNvIuBylqTz4bQ9ZT8Gy1Um8EEzn4X2MklHuM2AkhMXxX3yxDLWByztqRNKfP2if6NFxOb3w7/iRLKb68LSPARlt2y9B6egvL3D6bB+y+l4sVN/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UeFP1PtS; dkim-atps=neutral; spf=pass (client-ip=95.215.58.172; helo=out-172.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UeFP1PtS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.172; helo=out-172.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwgJt0Qw5z2yvY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 22:22:53 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776255753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VCECXRZt1tRWhYO2f/EdS9u/dfLhHAlOtvQp6eMeCao=;
	b=UeFP1PtSF6ipgLoxcNRkvHhJojxdRSDvpJboXiwDHiGFdWOJcrdUum8kCjr47GDwUTIjEL
	Oxib5nsSYCh6uASGbSDMCnR39l8VbiQwCV0shP4KLbjXNuik3D4XhtjFzThJ2YelY8PtYM
	Fxxwt17HNWkYfy7qwRomETUmFDVYQds=
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
Subject: Re: [PATCH v2 4/6] mm/sparse-vmemmap: Pass @pgmap argument to arch
 vmemmap_populate()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <9ceede7b-45d3-4d15-b8ce-f0b04bbb18dd@oracle.com>
Date: Wed, 15 Apr 2026 20:21:45 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 aneesh.kumar@linux.ibm.com,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 harry.yoo@oracle.com,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE14CDAA-32AC-48C3-AB9E-31F6B47843AB@linux.dev>
References: <20260415111412.1003526-1-songmuchun@bytedance.com>
 <20260415111412.1003526-5-songmuchun@bytedance.com>
 <9ceede7b-45d3-4d15-b8ce-f0b04bbb18dd@oracle.com>
To: Joao Martins <joao.m.martins@oracle.com>
X-Migadu-Flow: FLOW_OUT



> On Apr 15, 2026, at 20:13, Joao Martins <joao.m.martins@oracle.com> =
wrote:
>=20
> On 15/04/2026 12:14, Muchun Song wrote:
>> Add the struct dev_pagemap pointer as a parameter to the architecture
>> specific vmemmap_populate(), vmemmap_populate_hugepages() and
>> vmemmap_populate_basepages() functions.
>>=20
>> Currently, the vmemmap optimization for DAX is handled mostly in an
>> architecture-agnostic way via vmemmap_populate_compound_pages().
>> However, this approach skips crucial architecture-specific =
initialization
>> steps. For example, the x86 path must call sync_global_pgds() after
>> populating the vmemmap, which is currently being bypassed.
>>=20
>=20
> Harry's series fixed in a different way (for x86):
>=20
> =
https://lore.kernel.org/linux-mm/20250818020206.4517-1-harry.yoo@oracle.co=
m/#t

Thanks for your information. It indeed fixes the page table sync issue.

I'll drop this one int the next version.

Thanks,
Muhcun=


Return-Path: <linuxppc-dev+bounces-22310-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86162CD8C85
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 06:28:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZJs14h1Cz2xR4;
	Tue, 09 Jun 2026 16:28:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780986533;
	cv=none; b=mMWh4+EAk8KfDKWrUNnsAqcrWDe8NjlhqPdYjBHcw2Lv/BPMEhdw2QhPM+4mgrHKJfAJxoz6eDSILDWGG8fdrZMJnpmR1h4TsKBn0hgCzO6YmaAgkM/wyunqPIW+fHBT9QecnJ2w5BHVxAtm1PaHsI2K0MA9L3Uc8AdyJOhskLggkclbd2kPdb5KGV/aTwhkdYsm9q7ZqMTQWd8/e9lPc4/UNWRO5FIJ5LizYOKyk4uz2c6pf47YjN4j3RQwXiTz9RNAGSaLoS70jLYZ0bkQiqltY3SiiqG70PkRYjx6w6dNXMDS7O/hz4dXBZQ5nhLRbchapNA+taOHmmphV6lbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780986533; c=relaxed/relaxed;
	bh=sQDhEvXvj0vskWG5Nod+8TONy/NcJUoddZ5fD+XBrmU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type:References; b=ShYzJqcvJILPTRZbpe/RyNB4XHBoKngbdEfO/CjJuNBA6YErlRBbds/79pcFoZa++MpI+aXXc6lCDGxlEjzY78hxQgW2u5CCI6hsrHBLp1H5XE0opH+8V4Yg+Lx+357DUseC0+E77ICS4nE5sykeGYFufuxa0HVSURiEraWqDEiEglCWvQ/xWeysh/mEVPlxwJFyEgRvdAH/AHZVdF/soXMYIh9er4+4qpHo5oSGHCEqvSKzFLWaV73lvzo5hxGBe3Dar8aFA4CiGUC7o7GHcxh7OjFsrQNYzNOIc2YsIqF78CsTO1cf0e3iaVo3Ir3U0IGO+LAp9fLbVFzEHQLieg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=L71YJc2P; dkim-atps=neutral; spf=pass (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=L71YJc2P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZJrz2Y5pz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 16:28:50 +1000 (AEST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260609062840euoutp02cff183af08e6d80e4cec2670fa35ebb1~3Vc3wVRME1329613296euoutp02O
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2026 06:28:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260609062840euoutp02cff183af08e6d80e4cec2670fa35ebb1~3Vc3wVRME1329613296euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780986520;
	bh=sQDhEvXvj0vskWG5Nod+8TONy/NcJUoddZ5fD+XBrmU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=L71YJc2PSiiRY1n+YPatJVjODV3Te89KEOTZimaueovjODrs9pyp0pdbH67JiyEmb
	 wCUwBCsxT9/ecX7Nz8TuuKZuUCBE8zVB1UGNkFc3cWAa9XWukALnBxMuvL1JCRzJEL
	 shJ6fMw0Ilby9yFLoZKS/Rtr8A02ChpckDYrgCqw=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260609062840eucas1p1d49831bfdb3447e38a3cadc803a9afc0~3Vc3M9lZT1760217602eucas1p1O;
	Tue,  9 Jun 2026 06:28:40 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260609062837eusmtip165b8ffd20070283bf8a1cc3770a61ba5~3Vc0aQZiY2875428754eusmtip1_;
	Tue,  9 Jun 2026 06:28:36 +0000 (GMT)
Message-ID: <6a9c0f55-fe98-4063-864b-8f7e1f4fefd7@samsung.com>
Date: Tue, 9 Jun 2026 08:28:35 +0200
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
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v7 15/15] arm64: mm: Unmap kernel data/bss entirely from
 the linear map
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Ard Biesheuvel <ardb+git@google.com>,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com,
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts
	<ryan.roberts@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Kevin
	Brodsky <kevin.brodsky@arm.com>, Liz Prucka <lizprucka@google.com>, Seth
	Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, David Hildenbrand <david@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Content-Language: en-US
In-Reply-To: <a1b27e97-182c-485d-a448-56c19c5de2c2@samsung.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260609062840eucas1p1d49831bfdb3447e38a3cadc803a9afc0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260609062840eucas1p1d49831bfdb3447e38a3cadc803a9afc0
X-EPHeader: CA
X-CMS-RootMailID: 20260609062840eucas1p1d49831bfdb3447e38a3cadc803a9afc0
References: <20260529150150.1670604-17-ardb+git@google.com>
	<20260529150150.1670604-32-ardb+git@google.com>
	<a1b27e97-182c-485d-a448-56c19c5de2c2@samsung.com>
	<CGME20260609062840eucas1p1d49831bfdb3447e38a3cadc803a9afc0@eucas1p1.samsung.com>

On 09.06.2026 08:22, Marek Szyprowski wrote:
> On 29.05.2026 17:02, Ard Biesheuvel wrote:
>> From: Ard Biesheuvel <ardb@kernel.org>
>>
>> The linear aliases of the kernel text and rodata are also mapped
>> read-only in the linear map. Given that the contents of these regions
>> are mostly identical to the version in the loadable image, mapping them
>> read-only and leaving their contents visible is a reasonable hardening
>> measure.
>>
>> Data and bss, however, are now also mapped read-only but the contents of
>> these regions are more likely to contain data that we'd rather not leak.
>> So let's unmap these entirely in the linear map when the kernel is
>> running normally.
>>
>> When going into hibernation or waking up from it, these regions need to
>> be mapped, so map the region initially, and toggle the valid bit so
>> map/unmap the region as needed.
>>
>> Doing so is required because pages covering the kernel image are marked
>> as PageReserved, and therefore disregarded for snapshotting by the
>> hibernate logic unless they are mapped.
>>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> This commit landed in yesterday's linux-next as commit 63e0b6a5b693
> ("arm64: mm: Unmap kernel data/bss entirely from the linear map").
> In my tests I found that it breaks booting of RaspberryPi3 and
> RaspberryPi4 boards with the following kernel panic:
One more comment - reverting 63e0b6a5b693 and 53205d56212c (dependent
change) on top of next-20260608 fixes this issue.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



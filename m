Return-Path: <linuxppc-dev+bounces-26605-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BE6C624D6
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 09:08:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcSDy5dCdz2ygK;
	Sat, 05 Sep 2026 19:08:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.222
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788599330;
	cv=none; b=Jh3PSY2/Bq0ETTWQZKR0yCPD2oOgNt/O6nL1u7Fcy3F53uWMvK2dI2KobnE+1/HLMao4H16iKZ1NqQRk+S68ogKcMiggk+WGXq7ZrT9mLtWkl/btL+3HUG3NMlHDjuMTYXW3Be7kjYVft3EgykxT9LwZG3XmbcoagLf9szcuYJN+Xr5cJqkv6idonSWt+2RcTWFF5kaPbCnU1VMESghsoezG+CmSE12u1X1BXWUnIyUEtsTyzOfxTUckt7WgM0Qv8R4coITUDG1VGDyzNUPcjwK8ujZFJJJbiDUqkdoTQVxhwGsWYqsMDd93EZNB5he5fM89iisGReSrFvjLILSdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788599330; c=relaxed/relaxed;
	bh=928ftpQdBwt+cq+MctmlsoRyqL5DINpZLnaKzBho3a0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WY/BHSuraaqRg31gHB2i4s4OHZ0zGsW5P+jitKmRJMzMlERhse18vqIBTjUejbb/fU0TMxQUUr7jCGoc9mdDxN23U5TuwLOPm+YnxNjpYeSs4i9waw/xX/2JhgvkMZLmIc+gEI9cG5LgkAFXhcK/d3nkRXC7Nr95P4jcK4E8A6JWQ2RPjubDcZ7mRC0P6vrgMgorOaIZJYJHwtv8xdt/32mnFZKTry+L3q4i3ry7XwbXQjoramk33jtpeMQl2eYHjUbLivK7vFikWD25031TJQGPVYTeG4/G4luvv0pRvuJvn9Do3obw1CVyVToCkDHPR7G/uvQ0+LxeystY7LdpBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=M/3gHvGu; dkim-atps=neutral; spf=pass (client-ip=95.215.58.222; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=M/3gHvGu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.222; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 478 seconds by postgrey-1.37 at boromir; Sat, 05 Sep 2026 19:08:49 AEST
Received: from mta1.migadu.com (out-222.mta1.migadu.com [95.215.58.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcSDx5blSz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 19:08:49 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=928ftpQdBwt+cq+MctmlsoRyqL5DINpZLnaKzBho3a0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788599311; v=1; x=1789204111;
 b=M/3gHvGuKQyseerPBMWaIjrR9HHkxe5vMov/rwP54TOMft2DvArQHmeOJW8Ae+u0Y3Iiacvc
 iBNr1wkYBkLXlHElqXC4KyebKuUxmI/t+D/phJhRSMxQJcOrfRXA88FmD7JxUdjZ6tifxt6PdOR
 xvaUARySrGnmETV689CwX1Kc=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta11.migadu.com with ESMTPS id 6189846893d99aae;
	Sat, 05 Sep 2026 09:08:31 +0000
X-Mizu-Trace-ID: 6189846893d99aae
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
Subject: Re: [PATCH 06/11] mm/sparse-vmemmap: switch device DAX to shared tail
 vmemmap pages
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <e3d0eaf8-a85f-48ff-96c2-dced4945b085@linux.dev>
Date: Sat, 5 Sep 2026 17:08:12 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <861645FA-43D5-4619-82B6-7A0C889F95B8@linux.dev>
References: <20260831075342.57563-1-songmuchun@bytedance.com>
 <20260831075342.57563-7-songmuchun@bytedance.com>
 <e3d0eaf8-a85f-48ff-96c2-dced4945b085@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Sep 5, 2026, at 16:35, Qi Zheng <qi.zheng@linux.dev> wrote:
>=20
>=20
>=20
> On 8/31/26 3:53 PM, Muchun Song wrote:
>> HugeTLB vmemmap optimization now uses per-zone shared tail vmemmap =
pages.
>> Device DAX has not been switched to that mechanism yet.
>> Switch device DAX to vmemmap_shared_tail_page() as well. This aligns =
DAX
>> with HugeTLB by using the common per-zone shared tail vmemmap page.
>> Since the shared tail page can now back ZONE_DEVICE vmemmap mappings,
>=20
> Could you explain this in more detail?
>=20
> As sashiko pointed out [1], it looks like this assumption is
> problematic: dax_folio_reset_order() may end up modifying all shared
> tail pages?

I believe Sashiko's report is a false positive, because the issue =
Sashiko
raised is based on assumptions from code analysis for FS-DAX. =
Unfortunately,
the current implementation that supports HVO is DEV-DAX, and DEV-DAX =
does
not modify tail struct pages. Moreover, this patch itself is intended to
migrate DEV-DAX to section-based vmemmap optimization, so there is no =
issue
at all.

BTW, the current logic for determining whether DEV-DAX applies HVO is =
based
on pgmap->vmemmap_shift, and pgmap->vmemmap_shift is only assigned =
during the
initialization of DEV-DAX devices.

Muchun,
Thanks.

>=20
> [1]. =
https://sashiko.dev/#/patchset/20260831075342.57563-1-songmuchun%40bytedan=
ce.com
>=20
>> initialize its entries with PG_reserved for device zones. Also skip
>> poisoning vmemmap-optimizable sections while their struct pages may =
be
>> shared.


